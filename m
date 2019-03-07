Received: from eggs.gnu.org ([209.51.188.92]:60193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMd-0002nQ-W0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMa-0005lF-WF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMa-0005kB-Ji
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:44 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:39 -0800
Message-Id: <20190307072239.9594-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 30/37] multi-process: add
 processing of rdrive and rdevice command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, pbonzini@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add processing of command line options rdrive and rdevice.
After remote devices are created along with their proxies,
signal the proxies to finish the configuration steps.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

 Please enter the commit message for your changes. Lines starting
---
 vl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/vl.c b/vl.c
index 4c5cc0d..f6bd66e 100644
--- a/vl.c
+++ b/vl.c
@@ -30,6 +30,11 @@
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
 #include "sysemu/seccomp.h"
+#include "qapi/qmp/qdict.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
@@ -1165,6 +1170,21 @@ static int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return drive_new(opts, *block_default_type, errp) == NULL;
 }
 
+#if defined(CONFIG_MPQEMU)
+static int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_remote_add(opts, false /* this is drive */, errp);
+    if (!dev) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "qdev_remote_add failed for drive.\n");
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
+#endif
+
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get(opts, "snapshot") == NULL) {
@@ -2298,6 +2318,21 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+#if defined(CONFIG_MPQEMU)
+static int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_remote_add(opts, true /* this is device */, errp);
+    if (!dev) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "qdev_remote_add failed for device.\n");
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
+#endif
+
 static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -2984,6 +3019,7 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char *dir, **dirs;
+
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -3036,6 +3072,11 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+#if defined(CONFIG_MPQEMU)
+    qemu_add_opts(&qemu_rdrive_opts);
+    qemu_add_opts(&qemu_rdevice_opts);
+#endif
+
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
@@ -3633,6 +3674,22 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+
+#if defined(CONFIG_MPQEMU)
+            case QEMU_OPTION_rdevice:
+                if (!qemu_opts_parse_noisily(qemu_find_opts("rdevice"),
+                                             optarg, true)) {
+                    exit(1);
+                }
+
+                break;
+            case QEMU_OPTION_rdrive:
+                if (!qemu_opts_parse_noisily(qemu_find_opts("rdrive"),
+                                             optarg, false)) {
+                    exit(1);
+                }
+                break;
+#endif
             case QEMU_OPTION_smp:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("smp-opts"),
                                              optarg, true)) {
@@ -4387,6 +4444,7 @@ int main(int argc, char **argv, char **envp)
         qapi_free_BlockdevOptions(bdo->bdo);
         g_free(bdo);
     }
+
     if (snapshot || replay_mode != REPLAY_MODE_NONE) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
@@ -4478,6 +4536,21 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
 
+#if defined(CONFIG_MPQEMU)
+    if (qemu_opts_foreach(qemu_find_opts("rdrive"), rdrive_init_func,
+                          NULL, &err)) {
+        qemu_log_mask(LOG_REMOTE_DEBUG,
+                      "Failed to execute rdrive_init_func\n.");
+    }
+
+    if (qemu_opts_foreach(qemu_find_opts("rdevice"),
+
+                          rdevice_init_func, NULL, &err)) {
+        qemu_log_mask(LOG_REMOTE_DEBUG,
+                      "Failed to execute rdevice_init_func\n.");
+    }
+#endif
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
@@ -4530,10 +4603,13 @@ int main(int argc, char **argv, char **envp)
     qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
 
+#if defined(CONFIG_MPQEMU)
+    qdev_proxy_fire();
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);
     }
+#endif
 
     replay_start();
 
-- 
1.8.3.1
