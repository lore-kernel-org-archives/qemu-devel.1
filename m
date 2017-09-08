Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe0-00024u-Mp
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdv-00038X-Ea
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:16 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:18 +1000
Message-Id: <20170908103558.31632-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/40] ppc-for-2.11 queue 20170908
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc=
76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170908

for you to fetch changes up to 7cca3e466eb0baa36d1cc29d5aeb5da74a260711:

  ppc: spapr: Move VCPU ID calculation into sPAPR (2017-09-08 09:30:55 +1=
000)

----------------------------------------------------------------
ppc patch queue 2017-09-08

This is the first batch of ppc related patches for qemu-2.11, and it's
accumulated quite a few things.  Includes:

  * A cleanup to handling of ppc cpu models from Igor
  * First parts of fixes to handling of guest vs. host SMT modes from
    Sam Bobroff
  * Preliminary patches towards supporting the Sam460 board from
    Balaton Zoltan
  * Several fixes for hotplug logic
  * Assorted other fixes and cleanups

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      spapr_iommu: Realloc guest visible TCE table when hot(un)plugging v=
fio-pci

BALATON Zoltan (6):
      ppc4xx: Move MAL from ppc405_uc to ppc4xx_devs
      ppc4xx: Make MAL emulation more generic
      ppc4xx: Split off 4xx I2C emulation from ppc405_uc to its own file
      ppc4xx_i2c: QOMify
      ppc4xx_i2c: Move to hw/i2c
      ppc4xx: Export ECB and PLB emulation

Daniel Henrique Barboza (3):
      hw/ppc/spapr_drc.c: change spapr_drc_needed to use drc->dev
      hw/ppc: clear pending_events on machine reset
      hw/ppc: CAS reset on early device hotplug

Greg Kurz (9):
      spapr_pci: use memory_region_add_subregion() with DMA windows
      spapr_iommu: use g_strdup_printf() instead of snprintf()
      spapr_drc: use g_strdup_printf() instead of snprintf()
      spapr_iommu: convert TCE table object to realize()
      spapr_pci: parent the MSI memory region to the PHB
      spapr_drc: add unrealize method to physical DRC class
      spapr_iommu: unregister vmstate at unrealize time
      spapr: add pseries-2.11 machine type
      spapr: fallback to raw mode if best compat mode cannot be set durin=
g CAS

Igor Mammedov (7):
      ppc: use macros to make cpu type name from string literal
      ppc: make cpu_model translation to type consistent
      ppc: make cpu alias point only to real cpu models
      ppc: replace inter-function cyclic dependency/recurssion with 2 sim=
ple lookups
      ppc: simplify cpu model lookup by PVR
      ppc: drop caching ObjectClass from PowerPCCPUAlias
      ppc: remove non implemented cpu models

KONRAD Frederic (4):
      booke206: fix booke206_tlbnps for mav 2.0
      booke206: fix tlbnps for fixed size TLB
      booke206: allow to specify an mmucfg value at the init
      ppc64: introduce e6500

Michael Roth (2):
      spapr_drc: pass object ownership to parent/owner
      spapr_iommu: pass object ownership to parent/owner

Sam Bobroff (5):
      e500: Use cpu_index instead of vcpu_dt_id
      ppc: spapr: Rename cpu_dt_id to vcpu_id
      ppc: spapr: Make VCPU ID handling private to SPAPR
      PPC: KVM: Support machine option to set VSMT mode
      ppc: spapr: Move VCPU ID calculation into sPAPR

Thomas Huth (3):
      hw/ppc/spapr_cpu_core: Add a proper check for spapr machine
      hw/nvram/spapr_nvram: Device can not be created by the users
      target/ppc: Remove old STATUS file

 default-configs/ppc-softmmu.mak    |    1 +
 default-configs/ppc64-softmmu.mak  |    1 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/i2c/Makefile.objs               |    1 +
 hw/i2c/ppc4xx_i2c.c                |  216 ++++++++
 hw/nvram/spapr_nvram.c             |    2 +
 hw/ppc/e500.c                      |    8 +-
 hw/ppc/ppc.c                       |   21 -
 hw/ppc/ppc405.h                    |    3 +
 hw/ppc/ppc405_uc.c                 |  515 +-----------------
 hw/ppc/ppc4xx_devs.c               |  227 ++++++++
 hw/ppc/spapr.c                     |  166 +++++-
 hw/ppc/spapr_cpu_core.c            |   40 +-
 hw/ppc/spapr_drc.c                 |   37 +-
 hw/ppc/spapr_events.c              |   11 +
 hw/ppc/spapr_hcall.c               |   22 +-
 hw/ppc/spapr_iommu.c               |   57 +-
 hw/ppc/spapr_pci.c                 |    6 +-
 hw/ppc/spapr_rtas.c                |    4 +-
 include/hw/i2c/ppc4xx_i2c.h        |   61 +++
 include/hw/ppc/ppc4xx.h            |    3 +
 include/hw/ppc/spapr.h             |    5 +
 include/hw/ppc/spapr_drc.h         |    1 +
 scripts/device-crash-test          |    3 +
 target/ppc/STATUS                  |  550 -------------------
 target/ppc/cpu-models.c            | 1021 ++++++++++--------------------=
------
 target/ppc/cpu-models.h            |    4 +-
 target/ppc/cpu.h                   |   51 +-
 target/ppc/kvm.c                   |   46 +-
 target/ppc/kvm_ppc.h               |   14 +-
 target/ppc/mmu_helper.c            |   16 +-
 target/ppc/translate_init.c        |  232 ++++----
 32 files changed, 1310 insertions(+), 2036 deletions(-)
 create mode 100644 hw/i2c/ppc4xx_i2c.c
 create mode 100644 include/hw/i2c/ppc4xx_i2c.h
 delete mode 100644 target/ppc/STATUS
