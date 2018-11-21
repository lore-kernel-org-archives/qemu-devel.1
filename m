Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB6-0005Wl-P2
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB3-0003hQ-Pd
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:32 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:11:57 +0000
Message-ID: <20181121151211.15997-5-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 04/18] xen: create xenstore areas for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch adds a new source module, xen-bus-helper.c, which builds on
basic libxenstore primitives to provide functions to create (setting
permissions appropriately) and destroy xenstore areas, and functions to
'printf' and 'scanf' nodes therein. The main xen-bus code then uses
these primitives [1] to initialize and destroy the frontend and backend
areas for a XenDevice during realize and unrealize respectively.

The 'xen-qdisk' implementation is extended with a 'get_name' method that
returns the VBD number. This number is reqired to 'name' the xenstore
areas.

NOTE: An exit handler is also added to make sure the xenstore areas are
      cleaned up if QEMU terminates without devices being unrealized.

[1] The 'scanf' functions are actually not yet needed, but they will be
    needed by code delivered in subsequent patches.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen-qdisk.c            |  11 ++
 hw/xen/Makefile.objs            |   2 +-
 hw/xen/trace-events             |   6 +-
 hw/xen/xen-bus-helper.c         | 124 +++++++++++++++++
 hw/xen/xen-bus.c                | 288 +++++++++++++++++++++++++++++++++++++++-
 include/hw/xen/xen-bus-helper.h |  26 ++++
 include/hw/xen/xen-bus.h        |  12 ++
 7 files changed, 464 insertions(+), 5 deletions(-)
 create mode 100644 hw/xen/xen-bus-helper.c
 create mode 100644 include/hw/xen/xen-bus-helper.h

diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
index 72122073f7..0859643f7d 100644
--- a/hw/block/xen-qdisk.c
+++ b/hw/block/xen-qdisk.c
@@ -11,6 +11,14 @@
 #include "hw/xen/xen-qdisk.h"
 #include "trace.h"
 
+static char *xen_qdisk_get_name(XenDevice *xendev, Error **errp)
+{
+    XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
+    XenQdiskVdev *vdev = &qdiskdev->vdev;
+
+    return g_strdup_printf("%lu", vdev->number);
+}
+
 static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
 {
     XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
@@ -234,6 +242,9 @@ static void xen_qdisk_class_init(ObjectClass *class, void *data)
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenDeviceClass *xendev_class = XEN_DEVICE_CLASS(class);
 
+    xendev_class->backend = "qdisk";
+    xendev_class->device = "vbd";
+    xendev_class->get_name = xen_qdisk_get_name;
     xendev_class->realize = xen_qdisk_realize;
     xendev_class->unrealize = xen_qdisk_unrealize;
 
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index d9d6d7b4f9..77c0868190 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o
+common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 0172cd4e26..fa8aea1da1 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -16,5 +16,7 @@ xen_domid_restrict(int err) "err: %u"
 # include/hw/xen/xen-bus.c
 xen_bus_realize(void) ""
 xen_bus_unrealize(void) ""
-xen_device_realize(const char *type) "type: %s"
-xen_device_unrealize(const char *type) "type: %s"
+xen_device_realize(const char *type, char *name) "type: %s name: %s"
+xen_device_unrealize(const char *type, char *name) "type: %s name: %s"
+xen_device_backend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
+xen_device_frontend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
new file mode 100644
index 0000000000..d9ee2ed6a0
--- /dev/null
+++ b/hw/xen/xen-bus-helper.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) Citrix Systems Inc.
+ * All rights reserved.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/xen/xen.h"
+#include "hw/xen/xen-bus.h"
+#include "hw/xen/xen-bus-helper.h"
+#include "qapi/error.h"
+
+struct xs_state {
+    enum xenbus_state statenum;
+    const char *statestr;
+};
+#define XS_STATE(state) { state, #state }
+
+static struct xs_state xs_state[] = {
+    XS_STATE(XenbusStateUnknown),
+    XS_STATE(XenbusStateInitialising),
+    XS_STATE(XenbusStateInitWait),
+    XS_STATE(XenbusStateInitialised),
+    XS_STATE(XenbusStateConnected),
+    XS_STATE(XenbusStateClosing),
+    XS_STATE(XenbusStateClosed),
+    XS_STATE(XenbusStateReconfiguring),
+    XS_STATE(XenbusStateReconfigured),
+};
+
+#undef XS_STATE
+
+const char *xs_strstate(enum xenbus_state state)
+{
+    unsigned int i;
+
+   for (i = 0; i < ARRAY_SIZE(xs_state); i++) {
+        if (xs_state[i].statenum == state) {
+            return xs_state[i].statestr;
+        }
+    }
+
+    return "INVALID";
+}
+
+void xs_node_create(struct xs_handle *xsh, const char *node,
+                    struct xs_permissions perms[],
+                    unsigned int nr_perms, Error **errp)
+{
+    if (!xs_write(xsh, XBT_NULL, node, "", 0)) {
+        error_setg_errno(errp, errno, "failed to create node '%s'", node);
+        return;
+    }
+
+    if (!xs_set_permissions(xsh, XBT_NULL, node,
+                            perms, nr_perms)) {
+        error_setg_errno(errp, errno, "failed to set node '%s' permissions",
+                         node);
+    }
+}
+
+void xs_node_destroy(struct xs_handle *xsh, const char *node)
+{
+    xs_rm(xsh, XBT_NULL, node);
+}
+
+void xs_node_vprintf(struct xs_handle *xsh, const char *node,
+                     const char *key, const char *fmt, va_list ap)
+{
+    char *path, *value;
+
+    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
+        g_strdup(key);
+
+    value = g_strdup_vprintf(fmt, ap);
+
+    xs_write(xsh, XBT_NULL, path, value, strlen(value));
+
+    g_free(value);
+    g_free(path);
+}
+
+void xs_node_printf(struct xs_handle *xsh, const char *node,
+                    const char *key, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    xs_node_vprintf(xsh, node, key, fmt, ap);
+    va_end(ap);
+}
+
+int xs_node_vscanf(struct xs_handle *xsh, const char *node, const char *key,
+                   const char *fmt, va_list ap)
+{
+    char *path, *value;
+    int rc;
+
+    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
+        g_strdup(key);
+
+    value = xs_read(xsh, XBT_NULL, path, NULL);
+
+    rc = value ? vsscanf(value, fmt, ap) : EOF;
+
+    free(value);
+    g_free(path);
+
+    return rc;
+}
+
+int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
+                  const char *fmt, ...)
+{
+    va_list ap;
+    int rc;
+
+    va_start(ap, fmt);
+    rc = xs_node_vscanf(xsh, node, key, fmt, ap);
+    va_end(ap);
+
+    return rc;
+}
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index dede2d914a..663aa8e117 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -6,24 +6,102 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "hw/xen/xen.h"
 #include "hw/xen/xen-bus.h"
