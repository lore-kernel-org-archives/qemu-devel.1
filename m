Received: from eggs.gnu.org ([2001:4830:134:3::10]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s5G-00052R-75
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s5D-0005ye-1j
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:18 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:41791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s5C-0005yQ-Rm
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:14 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 89A0E637BF
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:13:13 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:15 +0100
Message-Id: <20171029181217.9927-7-clg@kaod.org>
In-Reply-To: <20171029181217.9927-1-clg@kaod.org>
References: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/8] sparp: merge ics_set_irq_type() in
 irq_alloc_block() operation
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

Setting the XICS_FLAGS_IRQ_LSI (or XICS_FLAGS_IRQ_MSI) for pre-2.11
pseries machines can now be done directly under the irq_alloc_block()
operation. let's remove ics_set_irq_type() which becomes useless.

The PowerNV machine is a bit special because it does not manage its
own IRQ number allocator yet. But, as it only handles the PSI
interrupts which are LSIs, this is not a problem.

For compatibility with older machines, we use the machine class flag
'pre_2_11_has_no_bitmap'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c       | 8 --------
 hw/intc/xics_spapr.c | 9 +--------
 hw/ppc/pnv_psi.c     | 4 ----
 hw/ppc/spapr.c       | 9 ++++++++-
 4 files changed, 9 insertions(+), 21 deletions(-)

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
index e1f158302a6a..23d81ff83182 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -264,7 +264,6 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
         }
     }
=20
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
     trace_xics_alloc(irq);
=20
     return irq;
@@ -277,7 +276,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi,
                           bool align, Error **errp)
 {
-    int i, first =3D -1;
+    int first =3D -1;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
=20
=20
@@ -300,12 +299,6 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
         return -1;
     }
=20
-    if (first >=3D 0) {
-        for (i =3D first; i < first + num; ++i) {
-            ics_set_irq_type(ics, i - ics->offset, lsi);
-        }
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
index d97f287118f0..557d89d9ecb5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3598,7 +3598,7 @@ static int spapr_irq_alloc_block(XICSFabric *xi, in=
t count, int align, bool lsi)
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int start =3D 0;
-    int srcno;
+    int srcno, i;
=20
     if (!lsi && !smc->pre_2_11_has_no_bitmap) {
         start =3D SPAPR_MAX_LSI;
@@ -3614,6 +3614,13 @@ static int spapr_irq_alloc_block(XICSFabric *xi, i=
nt count, int align, bool lsi)
         return -1;
     }
=20
+    if (lsi && smc->pre_2_11_has_no_bitmap) {
+        for (i =3D srcno; i < srcno + count; ++i) {
+            assert(!(spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK=
));
+            spapr->ics->irqs[srcno].flags =3D XICS_FLAGS_IRQ_LSI;
+        }
+    }
+
     bitmap_set(spapr->irq_map, srcno, count);
     return srcno + spapr->irq_base;
 }
--=20
2.13.6
