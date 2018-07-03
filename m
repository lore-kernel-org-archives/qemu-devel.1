Received: from eggs.gnu.org ([2001:4830:134:3::10]:39577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0002lc-Tl
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKO-0006sm-0U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:37 +1000
Message-Id: <20180703055804.13449-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/35] ppc/xics: move the vmstate structures
 under the ics-base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 112 ++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 8cfe223153..b9f1a3c972 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -549,61 +549,6 @@ static void ics_simple_reset_handler(void *dev)
     ics_simple_reset(dev);
 }
=20
-static int ics_simple_dispatch_pre_save(void *opaque)
-{
-    ICSState *ics =3D opaque;
-    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
-
-    if (info->pre_save) {
-        info->pre_save(ics);
-    }
-
-    return 0;
-}
-
-static int ics_simple_dispatch_post_load(void *opaque, int version_id)
-{
-    ICSState *ics =3D opaque;
-    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
-
-    if (info->post_load) {
-        return info->post_load(ics, version_id);
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_ics_simple_irq =3D {
-    .name =3D "ics/irq",
-    .version_id =3D 2,
-    .minimum_version_id =3D 1,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(server, ICSIRQState),
-        VMSTATE_UINT8(priority, ICSIRQState),
-        VMSTATE_UINT8(saved_priority, ICSIRQState),
-        VMSTATE_UINT8(status, ICSIRQState),
-        VMSTATE_UINT8(flags, ICSIRQState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static const VMStateDescription vmstate_ics_simple =3D {
-    .name =3D "ics",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .pre_save =3D ics_simple_dispatch_pre_save,
-    .post_load =3D ics_simple_dispatch_post_load,
-    .fields =3D (VMStateField[]) {
-        /* Sanity check */
-        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
-
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
-                                             vmstate_ics_simple_irq,
-                                             ICSIRQState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 static void ics_simple_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_SIMPLE(dev);
@@ -631,7 +576,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
     device_class_set_parent_reset(dc, ics_simple_reset,
                                   &isc->parent_reset);
=20
-    dc->vmsd =3D &vmstate_ics_simple;
     isc->reject =3D ics_simple_reject;
     isc->resend =3D ics_simple_resend;
     isc->eoi =3D ics_simple_eoi;
@@ -692,6 +636,61 @@ static void ics_base_instance_init(Object *obj)
     ics->offset =3D XICS_IRQ_BASE;
 }
=20
+static int ics_base_dispatch_pre_save(void *opaque)
+{
+    ICSState *ics =3D opaque;
+    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
+
+    if (info->pre_save) {
+        info->pre_save(ics);
+    }
+
+    return 0;
+}
+
+static int ics_base_dispatch_post_load(void *opaque, int version_id)
+{
+    ICSState *ics =3D opaque;
+    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
+
+    if (info->post_load) {
+        return info->post_load(ics, version_id);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_ics_base_irq =3D {
+    .name =3D "ics/irq",
+    .version_id =3D 2,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(server, ICSIRQState),
+        VMSTATE_UINT8(priority, ICSIRQState),
+        VMSTATE_UINT8(saved_priority, ICSIRQState),
+        VMSTATE_UINT8(status, ICSIRQState),
+        VMSTATE_UINT8(flags, ICSIRQState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_ics_base =3D {
+    .name =3D "ics",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .pre_save =3D ics_base_dispatch_pre_save,
+    .post_load =3D ics_base_dispatch_post_load,
+    .fields =3D (VMStateField[]) {
+        /* Sanity check */
+        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
+
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
+                                             vmstate_ics_base_irq,
+                                             ICSIRQState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static Property ics_base_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -704,6 +703,7 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
     dc->realize =3D ics_base_realize;
     dc->props =3D ics_base_properties;
     dc->reset =3D ics_base_reset;
+    dc->vmsd =3D &vmstate_ics_base;
 }
=20
 static const TypeInfo ics_base_info =3D {
--=20
2.17.1