+#include "hw/xen/xen-bus-helper.h"
+#include "monitor/monitor.h"
 #include "qapi/error.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
 
+static char *xen_device_get_backend_path(XenDevice *xendev)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(xendev));
+    const char *backend = xendev_class->backend;
+
+    if (!backend) {
+        backend = type;
+    }
+
+    return g_strdup_printf("/local/domain/%u/backend/%s/%u/%s",
+                           xenbus->backend_id, backend, xendev->frontend_id,
+                           xendev->name);
+}
+
+static char *xen_device_get_frontend_path(XenDevice *xendev)
+{
+    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(xendev));
+    const char *device = xendev_class->device;
+
+    if (!device) {
+        device = type;
+    }
+
+    return g_strdup_printf("/local/domain/%u/device/%s/%s",
+                           xendev->frontend_id, device, xendev->name);
+}
+
+static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
+{
+    XenDevice *xendev = XEN_DEVICE(dev);
+
+    monitor_printf(mon, "%*sname = '%s' frontend_id = %u\n",
+                   indent, "", xendev->name, xendev->frontend_id);
+}
+
+static char *xen_bus_get_dev_path(DeviceState *dev)
+{
+    return xen_device_get_backend_path(XEN_DEVICE(dev));
+}
+
 static void xen_bus_unrealize(BusState *bus, Error **errp)
 {
+    XenBus *xenbus = XEN_BUS(bus);
+
     trace_xen_bus_unrealize();
+
+    if (!xenbus->xsh) {
+        return;
+    }
+
+    xs_close(xenbus->xsh);
 }
 
 static void xen_bus_realize(BusState *bus, Error **errp)
 {
+    XenBus *xenbus = XEN_BUS(bus);
+    unsigned int domid;
+
     trace_xen_bus_realize();
+
+    xenbus->xsh = xs_open(0);
+    if (!xenbus->xsh) {
+        error_setg_errno(errp, errno, "failed xs_open");
+        goto fail;
+    }
+
+    if (xs_node_scanf(xenbus->xsh, "", /* domain root node */
+                            "domid", "%u", &domid) == 1) {
+        xenbus->backend_id = domid;
+    } else {
+        xenbus->backend_id = 0; /* Assume lack of node means dom0 */
+    }
+
+    return;
+
+fail:
+    xen_bus_unrealize(bus, &error_abort);
 }
 
 static void xen_bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bus_class = BUS_CLASS(class);
 
