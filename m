Received: from eggs.gnu.org ([2001:4830:134:3::10]:39332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zealot351@gmail.com>) id 1e9sVG-0003tr-UV
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zealot351@gmail.com>) id 1e9sVC-0006Pu-Hz
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:52:18 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zealot351@gmail.com>) id 1e9sVC-0006Pj-B2
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:52:14 -0400
Received: by mail-qk0-x241.google.com with SMTP id r64so2524423qkc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 05:52:13 -0700 (PDT)
MIME-Version: 1.0
From: Denis Dmitriev <zealot351@gmail.com>
Date: Wed, 1 Nov 2017 15:52:12 +0300
Message-ID: <CAF3nGXd5XMwe=O5Ub_CXY-pHo3mRoFa8W3iVeYScT_ZTmZV=6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Buslogic scsi adapter. Problem with executing scsi
 commands.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, pbonzini@redhat.com

Hi,
I'm trying to implement a buslogic scsi adapter (BT-958) for qemu. As a
basis I use its implementations in virtualbox.
At the moment, it is possible to send commands and data through the ports.
It is also possible to read data from kernel memory (mailboxes).
The current problem is that I can not implement the work of scsi commands
and dma. The adapter works as follows. The buslogic_check_mailboxes
function checks for new mailboxes from the driver.
When a new mailbox arrives, it is processed by the
buslogicProcessMailboxNext function. It receives data about the mailbox
type, the location of the CommandControlBlock (CCB).
The buslogicDeviceSCSIRequestSetup function prepares a query for the SCSI
subsystem of the QEMU. The first SCSI command from the driver is 0x12
(INQUIRY), it requires passing some data to the controller driver. During
the preparation of the request, the scatter gather list is read from the
driver's memory (buslogic_scsi_get_sglist is responsible for this). This
structure, as I understand it, describes where the response from the team
should be recorded.
Further, the disk subsystem QEMU forms a buffer with the response
information. After that, the buffer should be passed to the addresses
specified in the sglist.
The address_space_write function selects the memoryRegion for the record
(for which the address_space_translate function is responsible). It seems
to me that at this moment an error has already occurred because the result
is an unassigned region. Further, an attempt is made to write data to
addresses, but this fails (address_space_write_continue).
Could you tell me what to watch / debug on the topic of this error.
Below is the output of the backtrace from gdb and a link to github where I
put the code (the master branch).



#0  address_space_write_continue (as=0x555558174670, addr=118229008,
attrs=..., buf=0x555557db4010 "QEMU HARDDISK   2.5+", len=20,
addr1=118229008, l=4,
    mr=0x555556250700 <io_mem_unassigned>) at
/home/heroboec/qemu/exec.c:2750
#1  0x000055555575f735 in address_space_write (as=0x555558174670,
addr=118228992, attrs=..., buf=0x555557db4000 "", len=36) at
/home/heroboec/qemu/exec.c:2805
#2  0x000055555575fac1 in address_space_rw (as=0x555558174670,
addr=118228992, attrs=..., buf=0x555557db4000 "", len=36, is_write=true) at
/home/heroboec/qemu/exec.c:2907
#3  0x00005555558d65c7 in dma_memory_rw_relaxed (as=0x555558174670,
addr=118228992, buf=0x555557db4000, len=36, dir=DMA_DIRECTION_FROM_DEVICE)
    at /home/heroboec/qemu/include/sysemu/dma.h:87
#4  0x00005555558d661c in dma_memory_rw (as=0x555558174670, addr=118228992,
buf=0x555557db4000, len=36, dir=DMA_DIRECTION_FROM_DEVICE)
    at /home/heroboec/qemu/include/sysemu/dma.h:110
#5  0x00005555558d75cb in dma_buf_rw (ptr=0x555557db4000 "", len=36,
sg=0x555557888ba0, dir=DMA_DIRECTION_FROM_DEVICE) at dma-helpers.c:281
#6  0x00005555558d761a in dma_buf_read (ptr=0x555557db4000 "", len=36,
sg=0x555557888ba0) at dma-helpers.c:292
#7  0x0000555555a3dc06 in scsi_req_data (req=0x555557da5200, len=36) at
hw/scsi/scsi-bus.c:1756
#8  0x0000555555a33ac1 in scsi_disk_emulate_read_data (req=0x555557da5200)
at hw/scsi/scsi-disk.c:1396
#9  0x0000555555a3daa1 in scsi_req_continue (req=0x555557da5200) at
hw/scsi/scsi-bus.c:1726
#10 0x0000555555a46ce0 in buslogicDeviceSCSIRequestSetup (s=0x555558174460,
TaskState=0x555556760ed0) at hw/scsi/buslogic.c:2270
#11 0x0000555555a470a8 in buslogicProcessMailboxNext (s=0x555558174460) at
hw/scsi/buslogic.c:2393
#12 0x0000555555a472e0 in buslogic_check_mailboxes (opaque=0x555558174460)
at hw/scsi/buslogic.c:2447
#13 0x0000555555c0c6ae in timerlist_run_timers (timer_list=0x555556746500)
at util/qemu-timer.c:536
#14 0x0000555555c0c6fa in qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME)
at util/qemu-timer.c:547
#15 0x0000555555c0caac in qemu_clock_run_all_timers () at
util/qemu-timer.c:662
#16 0x0000555555c0d236 in main_loop_wait (nonblocking=0) at
util/main-loop.c:514
#17 0x00005555558da0d5 in main_loop () at vl.c:1898
#18 0x00005555558e1dd8 in main (argc=8, argv=0x7fffffffdb28,
envp=0x7fffffffdb70) at vl.c:4709



github:
    https://github.com/heroboec/qemu

-- 
Sincerely, Denis Dmitriev.
