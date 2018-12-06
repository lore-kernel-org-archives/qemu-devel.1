Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUvZx-0001oL-NS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUvZt-0007N1-HS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:28:41 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 6 Dec 2018 15:08:41 +0000
Message-ID: <1544108924-10841-16-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 15/18] xen: add a mechanism to automatically
 create XenDevice-s...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

...that maintains compatibility with existing Xen toolstacks.

Xen toolstacks instantiate PV backends by simply writing information into
xenstore and expecting a backend implementation to be watching for this.

This patch adds a new 'xen-backend' module to allow individual XenDevice
implementations to register a creator function to be called when a tool-
stack instantiates a new backend in this way.

To support this it is also necessary to add new watchers into the XenBus
implementation to handle enumeration of new backends and also destruction
of XenDevice-s when the toolstack sets the backend 'online' key to 0.

NOTE: This patch only adds the framework. A subsequent patch will add a
      creator function for xen-block devices.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v2:
 - Sort out error paths and error reporting
---
 hw/xen/Makefile.objs         |   2 +-
 hw/xen/trace-events          |   5 +
 hw/xen/xen-backend.c         |  69 +++++++++++++
 hw/xen/xen-bus.c             | 226 +++++++++++++++++++++++++++++++++++++++----
 include/hw/xen/xen-backend.h |  26 +++++
 include/hw/xen/xen-bus.h     |   5 +-
 include/qemu/module.h        |   3 +
 7 files changed, 315 insertions(+), 21 deletions(-)
 create mode 100644 hw/xen/xen-backend.c
 create mode 100644 include/hw/xen/xen-backend.h

diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 77c0868..84df60a 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o
+common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o xen-backend.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 22055b5..d567242 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -16,13 +16,18 @@ xen_domid_restrict(int err) "err: %u"
 # include/hw/xen/xen-bus.c
 xen_bus_realize(void) ""
 xen_bus_unrealize(void) ""
+xen_bus_enumerate(void) ""
+xen_bus_type_enumerate(const char *type) "type: %s"
+xen_bus_backend_create(const char *type, const char *path) "type: %s path: %s"
 xen_bus_add_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
 xen_bus_remove_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
 xen_bus_watch(const char *token) "token: %s"
 xen_device_realize(const char *type, char *name) "type: %s name: %s"
 xen_device_unrealize(const char *type, char *name) "type: %s name: %s"
 xen_device_backend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
+xen_device_backend_online(const char *type, char *name, bool online) "type: %s name: %s -> %u"
 xen_device_frontend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
+xen_device_backend_changed(const char *type, char *name) "type: %s name: %s"
 xen_device_frontend_changed(const char *type, char *name) "type: %s name: %s"
 
 # include/hw/xen/xen-bus-helper.c
diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
new file mode 100644
index 0000000..d87e6ec
--- /dev/null
+++ b/hw/xen/xen-backend.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "hw/xen/xen-backend.h"
+
+typedef struct XenBackendImpl {
+    const char *type;
+    XenBackendDeviceCreate create;
+} XenBackendImpl;
+
+static GHashTable *xen_backend_table_get(void)
+{
+    static GHashTable *table;
+
+    if (table == NULL) {
+        table = g_hash_table_new(g_str_hash, g_str_equal);
+    }
+
+    return table;
+}
+
+static void xen_backend_table_add(XenBackendImpl *impl)
+{
+    g_hash_table_insert(xen_backend_table_get(), (void *)impl->type, impl);
+}
+
+static XenBackendImpl *xen_backend_table_lookup(const char *type)
+{
+    return g_hash_table_lookup(xen_backend_table_get(), type);
+}
+
+void xen_backend_register(const XenBackendInfo *info)
+{
+    XenBackendImpl *impl = g_new0(XenBackendImpl, 1);
+
+    g_assert(info->type);
+
+    if (xen_backend_table_lookup(info->type)) {
+        error_report("attempt to register duplicate Xen backend type '%s'",
+                     info->type);
+        abort();
+    }
+
+    if (!info->create) {
+        error_report("backend type '%s' has no creator", info->type);
+        abort();
+    }
+
+    impl->type = info->type;
+    impl->create = info->create;
+
+    xen_backend_table_add(impl);
+}
+
+void xen_backend_device_create(BusState *bus, const char *type,
+                               const char *name, QDict *opts, Error **errp)
+{
+    XenBackendImpl *impl = xen_backend_table_lookup(type);
+
+    if (impl) {
+        impl->create(bus, name, opts, errp);
+    }
+}
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 1b3837c..83edeb9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -11,10 +11,12 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
+#include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -148,12 +150,119 @@ static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
     }
 }
 
