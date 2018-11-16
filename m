Received: from eggs.gnu.org ([2001:4830:134:3::10]:33308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpB-0006X5-1T
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbp7-0007Sg-2M
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:09 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbp6-0007Rj-Rt
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:04 -0500
Received: from player734.ha.ovh.net (unknown [10.109.143.216])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5FC57173902
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:58:03 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:56:57 +0100
Message-Id: <20181116105729.23240-5-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the XiveRouter
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XiveRouter models the second sub-engine of the overall XIVE
architecture : the Interrupt Virtualization Routing Engine (IVRE).

The IVRE handles event notifications of the IVSE through MMIO stores
and performs the interrupt routing process. For this purpose, it uses
a set of table stored in system memory, the first of which being the
Event Assignment Structure (EAS) table.

The EAT associates an interrupt source number with an Event Notification
Descriptor (END) which will be used in a second phase of the routing
process to identify a Notification Virtual Target.

The XiveRouter is an abstract class which needs to be inherited from
to define a storage for the EAT, and other upcoming tables. The
'chip-id' atttribute is not strictly necessary for the sPAPR and
PowerNV machines but it's a good way to test the routing algorithm.
Without this atttribute, the XiveRouter could be a simple QOM
interface.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      | 32 ++++++++++++++
 include/hw/ppc/xive_regs.h | 31 ++++++++++++++
 hw/intc/xive.c             | 86 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 include/hw/ppc/xive_regs.h

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index be93fae6317b..5a0696366577 100644
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
+    int (*get_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
+    int (*set_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
+} XiveRouterClass;
+
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
+
+int xive_router_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
+int xive_router_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
+
 #endif /* PPC_XIVE_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
new file mode 100644
index 000000000000..12499b33614c
--- /dev/null
+++ b/include/hw/ppc/xive_regs.h
@@ -0,0 +1,31 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2016-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_XIVE_REGS_H
+#define PPC_XIVE_REGS_H
+
+/* EAS (Event Assignment Structure)
+ *
+ * One per interrupt source. Targets an interrupt to a given Event
+ * Notification Descriptor (END) and provides the corresponding
+ * logical interrupt number (END data)
+ */
+typedef struct XiveEAS {
+        /* Use a single 64-bit definition to make it easier to
+         * perform atomic updates
+         */
+        uint64_t        w;
+#define EAS_VALID       PPC_BIT(0)
+#define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END bloc=
k# */
+#define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END inde=
x */
+#define EAS_MASKED      PPC_BIT(32)              /* Masked */
+#define EAS_END_DATA    PPC_BITMASK(33, 63)      /* Data written to the =
END */
+} XiveEAS;
+
+#endif /* PPC_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 014a2e41f71f..c4c90a25758e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -442,6 +442,91 @@ static const TypeInfo xive_source_info =3D {
     .class_init    =3D xive_source_class_init,
 };
=20
+/*
+ * XIVE Router (aka. Virtualization Controller or IVRE)
+ */
+
+int xive_router_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas)
+{
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->get_eas(xrtr, lisn, eas);
+}
+
+int xive_router_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas)
+{
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->set_eas(xrtr, lisn, eas);
+}
+
+static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(xf);
+    XiveEAS eas;
+
+    /* EAS cache lookup */
+    if (xive_router_get_eas(xrtr, lisn, &eas)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %x\n", lisn);
+        return;
+    }
+
+    /* The IVRE has a State Bit Cache for its internal sources which
+     * is also involed at this point. We skip the SBC lookup because
+     * the state bits of the sources are modeled internally in QEMU.
+     */
+
+    if (!(eas.w & EAS_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
+        return;
+    }
+
+    if (eas.w & EAS_MASKED) {
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
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon)
+{
+    if (!(eas->w & EAS_VALID)) {
+        return;
+    }
+
+    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
+                   lisn, eas->w & EAS_MASKED ? "M" : " ",
+                   (uint8_t)  GETFIELD(EAS_END_BLOCK, eas->w),
+                   (uint32_t) GETFIELD(EAS_END_INDEX, eas->w),
+                   (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
+}
+
 /*
  * XIVE Fabric
  */
@@ -455,6 +540,7 @@ static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
     type_register_static(&xive_fabric_info);
+    type_register_static(&xive_router_info);
 }
=20
 type_init(xive_register_types)
--=20
2.17.2
