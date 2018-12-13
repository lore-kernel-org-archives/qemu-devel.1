Received: from eggs.gnu.org ([2001:4830:134:3::10]:50520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC1-0003Z7-UY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIBv-0001ur-GQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:00:59 +1100
Message-Id: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 4b3aab204204ca742836219b97b538d90584f4=
f2:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2018-12-11 22:26:44 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181213

for you to fetch changes up to 67888a17b6683600ae3fa64ca275c737ba8a9a45:

  spapr/xive: use the VCPU id as a NVT identifier (2018-12-13 09:44:04 +1=
100)

----------------------------------------------------------------
ppc patch queue 2018-12-13

Here's the first ppc and spapr pull request for 4.0.  Highlights are:

 * The start of support for the POWER9 "XIVE" interrupt controller
   (not complete enough to use yet, but we're getting there)
 * A number of g_new vs. g_malloc cleanups
 * Some IRQ wiring cleanups
 * A fix for how we advertise NUMA nodes to the guest for pseries

----------------------------------------------------------------
C=C3=A9dric Le Goater (14):
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

 default-configs/ppc64-softmmu.mak  |    2 +
 disas/ppc.c                        |    2 +
 hw/intc/Makefile.objs              |    2 +
 hw/intc/spapr_xive.c               |  420 ++++++++++
 hw/intc/xive.c                     | 1568 ++++++++++++++++++++++++++++++=
++++++
 hw/ppc/e500.c                      |   18 +-
 hw/ppc/mac_newworld.c              |   30 +-
 hw/ppc/ppc405_boards.c             |    4 +-
 hw/ppc/ppc405_uc.c                 |    4 +-
 hw/ppc/ppc440_bamboo.c             |    5 +-
 hw/ppc/sam460ex.c                  |    2 +-
 hw/ppc/spapr.c                     |   22 +-
 hw/ppc/spapr_iommu.c               |    2 +-
 hw/ppc/spapr_irq.c                 |   16 +-
 hw/ppc/spapr_vio.c                 |    2 +-
 hw/ppc/virtex_ml507.c              |    2 +-
 include/hw/ppc/openpic.h           |    2 +
 include/hw/ppc/spapr.h             |    1 +
 include/hw/ppc/spapr_irq.h         |    1 +
 include/hw/ppc/spapr_xive.h        |   45 ++
 include/hw/ppc/xive.h              |  428 ++++++++++
 include/hw/ppc/xive_regs.h         |  213 +++++
 target/ppc/translate.c             |   60 +-
 target/ppc/translate/vmx-ops.inc.c |    2 +-
 target/ppc/translate_init.inc.c    |    6 +-
 25 files changed, 2773 insertions(+), 86 deletions(-)
 create mode 100644 hw/intc/spapr_xive.c
 create mode 100644 hw/intc/xive.c
 create mode 100644 include/hw/ppc/spapr_xive.h
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 include/hw/ppc/xive_regs.h
