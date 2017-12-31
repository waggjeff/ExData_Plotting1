# This script makes series of plots based on household power consumption data
# Jeff Wagg - December 30, 2017
library(lubridate)
graphics.off()

# first set the working directory and read the text file:
setwd("/Users/j.wagg/DataScience/Course4/")
filename <- "household_power_consumption.txt"
powdata <- read.table(filename,sep=';',header=T)

# reformat the Date column and create a subset of data covering 2007-02-01 and 2007-02-02. 
powdata$Date <- as.Date(powdata$Date,"%d/%m/%Y")
powsub <- subset(powdata,Date > "2007-01-31" & Date < "2007-02-03")
powsub$Timestamp <- paste(powsub$Date,powsub$Time)

# Create plot1: histogram of global active power
png(filename = "Plot1.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
hist(as.numeric(powsub$Global_active_power),main="Global Active Power",
     xlab="Global active power (kilowatts)",ylab="Frequency",col="red")
dev.off()


# Create plot2: Global active power versus date
png(filename = "Plot2.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Global_active_power),
     ylab="Global Active Power (kilowatts)",type="l",xlab="")
dev.off()

# Create plot3: Energy sub metering versus date
png(filename = "Plot3.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_1),
     ylab="Energy sub metering",type="l",xlab="")
lines(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_2),col="red")
lines(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_3),col="blue")
ltext <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
lcols <- c("black","red","blue")
legend("topright",legend=ltext,col=lcols,lty = c(1,1,1))
dev.off()

# Create plot4: multiple plots 
png(filename = "Plot4.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
par(mfrow=c(2,2))
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Global_active_power),
     ylab="Global Active Power (kilowatts)",type="l",xlab="")
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Voltage),
     ylab="Voltage",type="l",xlab="datetime")
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_1),
     ylab="Energy sub metering",type="l",xlab="")
lines(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_2),col="red")
lines(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Sub_metering_3),col="blue")
ltext <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
lcols <- c("black","red","blue")
legend("topright",legend=ltext,col=lcols,lty = c(1,1,1))
plot(strptime(powsub$Timestamp,format="%Y-%m-%d %H:%M:%S"),as.numeric(powsub$Global_reactive_power),
     ylab="Global_reactive_power",type="l",xlab="datetime")
dev.off()