+    bus_class->print_dev = xen_bus_print_dev;
+    bus_class->get_dev_path = xen_bus_get_dev_path;
     bus_class->realize = xen_bus_realize;
     bus_class->unrealize = xen_bus_unrealize;
 }
@@ -36,6 +114,138 @@ static const TypeInfo xen_bus_type_info = {
     .class_init = xen_bus_class_init,
 };
 
+static void xen_device_backend_printf(XenDevice *xendev, const char *key,
+                                      const char *fmt, ...)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    va_list ap;
+
+    g_assert(xenbus->xsh);
+
+    va_start(ap, fmt);
+    xs_node_vprintf(xenbus->xsh, xendev->backend_path, key, fmt, ap);
+    va_end(ap);
+}
+
+static void xen_device_backend_set_state(XenDevice *xendev,
+                                         enum xenbus_state state)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    if (xendev->backend_state == state) {
+        return;
+    }
+
+    trace_xen_device_backend_state(type, xendev->name,
+                                   xs_strstate(state));
+
+    xendev->backend_state = state;
+    xen_device_backend_printf(xendev, "state", "%u", state);
+}
+
+static void xen_device_backend_create(XenDevice *xendev, Error **errp)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    struct xs_permissions perms[2];
+    Error *local_err = NULL;
+
+    xendev->backend_path = xen_device_get_backend_path(xendev);
+
+    perms[0].id = xenbus->backend_id;
+    perms[0].perms = XS_PERM_NONE;
+    perms[1].id = xendev->frontend_id;
+    perms[1].perms = XS_PERM_READ;
+
+    g_assert(xenbus->xsh);
+
+    xs_node_create(xenbus->xsh, xendev->backend_path, perms,
+                   ARRAY_SIZE(perms), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to create backend: ");
+    }
+}
+
+static void xen_device_backend_destroy(XenDevice *xendev)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+
+    if (!xendev->backend_path) {
+        return;
+    }
+
+    g_assert(xenbus->xsh);
+
+    xs_node_destroy(xenbus->xsh, xendev->backend_path);
+    g_free(xendev->backend_path);
+}
+
+static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
+                                       const char *fmt, ...)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    va_list ap;
+
+    g_assert(xenbus->xsh);
+
+    va_start(ap, fmt);
+    xs_node_vprintf(xenbus->xsh, xendev->frontend_path, key, fmt, ap);
+    va_end(ap);
+}
+
+static void xen_device_frontend_set_state(XenDevice *xendev,
+                                          enum xenbus_state state)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    if (xendev->frontend_state == state) {
+        return;
+    }
+
+    trace_xen_device_frontend_state(type, xendev->name,
+                                    xs_strstate(state));
+
+    xendev->frontend_state = state;
+    xen_device_frontend_printf(xendev, "state", "%u", state);
+}
+
+static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    struct xs_permissions perms[2];
+    Error *local_err = NULL;
+
+    xendev->frontend_path = xen_device_get_frontend_path(xendev);
+
+    perms[0].id = xendev->frontend_id;
+    perms[0].perms = XS_PERM_NONE;
+    perms[1].id = xenbus->backend_id;
+    perms[1].perms = XS_PERM_READ | XS_PERM_WRITE;
+
+    g_assert(xenbus->xsh);
+
+    xs_node_create(xenbus->xsh, xendev->frontend_path, perms,
+                   ARRAY_SIZE(perms), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to create frontend: ");
+    }
+}
+
+static void xen_device_frontend_destroy(XenDevice *xendev)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+
+    if (!xendev->frontend_path) {
+        return;
+    }
+
+    g_assert(xenbus->xsh);
+
+    xs_node_destroy(xenbus->xsh, xendev->frontend_path);
+    g_free(xendev->frontend_path);
+}
+
 static void xen_device_unrealize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -43,7 +253,10 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     const char *type = object_get_typename(OBJECT(xendev));
     Error *local_err = NULL;
 
-    trace_xen_device_unrealize(type);
+    trace_xen_device_unrealize(type, xendev->name);
+
+    if (xendev->exit.notify)
+        qemu_remove_exit_notifier(&xendev->exit);
 
     if (xendev_class->unrealize) {
         xendev_class->unrealize(xendev, &local_err);
@@ -52,16 +265,62 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    xen_device_frontend_destroy(xendev);
+    xen_device_backend_destroy(xendev);
+
+    g_free(xendev->name);
+}
+
+static void xen_device_exit(Notifier *n, void *data)
+{
+    XenDevice *xendev = container_of(n, XenDevice, exit);
+
+    xen_device_unrealize(DEVICE(xendev), &error_abort);
 }
 
 static void xen_device_realize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
     XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     const char *type = object_get_typename(OBJECT(xendev));
     Error *local_err = NULL;
 
