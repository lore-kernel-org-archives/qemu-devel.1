Received: from eggs.gnu.org ([2001:4830:134:3::10]:41308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmvA-0001JH-Gc
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmv6-0005y0-Bm
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:04 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:52980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmv6-0005xK-53
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:00 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6D2E49BE01
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:30:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:37 +0100
Message-Id: <20171109101439.390-11-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 10/12] spapr: split the IRQ number
 space for LSI interrupts
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

The nature of an interrupt, MSI or LSI, is stored under the flag
attribute of the ICSIRQState array. To reduce the use of this array
and consequently of the ICSState object (needed to introduce for the
new XIVE model), we choose to split the IRQ number space of the
machine in two: first the LSIs and then the MSIs.

This also has the benefit to keep the LSI IRQ numbers in a well known
range which will be useful for PHB hotplug.

For compatibility with older machines, we use the machine class flag
'has_irq_bitmap'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c  |  6 +++---
 hw/ppc/spapr.c        | 27 ++++++++++++++++++++++++++-
 include/hw/ppc/xics.h |  2 +-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index de9e65d35247..b8e91aaf52bd 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -260,7 +260,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
         }
         irq =3D irq_hint;
     } else {
-        irq =3D xic->irq_alloc_block(ics->xics, 1, 1);
+        irq =3D xic->irq_alloc_block(ics->xics, 1, 1, lsi);
         if (irq < 0) {
             error_setg(errp, "can't allocate IRQ: no IRQ left");
             return -1;
@@ -297,9 +297,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
     if (align) {
         assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
                (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D xic->irq_alloc_block(ics->xics, num, num);
+        first =3D xic->irq_alloc_block(ics->xics, num, num, lsi);
     } else {
-        first =3D xic->irq_alloc_block(ics->xics, num, 1);
+        first =3D xic->irq_alloc_block(ics->xics, num, 1, lsi);
     }
     if (first < 0) {
         error_setg(errp, "can't find a free %d-IRQ block", num);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 86d5e310e85f..d576e235d226 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3592,9 +3592,21 @@ static bool spapr_irq_test(XICSFabric *xi, int irq=
)
     return test_bit(srcno, spapr->irq_map);
 }
=20
-static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
+
+/*
+ * Let's provision 4 LSIs per PHBs
+ */
+#define SPAPR_MAX_LSI (SPAPR_MAX_PHBS * 4)
+
+/*
+ * Split the IRQ number space of the machine in two: first the LSIs
+ * and then the MSIs. This allows us to keep the LSI IRQ numbers in a
+ * well known range which is useful for PHB hotplug.
+ */
+static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align, b=
ool lsi)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int start =3D 0;
     int srcno;
=20
@@ -3606,12 +3618,20 @@ static int spapr_irq_alloc_block(XICSFabric *xi, =
int count, int align)
      */
     align -=3D 1;
=20
+    if (!lsi && smc->has_irq_bitmap) {
+        start =3D SPAPR_MAX_LSI;
+    }
+
     srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_irqs,=
 start,
                                        count, align);
     if (srcno =3D=3D spapr->nr_irqs) {
         return -1;
     }
=20
+    if (lsi && smc->has_irq_bitmap && srcno >=3D SPAPR_MAX_LSI) {
+        return -1;
+    }
+
     bitmap_set(spapr->irq_map, srcno, count);
     return srcno + spapr->irq_base;
 }
@@ -3636,8 +3656,13 @@ static void spapr_irq_free_block(XICSFabric *xi, i=
nt irq, int num)
 static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int srcno =3D irq - spapr->irq_base;
=20
+    if (smc->has_irq_bitmap) {
+        return (srcno >=3D 0) && (srcno < SPAPR_MAX_LSI);
+    }
+
     return spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI;
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 478f8e510179..292b929e88eb 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -177,7 +177,7 @@ typedef struct XICSFabricClass {
     ICPState *(*icp_get)(XICSFabric *xi, int server);
     /* IRQ allocator helpers */
     bool (*irq_test)(XICSFabric *xi, int irq);
-    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
+    int (*irq_alloc_block)(XICSFabric *xi, int count, int align, bool ls=
i);
     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
     bool (*irq_is_lsi)(XICSFabric *xi, int irq);
 } XICSFabricClass;
--=20
2.13.6
