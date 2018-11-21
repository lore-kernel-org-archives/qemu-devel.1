Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB6-0005Vs-31
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB3-0003gL-8A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:32 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:11:58 +0000
Message-ID: <20181121151211.15997-6-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 05/18] xen: add xenstore watcher infratructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

A Xen PV frontend communicates its state to the PV backend by writing to
the 'state' key in the frontend area in xenstore. It is therefore
necessary for a XenDevice implementation to be notified whenever the
value of this key changes.

This patch adds code to do this as follows:

- an 'fd handler' is registered on the libxenstore handle which will be
  triggered whenever a 'watch' event occurs
- primitives are added to xen-bus-helper to add or remove watch events
- a list of Notifier objects is added to XenBus to provide a mechanism
  to call the appropriate 'watch handler' when its associated event
  occurs

The xen-qisk implementation is extended with a 'frontend_changed' method,
which calls as-yet stub 'connect' and 'disconnect' functions when the
relevant frontend state transitions occur. A subsequent patch will supply
a full implementation for these functions.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/block/trace-events           |   2 +
 hw/block/xen-qdisk.c            |  56 +++++++++++
 hw/xen/trace-events             |   4 +
 hw/xen/xen-bus-helper.c         |  28 ++++++
 hw/xen/xen-bus.c                | 205 +++++++++++++++++++++++++++++++++++++++-
 include/hw/xen/xen-bus-helper.h |   5 +
 include/hw/xen/xen-bus.h        |  15 +++
 7 files changed, 313 insertions(+), 2 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index fd3c126ac1..8b95567560 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -130,4 +130,6 @@ xen_disk_free(char *name) "%s"
 
 # hw/block/xen-qdisk.c
 xen_qdisk_realize(uint32_t disk, uint32_t partition) "d%up%u"
+xen_qdisk_connect(uint32_t disk, uint32_t partition) "d%up%u"
+xen_qdisk_disconnect(uint32_t disk, uint32_t partition) "d%up%u"
 xen_qdisk_unrealize(uint32_t disk, uint32_t partition) "d%up%u"
diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
index 0859643f7d..35f7b70480 100644
--- a/hw/block/xen-qdisk.c
+++ b/hw/block/xen-qdisk.c
@@ -32,12 +32,67 @@ static void xen_qdisk_realize(XenDevice *xendev, Error **errp)
     trace_xen_qdisk_realize(vdev->disk, vdev->partition);
 }
 
+static void xen_qdisk_connect(XenQdiskDevice *qdiskdev, Error **errp)
+{
+    XenQdiskVdev *vdev = &qdiskdev->vdev;
+
+    trace_xen_qdisk_connect(vdev->disk, vdev->partition);
+}
+
+static void xen_qdisk_disconnect(XenQdiskDevice *qdiskdev, Error **errp)
+{
+    XenQdiskVdev *vdev = &qdiskdev->vdev;
+
+    trace_xen_qdisk_disconnect(vdev->disk, vdev->partition);
+}
+
+static void xen_qdisk_frontend_changed(XenDevice *xendev,
+                                       enum xenbus_state frontend_state,
+                                       Error **errp)
+{
+    XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
+    enum xenbus_state backend_state = xen_device_backend_get_state(xendev);
+    Error *local_err = NULL;
+
+    switch (frontend_state) {
+    case XenbusStateInitialised:
+    case XenbusStateConnected:
+        if (backend_state == XenbusStateConnected) {
+            break;
+        }
+
+        xen_qdisk_disconnect(qdiskdev, &error_fatal);
+        xen_qdisk_connect(qdiskdev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            break;
+        }
+
+        xen_device_backend_set_state(xendev, XenbusStateConnected);
+        break;
+
+    case XenbusStateClosing:
+        xen_device_backend_set_state(xendev, XenbusStateClosing);
+        break;
+
+    case XenbusStateClosed:
+        xen_qdisk_disconnect(qdiskdev, &error_fatal);
+        xen_device_backend_set_state(xendev, XenbusStateClosed);
+        break;
+
+    default:
+        break;
+    }
+}
+
 static void xen_qdisk_unrealize(XenDevice *xendev, Error **errp)
 {
     XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
     XenQdiskVdev *vdev = &qdiskdev->vdev;
 
     trace_xen_qdisk_unrealize(vdev->disk, vdev->partition);
+
+    xen_qdisk_disconnect(qdiskdev, &error_fatal);
 }
 
 static char *disk_to_vbd_name(unsigned int disk)
