Received: from eggs.gnu.org ([2001:4830:134:3::10]:40552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dRtFB-00080G-Tc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 00:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dRtF7-0007m9-5N
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 00:45:53 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Mon,  3 Jul 2017 10:15:10 +0530
Message-Id: <1499057115-6773-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu devel v6 PATCH 0/5] Add support for Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com, f4bug@amsat.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Hi Qemu-devel,

I am trying to add Smartfusion2 SoC.
SoC is from Microsemi and System on Module(SOM)
board is from Emcraft systems. Smartfusion2 has hardened
Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
At the moment only system timer, sysreg and SPI
controller are modelled.

Testing:
./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial mon:stdio \
-kernel u-boot.bin -display none -drive file=spi.bin,if=mtd,format=raw

Binaries u-boot.bin and spi.bin are at:
https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git

U-boot is from Emcraft with modified
    - SPI driver not to use PDMA.
    - ugly hack to pass dtb to kernel in r1.
@
https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git

Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
driver added by myself @
https://github.com/Subbaraya-Sundeep/linux.git

v6:
    Moved some defines from header files to source files
    Added properties m3clk, apb0div, apb0div1 properties
    to soc.
    Added properties apb0divisor, apb1divisor to sysreg
    Update system_clock_source in msf2-soc.c
    Changed machine name smartfusion2-som->emcraft-sf2

v5
    As per Philippe comments:
        Added abort in Sysreg if guest tries to remap memory
        other than default mapping.
        Use of CONFIG_MSF2 in Makefile for soc.c
        Fixed incorrect logic in timer model.
        Renamed msf2-timer.c -> mss-timer.c
                msf2-spi.c -> mss-spi.c also type names
        Renamed function msf2_init->emcraft_sf2_init in msf2-som.c
        Added part-name,eNVM-size,eSRAM-size,pclk0 and pclk1
            properties to soc.
        Pass soc part-name,memory size and clock rate properties from som.
v4:
    Fixed build failure by using PRIx macros.
v3:
    Added SoC file and board file as per Alistair comments.
v2:
    Added SPI controller so that u-boot loads kernel from spi flash.
v1:
    Initial patch set with timer and sysreg

Thanks,
Sundeep

Subbaraya Sundeep (5):
  msf2: Add Smartfusion2 System timer
  msf2: Microsemi Smartfusion2 System Register block.
  msf2: Add Smartfusion2 SPI controller
  msf2: Add Smartfusion2 SoC.
  msf2: Add Emcraft's Smartfusion2 SOM kit.

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   2 +
 hw/arm/msf2-soc.c               | 216 +++++++++++++++++++++
 hw/arm/msf2-som.c               |  94 +++++++++
 hw/misc/Makefile.objs           |   1 +
 hw/misc/msf2-sysreg.c           | 200 +++++++++++++++++++
 hw/ssi/Makefile.objs            |   1 +
 hw/ssi/mss-spi.c                | 415 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs          |   1 +
 hw/timer/mss-timer.c            | 261 +++++++++++++++++++++++++
 include/hw/arm/msf2-soc.h       |  67 +++++++
 include/hw/misc/msf2-sysreg.h   |  82 ++++++++
 include/hw/ssi/mss-spi.h        |  62 ++++++
 include/hw/timer/mss-timer.h    |  67 +++++++
 14 files changed, 1470 insertions(+)
 create mode 100644 hw/arm/msf2-soc.c
 create mode 100644 hw/arm/msf2-som.c
 create mode 100644 hw/misc/msf2-sysreg.c
 create mode 100644 hw/ssi/mss-spi.c
 create mode 100644 hw/timer/mss-timer.c
 create mode 100644 include/hw/arm/msf2-soc.h
 create mode 100644 include/hw/misc/msf2-sysreg.h
 create mode 100644 include/hw/ssi/mss-spi.h
 create mode 100644 include/hw/timer/mss-timer.h

-- 
2.5.0