+static void xen_bus_backend_create(XenBus *xenbus, const char *type,
+                                   const char *name, char *path)
+{
+    char **key;
+    QDict *opts;
+    unsigned int i, n;
+    Error *local_err = NULL;
+
+    trace_xen_bus_backend_create(type, path);
+
+    key = xs_directory(xenbus->xsh, XBT_NULL, path, &n);
+    if (!key) {
+        return;
+    }
+
+    opts = qdict_new();
+    for (i = 0; i < n; i++) {
+        char *val;
+
+        /*
+         * Assume anything found in the xenstore backend area, other than
+         * the keys created for a generic XenDevice, are parameters
+         * to be used to configure the backend.
+         */
+        if (!strcmp(key[i], "state") ||
+            !strcmp(key[i], "online") ||
+            !strcmp(key[i], "frontend") ||
+            !strcmp(key[i], "frontend-id") ||
+            !strcmp(key[i], "hotplug-status"))
+            continue;
+
+        if (xs_node_scanf(xenbus->xsh, path, key[i], NULL, "%ms",
+                          &val) == 1) {
+            qdict_put_str(opts, key[i], val);
+            free(val);
+        }
+    }
+
+    xen_backend_device_create(BUS(xenbus), type, name, opts, &local_err);
+    qobject_unref(opts);
+
+    if (local_err) {
+        error_reportf_err(local_err, "failed to create '%s' device '%s': ",
+                      type, name);
+    }
+}
+
+static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
+{
+    char *domain_path = g_strdup_printf("backend/%s/%u", type, xen_domid);
+    char **backend;
+    unsigned int i, n;
+
+    trace_xen_bus_type_enumerate(type);
+
+    backend = xs_directory(xenbus->xsh, XBT_NULL, domain_path, &n);
+    if (!backend) {
+        goto out;
+    }
+
+    for (i = 0; i < n; i++) {
+        char *backend_path = g_strdup_printf("%s/%s", domain_path,
+                                             backend[i]);
+        enum xenbus_state backend_state;
+
+        if (xs_node_scanf(xenbus->xsh, backend_path, "state", NULL,
+                          "%u", &backend_state) != 1)
+            backend_state = XenbusStateUnknown;
+
+        if (backend_state == XenbusStateInitialising) {
+            xen_bus_backend_create(xenbus, type, backend[i], backend_path);
+        }
+
+        g_free(backend_path);
+    }
+
+    free(backend);
+
+out:
+    g_free(domain_path);
+}
+
+static void xen_bus_enumerate(void *opaque)
+{
+    XenBus *xenbus = opaque;
+    char **type;
+    unsigned int i, n;
+
+    trace_xen_bus_enumerate();
+
+    type = xs_directory(xenbus->xsh, XBT_NULL, "backend", &n);
+    if (!type) {
+        return;
+    }
+
+    for (i = 0; i < n; i++) {
+        xen_bus_type_enumerate(xenbus, type[i]);
+    }
+
+    free(type);
+}
+
 static void xen_bus_unrealize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
 
     trace_xen_bus_unrealize();
 
+    if (xenbus->backend_watch) {
+        xen_bus_remove_watch(xenbus, xenbus->backend_watch, NULL);
+        xenbus->backend_watch = NULL;
+    }
+
     if (!xenbus->xsh) {
         return;
     }
@@ -189,6 +298,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
     unsigned int domid;
+    Error *local_err = NULL;
 
     trace_xen_bus_realize();
 
@@ -208,6 +318,17 @@ static void xen_bus_realize(BusState *bus, Error **errp)
     notifier_list_init(&xenbus->watch_notifiers);
     qemu_set_fd_handler(xs_fileno(xenbus->xsh), xen_bus_watch, NULL,
                         xenbus);
+
+    module_call_init(MODULE_INIT_XEN_BACKEND);
+
+    xenbus->backend_watch =
+        xen_bus_add_watch(xenbus, "", /* domain root node */
+                          "backend", xen_bus_enumerate, xenbus, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to set up enumeration watch: ");
+    }
+
     return;
 
 fail:
@@ -293,6 +414,60 @@ enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
     return xendev->backend_state;
 }
 
+static void xen_device_backend_set_online(XenDevice *xendev, bool online)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    if (xendev->backend_online == online) {
+        return;
+    }
+
+    trace_xen_device_backend_online(type, xendev->name, online);
+
+    xendev->backend_online = online;
+    xen_device_backend_printf(xendev, "online", "%u", online);
+}
+
+static void xen_device_backend_changed(void *opaque)
+{
+    XenDevice *xendev = opaque;
+    const char *type = object_get_typename(OBJECT(xendev));
+    enum xenbus_state state;
+    unsigned int online;
+
+    trace_xen_device_backend_changed(type, xendev->name);
+
+    if (xen_device_backend_scanf(xendev, "state", "%u", &state) != 1) {
+        state = XenbusStateUnknown;
+    }
+
+    xen_device_backend_set_state(xendev, state);
+
+    if (xen_device_backend_scanf(xendev, "online", "%u", &online) != 1) {
+        online = 0;
+    }
+
+    xen_device_backend_set_online(xendev, !!online);
+
+    /*
+     * If a backend is still 'online' then its state should be cycled
+     * back round to InitWait in order for a new frontend instance to
+     * connect. This may happen when, for example, a frontend driver is
+     * re-installed or updated.
+     * If a backend is not 'online' then the device should be destroyed.
+     */
+    if (xendev->backend_online &&
+        xendev->backend_state == XenbusStateClosed) {
+        xen_device_backend_set_state(xendev, XenbusStateInitWait);
+    } else if (!xendev->backend_online &&
+               (xendev->backend_state == XenbusStateClosed ||
+                xendev->backend_state == XenbusStateInitialising ||
+                xendev->backend_state == XenbusStateInitWait ||
+                xendev->backend_state == XenbusStateUnknown)) {
+        object_unparent(OBJECT(xendev));
+    }
+}
+
 static void xen_device_backend_create(XenDevice *xendev, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
@@ -313,6 +488,27 @@ static void xen_device_backend_create(XenDevice *xendev, Error **errp)
     if (local_err) {
         error_propagate_prepend(errp, local_err,
                                 "failed to create backend: ");
+        return;
+    }
+
+    xendev->backend_state_watch =
+        xen_bus_add_watch(xenbus, xendev->backend_path,
+                          "state", xen_device_backend_changed,
+                          xendev, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to watch backend state: ");
+        return;
+    }
+
+    xendev->backend_online_watch =
+        xen_bus_add_watch(xenbus, xendev->backend_path,
+                          "online", xen_device_backend_changed,
+                          xendev, &local_err);
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to watch backend online: ");
+        return;
     }
 }
 