@@ -246,6 +301,7 @@ static void xen_qdisk_class_init(ObjectClass *class, void *data)
     xendev_class->device = "vbd";
     xendev_class->get_name = xen_qdisk_get_name;
     xendev_class->realize = xen_qdisk_realize;
+    xendev_class->frontend_changed = xen_qdisk_frontend_changed;
     xendev_class->unrealize = xen_qdisk_unrealize;
 
     dev_class->desc = "Xen Qdisk Device";
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index fa8aea1da1..94c46c2e34 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -16,7 +16,11 @@ xen_domid_restrict(int err) "err: %u"
 # include/hw/xen/xen-bus.c
 xen_bus_realize(void) ""
 xen_bus_unrealize(void) ""
+xen_bus_add_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
+xen_bus_remove_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
+xen_bus_watch(const char *token) "token: %s"
 xen_device_realize(const char *type, char *name) "type: %s name: %s"
 xen_device_unrealize(const char *type, char *name) "type: %s name: %s"
 xen_device_backend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
 xen_device_frontend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
+xen_device_frontend_changed(const char *type, char *name) "type: %s name: %s"
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index d9ee2ed6a0..b44acc8047 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -122,3 +122,31 @@ int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
 
     return rc;
 }
+
+void xs_node_watch(struct xs_handle *xsh, const char *node, const char *key,
+                   char *token, Error **errp)
+{
+    char *path;
+
+    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
+        g_strdup(key);
+
+    if (!xs_watch(xsh, path, token)) {
+        error_setg_errno(errp, errno, "failed to watch path '%s'", path);
+    }
+
+    g_free(path);
+}
+
+void xs_node_unwatch(struct xs_handle *xsh, const char *node,
+                     const char *key, const char *token)
+{
+    char *path;
+
+    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
+        g_strdup(key);
+
+    xs_unwatch(xsh, path, token);
+
+    g_free(path);
+}
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 663aa8e117..99988f8568 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -4,6 +4,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "qemu/uuid.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
@@ -57,6 +60,78 @@ static char *xen_bus_get_dev_path(DeviceState *dev)
     return xen_device_get_backend_path(XEN_DEVICE(dev));
 }
 
+struct XenWatch {
+    char *node, *key;
+    char *token;
+    XenWatchHandler handler;
+    void *opaque;
+    Notifier notifier;
+};
+
+static void watch_notify(Notifier *n, void *data)
+{
+    XenWatch *watch = container_of(n, XenWatch, notifier);
+    const char *token = data;
+
+    if (!strcmp(watch->token, token)) {
+        watch->handler(watch->opaque);
+    }
+}
+
+static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
+                                   const char *key, XenWatchHandler handler,
+                                   void *opaque, Error **errp)
+{
+    XenWatch *watch = g_new0(XenWatch, 1);
+    QemuUUID uuid;
+    Error *local_err = NULL;
+
+    qemu_uuid_generate(&uuid);
+    watch->token = qemu_uuid_unparse_strdup(&uuid);
+
+    trace_xen_bus_add_watch(node, key, watch->token);
+
+    watch->node = g_strdup(node);
+    watch->key = g_strdup(key);
+    watch->handler = handler;
+    watch->opaque = opaque;
+    watch->notifier.notify = watch_notify;
+
+    notifier_list_add(&xenbus->watch_notifiers, &watch->notifier);
+
+    xs_node_watch(xenbus->xsh, node, key, watch->token, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+
+        notifier_remove(&watch->notifier);
+
+        g_free(watch->token);
+        g_free(watch->key);
+        g_free(watch->node);
+
+        g_free(watch);
+        watch = NULL;
+    }
+
+    return watch;
+}
+
+static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch)
+{
+    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
+
+    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch->token);
+
+    notifier_remove(&watch->notifier);
+
+    g_free(watch->token);
+    g_free(watch->key);
+    g_free(watch->node);
+
+    g_free(watch);
+}
+
 static void xen_bus_unrealize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
