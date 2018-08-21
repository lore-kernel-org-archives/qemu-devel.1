Received: from eggs.gnu.org ([2001:4830:134:3::10]:56343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMk-000443-5s
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMe-0000Cm-Tx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:17 +1000
Message-Id: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/26] ppc-for-3.1 queue 20180821
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit d0092d90eb546a8bbe9e9120426c1894741237=
97:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into =
staging (2018-08-20 17:41:18 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.1-20180821

for you to fetch changes up to 0e3bf4890906fa7066a5deafd6ab033934b8d100:

  ppc: add DBCR based debugging (2018-08-21 14:28:45 +1000)

----------------------------------------------------------------
ppc patch queue 2018-08-21

Here's my first ppc & spapr pull request for qemu-3.1.  This contains
a bunch of things that have accumulated while 3.0 was in freeze.
Highlights are:
    * SLOF firmware update
    * A number of floating point cleanups from Richard Henderson and
      Yasmin Beatriz
    * A new model for assigning irq numbers on spapr, this is an
      important preliminary step towards implementing the POWER9
      "XIVE" interrupt controller

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      pseries: Update SLOF firmware image
      vfio/spapr: Allow backing bigger guest IOMMU pages with smaller phy=
sical pages

Bharata B Rao (1):
      spapr_cpu_core: vmstate_[un]register per-CPU data from (un)realizef=
n

C=C3=A9dric Le Goater (4):
      spapr: Add a pseries-3.1 machine type
      spapr: introduce a fixed IRQ number space
      spapr: introduce a IRQ controller backend to the machine
      spapr_pci: factorize the use of SPAPR_MACHINE_GET_CLASS()

Greg Kurz (1):
      xics: don't include "target/ppc/cpu-qom.h" in "hw/ppc/xics.h"

Herv=C3=A9 Poussineau (2):
      hw/ppc: deprecate the machine type 'prep', replaced by '40p'
      qemu-doc: mark ppc/prep machine as deprecated

Mark Cave-Ayland (3):
      40p: don't use legacy fw_cfg_init_mem() function
      mac_oldworld: don't use legacy fw_cfg_init_mem() function
      mac_newworld: don't use legacy fw_cfg_init_mem() function

Peter Maydell (3):
      hw/ppc/prep: Remove ifdeffed-out stub of XCSR code
      hw/ppc/ppc_boards: Don't use old_mmio for ref405ep_fpga
      hw/ppc/ppc405_uc: Convert away from old_mmio

Richard Henderson (7):
      target/ppc: Enable fp exceptions for user-only
      target/ppc: Honor fpscr_ze semantics and tidy fdiv
      target/ppc: Tidy helper_fmul
      target/ppc: Tidy helper_fadd, helper_fsub
      target/ppc: Tidy helper_fsqrt
      target/ppc: Honor fpscr_ze semantics and tidy fre, fresqrt
      target/ppc: Use non-arithmetic conversions for fp load/store

Roman Kapl (1):
      ppc: add DBCR based debugging

Yasmin Beatriz (2):
      target/ppc: bcdsub fix sign when result is zero
      target/ppc: simplify bcdadd/sub functions

 hw/ppc/Makefile.objs               |   2 +-
 hw/ppc/mac_newworld.c              |  12 +-
 hw/ppc/mac_oldworld.c              |  12 +-
 hw/ppc/ppc405_boards.c             |  60 ++------
 hw/ppc/ppc405_uc.c                 | 173 ++++------------------
 hw/ppc/prep.c                      | 111 ++------------
 hw/ppc/spapr.c                     | 225 +++++++---------------------
 hw/ppc/spapr_cpu_core.c            |  63 ++++----
 hw/ppc/spapr_events.c              |  12 +-
 hw/ppc/spapr_irq.c                 | 286 +++++++++++++++++++++++++++++++=
+++++
 hw/ppc/spapr_pci.c                 |  32 +++-
 hw/ppc/spapr_vio.c                 |  66 ++++++++-
 hw/vfio/common.c                   |   3 +
 hw/vfio/spapr.c                    |  21 ++-
 include/hw/ppc/spapr.h             |  16 +-
 include/hw/ppc/spapr_irq.h         |  54 +++++++
 include/hw/ppc/xics.h              |   1 -
 include/hw/vfio/vfio-common.h      |   1 +
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 924840 -> 974544 bytes
 qemu-deprecated.texi               |   6 +
 roms/SLOF                          |   2 +-
 target/ppc/cpu.h                   |   5 +
 target/ppc/excp_helper.c           |  11 +-
 target/ppc/fpu_helper.c            | 292 ++++++++++++++++++++++---------=
------
 target/ppc/helper.h                |  14 +-
 target/ppc/int_helper.c            |  46 +++---
 target/ppc/translate.c             | 107 ++++++++++----
 target/ppc/translate/fp-impl.inc.c |  26 ++--
 target/ppc/translate_init.inc.c    |  19 +++
 tests/boot-serial-test.c           |   2 -
 31 files changed, 946 insertions(+), 736 deletions(-)
 create mode 100644 hw/ppc/spapr_irq.c
 create mode 100644 include/hw/ppc/spapr_irq.h
