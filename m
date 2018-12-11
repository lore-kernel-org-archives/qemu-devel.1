Received: from eggs.gnu.org ([2001:4830:134:3::10]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkQK-0004gB-5W
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkQE-0003Sg-5p
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:58:15 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:57:26 +0000
Message-ID: <1544543862-9997-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
References: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 02/18] xen: introduce new 'XenBus' and
 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This patch adds the basic boilerplate for a 'XenBus' object that will act
as a parent to 'XenDevice' PV backends.
A new 'XenBridge' object is also added to connect XenBus to the system bus.

The XenBus object is instantiated by a new xen_bus_init() function called
from the same sites as the legacy xen_be_init() function.

Subsequent patches will flesh-out the functionality of these objects.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>

v3:
 - Don't use local_err unless it is needed

v2:
 - Fix boilerplate
 - Make xen-bus hotplug capable
---
 hw/i386/xen/xen-hvm.c     |   3 ++
 hw/xen/Makefile.objs      |   2 +-
 hw/xen/trace-events       |   6 +++
 hw/xen/xen-bus.c          | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/xenpv/xen_machine_pv.c |   3 ++
 include/hw/xen/xen-bus.h  |  55 ++++++++++++++++++++
 6 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 hw/xen/xen-bus.c
 create mode 100644 include/hw/xen/xen-bus.h

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 1d63763..4497f75 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -17,6 +17,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen-bus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
@@ -1479,6 +1480,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     QLIST_INIT(&state->dev_list);
     device_listener_register(&state->device_listener);
 
+    xen_bus_init();
+
     /* Initialize backend core & drivers */
     if (xen_be_init() != 0) {
         error_report("xen backend core setup failed");
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 3f64a44..d9d6d7b 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o
+common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index c7e7a3b..0172cd4 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -12,3 +12,9 @@ xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id:
 xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 xen_domid_restrict(int err) "err: %u"
+
+# include/hw/xen/xen-bus.c
+xen_bus_realize(void) ""
+xen_bus_unrealize(void) ""
+xen_device_realize(const char *type) "type: %s"
+xen_device_unrealize(const char *type) "type: %s"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
new file mode 100644
index 0000000..bc04da7
--- /dev/null
+++ b/hw/xen/xen-bus.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/xen/xen-bus.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+static void xen_bus_unrealize(BusState *bus, Error **errp)
+{
+    trace_xen_bus_unrealize();
+}
+
+static void xen_bus_realize(BusState *bus, Error **errp)
+{
+    trace_xen_bus_realize();
+}
+
+static void xen_bus_class_init(ObjectClass *class, void *data)
+{
+    BusClass *bus_class = BUS_CLASS(class);
+
+    bus_class->realize = xen_bus_realize;
+    bus_class->unrealize = xen_bus_unrealize;
+}
+
+static const TypeInfo xen_bus_type_info = {
+    .name = TYPE_XEN_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(XenBus),
+    .class_size = sizeof(XenBusClass),
+    .class_init = xen_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
+};
+
+static void xen_device_unrealize(DeviceState *dev, Error **errp)
+{
+    XenDevice *xendev = XEN_DEVICE(dev);
+    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    trace_xen_device_unrealize(type);
+
+    if (xendev_class->unrealize) {
+        xendev_class->unrealize(xendev, errp);
+    }
+}
+
+static void xen_device_realize(DeviceState *dev, Error **errp)
+{
+    XenDevice *xendev = XEN_DEVICE(dev);
+    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(xendev));
+    Error *local_err = NULL;
+
+    trace_xen_device_realize(type);
+
+    if (xendev_class->realize) {
+        xendev_class->realize(xendev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto unrealize;
+        }
+    }
+
+    return;
+
+unrealize:
+    xen_device_unrealize(dev, &error_abort);
+}
+
+static void xen_device_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dev_class = DEVICE_CLASS(class);
+
+    dev_class->realize = xen_device_realize;
+    dev_class->unrealize = xen_device_unrealize;
+    dev_class->bus_type = TYPE_XEN_BUS;
+}
+
+static const TypeInfo xen_device_type_info = {
+    .name = TYPE_XEN_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(XenDevice),
+    .abstract = true,
+    .class_size = sizeof(XenDeviceClass),
+    .class_init = xen_device_class_init,
+};
+
+typedef struct XenBridge {
+    SysBusDevice busdev;
+} XenBridge;
+
+#define TYPE_XEN_BRIDGE "xen-bridge"
+
+static const TypeInfo xen_bridge_type_info = {
+    .name = TYPE_XEN_BRIDGE,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XenBridge),
+};
+
+static void xen_register_types(void)
+{
+    type_register_static(&xen_bridge_type_info);
+    type_register_static(&xen_bus_type_info);
+    type_register_static(&xen_device_type_info);
+}
+
+type_init(xen_register_types)
+
+void xen_bus_init(void)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_XEN_BRIDGE);
+    BusState *bus = qbus_create(TYPE_XEN_BUS, dev, NULL);
+
+    qdev_init_nofail(dev);
+    qbus_set_bus_hotplug_handler(bus, &error_abort);
+}
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 8c86fb7..608e591 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen-bus.h"
 #include "xen_domainbuild.h"
 #include "sysemu/block-backend.h"
 
@@ -93,6 +94,8 @@ static void xen_init_pv(MachineState *machine)
         xen_config_dev_nic(nd_table + i);
     }
 
+    xen_bus_init();
+
     /* config cleanup hook */
     atexit(xen_config_cleanup);
 }
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
new file mode 100644
index 0000000..0cb1246
--- /dev/null
+++ b/include/hw/xen/xen-bus.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_XEN_BUS_H
+#define HW_XEN_BUS_H
+
+#include "hw/sysbus.h"
+
+typedef struct XenDevice {
+    DeviceState qdev;
+} XenDevice;
+
+typedef void (*XenDeviceRealize)(XenDevice *xendev, Error **errp);
+typedef void (*XenDeviceUnrealize)(XenDevice *xendev, Error **errp);
+
+typedef struct XenDeviceClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    XenDeviceRealize realize;
+    XenDeviceUnrealize unrealize;
+} XenDeviceClass;
+
+#define TYPE_XEN_DEVICE "xen-device"
+#define XEN_DEVICE(obj) \
+     OBJECT_CHECK(XenDevice, (obj), TYPE_XEN_DEVICE)
+#define XEN_DEVICE_CLASS(class) \
+     OBJECT_CLASS_CHECK(XenDeviceClass, (class), TYPE_XEN_DEVICE)
+#define XEN_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(XenDeviceClass, (obj), TYPE_XEN_DEVICE)
+
+typedef struct XenBus {
+    BusState qbus;
+} XenBus;
+
+typedef struct XenBusClass {
+    /*< private >*/
+    BusClass parent_class;
+} XenBusClass;
+
+#define TYPE_XEN_BUS "xen-bus"
+#define XEN_BUS(obj) \
+    OBJECT_CHECK(XenBus, (obj), TYPE_XEN_BUS)
+#define XEN_BUS_CLASS(class) \
+    OBJECT_CLASS_CHECK(XenBusClass, (class), TYPE_XEN_BUS)
+#define XEN_BUS_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(XenBusClass, (obj), TYPE_XEN_BUS)
+
+void xen_bus_init(void);
+
+#endif /* HW_XEN_BUS_H */
-- 
2.1.4
