Received: from eggs.gnu.org ([2001:4830:134:3::10]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xl-000724-Dt
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xg-0002pa-Jk
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:45 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:58:58 -0600
Message-Id: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 00/17] Add MVME3100 PPC SBC v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Changes since previous iteration.

openpic: debug w/ info_report()

  New

i2c: start trace-events
i2c: add mpc8540 i2c controller

  Debugging cleanup and fix a spurious warning triggered by Linux guests.

qtest: add e500_i2c_create()

  Unchanged

timer: generalize Dallas/Maxim RTC i2c devices
tests: rewrite testing for DS RTC devices

  Combined models of ds1338 and ds1375 RTCs, along with untested support
  for some similar chips.
  Test case for setting time to exercise offset calculation.

e500: fix pci host bridge class/type

  After further investigation, revert the change which caused the host bridge
  to be identified as a pci-pci bridge.

e500: additional CCSR registers

  Also update CPUPPCState::mpic_iack when changing CCSRBAR.

e500: additional CCSR registers
e500: move mpic under CCSR
e500: move uarts CCSR
e500: derive baud from CCB clock
e500: add i2c controller to CCSR
e500: move PCI host bridge into CCSR

  Moved MPIC, UARTS, and PCI host bridge under CCSR device.
  Many of the PPCE500Params members become properties of the CCSR device.

e500: split mpc8544ds specific initialization

  Split ppce500_init() to create mpc85xx_init().
  mpc85xx_init() has all the bits used by the exist mpc8544ds and ppce500 machines,
  but not by the new mvme3100 machine (which doesn't use PPCE500Params).

ppc: add mvme3100 machine

  Minor changes related to ppce500_init() changes

tests: run ds-rtc-i2c-test w/ ppc/mvme3100

  New

tests: add mvme3100-test

  Unchanged

Michael Davidsaver (17):
  openpic: debug w/ info_report()
  i2c: start trace-events
  i2c: add mpc8540 i2c controller
  qtest: add e500_i2c_create()
  timer: generalize Dallas/Maxim RTC i2c devices
  tests: rewrite testing for DS RTC devices
  e500: fix pci host bridge class/type
  e500: additional CCSR registers
  e500: move mpic under CCSR
  e500: move uarts CCSR
  e500: derive baud from CCB clock
  e500: add i2c controller to CCSR
  e500: move PCI host bridge into CCSR
  e500: split mpc8544ds specific initialization
  ppc: add mvme3100 machine
  tests: run ds-rtc-i2c-test w/ ppc/mvme3100
  tests: add mvme3100-test

 Makefile.objs                   |   1 +
 default-configs/arm-softmmu.mak |   2 +-
 default-configs/ppc-softmmu.mak |   1 +
 hw/i2c/Makefile.objs            |   1 +
 hw/i2c/mpc8540_i2c.c            | 307 +++++++++++++++++
 hw/i2c/trace-events             |   7 +
 hw/intc/openpic.c               | 102 +++---
 hw/pci-host/ppce500.c           |   5 -
 hw/ppc/Makefile.objs            |   1 +
 hw/ppc/e500.c                   | 175 +++-------
 hw/ppc/e500.h                   |   3 +-
 hw/ppc/e500_ccsr.c              | 246 ++++++++++++-
 hw/ppc/e500plat.c               |   2 +-
 hw/ppc/mpc8544ds.c              |   2 +-
 hw/ppc/mvme3100.c               | 740 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/mvme3100_cpld.c          | 192 +++++++++++
 hw/timer/Makefile.objs          |   2 +-
 hw/timer/ds-rtc-i2c.c           | 461 +++++++++++++++++++++++++
 hw/timer/ds1338.c               | 239 -------------
 tests/Makefile.include          |   9 +-
 tests/ds-rtc-i2c-test.c         | 170 +++++++++
 tests/ds1338-test.c             |  77 -----
 tests/libqos/i2c-e500.c         |  66 ++++
 tests/libqos/i2c.h              |   3 +
 tests/mvme3100-test.c           |  79 +++++
 25 files changed, 2376 insertions(+), 517 deletions(-)
 create mode 100644 hw/i2c/mpc8540_i2c.c
 create mode 100644 hw/i2c/trace-events
 create mode 100644 hw/ppc/mvme3100.c
 create mode 100644 hw/ppc/mvme3100_cpld.c
 create mode 100644 hw/timer/ds-rtc-i2c.c
 delete mode 100644 hw/timer/ds1338.c
 create mode 100644 tests/ds-rtc-i2c-test.c
 delete mode 100644 tests/ds1338-test.c
 create mode 100644 tests/libqos/i2c-e500.c
 create mode 100644 tests/mvme3100-test.c

-- 
2.11.0
