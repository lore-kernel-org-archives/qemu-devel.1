Received: from eggs.gnu.org ([2001:4830:134:3::10]:38724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBf-0001ro-KD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBa-0003cE-Uk
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:55 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBa-0003bJ-Ny
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:50 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.79])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id F0CB11BE4C3
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:48 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:41 +0200
Message-Id: <20180607155003.1580-7-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/28] ppc/xive: introduce the XiveFabric
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XiveFabric offers a simple interface, between the XiveSource
object and the main interrupt controller of the machine. It will
forward event notifications to the XIVE Interrupt Virtualization
Routing Engine (IVRE).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 23 +++++++++++++++++++++++
 hw/intc/xive.c        | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e118acd59f1e..be93fae6317b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -13,6 +13,27 @@
 #include "hw/sysbus.h"
=20
 /*
+ * XIVE Fabric (Interface between Source and Router)
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
+/*
  * XIVE Interrupt Source
  */
=20
@@ -42,6 +63,8 @@ typedef struct XiveSource {
     uint64_t        esb_flags;
     uint32_t        esb_shift;
     MemoryRegion    esb_mmio;
+
+    XiveFabric      *xive;
 } XiveSource;
=20
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3ad8c151b9dc..3f6fcb358f83 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -152,7 +152,11 @@ static bool xive_source_esb_eoi(XiveSource *xsrc, ui=
nt32_t srcno)
  */
 static void xive_source_notify(XiveSource *xsrc, int srcno)
 {
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
=20
+    if (xfc->notify) {
+        xfc->notify(xsrc->xive, srcno);
+    }
 }
=20
 /* In a two pages ESB MMIO setting, even page is the trigger page, odd
@@ -358,6 +362,17 @@ static void xive_source_reset(DeviceState *dev)
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
@@ -427,9 +442,19 @@ static const TypeInfo xive_source_info =3D {
     .class_init    =3D xive_source_class_init,
 };
=20
+/*
+ * XIVE Fabric
+ */
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveFabricClass),
+};
+
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
+    type_register_static(&xive_fabric_info);
 }
=20
 type_init(xive_register_types)
--=20
2.13.6