@@ -321,6 +517,16 @@ static void xen_device_backend_destroy(XenDevice *xendev)
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     Error *local_err = NULL;
 
+    if (xendev->backend_online_watch) {
+        xen_bus_remove_watch(xenbus, xendev->backend_online_watch, NULL);
+        xendev->backend_online_watch = NULL;
+    }
+
+    if (xendev->backend_state_watch) {
+        xen_bus_remove_watch(xenbus, xendev->backend_state_watch, NULL);
+        xendev->backend_state_watch = NULL;
+    }
+
     if (!xendev->backend_path) {
         return;
     }
@@ -412,24 +618,6 @@ static void xen_device_frontend_changed(void *opaque)
             error_reportf_err(local_err, "frontend change error: ");
         }
     }
-
-    /*
-     * If a backend is still 'online' then its state should be cycled
-     * back round to InitWait in order for a new frontend instance to
-     * connect. This may happen when, for example, a frontend driver is
-     * re-installed or updated.
-     */
-    if (xendev->backend_state == XenbusStateClosed) {
-        unsigned int online;
-
-        if (xen_device_backend_scanf(xendev, "online", "%u", &online) != 1) {
-            online = 0;
-        }
-
-        if (online) {
-            xen_device_backend_set_state(xendev, XenbusStateInitWait);
-        }
-    }
 }
 
 static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
@@ -830,9 +1018,9 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
                               xendev->frontend_path);
     xen_device_backend_printf(xendev, "frontend-id", "%u",
                               xendev->frontend_id);
-    xen_device_backend_printf(xendev, "online", "%u", 1);
     xen_device_backend_printf(xendev, "hotplug-status", "connected");
 
+    xen_device_backend_set_online(xendev, true);
     xen_device_backend_set_state(xendev, XenbusStateInitWait);
 
     xen_device_frontend_printf(xendev, "backend", "%s",
diff --git a/include/hw/xen/xen-backend.h b/include/hw/xen/xen-backend.h
new file mode 100644
index 0000000..dd9bd58
--- /dev/null
+++ b/include/hw/xen/xen-backend.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2018  Citrix Systems Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_XEN_BACKEND_H
+#define HW_XEN_BACKEND_H
+
+#include "hw/xen/xen-bus.h"
+
+typedef void (*XenBackendDeviceCreate)(BusState *bus, const char *name,
+                                       QDict *opts, Error **errp);
+
+typedef struct XenBackendInfo {
+    const char *type;
+    XenBackendDeviceCreate create;
+} XenBackendInfo;
+
+void xen_backend_register(const XenBackendInfo *info);
+
+void xen_backend_device_create(BusState *bus, const char *type,
+                               const char *name, QDict *opts, Error **errp);
+
+#endif /* HW_XEN_BACKEND_H */
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index d7f0f0a..e55a5de 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -23,7 +23,9 @@ typedef struct XenDevice {
     char *backend_path, *frontend_path;
     enum xenbus_state backend_state, frontend_state;
     Notifier exit;
-    XenWatch *frontend_state_watch;
+    XenWatch *backend_state_watch, *frontend_state_watch;
+    bool backend_online;
+    XenWatch *backend_online_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
     xenevtchn_handle *xeh;
@@ -63,6 +65,7 @@ typedef struct XenBus {
     domid_t backend_id;
     struct xs_handle *xsh;
     NotifierList watch_notifiers;
+    XenWatch *backend_watch;
 } XenBus;
 
 typedef struct XenBusClass {
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 54300ab..55dd2be 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -44,6 +44,7 @@ typedef enum {
     MODULE_INIT_OPTS,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
+    MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_MAX
 } module_init_type;
 
@@ -51,6 +52,8 @@ typedef enum {
 #define opts_init(function) module_init(function, MODULE_INIT_OPTS)
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
+#define xen_backend_init(function) module_init(function, \
+                                               MODULE_INIT_XEN_BACKEND)
 
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
-- 
2.1.4
