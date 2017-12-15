Received: from eggs.gnu.org ([2001:4830:134:3::10]:53038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixH-0003Zf-E8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixG-0004YM-Cw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:11 +1100
Message-Id: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/24] ppc-for-2.12 queue 20171215
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b=
6d:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' =
into staging (2017-12-14 15:32:32 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20171215

for you to fetch changes up to 1481fe5fcfeb7fcf3c1ebb9d8c0432e3e0188ccf:

  spapr: don't initialize PATB entry if max-cpu-compat < power9 (2017-12-=
15 09:50:29 +1100)

----------------------------------------------------------------
ppc patch queue 2017-12-15

First pull request for qemu-2.12.  This has quite a bit of stuff
accumulated while 2.11 was finalizing.  Highlights are:

  * Some preliminary work towards implementing the "XIVE" POWER9
    interrupt controller
  * Some fixes for problems during reboot with MTTCG
  * A substantial TCG performance improvement via
    tcg_get_lookup_and_goto_ptr
  * Numerous assorted cleanups and bugfixes that weren't urgent enough
    for 2.11

----------------------------------------------------------------
C=C3=A9dric Le Goater (11):
      ppc/xics: remove useless if condition
      pcc: define the Power-saving mode Exit Cause Enable bits in PowerPC=
CPUClass
      spapr/rtas: disable the decrementer interrupt when a CPU is unplugg=
ed
      spapr/rtas: fix reboot of a a SMP TCG guest
      spapr/rtas: do not reset the MSR in stop-self command
      ppc/xics: introduce an icp_create() helper
      ppc/xics: assign of the CPU 'intc' pointer under the core
      spapr: move the IRQ allocation routines under the machine
      spapr: introduce a spapr_irq_set_lsi() helper
      spapr: introduce a spapr_qirq() helper
      target/ppc: introduce the PPC_BIT() macro

David Gibson (3):
      spapr: Add pseries-2.12 machine type
      spapr: Rename machine init functions for clarity
      spapr: Assume msi_nonbroken

Greg Kurz (3):
      spapr_cpu_core: instantiate CPUs separately
      spapr: fix LSI interrupt specifiers in the device tree
      spapr_events: drop bogus cell from "interrupt-ranges" property

Igor Mammedov (1):
      spapr: replace numa_get_node() with lookup in pc-dimm list

Laurent Vivier (1):
      spapr: don't initialize PATB entry if max-cpu-compat < power9

Michael Davidsaver (4):
      e500: name openpic and pci host bridge
      nvram: add AT24Cx i2c eeprom
      openpic: debug w/ info_report()
      e500: fix pci host bridge class/type

Richard Henderson (1):
      target/ppc: Use tcg_gen_lookup_and_goto_ptr

 hw/intc/openpic.c               | 102 +++++++++---------
 hw/intc/trace-events            |   4 -
 hw/intc/xics.c                  |  34 +++---
 hw/intc/xics_spapr.c            | 116 ---------------------
 hw/mem/pc-dimm.c                |   2 -
 hw/nvram/Makefile.objs          |   1 +
 hw/nvram/eeprom_at24c.c         | 205 ++++++++++++++++++++++++++++++++++=
+++
 hw/pci-host/ppce500.c           |   5 -
 hw/ppc/e500.c                   |   4 +
 hw/ppc/pnv_core.c               |  10 +-
 hw/ppc/spapr.c                  | 222 ++++++++++++++++++++++++++++++++++=
+-----
 hw/ppc/spapr_cpu_core.c         |  41 ++++----
 hw/ppc/spapr_events.c           |  22 ++--
 hw/ppc/spapr_pci.c              |  13 ++-
 hw/ppc/spapr_rtas.c             |  21 ++--
 hw/ppc/spapr_vio.c              |   5 +-
 hw/ppc/trace-events             |   4 +
 include/hw/compat.h             |   2 +
 include/hw/pci-host/spapr.h     |   2 +-
 include/hw/ppc/spapr.h          |  17 +++
 include/hw/ppc/spapr_cpu_core.h |   2 +-
 include/hw/ppc/spapr_vio.h      |   2 +-
 include/hw/ppc/xics.h           |   8 +-
 include/sysemu/numa.h           |  10 --
 numa.c                          |  94 -----------------
 target/ppc/cpu-qom.h            |   1 +
 target/ppc/cpu.h                | 105 ++++++++++---------
 target/ppc/translate.c          |  23 ++---
 target/ppc/translate_init.c     |  26 ++---
 29 files changed, 636 insertions(+), 467 deletions(-)
 create mode 100644 hw/nvram/eeprom_at24c.c
