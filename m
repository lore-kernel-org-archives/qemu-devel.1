Received: from eggs.gnu.org ([2001:4830:134:3::10]:56910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWm6d-0005eZ-GI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWm6Y-0007fJ-JY
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:41:31 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 13:41:15 -0300
Message-Id: <20180103164117.11850-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] pxa2xx_timer: ignore incorrect registers
 access to use U-Boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org

Hi,

tiny patches that allow to boot a Gumstix Connex board and use U-Boot.

Using https://wiki.gumstix.com/index.php/Making_qemu_images#Connex
Linux kernel also booting but crashes entering userland:

    $ arm-softmmu/qemu-system-arm -M connex -nographic -pflash cflash.img
    pxa2xx_clkcfg_write: CPU frequency change attempt
    pxa2xx_timer_write: incorrect reg 0xd8 (value 0x000000c9)
    pxa2xx_timer_write: incorrect reg 0x98 (value 0x00000001)
    pxa2xx_timer_write: incorrect reg 0x58 (value 0x00000001)


    U-Boot 1.2.0 (May 10 2008 - 21:17:19) - PXA270@400 MHz - 1604

    *** Welcome to Gumstix ***

    DRAM:  256 MB
    Flash: 16 MB
    Using default environment

    Hit any key to stop autoboot:  0 
    Instruction Cache is ON
    Copying kernel to 0xa2000000 from 0x00f00000 (length 0x00100000)...done
    ## Booting image at a2000000 ...
       Image Name:   Angstrom/2.6.21/gumstix-custom-c
       Image Type:   ARM Linux Kernel Image (uncompressed)
       Data Size:    1041252 Bytes = 1016.8 kB
       Load Address: a0008000
       Entry Point:  a0008000
    OK

    Starting kernel ...

    Linux version 2.6.21 (otto@otto) (gcc version 4.1.2) #1 PREEMPT Mon May 12 14:33:32 PDT 2008
    CPU: XScale-PXA255 [69052d00] revision 0 (ARMv5TE), cr=00007977
    Machine: The Gumstix Platform
    Memory policy: ECC disabled, Data cache writeback
    Memory clock: 0.00MHz (*0)
    Run Mode clock: 0.00MHz (*0)
    Turbo Mode clock: 0.00MHz (*2.0, active)
    CPU0: D VIVT write-back cache
    CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
    CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
    Built 1 zonelists.  Total pages: 65024
    Kernel command line: console=ttyS0,115200n8 root=1f01 rootfstype=jffs2 reboot=cold,hard
    PID hash table entries: 1024 (order: 10, 4096 bytes)
    Console: colour dummy device 80x30
    Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
    Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
    Memory: 256MB = 256MB total
    Memory: 257536KB available (1884K code, 191K data, 144K init)
    Mount-cache hash table entries: 512
    CPU: Testing write buffer coherency: ok
    NET: Registered protocol family 16
    Time: pxa_timer clocksource has been installed.
    NET: Registered protocol family 2
    IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
    TCP established hash table entries: 8192 (order: 4, 65536 bytes)
    TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
    TCP: Hash tables configured (established 8192 bind 8192)
    TCP reno registered
    JFFS2 version 2.2. (NAND) (SUMMARY)  (C) 2001-2006 Red Hat, Inc.
    io scheduler noop registered
    io scheduler cfq registered (default)
    Console: switching to colour frame buffer device 80x24
    pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 15) is a FFUART
    pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 14) is a BTUART
    pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 13) is a STUART
    pxa2xx-uart.3: ttyS3 at MMIO 0x41600000 (irq = 0) is a HWUART
    Probing Gumstix Flash ROM at physical address 0x00000000 (16-bit bankwidth)
    Gumstix Flash ROM: Found 1 x16 devices at 0x0 in 16-bit bank
     Intel/Sharp Extended Query Table at 0x0031
    Using buffer write method
    Using static partitions on Gumstix Flash ROM
    Creating 3 MTD partitions on "Gumstix Flash ROM":
    0x00000000-0x00040000 : "Bootloader"
    0x00040000-0x00f00000 : "RootFS"
    0x00f00000-0x01000000 : "Kernel"
    TCP cubic registered
    NET: Registered protocol family 1
    NET: Registered protocol family 17
    XScale DSP coprocessor detected.
    VFS: Mounted root (jffs2 filesystem).
    Freeing init memory: 144K
    INIT: version 2.86 booting
    qemu-system-arm: Trying to execute code outside RAM or ROM at 0x000618e8
    This usually means one of the following happened:

    (1) You told QEMU to execute a kernel for the wrong machine type, and it crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb QEMU machine)
    (2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU executed a ROM full of no-op instructions until it fell off the end
    (3) Your guest kernel has a bug and crashed by jumping off into nowhere

    This is almost always one of the first two, so check your command line and that you are using the right type of kernel for this machine.
    If you think option (3) is likely then you can try debugging your guest with the -d debug options; in particular -d guest_errors will cause the log to include a dump of the guest register state at this point.

    Execution cannot continue; stopping here.

    qemu: fatal: Trying to execute code outside RAM or ROM at 0x000618e8
    R00=00000000 R01=be9acd04 R02=000bd818 R03=000b1d78
    R04=000bd838 R05=000bd80c R06=00000001 R07=000bda88
    R08=00000000 R09=00000000 R10=401d7000 R11=00000000
    R12=00000000 R13=be9aca38 R14=000876b8 R15=000618e8
    PSR=60000010 -ZC- A usr32
    FPSCR: 00000000

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/timer/pxa2xx_timer: replace hw_error() -> qemu_log_mask()
  hw/sd/pxa2xx_mmci: add read/write() trace events

 hw/sd/pxa2xx_mmci.c     | 63 +++++++++++++++++++++++++++++++------------------
 hw/timer/pxa2xx_timer.c | 13 ++++++++--
 hw/sd/trace-events      |  4 ++++
 3 files changed, 55 insertions(+), 25 deletions(-)

-- 
2.15.1
