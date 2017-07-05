Received: from eggs.gnu.org ([2001:4830:134:3::10]:41208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnst-0003WI-V3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnsp-0002qf-Bf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:39 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:54951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnsp-0002qI-4p
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:35 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3172BFCBEC
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:34 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:19 +0200
Message-Id: <1499274819-15607-7-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 06/26] ppc/xive: introduce a XIVE interrupt
 source model
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

This is very similar to the current ICS_SIMPLE model in XICS. We try
to reuse the ICS model because the sPAPR machine is tied to the
XICSFabric interface and should be using a common framework to switch
from one controller model to another: XICS <-> XIVE.

The next patch will introduce the MMIO handlers to interact with XIVE
interrupt sources.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 110 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/xive.h |  12 ++++++
 2 files changed, 122 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5b14d8155317..9ff14c0da595 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -26,6 +26,115 @@
=20
 #include "xive-internal.h"
=20
+static void xive_icp_irq(XiveICSState *xs, int lisn)
+{
+
+}
+
+/*
+ * XIVE Interrupt Source
+ */
+static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int val)
+{
+    if (val) {
+        xive_icp_irq(xs, srcno + ICS_BASE(xs)->offset);
+    }
+}
+
+static void xive_ics_set_irq_lsi(XiveICSState *xs, int srcno, int val)
+{
+    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
+
+    if (val) {
+        irq->status |=3D XICS_STATUS_ASSERTED;
+    } else {
+        irq->status &=3D ~XICS_STATUS_ASSERTED;
+    }
+
+    if (irq->status & XICS_STATUS_ASSERTED
+        && !(irq->status & XICS_STATUS_SENT)) {
+        irq->status |=3D XICS_STATUS_SENT;
+        xive_icp_irq(xs, srcno + ICS_BASE(xs)->offset);
+    }
+}
+
+static void xive_ics_set_irq(void *opaque, int srcno, int val)
+{
+    XiveICSState *xs =3D ICS_XIVE(opaque);
+    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
+
+    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
+        xive_ics_set_irq_lsi(xs, srcno, val);
+    } else {
+        xive_ics_set_irq_msi(xs, srcno, val);
+    }
+}
+
+static void xive_ics_reset(void *dev)
+{
+    ICSState *ics =3D ICS_BASE(dev);
+    int i;
+    uint8_t flags[ics->nr_irqs];
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        flags[i] =3D ics->irqs[i].flags;
+    }
+
+    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        ics->irqs[i].flags =3D flags[i];
+    }
+}
+
+static void xive_ics_realize(ICSState *ics, Error **errp)
+{
+    XiveICSState *xs =3D ICS_XIVE(ics);
+    Object *obj;
+    Error *err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(xs), "xive", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'xive' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+    xs->xive =3D XIVE(obj);
+
+    if (!ics->nr_irqs) {
+        error_setg(errp, "Number of interrupts needs to be greater 0");
+        return;
+    }
+
+    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+    ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr_irqs=
);
+
+    qemu_register_reset(xive_ics_reset, xs);
+}
+
+static Property xive_ics_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
+    DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_ics_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
+
+    isc->realize =3D xive_ics_realize;
+
+    dc->props =3D xive_ics_properties;
+}
+
+static const TypeInfo xive_ics_info =3D {
+    .name =3D TYPE_ICS_XIVE,
+    .parent =3D TYPE_ICS_BASE,
+    .instance_size =3D sizeof(XiveICSState),
+    .class_init =3D xive_ics_class_init,
+};
+
 /*
  * Main XIVE object
  */
@@ -123,6 +232,7 @@ static const TypeInfo xive_info =3D {
 static void xive_register_types(void)
 {
     type_register_static(&xive_info);
+    type_register_static(&xive_ics_info);
 }
=20
 type_init(xive_register_types)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 863f5a9c6b5f..544cc6e0c796 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -19,9 +19,21 @@
 #ifndef PPC_XIVE_H
 #define PPC_XIVE_H
=20
+#include "hw/ppc/xics.h"
+
 typedef struct XIVE XIVE;
+typedef struct XiveICSState XiveICSState;
=20
 #define TYPE_XIVE "xive"
 #define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
=20
+#define TYPE_ICS_XIVE "xive-source"
+#define ICS_XIVE(obj) OBJECT_CHECK(XiveICSState, (obj), TYPE_ICS_XIVE)
+
+struct XiveICSState {
+    ICSState parent_obj;
+
+    XIVE         *xive;
+};
+
 #endif /* PPC_XIVE_H */
--=20
2.7.5
