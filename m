Received: from eggs.gnu.org ([209.51.188.92]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMY-0002kE-Du
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMU-0005hh-OR
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMT-0005fc-EK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:37 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:29 -0800
Message-Id: <20190307072229.9409-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 26/37] multi-process: add
 qdev_proxy_add to create proxy devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, ehabkost@redhat.com, marcandre.lureau@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

This is handled while parsing the command line options.
The parsed options are being sent to remote process
as the messgaes containing JSON strings.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/hw/proxy/qemu-proxy.h |   7 ++
 include/monitor/qdev.h        |   4 ++
 qdev-monitor.c                | 159 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 6b61bb7..3639792 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -74,6 +74,13 @@ typedef struct PCIProxyDevClass {
     char *command;
 } PCIProxyDevClass;
 
+typedef struct PCIProxyDevList {
+    QLIST_HEAD(, PCIProxyDev) devices;
+} proxy_dev_list_t;
+
+extern QemuMutex proxy_list_lock;
+extern proxy_dev_list_t proxy_dev_list;
+
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                              uint64_t val, unsigned size, bool memory);
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 0ca0833..089429c 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -11,8 +11,12 @@ void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 #ifdef CONFIG_MPQEMU
+#include "hw/proxy/qemu-proxy.h"
 void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
 void qmp_rdevice_del(QDict *qdict, QObject **ret_data, Error **errp);
+DeviceState *qdev_proxy_add(const char *rid, const char *id, Error **errp);
+DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp);
+void qdev_proxy_fire(void);
 #endif
 
 int qdev_device_help(QemuOpts *opts);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index eb7e542..e0e16d8 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -33,6 +33,16 @@
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "hw/proxy/proxy-lsi53c895a.h"
+#include "include/qemu/cutils.h"
+#include "include/qemu/log.h"
+#include "qapi/qmp/qlist.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "io/proxy-link.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -45,6 +55,8 @@ typedef struct QDevAlias
     uint32_t arch_mask;
 } QDevAlias;
 
+proxy_dev_list_t proxy_dev_list;
+QemuMutex proxy_list_lock;
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "e1000", "e1000-82540em" },
@@ -569,6 +581,153 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
+#if defined(CONFIG_MPQEMU)
+PCIProxyDev *get_proxy_object(const char *rid);
+PCIProxyDev *get_proxy_object(const char *rid)
+{
+    PCIProxyDev *entry;
+
+    qemu_mutex_lock(&proxy_list_lock);
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (strncmp(entry->rid, rid, strlen(entry->rid)) == 0) {
+            qemu_mutex_unlock(&proxy_list_lock);
+            return entry;
+        }
+    }
+    qemu_mutex_unlock(&proxy_list_lock);
+    return NULL;
+
+}
+
+#define MAX_RID_LENGTH 10
+void qdev_proxy_fire(void)
+{
+    PCIProxyDev *entry;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (entry->proxy_ready) {
+            entry->proxy_ready(PCI_DEVICE(entry));
+        }
+    }
+}
+
+DeviceState *qdev_proxy_add(const char *rid, const char *id, Error **errp)
+{
+    DeviceState *ds;
+    PCIProxyDev *pdev;
+    QemuOpts *proxy_opts;
+    const char *proxy_type;
+    Error *local_err = NULL;
+    QDict *qdict;
+    const char *str;
+
+    pdev = get_proxy_object(rid);
+    if (pdev) {
+        return DEVICE(pdev);
+    }
+
+    if (strlen(rid) > MAX_RID_LENGTH) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "rid is too long.\n");
+        error_setg(errp, "rid %s is too long", rid);
+        return NULL;
+    }
+
+    proxy_opts = qemu_opts_create(&qemu_device_opts, NULL, 0,
+                                  errp);
+
+    /* TODO: remove hardcoded type and add approptiate type identification. */
+    proxy_type = TYPE_PROXY_LSI53C895A;
+    if (!proxy_type) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Driver is not supported in"
+                      " multi-process qemu.\n");
+        error_setg(errp, "Driver is not supported in multi-process qemu.");
+        return NULL;
+    }
+
+    qemu_opts_set_id(proxy_opts, (char *)rid);
+    qemu_opt_set(proxy_opts, "driver", proxy_type, &local_err);
+
+    qdict = qemu_opts_to_qdict(proxy_opts, NULL);
+    str = qstring_get_str(qobject_to_json(QOBJECT(qdict)));
+
+    ds = qdev_device_add(proxy_opts, &local_err);
+    if (!ds) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Could not create proxy device"
+                      " with opts %s.\n", str);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+    qdev_set_id(ds, qemu_opts_id(proxy_opts));
+
+    pdev = PCI_PROXY_DEV(ds);
+    if (!pdev) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "qdev_device_add failed.\n");
+        qdev_unplug(ds, errp);
+        return NULL;
+    }
+    pdev->rid = g_strdup(rid);
+
+    qemu_mutex_lock(&proxy_list_lock);
+    QLIST_INSERT_HEAD(&proxy_dev_list.devices, pdev, next);
+    qemu_mutex_unlock(&proxy_list_lock);
+
+    return ds;
+}
+
+DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp)
+{
+    PCIProxyDev *pdev = NULL;
+    DeviceState *dev;
+    const char *rid;
+    QDict *qdict_new;
+
+    if (!proxy_list_lock.initialized) {
+        QLIST_INIT(&proxy_dev_list.devices);
+        qemu_mutex_init(&proxy_list_lock);
+    }
+
+    rid = qemu_opt_get(opts, "rid");
+    if (!rid) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "rdevice option needs rid"
+                      " specified.\n");
+        error_setg(errp, "rdevice option needs rid specified.");
+        return NULL;
+    }
+
+    dev = qdev_proxy_add(rid, qemu_opt_get(opts, "id"), errp);
+    if (!dev) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Failed to add proxy for %s\n",
+                      device ? "device" : "driver");
+        error_setg(errp, "qdev_proxy_add error.");
+        return NULL;
+    }
+
+    qdict_new = qemu_opts_to_qdict(opts, NULL);
+
+    if (!qdict_new) {
+        printf("Could not parse rdevice options.");
+        error_setg(errp, "Could not parse rdevice options.");
+        return NULL;
+    }
+
+    pdev = PCI_PROXY_DEV(dev);
+    if (!pdev->set_remote_opts) {
+        printf("will not set remote opts\n");
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Device/driver opts are not"
+                      " specified, probably no multi-process support"
+                      " rid=%s\n", rid);
+        /* TODO: destroy proxy? */
+        error_setg(errp, "set_remote_opts not set.");
+        return NULL;
+    } else {
+        pdev->set_remote_opts(PCI_DEVICE(pdev), qdict_new,
+                              device ? DEV_OPTS : DRIVE_OPTS);
+    }
+
+    return dev;
+}
+#endif /*defined(CONFIG_MPQEMU)*/
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
     DeviceClass *dc;
-- 
1.8.3.1
