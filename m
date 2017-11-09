Received: from eggs.gnu.org ([2001:4830:134:3::10]:41479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmvc-0001fH-1T
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmvY-0006Ec-2E
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:32 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:54504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmvX-0006DM-SM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:28 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7F38D9BDFE
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:31:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:38 +0100
Message-Id: <20171109101439.390-12-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 11/12] sparp: merge
 ics_set_irq_type() in irq_alloc_block() operation
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

Setting the XICS_FLAGS_IRQ_LSI (or XICS_FLAGS_IRQ_MSI) for older
pseries machines can now be done directly under the irq_alloc_block()
operation.

For compatibility with older machines, we use the machine class flag
'has_irq_bitmap'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  8 --------
 hw/intc/xics_spapr.c  |  7 +------
 hw/ppc/pnv_psi.c      |  4 ----
 hw/ppc/spapr.c        | 14 ++++++++++++++
 include/hw/ppc/xics.h |  1 -
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 42880e736697..237eed3c11f8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -710,14 +710,6 @@ ICPState *xics_icp_get(XICSFabric *xi, int server)
     return xic->icp_get(xi, server);
 }
=20
-void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
-{
-    assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
-
-    ics->irqs[srcno].flags |=3D
-        lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
-}
-
 static void xics_register_types(void)
 {
     type_register_static(&ics_simple_info);
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index b8e91aaf52bd..f28e9136f2f6 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -267,7 +267,6 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
         }
     }
=20
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
     trace_xics_alloc(irq);
=20
     return irq;
@@ -280,7 +279,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi,
                           bool align, Error **errp)
 {
-    int i, first =3D -1;
+    int first =3D -1;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
=20
     if (!ics) {
@@ -306,10 +305,6 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
         return -1;
     }
=20
-    for (i =3D first; i < first + num; ++i) {
-        ics_set_irq_type(ics, i - ics->offset, lsi);
-    }
-
     trace_xics_alloc_block(first, num, lsi, align);
=20
     return first;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 9876c266223d..ee7fca311cbf 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -487,10 +487,6 @@ static void pnv_psi_realize(DeviceState *dev, Error =
**errp)
         return;
     }
=20
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        ics_set_irq_type(ics, i, true);
-    }
-
     /* XSCOM region for PSI registers */
     pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_=
ops,
                 psi, "xscom-psi", PNV_XSCOM_PSIHB_SIZE);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d576e235d226..0cf1e02fa2b7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3592,6 +3592,13 @@ static bool spapr_irq_test(XICSFabric *xi, int irq=
)
     return test_bit(srcno, spapr->irq_map);
 }
=20
+static void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
+{
+    assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
+
+    ics->irqs[srcno].flags |=3D
+        lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
+}
=20
 /*
  * Let's provision 4 LSIs per PHBs
@@ -3632,6 +3639,13 @@ static int spapr_irq_alloc_block(XICSFabric *xi, i=
nt count, int align, bool lsi)
         return -1;
     }
=20
+    if (!smc->has_irq_bitmap) {
+        int i;
+        for (i =3D srcno; i < srcno + count; ++i) {
+            ics_set_irq_type(spapr->ics, i, lsi);
+        }
+    }
+
     bitmap_set(spapr->irq_map, srcno, count);
     return srcno + spapr->irq_base;
 }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 292b929e88eb..056cf37bc68f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -203,7 +203,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
 void ics_simple_write_xive(ICSState *ics, int nr, int server,
                            uint8_t priority, uint8_t saved_priority);
=20
-void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
 bool ics_is_lsi(ICSState *ics, int srno);
--=20
2.13.6
