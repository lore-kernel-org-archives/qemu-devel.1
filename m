Received: from eggs.gnu.org ([2001:4830:134:3::10]:51778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkQj-00053k-Jb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkQh-0004Jf-E1
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:58:41 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:57:39 +0000
Message-ID: <1544543862-9997-16-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
References: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 15/18] xen: add a mechanism to automatically
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
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

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
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v3:
 - Use a xenstore transaction in enumeration code to ensure consistent
   parameters
 - Not adding Anthony's R-b because of change

v2:
 - Sort out error paths and error reporting
---
 hw/xen/Makefile.objs         |   2 +-
 hw/xen/trace-events          |   3 +
 hw/xen/xen-backend.c         |  69 +++++++++++++++++++
 hw/xen/xen-bus.c             | 154 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-backend.h |  26 ++++++++
 include/hw/xen/xen-bus.h     |   1 +
 include/qemu/module.h        |   3 +
 7 files changed, 257 insertions(+), 1 deletion(-)
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
index d4651bd..f694462 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -16,6 +16,9 @@ xen_domid_restrict(int err) "err: %u"
 # include/hw/xen/xen-bus.c
 xen_bus_realize(void) ""
 xen_bus_unrealize(void) ""
+xen_bus_enumerate(void) ""
+xen_bus_type_enumerate(const char *type) "type: %s"
+xen_bus_backend_create(const char *type, const char *path) "type: %s path: %s"
 xen_bus_add_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
 xen_bus_remove_watch(const char *node, const char *key, char *token) "node: %s key: %s token: %s"
 xen_bus_watch(const char *token) "token: %s"
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
index a22aa49..7593d61 100644
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
 
@@ -190,12 +192,151 @@ static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
     free_watch(watch);
 }
 
+static void xen_bus_backend_create(XenBus *xenbus, const char *type,
+                                   const char *name, char *path,
+                                   Error **errp)
+{
+    xs_transaction_t tid;
+    char **key;
+    QDict *opts;
+    unsigned int i, n;
+    Error *local_err = NULL;
+
+    trace_xen_bus_backend_create(type, path);
+
+again:
+    tid = xs_transaction_start(xenbus->xsh);
+    if (tid == XBT_NULL) {
+        error_setg(errp, "failed xs_transaction_start");
+        return;
+    }
+
+    key = xs_directory(xenbus->xsh, tid, path, &n);
+    if (!key) {
+        if (!xs_transaction_end(xenbus->xsh, tid, true)) {
+            error_setg_errno(errp, errno, "failed xs_transaction_end");
+        }
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
+        if (xs_node_scanf(xenbus->xsh, tid, path, key[i], NULL, "%ms",
+                          &val) == 1) {
+            qdict_put_str(opts, key[i], val);
+            free(val);
+        }
+    }
+
+    free(key);
+
+    if (!xs_transaction_end(xenbus->xsh, tid, false)) {
+        qobject_unref(opts);
+
+        if (errno == EAGAIN) {
+            goto again;
+        }
+
+        error_setg_errno(errp, errno, "failed xs_transaction_end");
+        return;
+    }
+
+    xen_backend_device_create(BUS(xenbus), type, name, opts, &local_err);
+    qobject_unref(opts);
+
+    if (local_err) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to create '%s' device '%s': ",
+                                type, name);
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
+        if (xs_node_scanf(xenbus->xsh, XBT_NULL, backend_path, "state",
+                          NULL, "%u", &backend_state) != 1)
+            backend_state = XenbusStateUnknown;
+
+        if (backend_state == XenbusStateInitialising) {
+            Error *local_err = NULL;
+
+            xen_bus_backend_create(xenbus, type, backend[i], backend_path,
+                                   &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+            }
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
@@ -231,6 +372,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
     unsigned int domid;
+    Error *local_err = NULL;
 
     trace_xen_bus_realize();
 
@@ -250,6 +392,18 @@ static void xen_bus_realize(BusState *bus, Error **errp)
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
+        /* This need not be treated as a hard error so don't propagate */
+        error_reportf_err(local_err,
+                          "failed to set up enumeration watch: ");
+    }
+
     return;
 
 fail:
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
index 0834cb3..e55a5de 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -65,6 +65,7 @@ typedef struct XenBus {
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
