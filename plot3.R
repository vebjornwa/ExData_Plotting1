# download and unzip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
download.file(fileUrl, "household_power_consumption.zip");
unzip("household_power_consumption.zip");

# read file into dataframe
dataclasses <- c(rep("character", 2), rep("numeric", 7));
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.string="?", colClasses = dataclasses);

# filter data on Jun 1st+2nd 2007
filter <- data$Date == "1/2/2007" | data$Date == "2/2/2007";
filtereddata <- data[filter, ];

# format date and time data
dateformat <- "%d/%m/%Y";
timeformat <- "%d/%m/%Y %H:%M:%S";
datetime <- paste(filtereddata$Date, filtereddata$Time);
filtereddata$Date <- as.Date(filtereddata$Date, format=dateformat);
filtereddata$Time <- strptime(datetime, format=timeformat);

# produce plot and output to PNG
png("plot3.PNG");
plot(filtereddata$Time, filtereddata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering");
lines(filtereddata$Time, filtereddata$Sub_metering_2, col="red");
lines(filtereddata$Time, filtereddata$Sub_metering_3, col="blue");
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"));
dev.off();