Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB7X-00081D-6W
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB7T-0006ag-3c
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:27 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:59875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eDB7S-0006ZQ-TI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:23 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D59459C350
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:21:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Nov 2017 15:20:13 +0000
Message-Id: <20171110152017.24324-8-clg@kaod.org>
In-Reply-To: <20171110152017.24324-1-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 07/11] spapr: introduce an
 'irq_base' number
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

'irq_base' is a base IRQ number which lets us allocate only the subset
of the IRQ numbers used on the sPAPR platform. It is sync with the
ICSState 'offset' attribute and this is slightly redundant. We could
also choose to waste some extra bytes (512) and allocate the whole
number space. To be discussed.

But more important, it removes a dependency on the ICSState object of
the sPAPR machine which is required for XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 7 ++++---
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bf0e5b4f815b..1cbbd7715a85 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2362,6 +2362,7 @@ static void ppc_spapr_init(MachineState *machine)
     /* Initialize the IRQ allocator */
     spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
     spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+    spapr->irq_base =3D XICS_IRQ_BASE;
=20
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, spapr->nr_irqs, &error_fatal);
@@ -3630,7 +3631,7 @@ static void spapr_irq_free_block_2_11(XICSFabric *x=
i, int irq, int num)
 static bool spapr_irq_test(XICSFabric *xi, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    int srcno =3D irq - spapr->ics->offset;
+    int srcno =3D irq - spapr->irq_base;
=20
     return test_bit(srcno, spapr->irq_map);
 }
@@ -3656,13 +3657,13 @@ static int spapr_irq_alloc_block(XICSFabric *xi, =
int count, int align)
     }
=20
     bitmap_set(spapr->irq_map, srcno, count);
-    return srcno + spapr->ics->offset;
+    return srcno + spapr->irq_base;
 }
=20
 static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    int srcno =3D irq - spapr->ics->offset;
+    int srcno =3D irq - spapr->irq_base;
=20
     bitmap_clear(spapr->irq_map, srcno, num);
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 023436c32b2a..200667dcff9d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -82,6 +82,7 @@ struct sPAPRMachineState {
     int32_t nr_irqs;
     unsigned long *irq_map;
     unsigned long *irq_map_ref;
+    uint32_t irq_base;
     ICSState *ics;
     sPAPRRTCState rtc;
=20
--=20
2.13.6
