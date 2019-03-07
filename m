Received: from eggs.gnu.org ([209.51.188.92]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMv-00036q-7K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMs-0006aU-DK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMr-0006ZJ-D3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:02 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:51 -0800
Message-Id: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 35/37] multi-process: QMP/HMP
 commands to resize block device on remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, berrange@redhat.com, eblake@redhat.com, armbru@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Adds rblock_resize QMP/HMP commands to resize block devices on the remote
process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands.hx         | 14 +++++++++++++
 hmp.h                   |  1 +
 hw/proxy/monitor.c      | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |  2 ++
 qapi/block-core.json    | 25 +++++++++++++++++++++++
 remote/remote-main.c    | 36 +++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 510fc24..844acd0 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1429,6 +1429,20 @@ STEXI
 @findex rdrive_del
 Remove drive from remote PCI storage controller
 ETEXI
+
+    {
+        .name       = "rblock_resize",
+        .args_type  = "rdev_id:s,device:s,size:o",
+        .params     = "rdev_id device size",
+        .help       = "resize block device on the remote device",
+        .cmd        = hmp_rblock_resize,
+    },
+
+STEXI
+@item rblock_resize
+@findex rblock_resize
+Resize block device on the remote device
+ETEXI
 #endif
 
     {
diff --git a/hmp.h b/hmp.h
index 52b83c0..6a51bd3 100644
--- a/hmp.h
+++ b/hmp.h
@@ -152,5 +152,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_remote_proc_list(Monitor *mon, const QDict *qdict);
 void hmp_rdevice_add(Monitor *mon, const QDict *qdict);
 void hmp_rdevice_del(Monitor *mon, const QDict *qdict);
+void hmp_rblock_resize(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index aa09ea8..bd5fc4f 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -283,3 +283,56 @@ void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
     (void)g_hash_table_remove(pcms->remote_devs, (gpointer)id);
 }
 
+void qmp_rblock_resize(const char *rdev_id, const char *device, int64_t size,
+                       Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    PCIProxyDev *pdev = NULL;
+    ProcMsg msg = {0};
+    QString *json;
+    QDict *qdict;
+    int wait;
+
+    pdev = (PCIProxyDev *)g_hash_table_lookup(pcms->remote_devs, rdev_id);
+    if (!pdev) {
+        error_setg(errp, "No remote device named %s", device);
+        return;
+    }
+
+    qdict = qdict_new();
+    qdict_put_str(qdict, "device", device);
+    qdict_put_int(qdict, "size", size);
+
+    json = qobject_to_json(QOBJECT(qdict));
+
+    wait = GET_REMOTE_WAIT;
+
+    msg.cmd = BLOCK_RESIZE;
+    msg.bytestream = 1;
+    msg.size = strlen(qstring_get_str(json));
+    msg.data2 = (uint8_t *)qstring_get_str(json);
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+    (void)wait_for_remote(wait);
+    PUT_REMOTE_WAIT(wait);
+}
+
+void hmp_rblock_resize(Monitor *mon, const QDict *qdict)
+{
+    Error *local_err = NULL;
+    const char *rdev_id, *device;
+    int64_t size;
+
+    rdev_id = qdict_get_str(qdict, "rdev_id");
+    device = qdict_get_str(qdict, "device");
+    size = qdict_get_int(qdict, "size");
+
+    qmp_rblock_resize(rdev_id, device, size, &local_err);
+    if (local_err) {
+        monitor_printf(mon, "rblock_resize error: %s\n",
+                       error_get_pretty(local_err));
+        error_free(local_err);
+    }
+}
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 013a845..8ed520c 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -64,6 +64,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
  * DRIVE_ADD        HMP command to hotplug drive
  * DRIVE_DEL        HMP command to hot-unplug drive
+ * BLOCK_RESIZE     QMP/HMP command to resize block backend
  *
  */
 typedef enum {
@@ -81,6 +82,7 @@ typedef enum {
     DRIVE_ADD,
     DRIVE_DEL,
     PROXY_PING,
+    BLOCK_RESIZE,
     MAX,
 } proc_cmd_t;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 05394c4..4869ff7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1260,6 +1260,31 @@
             'size': 'int' } }
 
 ##
+# @rblock_resize:
+#
+# Resize a block image while a guest is running, on a remote device.
+#
+# @device: the name of the device to get the image resized
+#
+# @size:  new image size in bytes
+#
+# Returns: nothing on success
+#          If @device is not a valid block device, DeviceNotFound
+#
+# Since: 3.0.93
+#
+# Example:
+#
+# -> { "execute": "rblock_resize",
+#      "arguments": { "device": "scratch", "size": 1073741824 } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'rblock_resize',
+  'data': { 'rdev_id': 'str', 'device': 'str', 'size': 'int' },
+  'if': 'defined(CONFIG_MPQEMU)' }
+
+##
 # @NewImageMode:
 #
 # An enumeration that tells QEMU how to set the backing file path in
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 08e3528..3316546 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -64,6 +64,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-commands-block-core.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -272,6 +273,38 @@ static void process_drive_del_msg(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_block_resize_msg(ProcMsg *msg)
+{
+    const char *json = (const char *)msg->data2;
+    Error *local_err = NULL;
+    int wait = msg->fds[0];
+    const char *device;
+    int64_t size;
+    QObject *qobj = NULL;
+    QDict *qdict = NULL;
+
+    qobj = qobject_from_json(json, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    qdict = qobject_to(QDict, qobj);
+    assert(qdict);
+
+    device = qdict_get_str(qdict, "device");
+    size = qdict_get_int(qdict, "size");
+
+    qmp_block_resize(true, device, false, NULL, size, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -468,6 +501,9 @@ static void process_msg(GIOCondition cond)
         notify_proxy(wait, (uint32_t)getpid());
         PUT_REMOTE_WAIT(wait);
         break;
+    case BLOCK_RESIZE:
+        process_block_resize_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
