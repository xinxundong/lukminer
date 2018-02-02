#!/bin/bash

# usage:
# 1) make sure to adapt the URL, PORT, and USER values you want to mine for
# 2) execute this script. Preferrably, execute with sudo (ie, "sudo ./mine.sh),
#    which will allow the script to automaticaly enable the OS'es large-page support

# your pool's url
URL=mine.aeon-pool.com

# the port your pool is listening on
PORT=8080

# your user name at this pool
USER=Wmt5hTKURa1bzAaUroB9JQByeiK7nPooLf4KcMXBCjMfdbeoTHVWzXePHMiyGFTNVhgtzXrxn9vZTfCqKFD57oea2UV2de3Qy

# your account password at this pool, if required. Note most pools will actually
# interpret that as a worker name, so do NOT put your real password here!
PASS=x

# if you want to force a given number of threads, use this value. '-1'
# means 'all that make sense' given this CPU, cache size, etc.
MAX_THREADS=-1

# watchdog value, in seconds. If no share gets found within this many
# seconds, the miner assumes a non-replying pool, and exits, thus
# allowing an automatic, clean restart. Set to '0' to disable watchdog.
WATCHDOG=300

# executable to run.
# set to 'luk-aeon-phi' if this is a x200-series Xeon Phi
# set to 'luk-aeon-ocl' if this is a for one or more OpenCL-capable GPUs 
# (note that even in GPU mode it will still use the CPU cores, too)
MINER=./luk-aeon-cpu


# =======================================================
# end configuration section - now the actual script
# =======================================================

# enable the OS'es huge-page support. This requires sudo priviledges
# to succeed. If you called this script without 'sudo', this will emit
# an error (but don't despair, it'll still work - just a bit slower
# than if you _had_ used sudo)
echo 10000 > /proc/sys/vm/nr_hugepages

# now, call the miner, in an infiinite loop - ie, if the miner exists
# (or gets killed) for any reason, it'll automatically restart.
while [ true ] ; do
    echo "----------- re-starting miner -----------"
    $MINER --url $URL --port $PORT --user $USER --pass $PASS -wd $WATCHDOG -t $MAX_THREADS
    sleep 1
done