@@ -67,9 +142,34 @@ static void xen_bus_unrealize(BusState *bus, Error **errp)
         return;
     }
 
+    qemu_set_fd_handler(xs_fileno(xenbus->xsh), NULL, NULL, NULL);
+
     xs_close(xenbus->xsh);
 }
 
+static void xen_bus_watch(void *opaque)
+{
+    XenBus *xenbus = opaque;
+    char **v;
+    const char *token;
+    unsigned int n;
+
+    g_assert(xenbus->xsh);
+
+    v = xs_read_watch(xenbus->xsh, &n);
+    if (!v) {
+        return;
+    }
+
+    token = v[XS_WATCH_TOKEN];
+
+    trace_xen_bus_watch(token);
+
+    notifier_list_notify(&xenbus->watch_notifiers, (void *)token);
+
+    free(v);
+}
+
 static void xen_bus_realize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
@@ -90,6 +190,9 @@ static void xen_bus_realize(BusState *bus, Error **errp)
         xenbus->backend_id = 0; /* Assume lack of node means dom0 */
     }
 
+    notifier_list_init(&xenbus->watch_notifiers);
+    qemu_set_fd_handler(xs_fileno(xenbus->xsh), xen_bus_watch, NULL,
+                        xenbus);
     return;
 
 fail:
@@ -127,8 +230,25 @@ static void xen_device_backend_printf(XenDevice *xendev, const char *key,
     va_end(ap);
 }
 
-static void xen_device_backend_set_state(XenDevice *xendev,
-                                         enum xenbus_state state)
+static int xen_device_backend_scanf(XenDevice *xendev, const char *key,
+                                    const char *fmt, ...)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    va_list ap;
+    int rc;
+
+    g_assert(xenbus->xsh);
+
+    va_start(ap, fmt);
+    rc = xs_node_vscanf(xenbus->xsh, xendev->backend_path, key, fmt,
+                        ap);
+    va_end(ap);
+
+    return rc;
+}
+
+void xen_device_backend_set_state(XenDevice *xendev,
+                                  enum xenbus_state state)
 {
     const char *type = object_get_typename(OBJECT(xendev));
 
@@ -143,6 +263,11 @@ static void xen_device_backend_set_state(XenDevice *xendev,
     xen_device_backend_printf(xendev, "state", "%u", state);
 }
 
+enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
+{
+    return xendev->backend_state;
+}
+
 static void xen_device_backend_create(XenDevice *xendev, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
@@ -193,6 +318,23 @@ static void xen_device_frontend_printf(XenDevice *xendev, const char *key,
     va_end(ap);
 }
 
+static int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
+                                      const char *fmt, ...)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+    va_list ap;
+    int rc;
+
+    g_assert(xenbus->xsh);
+
+    va_start(ap, fmt);
+    rc = xs_node_vscanf(xenbus->xsh, xendev->frontend_path, key, fmt,
+                        ap);
+    va_end(ap);
+
+    return rc;
+}
+
 static void xen_device_frontend_set_state(XenDevice *xendev,
                                           enum xenbus_state state)
 {
@@ -209,6 +351,53 @@ static void xen_device_frontend_set_state(XenDevice *xendev,
     xen_device_frontend_printf(xendev, "state", "%u", state);
 }
 
+static void xen_device_frontend_changed(void *opaque)
+{
+    XenDevice *xendev = opaque;
+    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
+    const char *type = object_get_typename(OBJECT(xendev));
+    enum xenbus_state state;
+
+    trace_xen_device_frontend_changed(type, xendev->name);
+
+    if (xen_device_frontend_scanf(xendev, "state", "%u", &state) != 1) {
+        state = XenbusStateUnknown;
+    }
+
+    xen_device_frontend_set_state(xendev, state);
+
+    if (xendev_class->frontend_changed) {
+        Error *local_err = NULL;
+
+        xendev_class->frontend_changed(xendev, state, &local_err);
+
+        if (local_err) {
+            const char *msg = error_get_pretty(local_err);
+
+            error_report("frontend change error: %s", msg);
+            error_free(local_err);
+        }
+    }
+
+    /*
+     * If a backend is still 'online' then its state should be cycled
+     * back round to InitWait in order for a new frontend instance to
+     * connect. This may happen when, for example, a frontend driver is
+     * re-installed or updated.
+     */
+    if (xendev->backend_state == XenbusStateClosed) {
+        unsigned int online;
+
+        if (xen_device_backend_scanf(xendev, "online", "%u", &online) != 1) {
+            online = 0;
+        }
+
+        if (online) {
+            xen_device_backend_set_state(xendev, XenbusStateInitWait);
+        }
+    }
+}
+
 static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
@@ -230,12 +419,24 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
         error_propagate(errp, local_err);
         error_prepend(errp, "failed to create frontend: ");
     }
