Received: from eggs.gnu.org ([2001:4830:134:3::10]:56465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98v2-0007aD-NX
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98ux-0007m3-R0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:08 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:45185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98ux-0007kM-K5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:03 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.38])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DCD211A3D6D
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:01 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:42:59 +0200
Message-Id: <20180419124331.3915-4-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/35] ppc/xive: introduce the XiveFabric
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XiveFabric offers a simple interface, between the XiveSourve
object and the device model owning the interrupt sources, to forward
an event notification to the XIVE interrupt controller of the machine
and if the owner is the controller, to call directly the routing
sub-engine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 060976077dd7..b4c3d06c1219 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -17,6 +17,21 @@
 #include "hw/ppc/xive.h"
=20
 /*
+ * XIVE Fabric
+ */
+
+static void xive_fabric_route(XiveFabric *xf, int lisn)
+{
+
+}
+
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveFabricClass),
+};
+
+/*
  * XIVE Interrupt Source
  */
=20
@@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSource *xsrc,=
 uint32_t srcno)
=20
 /*
  * Forward the source event notification to the associated XiveFabric,
- * the device owning the sources.
+ * the device owning the sources, or perform the routing if the device
+ * is the interrupt controller.
  */
 static void xive_source_notify(XiveSource *xsrc, int srcno)
 {
=20
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
+
+    if (xfc->notify) {
+        xfc->notify(xsrc->xive, srcno + xsrc->offset);
+    } else {
+        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
+    }
 }
=20
 /*
@@ -302,6 +325,17 @@ static void xive_source_reset(DeviceState *dev)
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
+    xsrc->xive =3D XIVE_FABRIC(obj);
=20
     if (!xsrc->nr_irqs) {
         error_setg(errp, "Number of interrupt needs to be greater than 0=
");
@@ -376,6 +410,7 @@ static const TypeInfo xive_source_info =3D {
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
+    type_register_static(&xive_fabric_info);
 }
=20
 type_init(xive_register_types)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 0b76dd278d9b..4fcae2c763e6 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -12,6 +12,8 @@
=20
 #include "hw/sysbus.h"
=20
+typedef struct XiveFabric XiveFabric;
+
 /*
  * XIVE Interrupt Source
  */
@@ -46,6 +48,8 @@ typedef struct XiveSource {
     hwaddr       esb_base;
     uint32_t     esb_shift;
     MemoryRegion esb_mmio;
+
+    XiveFabric   *xive;
 } XiveSource;
=20
 /*
@@ -143,4 +147,25 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
     xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
 }
=20
+/*
+ * XIVE Fabric
+ */
+
+typedef struct XiveFabric {
+    Object parent;
+} XiveFabric;
+
+#define TYPE_XIVE_FABRIC "xive-fabric"
+#define XIVE_FABRIC(obj)                                     \
+    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
+
+typedef struct XiveFabricClass {
+    InterfaceClass parent;
+    void (*notify)(XiveFabric *xf, uint32_t lisn);
+} XiveFabricClass;
+
 #endif /* PPC_XIVE_H */
--=20
2.13.6
