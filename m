Received: from eggs.gnu.org ([2001:4830:134:3::10]:41517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntO-00040a-IZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntK-00038Z-Is
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:10 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:44957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntK-00037D-DX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:06 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 18295FCCB1
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:24 +0200
Message-Id: <1499274819-15607-12-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 11/26] ppc/xics: introduce a print_info()
 handler to the ICS and ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This handler will be used to customize the ouput of the XIVE interrupt
source and presenter objects.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 36 ++++++++++++++++++++++++------------
 include/hw/ppc/xics.h |  2 ++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index faa5c631f655..7837c2022b4a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -40,18 +40,26 @@
=20
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
+    ICPStateClass *k =3D ICP_GET_CLASS(icp);
     int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
=20
     if (!icp->output) {
         return;
     }
-    monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
-                   cpu_index, icp->xirr, icp->xirr_owner,
-                   icp->pending_priority, icp->mfrr);
+
+    monitor_printf(mon, "CPU %d ", cpu_index);
+    if (k->print_info) {
+        k->print_info(icp, mon);
+    } else {
+        monitor_printf(mon, "XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n",
+                       icp->xirr, icp->xirr_owner,
+                       icp->pending_priority, icp->mfrr);
+    }
 }
=20
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
 {
+    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
     uint32_t i;
=20
     monitor_printf(mon, "ICS %4x..%4x %p\n",
@@ -61,17 +69,21 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         return;
     }
=20
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        ICSIRQState *irq =3D ics->irqs + i;
+    if (k->print_info) {
+        k->print_info(ics, mon);
+    } else {
+        for (i =3D 0; i < ics->nr_irqs; i++) {
+            ICSIRQState *irq =3D ics->irqs + i;
=20
-        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
-            continue;
+            if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
+                continue;
+            }
+            monitor_printf(mon, "  %4x %s %02x %02x\n",
+                           ics->offset + i,
+                           (irq->flags & XICS_FLAGS_IRQ_LSI) ?
+                           "LSI" : "MSI",
+                           irq->priority, irq->status);
         }
-        monitor_printf(mon, "  %4x %s %02x %02x\n",
-                       ics->offset + i,
-                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
-                       "LSI" : "MSI",
-                       irq->priority, irq->status);
     }
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 28d248abad61..902f3bfd0e33 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -69,6 +69,7 @@ struct ICPStateClass {
     void (*pre_save)(ICPState *icp);
     int (*post_load)(ICPState *icp, int version_id);
     void (*reset)(ICPState *icp);
+    void (*print_info)(ICPState *icp, Monitor *mon);
 };
=20
 struct ICPState {
@@ -119,6 +120,7 @@ struct ICSStateClass {
     void (*reject)(ICSState *s, uint32_t irq);
     void (*resend)(ICSState *s);
     void (*eoi)(ICSState *s, uint32_t irq);
+    void (*print_info)(ICSState *s, Monitor *mon);
 };
=20
 struct ICSState {
--=20
2.7.5
