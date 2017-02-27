Received: from eggs.gnu.org ([2001:4830:134:3::10]:37911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJk-0000tx-Mw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJg-0007Qw-NN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:24 -0500
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:48980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJg-0007QC-DM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:20 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 567BEB3ABE
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:30:19 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:13 +0100
Message-Id: <1488205773-30436-7-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/26] ppc/xics: add an
 InterruptStatsProvider interface to ICS and ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is, again, to reduce the use of the list of ICS objects. Let's
make each individual ICS and ICP object an InterruptStatsProvider and
remove this same interface from XICSState.

The InterruptStatsProvider will be moved at the machine level after
the XICS cleanups are completed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c | 76 +++++++++++++++++++++++++++++++---------------------=
------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d2a417f73fd5..c7c9bd600790 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -92,44 +92,44 @@ void xics_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
     }
 }
=20
-static void xics_common_pic_print_info(InterruptStatsProvider *obj,
-                                       Monitor *mon)
+static void icp_pic_print_info(InterruptStatsProvider *obj,
+                           Monitor *mon)
 {
-    XICSState *xics =3D XICS_COMMON(obj);
-    ICSState *ics;
+    ICPState *icp =3D ICP(obj);
+    int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
+
+    if (!icp->output) {
+        return;
+    }
+    monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
+                   cpu_index, icp->xirr, icp->xirr_owner,
+                   icp->pending_priority, icp->mfrr);
+}
+
+static void ics_simple_pic_print_info(InterruptStatsProvider *obj,
+                                      Monitor *mon)
+{
+    ICSState *ics =3D ICS_SIMPLE(obj);
     uint32_t i;
=20
-    for (i =3D 0; i < xics->nr_servers; i++) {
-        ICPState *icp =3D &xics->ss[i];
+    monitor_printf(mon, "ICS %4x..%4x %p\n",
+                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
=20
-        if (!icp->output) {
-            continue;
-        }
-        monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%0=
2x\n",
-                       i, icp->xirr, icp->xirr_owner,
-                       icp->pending_priority, icp->mfrr);
+    if (!ics->irqs) {
+        return;
     }
=20
-    QLIST_FOREACH(ics, &xics->ics, list) {
-        monitor_printf(mon, "ICS %4x..%4x %p\n",
-                       ics->offset, ics->offset + ics->nr_irqs - 1, ics)=
;
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        ICSIRQState *irq =3D ics->irqs + i;
=20
-        if (!ics->irqs) {
+        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
             continue;
         }
-
-        for (i =3D 0; i < ics->nr_irqs; i++) {
-            ICSIRQState *irq =3D ics->irqs + i;
-
-            if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
-                continue;
-            }
-            monitor_printf(mon, "  %4x %s %02x %02x\n",
-                           ics->offset + i,
-                           (irq->flags & XICS_FLAGS_IRQ_LSI) ?
-                           "LSI" : "MSI",
-                           irq->priority, irq->status);
-        }
+        monitor_printf(mon, "  %4x %s %02x %02x\n",
+                       ics->offset + i,
+                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
+                       "LSI" : "MSI",
+                       irq->priority, irq->status);
     }
 }
=20
@@ -161,10 +161,8 @@ static void xics_common_initfn(Object *obj)
 static void xics_common_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(o=
c);
=20
     dc->reset =3D xics_common_reset;
-    ic->print_info =3D xics_common_pic_print_info;
 }
=20
 static const TypeInfo xics_common_info =3D {
@@ -174,10 +172,6 @@ static const TypeInfo xics_common_info =3D {
     .class_size    =3D sizeof(XICSStateClass),
     .instance_init =3D xics_common_initfn,
     .class_init    =3D xics_common_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
-    },
 };
=20
 /*
@@ -414,10 +408,12 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
 static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
=20
     dc->reset =3D icp_reset;
     dc->vmsd =3D &vmstate_icp_server;
     dc->realize =3D icp_realize;
+    ic->print_info =3D icp_pic_print_info;
 }
=20
 static const TypeInfo icp_info =3D {
@@ -426,6 +422,10 @@ static const TypeInfo icp_info =3D {
     .instance_size =3D sizeof(ICPState),
     .class_init =3D icp_class_init,
     .class_size =3D sizeof(ICPStateClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_INTERRUPT_STATS_PROVIDER },
+        { }
+    },
 };
=20
 /*
@@ -682,6 +682,7 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
+    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
=20
     isc->realize =3D ics_simple_realize;
     dc->props =3D ics_simple_properties;
@@ -691,6 +692,7 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
     isc->reject =3D ics_simple_reject;
     isc->resend =3D ics_simple_resend;
     isc->eoi =3D ics_simple_eoi;
+    ic->print_info =3D ics_simple_pic_print_info;
 }
=20
 static const TypeInfo ics_simple_info =3D {
@@ -700,6 +702,10 @@ static const TypeInfo ics_simple_info =3D {
     .class_init =3D ics_simple_class_init,
     .class_size =3D sizeof(ICSStateClass),
     .instance_init =3D ics_simple_initfn,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_INTERRUPT_STATS_PROVIDER },
+        { }
+    },
 };
=20
 static void ics_base_realize(DeviceState *dev, Error **errp)
--=20
2.7.4
