Received: from eggs.gnu.org ([2001:4830:134:3::10]:37251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchU-0001e6-Md
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchT-0006RJ-Fy
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:48 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:08 -0600
Message-Id: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 00/12] Add MVME3100 PPC SBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

This series adds simulation of MVME3100 powerpc SBCs, originally from Motorola,
and now sold by Artesyn[1].  There are two variants differing in CPU
speed and memory size.

I've been working on this sporadically for the past 2 year.  Recently I've
finished all the features which I have in mind.  If this series is accepted
there is a continuation which adds VME bus.  I've found it
useful in software compatibility testing.  I wonder if there is
any interest at large?


There are two main parts of this series.  1-5 are changing code common
with the "ppce500" and "mpc8544ds" boards, with the remainder being
additions.

The changes are to how the CCSR region is handled in order to support
the CCSRBAR register which allows the whole region to be relocated.
Also added are a couple of memory and clock configuration registers
which RTEMS guests read.

#3 is actually a minor issue I found recently with the mpc8544 PCI host bridge,
which I'm uncertain how to address.  The host bridge device 0:0 identifies
itself as a bridge, but doesn't properly implement the bridge config registers.
This confuses Linux, which then does a full re-enumeration (successfully).

The rest are additions of an I2C controller, an I2C eeprom, an I2C RTC,
and new board code.

My testing has been almost exclusively with an RTEMS guest[2].
Though I have recently done a little with Linux.

RTEMS guests (and Linux too for now) require a stub bootloader[3] to
put the system in the same state as the real bootloader.
RTEMS has an unfortunately strong dependence on bootloader
provided configuration (eg. it doesn't re-enumerate the PCI bus).


[1] https://www.artesyn.com/computing/products/product/mvme3100-vme-board-with-freescale-mpc8540-system-on-chip-processor

[2] https://www.rtems.org/

[3] https://github.com/mdavidsaver/qemu/wiki


Michael Davidsaver (12):
  e500: add board config options
  e500: consolidate mpc8540 guts with e500-ccsr
  e500: note possible bug with host bridge
  e500: additional CCSR registers
  e500: name openpic and pci host bridge
  i2c: add mpc8540 i2c controller
  qtest: add e500_i2c_create()
  e500: add mpc8540 i2c controller to ccsr
  nvram: add AT24Cx i2c eeprom
  timer: add ds1375 RTC
  ppc: add mvme3100 machine
  tests: add mvme3100-test

 default-configs/ppc-softmmu.mak |   1 +
 hw/i2c/Makefile.objs            |   1 +
 hw/i2c/mpc8540_i2c.c            | 287 +++++++++++++++++
 hw/nvram/Makefile.objs          |   1 +
 hw/nvram/eeprom_at24c.c         | 205 ++++++++++++
 hw/pci-host/ppce500.c           |  13 +-
 hw/ppc/Makefile.objs            |   4 +-
 hw/ppc/e500-ccsr.h              |  17 -
 hw/ppc/e500.c                   |  59 ++--
 hw/ppc/e500.h                   |   4 +
 hw/ppc/e500_ccsr.c              | 220 +++++++++++++
 hw/ppc/e500plat.c               |   2 +
 hw/ppc/mpc8544_guts.c           | 143 ---------
 hw/ppc/mpc8544ds.c              |   2 +
 hw/ppc/mvme3100.c               | 688 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/mvme3100_cpld.c          | 192 +++++++++++
 hw/timer/Makefile.objs          |   1 +
 hw/timer/ds1375-i2c.c           | 293 +++++++++++++++++
 tests/Makefile.include          |   4 +
 tests/libqos/i2c-e500.c         |  66 ++++
 tests/libqos/i2c.h              |   3 +
 tests/mvme3100-test.c           |  79 +++++
 22 files changed, 2083 insertions(+), 202 deletions(-)
 create mode 100644 hw/i2c/mpc8540_i2c.c
 create mode 100644 hw/nvram/eeprom_at24c.c
 delete mode 100644 hw/ppc/e500-ccsr.h
 create mode 100644 hw/ppc/e500_ccsr.c
 delete mode 100644 hw/ppc/mpc8544_guts.c
 create mode 100644 hw/ppc/mvme3100.c
 create mode 100644 hw/ppc/mvme3100_cpld.c
 create mode 100644 hw/timer/ds1375-i2c.c
 create mode 100644 tests/libqos/i2c-e500.c
 create mode 100644 tests/mvme3100-test.c

-- 
2.11.0
