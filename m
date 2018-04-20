Received: from eggs.gnu.org ([2001:4830:134:3::10]:43309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPJ-0006Iz-Q3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPI-0007oi-Sy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPI-0007mN-Ht
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:36 +0100
Message-Id: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/13] Drop compile time limit on number of
 serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

For many years, QEMU has had a compile time restriction on how
many serial port devices you can create and configure with the
-serial argument. This is 4, largely because for x86 PC the
traditional number of ISA serial devices is 4, and nobody's
ever changed the limit since.

This patchset drops the compile time limit.

The first patch removes an unnecessary check in hw/char/serial
that insisted that it was not talking to a NULL chardev.
Our newly set direction is that we want to allow NULL chardev
pointers, rather than requiring UARTs and boards to create
"null" backends, so drop the check. (I have looked at the code
and it should all be fine with a NULL pointer here, including
the tricky bit where qemu_chr_fe_add_watch() returns 0 and
the required behaviour is "insta-drain the FIFO".)

The next 4 patches drop unnecessary creations of "null" chardevs.
These have to go here because in most cases they were writing
back to the serial_hds[] array, which is about to go away.

Patch 6 implements an accessor function serial_hd() which can
be used to replace direct reads of serial_hds[].

Patch 7 is purely mechanical and replaces serial_hds[x]
with serial_hd(x).

Patches 8 through 11 remove or rename various uses of the
MAX_SERIAL_PORTS #define that shouldn't really be using it.

Patch 12 then makes the serial_hds array be dynamically
reallocated.

Patch 13 adds a "what actually is the highest serial_hds entry"
function for the benefit of spapr, which is the only remaining
user of MAX_SERIAL_PORTS.

Testing: I tested mips-malta and imx6 by hand; others are only
tested via 'make check' (which did find some bugs for me!)

thanks
-- PMM

Peter Maydell (13):
  hw/char/serial: Allow disconnected chardevs
  hw/arm/fsl-imx*: Don't create "null" chardevs for serial devices
  hw/mips/boston.c: Don't create "null" chardevs for serial devices
  hw/mips/mips_malta: Don't create "null" chardevs for serial devices
  hw/xtensa/xtfpga.c: Don't create "null" chardevs for serial devices
  vl.c: Provide accessor function serial_hd() for serial_hds[] array
  Change references to serial_hds[] to serial_hd()
  Remove checks on MAX_SERIAL_PORTS that are just bounds checks
  hw/char/exynos4210_uart.c: Remove unneeded handling of NULL chardev
  serial-isa: Use MAX_ISA_SERIAL_PORTS instead of MAX_SERIAL_PORTS
  superio: Don't use MAX_SERIAL_PORTS for serial port limit
  vl.c: Remove compile time limit on number of serial ports
  vl.c: new function max_serial_hds()

 include/hw/char/serial.h                 |  3 +++
 include/hw/isa/superio.h                 |  4 +++-
 include/sysemu/sysemu.h                  |  9 +++++---
 hw/arm/allwinner-a10.c                   |  4 ++--
 hw/arm/aspeed_soc.c                      |  4 ++--
 hw/arm/bcm2835_peripherals.c             |  4 ++--
 hw/arm/digic.c                           |  2 +-
 hw/arm/fsl-imx25.c                       | 14 +-----------
 hw/arm/fsl-imx31.c                       | 14 +-----------
 hw/arm/fsl-imx6.c                        | 17 ++-------------
 hw/arm/fsl-imx7.c                        |  4 +---
 hw/arm/highbank.c                        |  2 +-
 hw/arm/integratorcp.c                    |  4 ++--
 hw/arm/kzm.c                             |  4 ++--
 hw/arm/mps2-tz.c                         |  3 +--
 hw/arm/mps2.c                            |  6 ++----
 hw/arm/msf2-soc.c                        |  4 ++--
 hw/arm/musicpal.c                        |  8 +++----
 hw/arm/omap1.c                           |  6 +++---
 hw/arm/omap2.c                           | 10 ++++-----
 hw/arm/pxa2xx.c                          | 16 +++++++-------
 hw/arm/realview.c                        |  8 +++----
 hw/arm/stellaris.c                       |  2 +-
 hw/arm/stm32f205_soc.c                   |  3 +--
 hw/arm/strongarm.c                       |  2 +-
 hw/arm/versatilepb.c                     |  8 +++----
 hw/arm/vexpress.c                        |  8 +++----
 hw/arm/virt.c                            |  4 ++--
 hw/arm/xilinx_zynq.c                     |  4 ++--
 hw/arm/xlnx-zynqmp.c                     |  2 +-
 hw/char/exynos4210_uart.c                | 20 ------------------
 hw/char/serial-isa.c                     | 14 ++++++------
 hw/char/serial.c                         |  5 -----
 hw/char/xen_console.c                    |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/hppa/machine.c                        |  4 ++--
 hw/i386/pc.c                             |  2 +-
 hw/isa/isa-superio.c                     |  4 ++--
 hw/lm32/lm32_boards.c                    |  8 +++----
 hw/lm32/milkymist.c                      |  4 ++--
 hw/m68k/mcf5206.c                        |  4 ++--
 hw/m68k/mcf5208.c                        |  6 +++---
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/boston.c                         |  6 +-----
 hw/mips/mips_jazz.c                      |  8 +++----
 hw/mips/mips_malta.c                     |  7 +-----
 hw/mips/mips_mipssim.c                   |  4 ++--
 hw/mips/mips_r4k.c                       |  2 +-
 hw/misc/macio/macio.c                    |  4 ++--
 hw/moxie/moxiesim.c                      |  4 ++--
 hw/nios2/10m50_devboard.c                |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/ppc/e500.c                            | 12 +++++------
 hw/ppc/pnv.c                             |  2 +-
 hw/ppc/ppc405_uc.c                       | 16 +++++++-------
 hw/ppc/ppc440_bamboo.c                   |  8 +++----
 hw/ppc/sam460ex.c                        |  8 +++----
 hw/ppc/spapr.c                           |  6 +++---
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/riscv/sifive_e.c                      |  4 ++--
 hw/riscv/sifive_u.c                      |  4 ++--
 hw/riscv/spike.c                         |  4 ++--
 hw/riscv/virt.c                          |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sh4/sh7750.c                          |  4 ++--
 hw/sparc/leon3.c                         |  4 ++--
 hw/sparc/sun4m.c                         |  4 ++--
 hw/sparc64/niagara.c                     |  4 ++--
 hw/sparc64/sun4u.c                       |  4 ++--
 hw/xtensa/sim.c                          |  4 ++--
 hw/xtensa/xtfpga.c                       |  6 +-----
 vl.c                                     | 27 ++++++++++++++++++------
 73 files changed, 184 insertions(+), 244 deletions(-)

-- 
2.17.0
