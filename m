Received: from eggs.gnu.org ([2001:4830:134:3::10]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1figSd-0000Jf-Cx
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1figSa-0001OU-Dd
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:37:43 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:57578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1figSa-0001NM-5S
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:37:40 -0400
Received: from player687.ha.ovh.net (unknown [10.109.160.226])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 764C9C7265
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 15:37:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 26 Jul 2018 15:37:20 +0200
Message-Id: <20180726133723.17041-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/3] spapr: introduce a fixed IRQ number
 space and an IRQ controller backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Here is a proposal for a new IRQ number space layout using static
numbers and a bitmap allocator for the MSIs. The previous layout is
kept for compatibly in machines raising the 'legacy_irq_allocation' flag.

The patchset also introduces a sPAPR IRQ interface which offers the
possibility to provide different IRQ controller backend to the sPAPR
machine. This is preparing ground for the new XIVE controller.

The new XICS layout will only be activated when a new pseries-3.1
machine is introduced.

Thanks,

C.

Changes since v4 :

 - assigned IRQ numbers to their default static values
 - improved the reg_to_irq conversion routine for the VIO devices

Changes since v3 :

 - introduced a reg_to_irq conversion routine for the VIO devices

Changes since v2 :

 - renamed 'xics_legacy' to 'legacy_irq_allocation'
 - introduced the sPAPR IRQ backend interface
 - increase the size of the IRQ number space for newer machines

Changes since v1 :

 - removed block allocation
 - spaced the IRQ offsets=20
 - check for overlaps when allocating VIO irqs
 - removed 'Error *' arg from spapr_irq_msi_init()=20

C=C3=A9dric Le Goater (3):
  spapr: introduce a fixed IRQ number space
  spapr: introduce a IRQ controller backend to the machine
  spapr: increase the size of the IRQ number space

 include/hw/ppc/spapr.h     |  16 +-
 include/hw/ppc/spapr_irq.h |  55 +++++++
 hw/ppc/spapr.c             | 203 ++++---------------------
 hw/ppc/spapr_cpu_core.c    |   1 +
 hw/ppc/spapr_events.c      |  12 +-
 hw/ppc/spapr_irq.c         | 296 +++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c         |  29 +++-
 hw/ppc/spapr_vio.c         |  65 +++++++-
 hw/ppc/Makefile.objs       |   2 +-
 9 files changed, 480 insertions(+), 199 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.17.1
