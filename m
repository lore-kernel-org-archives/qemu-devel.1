Received: from eggs.gnu.org ([209.51.188.92]:60320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMs-000329-C6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMr-0006Zl-01
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMq-0006Z4-JP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:00 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:48 -0800
Message-Id: <20190307072248.9778-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 34/37] multi-process: HMP
 command to delete drive from remote device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, berrange@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Add rdrive_del HMP command to hot-unplug drive from remote device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hmp-commands.hx           | 14 ++++++++++++++
 hw/proxy/monitor.c        | 37 +++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h   |  2 ++
 include/sysemu/blockdev.h |  1 +
 remote/remote-main.c      | 18 ++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 3829203..510fc24 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1415,6 +1415,20 @@ STEXI
 @findex rdrive_add
 Add drive to remote PCI storage controller.
 ETEXI
+
+    {
+        .name       = "rdrive_del",
+        .args_type  = "rdev_id:s,id:s",
+        .params     = "rdev_id id",
+        .help       = "remove drive from remote PCI storage controller",
+        .cmd        = hmp_rdrive_del,
+    },
+
+STEXI
+@item rdrive_del
+@findex rdrive_del
+Remove drive from remote PCI storage controller
+ETEXI
 #endif
 
     {
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index ead1e3d..aa09ea8 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -42,6 +42,7 @@
 #include "qapi/error.h"
 #include "io/proxy-link.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
 
 /*
  * TODO: Is there a callback where the allocated memory for QMP could be free'd
@@ -246,3 +247,39 @@ void hmp_rdrive_add(Monitor *mon, const QDict *qdict)
     g_free(data);
 }
 
+void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    Error *local_err = NULL;
+    ProcMsg msg = {0};
+    PCIProxyDev *pdev = NULL;
+    const char *id;
+    int wait;
+
+    pdev = get_proxy_device((QDict *)qdict, &local_err);
+    if (local_err) {
+        monitor_printf(mon, "rdrive_del error: %s\n",
+                       error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    id = qdict_get_str(qdict, "id");
+
+    wait = GET_REMOTE_WAIT;
+
+    msg.cmd = DRIVE_DEL;
+    msg.bytestream = 1;
+    msg.size = strlen(id);
+    msg.data2 = (uint8_t *)id;
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+    (void)wait_for_remote(wait);
+    PUT_REMOTE_WAIT(wait);
+
+    /* TODO: Only on success */
+    (void)g_hash_table_remove(pcms->remote_devs, (gpointer)id);
+}
+
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 3ef16f1..013a845 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -63,6 +63,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * DEVICE_ADD       QMP/HMP command to hotplug device
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
  * DRIVE_ADD        HMP command to hotplug drive
+ * DRIVE_DEL        HMP command to hot-unplug drive
  *
  */
 typedef enum {
@@ -78,6 +79,7 @@ typedef enum {
     DEVICE_ADD,
     DEVICE_DEL,
     DRIVE_ADD,
+    DRIVE_DEL,
     PROXY_PING,
     MAX,
 } proc_cmd_t;
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index d34c492..e6a9780 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -61,4 +61,5 @@ DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
 
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_rdrive_del(Monitor *mon, const QDict *qdict);
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 4c52d30..08e3528 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -257,6 +257,21 @@ static void process_drive_add_msg(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_drive_del_msg(ProcMsg *msg)
+{
+    const char *idstr = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QDict *qdict = qdict_new();
+
+    qdict_put_str(qdict, "id", idstr);
+
+    hmp_drive_del(NULL, qdict);
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -445,6 +460,9 @@ static void process_msg(GIOCondition cond)
     case DRIVE_ADD:
         process_drive_add_msg(msg);
         break;
+    case DRIVE_DEL:
+        process_drive_del_msg(msg);
+        break;
     case PROXY_PING:
         wait = msg->fds[0];
         notify_proxy(wait, (uint32_t)getpid());
-- 
1.8.3.1
