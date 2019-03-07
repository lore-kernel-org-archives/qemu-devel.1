Received: from eggs.gnu.org ([209.51.188.92]:59996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMM-0002a6-Bf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMJ-0005b4-1K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMI-0005Zc-5d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:26 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:18 -0800
Message-Id: <20190307072218.9153-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 22/37] multi-process: QMP/HMP
 commands to remove device from the remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, berrange@redhat.com, armbru@redhat.com, eblake@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Add rdevice_del QMP & HMP commands to hot-unplug device from remote
device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands.hx         | 14 ++++++++++++++
 hmp.h                   |  1 +
 hw/proxy/monitor.c      | 22 ++++++++++++++++++++++
 include/hw/qdev-core.h  |  1 +
 include/io/proxy-link.h |  2 ++
 include/monitor/qdev.h  |  1 +
 monitor.c               |  2 ++
 qapi/misc.json          | 27 +++++++++++++++++++++++++++
 qdev-monitor.c          |  2 +-
 remote/remote-main.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7e8e8ab..7f121b4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -741,6 +741,20 @@ Add device to remote proc.
 ETEXI
 
     {
+        .name       = "rdevice_del",
+        .args_type  = "rdev_id:s,id:s",
+        .params     = "rdev_id id",
+        .help       = "remove device from remote proc",
+        .cmd        = hmp_rdevice_del,
+    },
+
+STEXI
+@item rdevice_del @var{rdev_id} @var{id}
+@findex rdevice_del
+Remove device from remote proc.
+ETEXI
+
+    {
         .name       = "remote_proc_list",
         .args_type  = "",
         .params     = "",
diff --git a/hmp.h b/hmp.h
index 355a27e..52b83c0 100644
--- a/hmp.h
+++ b/hmp.h
@@ -151,5 +151,6 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_remote_proc_list(Monitor *mon, const QDict *qdict);
 void hmp_rdevice_add(Monitor *mon, const QDict *qdict);
+void hmp_rdevice_del(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index 2e2cda0..05c8f8b 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -158,6 +158,8 @@ static void rdevice_add_del(QDict *qdict, proc_cmd_t cmd, Error **errp)
     if (cmd == DEVICE_ADD) {
         (void)g_hash_table_insert(pcms->remote_devs, (gpointer)g_strdup(id),
                                   (gpointer)pdev);
+    } else {
+        (void)g_hash_table_remove(pcms->remote_devs, (gpointer)id);
     }
 }
 
@@ -179,3 +181,23 @@ void hmp_rdevice_add(Monitor *mon, const QDict *qdict)
         error_free(err);
     }
 }
+
+void qmp_rdevice_del(QDict *qdict, QObject **ret_data, Error **errp)
+{
+    rdevice_add_del(qdict, DEVICE_DEL, errp);
+}
+
+void hmp_rdevice_del(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    /* TODO: Is it OK to modify the QDict argument from HMP? */
+    rdevice_add_del((QDict *)qdict, DEVICE_DEL, &err);
+
+    if (err) {
+        monitor_printf(mon, "rdevice_del error: %s\n",
+                       error_get_pretty(err));
+        error_free(err);
+    }
+}
+
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 17f09aa..bdaa3b9 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -358,6 +358,7 @@ BusState *qdev_get_parent_bus(DeviceState *dev);
 /*** BUS API. ***/
 
 DeviceState *qdev_find_recursive(BusState *bus, const char *id);
+DeviceState *find_device_state(const char *id, Error **errp);
 
 /* Returns 0 to walk children, > 0 to skip walk, < 0 to terminate walk. */
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 8781508..ce2fcc3 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -61,6 +61,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * SET_IRQFD        Sets the IRQFD to be used to raise interrupts directly
  *                  from remote device
  * DEVICE_ADD       QMP/HMP command to hotplug device
+ * DEVICE_DEL       QMP/HMP command to hot-unplug device
  *
  */
 typedef enum {
@@ -72,6 +73,7 @@ typedef enum {
     BAR_READ,
     SET_IRQFD,
     DEVICE_ADD,
+    DEVICE_DEL,
     MAX,
 } proc_cmd_t;
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 065701c..0ca0833 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -12,6 +12,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 #ifdef CONFIG_MPQEMU
 void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
+void qmp_rdevice_del(QDict *qdict, QObject **ret_data, Error **errp);
 #endif
 
 int qdev_device_help(QemuOpts *opts);
diff --git a/monitor.c b/monitor.c
index 0ad52e5..6686c80 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1158,6 +1158,8 @@ static void monitor_init_qmp_commands(void)
 #ifdef CONFIG_MPQEMU
     qmp_register_command(&qmp_commands, "rdevice_add", qmp_rdevice_add,
                          QCO_NO_OPTIONS);
+    qmp_register_command(&qmp_commands, "rdevice_del", qmp_rdevice_del,
+                         QCO_NO_OPTIONS);
 #endif
 
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
diff --git a/qapi/misc.json b/qapi/misc.json
index 28d49ea..bc1d2ec 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1717,6 +1717,33 @@
 { 'command': 'device_del', 'data': {'id': 'str'} }
 
 ##
+# @rdevice_del:
+#
+# Remove a device from a guest
+#
+# @rdev_id: ID of the remote device root
+#
+# @id: the device's ID
+#
+# Returns: Nothing on success
+#          If @id is not a valid device, DeviceNotFound
+#
+# Notes: When this command completes, the device may not be removed from the
+#        guest.  Hot removal is an operation that requires guest cooperation.
+#        This command merely requests that the guest begin the hot removal
+#        process.  Completion of the device removal process is signaled with a
+#        DEVICE_DELETED event. Guest reset will automatically complete removal
+#        for all devices.
+#
+# Since: 3.0
+#
+##
+{ 'command': 'rdevice_del',
+  'data': {'rdev_id': 'str', 'id': 'str'},
+  'if': 'defined(CONFIG_MPQEMU)',
+  'gen': false }
+
+##
 # @DEVICE_DELETED:
 #
 # Emitted whenever the device removal completion is acknowledged by the guest.
diff --git a/qdev-monitor.c b/qdev-monitor.c
index d432098..46d0ad0 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -828,7 +828,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 03c14de..a9c12a9 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -53,6 +53,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -181,6 +182,47 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_del_msg(ProcMsg *msg)
+{
+    Error *local_err = NULL;
+    DeviceState *dev = NULL;
+    const char *json = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QObject *qobj = NULL;
+    QDict *qdict = NULL;
+    const char *id;
+
+    qobj = qobject_from_json(json, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    qdict = qobject_to(QDict, qobj);
+    assert(qdict);
+
+    id = qdict_get_try_str(qdict, "id");
+    assert(id);
+
+    dev = find_device_state(id, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    if (dev) {
+        qdev_unplug(dev, &local_err);
+    }
+
+fail:
+    if (local_err) {
+        error_report_err(local_err);
+        /* TODO: communicate the exact error message to proxy */
+    }
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -235,6 +277,9 @@ static void process_msg(GIOCondition cond)
     case DEVICE_ADD:
         process_device_add_msg(msg);
         break;
+    case DEVICE_DEL:
+        process_device_del_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