-    trace_xen_device_realize(type);
+    if (xendev->frontend_id == DOMID_INVALID) {
+        xendev->frontend_id = xen_domid;
+    }
+
+    if (xendev->frontend_id >= DOMID_FIRST_RESERVED) {
+        error_setg(errp, "invalid frontend-id");
+        return;
+    }
+
+    if (!xendev_class->get_name) {
+        error_setg(errp, "get_name method not implemented");
+        return;
+    }
+
+    xendev->name = xendev_class->get_name(xendev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to get device name: ");
+        return;
+    }
+
+    trace_xen_device_realize(type, xendev->name);
+
+    xen_device_backend_create(xendev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto unrealize;
+    }
+
+    xen_device_frontend_create(xendev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto unrealize;
+    }
 
     if (xendev_class->realize) {
         xendev_class->realize(xendev, &local_err);
@@ -71,18 +330,43 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    xen_device_backend_printf(xendev, "frontend", "%s",
+                              xendev->frontend_path);
+    xen_device_backend_printf(xendev, "frontend-id", "%u",
+                              xendev->frontend_id);
+    xen_device_backend_printf(xendev, "online", "%u", 1);
+    xen_device_backend_printf(xendev, "hotplug-status", "connected");
+
+    xen_device_backend_set_state(xendev, XenbusStateInitWait);
+
+    xen_device_frontend_printf(xendev, "backend", "%s",
+                               xendev->backend_path);
+    xen_device_frontend_printf(xendev, "backend-id", "%u",
+                               xenbus->backend_id);
+
+    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
+
+    xendev->exit.notify = xen_device_exit;
+    qemu_add_exit_notifier(&xendev->exit);
     return;
 
 unrealize:
     xen_device_unrealize(dev, &error_abort);
 }
 
+static Property xen_device_props[] = {
+    DEFINE_PROP_UINT16("frontend-id", XenDevice, frontend_id,
+                       DOMID_INVALID),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void xen_device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
 
     dev_class->realize = xen_device_realize;
     dev_class->unrealize = xen_device_unrealize;
+    dev_class->props = xen_device_props;
     dev_class->bus_type = TYPE_XEN_BUS;
 }
 
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
new file mode 100644
index 0000000000..53570650db
--- /dev/null
+++ b/include/hw/xen/xen-bus-helper.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) Citrix Systems Inc.
+ * All rights reserved.
+ */
+
+#ifndef HW_XEN_BUS_HELPER_H
+#define HW_XEN_BUS_HELPER_H
+
+const char *xs_strstate(enum xenbus_state state);
+
+void xs_node_create(struct xs_handle *xsh, const char *node,
+                    struct xs_permissions perms[],
+                    unsigned int nr_perms, Error **errp);
+void xs_node_destroy(struct xs_handle *xsh, const char *node);
+
+void xs_node_vprintf(struct xs_handle *xsh, const char *node,
+                     const char *key, const char *fmt, va_list ap);
+void xs_node_printf(struct xs_handle *xsh, const char *node, const char *key,
+                    const char *fmt, ...);
+
+int xs_node_vscanf(struct xs_handle *xsh, const char *node, const char *key,
+                   const char *fmt, va_list ap);
+int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
+                  const char *fmt, ...);
+
+#endif /* HW_XEN_BUS_HELPER_H */
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 41772dc73a..434d1dbf58 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -6,12 +6,19 @@
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
 
+#include "hw/xen/xen_common.h"
 #include "hw/sysbus.h"
 
 typedef struct XenDevice {
     DeviceState qdev;
+    domid_t frontend_id;
+    char *name;
+    char *backend_path, *frontend_path;
+    enum xenbus_state backend_state, frontend_state;
+    Notifier exit;
 } XenDevice;
 
+typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
 typedef void (*XenDeviceRealize)(XenDevice *xendev, Error **errp);
 typedef void (*XenDeviceUnrealize)(XenDevice *xendev, Error **errp);
 
@@ -19,6 +26,9 @@ typedef struct XenDeviceClass {
     /*< private >*/
     DeviceClass parent_class;
     /*< public >*/
+    const char *backend;
+    const char *device;
+    XenDeviceGetName get_name;
     XenDeviceRealize realize;
     XenDeviceUnrealize unrealize;
 } XenDeviceClass;
@@ -33,6 +43,8 @@ typedef struct XenDeviceClass {
 
 typedef struct XenBus {
     BusState qbus;
+    domid_t backend_id;
+    struct xs_handle *xsh;
 } XenBus;
 
 typedef struct XenBusClass {
-- 
2.11.0
