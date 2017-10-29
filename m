Received: from eggs.gnu.org ([2001:4830:134:3::10]:35514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s4j-0004cR-SV
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s4g-0005o3-N1
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:45 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:44084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s4g-0005fK-Gr
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:42 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2069663787
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:12:30 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:09 +0100
Message-Id: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] introduce an IRQ allocator at the machine
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Currently, the ICSState 'ics' object of the sPAPR machine acts as the
global interrupt source handler and also as the IRQ number allocator
for the machine. Some IRQ numbers are allocated very early in the
machine initialization sequence to populate the device tree, and this
is a problem to introduce the new POWER XIVE interrupt model, as it
needs to share the IRQ numbers with the older model.

To prepare ground for XIVE, here is a proposal adding a set of new
XICSFabric operations to let the machine handle directly the IRQ
number allocation and to decorrelate the allocation from the interrupt
source object :

    bool (*irq_test)(XICSFabric *xi, int irq);
    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
    bool (*irq_is_lsi)(XICSFabric *xi, int irq);

In these prototypes, the 'irq' parameter refers to a number in the
global IRQ number space.

On the sPAPR platform, these operations are simply backed by a
bitmap. To handle migration compatibility with older machines, we
introduce a machine class flag 'pre_2_11_has_no_bitmap'.

Below is the repo with a XIVE model using this new allocator :

    https://github.com/legoater/qemu/commits/xive


Thanks,

C.


C=C3=A9dric Le Goater (8):
  spapr: introduce an IRQ allocator at the machine level
  spapr: introduce a machine class flag to handle migration
    compatibility
  pnv: introduce an irq_test() operation
  spapr: split the IRQ number space for LSI interrupts
  spapr: introduce an is_lsi() operation
  sparp: merge ics_set_irq_type() in irq_alloc_block() operation
  spapr: move spapr_ics_free() under irq_free_block() operation
  spapr: use sPAPRMachineState in spapr_ics_* prototypes

 hw/intc/trace-events   |   2 -
 hw/intc/xics.c         |  37 +++++++-------
 hw/intc/xics_kvm.c     |   4 +-
 hw/intc/xics_spapr.c   |  76 +++++-----------------------
 hw/ppc/pnv.c           |  34 +++++++++++++
 hw/ppc/pnv_psi.c       |   4 --
 hw/ppc/spapr.c         | 135 +++++++++++++++++++++++++++++++++++++++++++=
++++--
 hw/ppc/spapr_events.c  |   4 +-
 hw/ppc/spapr_pci.c     |   8 +--
 hw/ppc/spapr_vio.c     |   2 +-
 hw/ppc/trace-events    |   2 +
 include/hw/ppc/spapr.h |   5 ++
 include/hw/ppc/xics.h  |  19 ++++---
 13 files changed, 227 insertions(+), 105 deletions(-)

--=20
2.13.6
