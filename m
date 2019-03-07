Received: from eggs.gnu.org ([209.51.188.92]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMk-0002u2-Ig
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMj-00061o-5g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMi-0005qk-0D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:52 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:46 -0800
Message-Id: <20190307072246.9733-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 33/37] multi-process: HMP
 command to add drive to the remote device
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

Add rdrive_add HMP command to hot-plug drive to the remote device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands.hx         | 16 ++++++++++++++++
 hw/proxy/monitor.c      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |  2 ++
 include/sysemu/sysemu.h |  1 +
 remote/machine.c        |  8 ++++++++
 remote/remote-main.c    | 31 +++++++++++++++++++++++++++++++
 6 files changed, 103 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f121b4..3829203 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1401,6 +1401,22 @@ STEXI
 Add drive to PCI storage controller.
 ETEXI
 
+#if defined(CONFIG_MPQEMU)
+    {
+        .name       = "rdrive_add",
+        .args_type  = "rdev_id:s,id:s,opts:s",
+        .params     = "rdev_id opts",
+        .help       = "add drive to remote PCI storage controller",
+        .cmd        = hmp_rdrive_add,
+    },
+
+STEXI
+@item rdrive_add
+@findex rdrive_add
+Add drive to remote PCI storage controller.
+ETEXI
+#endif
+
     {
         .name       = "pcie_aer_inject_error",
         .args_type  = "advisory_non_fatal:-a,correctable:-c,"
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index 05c8f8b..ead1e3d 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -41,6 +41,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
 #include "io/proxy-link.h"
+#include "sysemu/sysemu.h"
 
 /*
  * TODO: Is there a callback where the allocated memory for QMP could be free'd
@@ -201,3 +202,47 @@ void hmp_rdevice_del(Monitor *mon, const QDict *qdict)
     }
 }
 
+void hmp_rdrive_add(Monitor *mon, const QDict *qdict)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    Error *local_err = NULL;
+    ProcMsg msg = {0};
+    PCIProxyDev *pdev = NULL;
+    const char *id, *opts;
+    char *data;
+    int wait;
+
+    pdev = get_proxy_device((QDict *)qdict, &local_err);
+    if (local_err) {
+        monitor_printf(mon, "rdrive_add error: %s\n",
+                       error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    id = qdict_get_str(qdict, "id");
+
+    opts = qdict_get_str(qdict, "opts");
+
+    data = g_strdup_printf("%s,id=%s", opts, id);
+
+    wait = GET_REMOTE_WAIT;
+
+    msg.cmd = DRIVE_ADD;
+    msg.bytestream = 1;
+    msg.size = strlen(data);
+    msg.data2 = (uint8_t *)data;
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+    (void)wait_for_remote(wait);
+    PUT_REMOTE_WAIT(wait);
+
+    /* TODO: Only on success */
+    (void)g_hash_table_insert(pcms->remote_devs, (gpointer)g_strdup(id),
+                              (gpointer)pdev);
+
+    g_free(data);
+}
+
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index af451e8..3ef16f1 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -62,6 +62,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  *                  from remote device
  * DEVICE_ADD       QMP/HMP command to hotplug device
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
+ * DRIVE_ADD        HMP command to hotplug drive
  *
  */
 typedef enum {
@@ -76,6 +77,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    DRIVE_ADD,
     PROXY_PING,
     MAX,
 } proc_cmd_t;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 82622be..0c51fe0 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -138,6 +138,7 @@ extern unsigned int nb_prom_envs;
 
 /* generic hotplug */
 void hmp_drive_add(Monitor *mon, const QDict *qdict);
+void hmp_rdrive_add(Monitor *mon, const QDict *qdict);
 
 /* pcie aer error injection */
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
diff --git a/remote/machine.c b/remote/machine.c
index c1c7b77..c6801ca 100644
--- a/remote/machine.c
+++ b/remote/machine.c
@@ -74,6 +74,8 @@ static void remote_machine_init(Object *obj)
     MemoryRegion *system_memory, *system_io, *pci_memory;
     PCIHostState *pci_host;
     PCIDevice *pci_dev;
+    MachineState *ms;
+    MachineClass *mc;
 
     Error *error_abort = NULL;
 
@@ -116,6 +118,12 @@ static void remote_machine_init(Object *obj)
 
     pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_irq,
                  s->iohub, REMOTE_IOHUB_NB_PIRQS);
+
+    ms = MACHINE(s);
+
+    mc = MACHINE_GET_CLASS(ms);
+
+    mc->block_default_type = IF_IDE;
 }
 
 static const TypeInfo remote_machine = {
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 1e45105..4c52d30 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -234,6 +234,29 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_drive_add_msg(ProcMsg *msg)
+{
+    Error *local_err = NULL;
+    const char *optstr = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QemuOpts *opts;
+    MachineClass *mc;
+
+    opts = drive_def(optstr);
+    assert(opts);
+
+    mc = MACHINE_GET_CLASS(current_machine);
+    (void)drive_new(opts, mc->block_default_type, &local_err);
+
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
@@ -419,6 +442,9 @@ static void process_msg(GIOCondition cond)
     case DEVICE_DEL:
         process_device_del_msg(msg);
         break;
+    case DRIVE_ADD:
+        process_drive_add_msg(msg);
+        break;
     case PROXY_PING:
         wait = msg->fds[0];
         notify_proxy(wait, (uint32_t)getpid());
@@ -462,6 +488,11 @@ int main(int argc, char *argv[])
     bdrv_init_with_whitelist();
 
     qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&qemu_legacy_drive_opts);
+    qemu_add_drive_opts(&qemu_common_drive_opts);
+    qemu_add_drive_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&bdrv_runtime_opts);
 
     if (qemu_init_main_loop(&err)) {
         error_report_err(err);
-- 
1.8.3.1
