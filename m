Received: from eggs.gnu.org ([2001:4830:134:3::10]:59933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdg-0000Ue-An
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDde-0006yo-HG
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:26 +1100
Message-Id: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/40] ppc-for-4.0 queue 20181221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 95de6f4b92efea391a3cbb8651d774a4d35298=
61:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-12-20'=
 into staging (2018-12-20 18:54:47 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181221

for you to fetch changes up to b62c6e1237fb5ca2563f7e72b66ac0c40ff7a714:

  MAINTAINERS: PPC: add a XIVE section (2018-12-21 09:40:43 +1100)

----------------------------------------------------------------
ppc patch queue 2018-12-21

This pull request supersedes the one from 2018-12-13.

This is a revised first ppc pull request for qemu-4.0.  Highlights
are:

 * Most of the code for the POWER9 "XIVE" interrupt controller
   (not complete yet, but we're getting there)
 * A number of g_new vs. g_malloc cleanups
 * Some IRQ wiring cleanups
 * A fix for how we advertise NUMA nodes to the guest for pseries

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      spapr-iommu: Always advertise the maximum possible DMA window size

C=C3=A9dric Le Goater (25):
      target/ppc: fix the PPC_BIT definitions
      ppc/xive: introduce a XIVE interrupt source model
      ppc/xive: add support for the LSI interrupt sources
      ppc/xive: introduce the XiveNotifier interface
      ppc/xive: introduce the XiveRouter model
      ppc/xive: introduce the XIVE Event Notification Descriptors
      spapr: initialize VSMT before initializing the IRQ backend
      spapr: introduce a spapr_irq_init() routine
      spapr: export and rename the xics_max_server_number() routine
      ppc/xive: add support for the END Event State Buffers
      ppc/xive: introduce the XIVE interrupt thread context
      ppc/xive: introduce a simplified XIVE presenter
      ppc/xive: notify the CPU when the interrupt priority is more privil=
eged
      spapr/xive: introduce a XIVE interrupt controller
      spapr/xive: use the VCPU id as a NVT identifier
      spapr: introduce a new machine IRQ backend for XIVE
      spapr: add hcalls support for the XIVE exploitation interrupt mode
      spapr: add device tree support for the XIVE exploitation mode
      spapr: allocate the interrupt thread context under the CPU core
      spapr: extend the sPAPR IRQ backend for XICS migration
      spapr: add a 'reset' method to the sPAPR IRQ backend
      spapr: add an extra OV5 field to the sPAPR IRQ backend
      spapr: introduce an 'ic-mode' machine option
      spapr: change default CPU type to POWER9
      MAINTAINERS: PPC: add a XIVE section

David Gibson (1):
      target/ppc: Remove silly GETFIELD/SETFIELD/MASK_TO_LSH macros

Greg Kurz (10):
      spapr: drop redundant statement in spapr_populate_drconf_memory()
      target/ppc: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      spapr: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc405_boards: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc405_uc: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      ppc440_bamboo: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      sam460ex: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      virtex_ml507: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      mac_newworld: simplify IRQ wiring
      e500: simplify IRQ wiring

Paul A. Clarke (1):
      Changes requirement for "vsubsbs" instruction

Serhii Popovych (1):
      spapr: Fix ibm,max-associativity-domains property number of nodes

Suraj Jitindar Singh (1):
      target/ppc: tcg: Implement addex instruction

 MAINTAINERS                        |    8 +
 default-configs/ppc64-softmmu.mak  |    2 +
 disas/ppc.c                        |    2 +
 hw/intc/Makefile.objs              |    2 +
 hw/intc/spapr_xive.c               | 1486 ++++++++++++++++++++++++++++++=
+++
 hw/intc/xics_spapr.c               |    3 +-
 hw/intc/xive.c                     | 1599 ++++++++++++++++++++++++++++++=
++++++
 hw/ppc/e500.c                      |   18 +-
 hw/ppc/mac_newworld.c              |   30 +-
 hw/ppc/ppc405_boards.c             |    4 +-
 hw/ppc/ppc405_uc.c                 |    4 +-
 hw/ppc/ppc440_bamboo.c             |    5 +-
 hw/ppc/sam460ex.c                  |    2 +-
 hw/ppc/spapr.c                     |  121 ++-
 hw/ppc/spapr_cpu_core.c            |    4 +-
 hw/ppc/spapr_iommu.c               |    2 +-
 hw/ppc/spapr_irq.c                 |  194 ++++-
 hw/ppc/spapr_rtas_ddw.c            |   19 +-
 hw/ppc/spapr_vio.c                 |    2 +-
 hw/ppc/virtex_ml507.c              |    2 +-
 include/hw/ppc/openpic.h           |    2 +
 include/hw/ppc/spapr.h             |   25 +-
 include/hw/ppc/spapr_irq.h         |   12 +
 include/hw/ppc/spapr_xive.h        |   52 ++
 include/hw/ppc/xics.h              |    4 +-
 include/hw/ppc/xive.h              |  429 ++++++++++
 include/hw/ppc/xive_regs.h         |  235 ++++++
 target/ppc/cpu.h                   |   18 +-
 target/ppc/translate.c             |   60 +-
 target/ppc/translate/vmx-ops.inc.c |    2 +-
 target/ppc/translate_init.inc.c    |    6 +-
 31 files changed, 4201 insertions(+), 153 deletions(-)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/xive.c
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 include/hw/ppc/xive_regs.h