+
+    xendev->frontend_state_watch =
+        xen_bus_add_watch(xenbus, xendev->frontend_path, "state",
+                          xen_device_frontend_changed, xendev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "failed to watch frontend state: ");
+    }
 }
 
 static void xen_device_frontend_destroy(XenDevice *xendev)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
 
+    if (xendev->frontend_state_watch) {
+        xen_bus_remove_watch(xenbus, xendev->frontend_state_watch);
+    }
+
     if (!xendev->frontend_path) {
         return;
     }
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
index 53570650db..3b88efaa0c 100644
--- a/include/hw/xen/xen-bus-helper.h
+++ b/include/hw/xen/xen-bus-helper.h
@@ -23,4 +23,9 @@ int xs_node_vscanf(struct xs_handle *xsh, const char *node, const char *key,
 int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
                   const char *fmt, ...);
 
+void xs_node_watch(struct xs_handle *xsh, const char *node, const char *key,
+                   char *token, Error **errp);
+void xs_node_unwatch(struct xs_handle *xsh, const char *node, const char *key,
+                     const char *token);
+
 #endif /* HW_XEN_BUS_HELPER_H */
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 434d1dbf58..954149e51b 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -8,6 +8,11 @@
 
 #include "hw/xen/xen_common.h"
 #include "hw/sysbus.h"
+#include "qemu/notify.h"
+
+typedef void (*XenWatchHandler)(void *opaque);
+
+typedef struct XenWatch XenWatch;
 
 typedef struct XenDevice {
     DeviceState qdev;
@@ -16,10 +21,14 @@ typedef struct XenDevice {
     char *backend_path, *frontend_path;
     enum xenbus_state backend_state, frontend_state;
     Notifier exit;
+    XenWatch *frontend_state_watch;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
 typedef void (*XenDeviceRealize)(XenDevice *xendev, Error **errp);
+typedef void (*XenDeviceFrontendChanged)(XenDevice *xendev,
+                                         enum xenbus_state frontend_state,
+                                         Error **errp);
 typedef void (*XenDeviceUnrealize)(XenDevice *xendev, Error **errp);
 
 typedef struct XenDeviceClass {
@@ -30,6 +39,7 @@ typedef struct XenDeviceClass {
     const char *device;
     XenDeviceGetName get_name;
     XenDeviceRealize realize;
+    XenDeviceFrontendChanged frontend_changed;
     XenDeviceUnrealize unrealize;
 } XenDeviceClass;
 
@@ -45,6 +55,7 @@ typedef struct XenBus {
     BusState qbus;
     domid_t backend_id;
     struct xs_handle *xsh;
+    NotifierList watch_notifiers;
 } XenBus;
 
 typedef struct XenBusClass {
@@ -62,4 +73,8 @@ typedef struct XenBusClass {
 
 void xen_bus_init(void);
 
+void xen_device_backend_set_state(XenDevice *xendev,
+                                  enum xenbus_state state);
+enum xenbus_state xen_device_backend_get_state(XenDevice *xendev);
+
 #endif /* HW_XEN_BUS_H */
-- 
2.11.0
