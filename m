Received: from eggs.gnu.org ([2001:4830:134:3::10]:38763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBl-0001wh-A0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBg-0003fD-IB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:01 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:48820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBg-0003e5-5q
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:56 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.121])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 832901BC30A
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:42 +0200
Message-Id: <20180607155003.1580-8-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/28] ppc/xive: introduce the XiveRouter
 model
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

The XiveRouter models the second sub-engine of the overall XIVE
architecture : the Interrupt Virtualization Routing Engine (IVRE).

The IVRE handles event notifications of the IVSE through MMIO stores
and performs the interrupt routing process. For this purpose, it uses
a set of table stored in system memory, the first of which being the
Interrupt Virtualization entries (IVE) table.

The IVT associates an interrupt source number with an Event Queue
Descriptor which will be used in a second phase of the routing process
to identify a notification target.

The XiveRouter is an abstract class which needs to be inherited from to
define a storage for the IVT, and other upcoming tables.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      | 32 ++++++++++++++++++
 include/hw/ppc/xive_regs.h | 30 +++++++++++++++++
 hw/intc/xive.c             | 84 ++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 146 insertions(+)
 create mode 100644 include/hw/ppc/xive_regs.h

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index be93fae6317b..13c414bf7d55 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -11,6 +11,7 @@
 #define PPC_XIVE_H
=20
 #include "hw/sysbus.h"
+#include "hw/ppc/xive_regs.h"
=20
 /*
  * XIVE Fabric (Interface between Source and Router)
@@ -168,4 +169,35 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
     }
 }
=20
+/*
+ * XIVE Router
+ */
+
+typedef struct XiveRouter {
+    SysBusDevice    parent;
+
+    uint32_t        chip_id;
+} XiveRouter;
+
+#define TYPE_XIVE_ROUTER "xive-router"
+#define XIVE_ROUTER(obj)                                \
+    OBJECT_CHECK(XiveRouter, (obj), TYPE_XIVE_ROUTER)
+#define XIVE_ROUTER_CLASS(klass)                                        =
\
+    OBJECT_CLASS_CHECK(XiveRouterClass, (klass), TYPE_XIVE_ROUTER)
+#define XIVE_ROUTER_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
+
+typedef struct XiveRouterClass {
+    SysBusDeviceClass parent;
+
+    /* XIVE table accessors */
+    int (*get_ive)(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+    int (*set_ive)(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+} XiveRouterClass;
+
+void xive_router_print_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive=
,
+                           Monitor *mon);
+int xive_router_get_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+int xive_router_set_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+
 #endif /* PPC_XIVE_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
new file mode 100644
index 000000000000..74420030111a
--- /dev/null
+++ b/include/hw/ppc/xive_regs.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2016-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef _PPC_XIVE_REGS_H
+#define _PPC_XIVE_REGS_H
+
+/* IVE (Interrupt Virtualization Entry)
+ *
+ * One per interrupt source. Targets that interrupt to a given EQ
+ * and provides the corresponding logical interrupt number (EQ data)
+ */
+typedef struct XiveIVE {
+        /* Use a single 64-bit definition to make it easier to
+         * perform atomic updates
+         */
+        uint64_t        w;
+#define IVE_VALID       PPC_BIT(0)
+#define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ block=
# */
+#define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ index=
 */
+#define IVE_MASKED      PPC_BIT(32)              /* Masked */
+#define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
+} XiveIVE;
+
+#endif /* _PPC_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3f6fcb358f83..7f007d5a3ec0 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -443,6 +443,89 @@ static const TypeInfo xive_source_info =3D {
 };
=20
 /*
+ * XIVE Router (aka. Virtualization Controller or IVRE)
+ */
+
+int xive_router_get_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive)
+{
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->get_ive(xrtr, lisn, ive);
+}
+
+int xive_router_set_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive)
+{
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->set_ive(xrtr, lisn, ive);
+}
+
+static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(xf);
+    XiveIVE ive;
+
+    /* IVE cache lookup */
+    if (xive_router_get_ive(xrtr, lisn, &ive)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %x\n", lisn);
+        return;
+    }
+
+    /* The IVRE has also a State Bit Cache for its internal sources
+     * which is also involed at this point. We can skip the SBC lookup
+     * here because the internal sources are modeled in a different
+     * way in QEMU.
+     */
+
+    if (!(ive.w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
+        return;
+    }
+
+    if (ive.w & IVE_MASKED) {
+        /* Notification completed */
+        return;
+    }
+}
+
+static Property xive_router_properties[] =3D {
+    DEFINE_PROP_UINT32("chip-id", XiveRouter, chip_id, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_router_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
+
+    dc->desc    =3D "XIVE Router Engine";
+    dc->props   =3D xive_router_properties;
+    xfc->notify =3D xive_router_notify;
+}
+
+static const TypeInfo xive_router_info =3D {
+    .name          =3D TYPE_XIVE_ROUTER,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .abstract      =3D true,
+    .class_size    =3D sizeof(XiveRouterClass),
+    .class_init    =3D xive_router_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_XIVE_FABRIC },
+        { }
+    }
+};
+
+void xive_router_print_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive=
,
+                           Monitor *mon)
+{
+    if (!(ive->w & IVE_VALID)) {
+        return;
+    }
+
+    monitor_printf(mon, "  %8x %s\n", lisn, ive->w & IVE_MASKED ? "M" : =
" ");
+}
+
+/*
  * XIVE Fabric
  */
 static const TypeInfo xive_fabric_info =3D {
@@ -455,6 +538,7 @@ static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
     type_register_static(&xive_fabric_info);
+    type_register_static(&xive_router_info);
 }
=20
 type_init(xive_register_types)
--=20
2.13.6
