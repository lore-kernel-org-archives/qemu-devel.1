Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dulRR-0007l3-Ch
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dulRO-0002VZ-7X
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:17:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Sep 2017 17:17:32 -0300
Message-Id: <20170920201737.25723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 0/5] Add support for Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi Peter,

Now than Igor's patch landed, I respin Sundeep's series updating it to work
after the "arm: drop intermediate cpu_model -> cpu type parsing and use cpu
type directly" patch.

v11:
- msf2-soc.c: add a check for null m3clk
- msf2-soc.c, msf2-som.c: drop cpu_model to directly use cpu type

--

Sundeep original cover:

I am trying to add Smartfusion2 SoC.
SoC is from Microsemi and System on Module(SOM)
board is from Emcraft systems. Smartfusion2 has hardened
Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
At the moment only system timer, sysreg and SPI
controller are modelled.

Testing:
./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio \
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

v10:
    Added msf2_sysreg_realize in msf2-sysreg.c
    modified unimplemented devices names:
        pdma->dma and hpdma->hs-dma
    used uint8_t for apb divisors properties
    simplified msf2_divbits() using ctz32()

v9:
    used trace instead of DB_PRINT in msf2-sysreg.c
    used LOG_UNIMP for non guest errors in msf2-sysreg.c
    added unimplemented devices in msf2-soc.c
    removed .alias suffix in alias memory region name for eNVM
    removed mc->ignore_memory_transaction_failures in msf2-som.c

v8:
    memory_region_init_ram to memory_region_init_rom in soc
    %s/emcraft_sf2_init/emcraft_sf2_s2s010_init/g in som
    Added mc->ignore_memory_transaction_failures = true in som
        as per latest commit.
    Code simplifications as suggested by Alistair in sysreg and ssi.

v7:
    Removed vmstate_register_ram_global as per latest commit
    Moved header files to C which are local to C source files
    Removed abort() from msf2-sysreg.c
    Added VMStateDescription in mss-timer.c

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
  msf2: Microsemi Smartfusion2 System Register block
  msf2: Add Smartfusion2 SPI controller
  msf2: Add Smartfusion2 SoC
  msf2: Add Emcraft's Smartfusion2 SOM kit

 default-configs/arm-softmmu.mak |   1 +
 include/hw/arm/msf2-soc.h       |  67 +++++++
 include/hw/misc/msf2-sysreg.h   |  77 ++++++++
 include/hw/ssi/mss-spi.h        |  58 ++++++
 include/hw/timer/mss-timer.h    |  64 +++++++
 hw/arm/msf2-soc.c               | 238 +++++++++++++++++++++++
 hw/arm/msf2-som.c               | 105 +++++++++++
 hw/misc/msf2-sysreg.c           | 160 ++++++++++++++++
 hw/ssi/mss-spi.c                | 404 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/mss-timer.c            | 289 ++++++++++++++++++++++++++++
 hw/arm/Makefile.objs            |   1 +
 hw/misc/Makefile.objs           |   1 +
 hw/misc/trace-events            |   5 +
 hw/ssi/Makefile.objs            |   1 +
 hw/timer/Makefile.objs          |   1 +
 15 files changed, 1472 insertions(+)
 create mode 100644 include/hw/arm/msf2-soc.h
 create mode 100644 include/hw/misc/msf2-sysreg.h
 create mode 100644 include/hw/ssi/mss-spi.h
 create mode 100644 include/hw/timer/mss-timer.h
 create mode 100644 hw/arm/msf2-soc.c
 create mode 100644 hw/arm/msf2-som.c
 create mode 100644 hw/misc/msf2-sysreg.c
 create mode 100644 hw/ssi/mss-spi.c
 create mode 100644 hw/timer/mss-timer.c

-- 
2.14.1
