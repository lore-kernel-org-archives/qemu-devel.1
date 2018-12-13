Received: from eggs.gnu.org ([2001:4830:134:3::10]:50837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC9-0003jx-Se
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC7-0002Eq-SE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:14 +1100
Message-Id: <20181213040126.6768-16-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/27] ppc/xive: introduce the XiveNotifier
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The XiveNotifier offers a simple interface, between the XiveSource
object and the main interrupt controller of the machine. It will
forward event notifications to the XIVE Interrupt Virtualization
Routing Engine (IVRE).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg: Adjust type name string for XiveNotifier]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 25 +++++++++++++++++++++++++
 include/hw/ppc/xive.h | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 11c7aac962..79238eb57f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -155,7 +155,11 @@ static bool xive_source_esb_eoi(XiveSource *xsrc, ui=
nt32_t srcno)
  */
 static void xive_source_notify(XiveSource *xsrc, int srcno)
 {
+    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
=20
+    if (xnc->notify) {
+        xnc->notify(xsrc->xive, srcno);
+    }
 }
=20
 /*
@@ -362,6 +366,17 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'xive' not found: ");
+        return;
+    }
+
+    xsrc->xive =3D XIVE_NOTIFIER(obj);
=20
     if (!xsrc->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater than 0=
");
@@ -428,9 +443,19 @@ static const TypeInfo xive_source_info =3D {
     .class_init    =3D xive_source_class_init,
 };
=20
+/*
+ * XIVE Fabric
+ */
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_NOTIFIER,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveNotifierClass),
+};
+
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
+    type_register_static(&xive_fabric_info);
 }
=20
 type_init(xive_register_types)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7cebc32eba..436f1bf756 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -142,6 +142,27 @@
=20
 #include "hw/qdev-core.h"
=20
+/*
+ * XIVE Fabric (Interface between Source and Router)
+ */
+
+typedef struct XiveNotifier {
+    Object parent;
+} XiveNotifier;
+
+#define TYPE_XIVE_NOTIFIER "xive-notifier"
+#define XIVE_NOTIFIER(obj)                                     \
+    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+#define XIVE_NOTIFIER_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
+#define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XiveNotifierClass, (obj), TYPE_XIVE_NOTIFIER)
+
+typedef struct XiveNotifierClass {
+    InterfaceClass parent;
+    void (*notify)(XiveNotifier *xn, uint32_t lisn);
+} XiveNotifierClass;
+
 /*
  * XIVE Interrupt Source
  */
@@ -171,6 +192,8 @@ typedef struct XiveSource {
     uint64_t        esb_flags;
     uint32_t        esb_shift;
     MemoryRegion    esb_mmio;
+
+    XiveNotifier    *xive;
 } XiveSource;
=20
 /*
--=20
2.19.2
