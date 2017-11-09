Received: from eggs.gnu.org ([2001:4830:134:3::10]:40794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmu7-0000Kw-3h
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmu3-0005QS-3B
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:59 -0500
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmu2-0005QC-TR
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:55 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B194E9B877
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:29:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:34 +0100
Message-Id: <20171109101439.390-8-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 07/12] spapr: introduce an
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
 hw/ppc/spapr.c         | 11 +++++------
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4d0a36cc5bf..6c3fc12ed8e1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2383,6 +2383,7 @@ static void ppc_spapr_init(MachineState *machine)
     /* Initialize the IRQ allocator */
     spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
     spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+    spapr->irq_base =3D XICS_IRQ_BASE;
=20
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, spapr->nr_irqs, &error_fatal);
@@ -3586,8 +3587,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
vcpu_id)
 static bool spapr_irq_test(XICSFabric *xi, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    ICSState *ics =3D spapr->ics;
-    int srcno =3D irq - ics->offset;
+    int srcno =3D irq - spapr->irq_base;
=20
     return test_bit(srcno, spapr->irq_map);
 }
@@ -3595,7 +3595,6 @@ static bool spapr_irq_test(XICSFabric *xi, int irq)
 static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    ICSState *ics =3D spapr->ics;
     int start =3D 0;
     int srcno;
=20
@@ -3614,21 +3613,21 @@ static int spapr_irq_alloc_block(XICSFabric *xi, =
int count, int align)
     }
=20
     bitmap_set(spapr->irq_map, srcno, count);
-    return srcno + ics->offset;
+    return srcno + spapr->irq_base;
 }
=20
 static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     ICSState *ics =3D spapr->ics;
-    int srcno =3D irq - ics->offset;
+    int srcno =3D irq - spapr->irq_base;
     int i;
=20
     if (ics_valid_irq(ics, irq)) {
         trace_spapr_irq_free(0, irq, num);
         for (i =3D srcno; i < srcno + num; ++i) {
             if (!test_bit(i, spapr->irq_map)) {
-                trace_spapr_irq_free_warn(0, i + ics->offset);
+                trace_spapr_irq_free_warn(0, i + spapr->irq_base);
             }
         }
         bitmap_clear(spapr->irq_map, srcno, num);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 090eda962ccb..8d227fe6f56c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -83,6 +83,7 @@ struct sPAPRMachineState {
     int32_t nr_irqs;
     unsigned long *irq_map;
     unsigned long *irq_map_ref;
+    uint32_t irq_base;
     ICSState *ics;
     sPAPRRTCState rtc;
=20
--=20
2.13.6
