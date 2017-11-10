Received: from eggs.gnu.org ([2001:4830:134:3::10]:47396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB6h-0007N9-UK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB6d-0004wc-MO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:35 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eDB6d-0004u1-El
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:31 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 220E89C086
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:20:28 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Nov 2017 15:20:06 +0000
Message-Id: <20171110152017.24324-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 00/11] spapr: introduce an IRQ
 allocator at the machine level
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

On the latest pseries machines, these operations are simply backed by
a bitmap and to handle migration compatibility, we keep an old set of
operations using the ICSIRQState array.


To completely remove the use of the ICSState object (required to
introduce XIVE), we also need to change how the nature of an
interrupt, MSI or LSI, is stored. Today, this is done using the flag
attribute of the ICSIRQState array. We change that by splitting the
IRQ number space of the machine in two: first the LSIs and then the
MSIs. This has the benefit to keep the LSI IRQ numbers in a well known
range which is useful for PHB hotplug.

The git repo for this pachset can be found here along with the latest
XIVE model:

    https://github.com/legoater/qemu/commits/xive

Thanks,

C.

Tests :

 - make check on each patch
 - migration :
     qemu-2.12 (pseries-2.12) <->  qemu-2.12 (pseries-2.12)
     qemu-2.12 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)
     qemu-2.10 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)

Changes since v2 :

 - introduced a second set of XICSFabric IRQ operations for older
   pseries machines

Changes since v1 :

 - reorganised patchset to introduce the XICSFabric operations before
   the major changes: bitmap and IRQ number space split  =20
 - introduced a reference bitmap to save some state in migration

C=C3=A9dric Le Goater (11):
  spapr: add pseries 2.12 machine type
  ppc/xics: remove useless if condition
  spapr: introduce new XICSFabric operations for an IRQ allocator
  spapr: move current IRQ allocation under the machine
  spapr: introduce an IRQ allocator using a bitmap
  spapr: store a reference IRQ bitmap
  spapr: introduce an 'irq_base' number
  spapr: introduce a XICSFabric irq_is_lsi() operation
  spapr: split the IRQ number space for LSI interrupts
  sparp: merge ics_set_irq_type() in irq_alloc_block() operation
  spapr: use sPAPRMachineState in spapr_ics_ prototypes

 hw/intc/trace-events   |   2 -
 hw/intc/xics.c         |  37 ++++-----
 hw/intc/xics_kvm.c     |   4 +-
 hw/intc/xics_spapr.c   |  76 +++---------------
 hw/ppc/pnv.c           |  34 ++++++++
 hw/ppc/pnv_psi.c       |   4 -
 hw/ppc/spapr.c         | 209 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
 hw/ppc/spapr_events.c  |   4 +-
 hw/ppc/spapr_pci.c     |   8 +-
 hw/ppc/spapr_vio.c     |   2 +-
 hw/ppc/trace-events    |   2 +
 include/hw/ppc/spapr.h |   5 ++
 include/hw/ppc/xics.h  |  20 +++--
 13 files changed, 301 insertions(+), 106 deletions(-)

--=20
2.13.6
