Received: from eggs.gnu.org ([209.51.188.92]:59685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLb-0001x9-ME
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLa-0004wx-T4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLa-0004wh-KQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:42 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:32 -0800
Message-Id: <20190307072132.8630-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 12/37] multi-process: remote
 process initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Jagannathan Raman <jag.raman@oracle.com>

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 remote/remote-main.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index d5304fb..b15e299 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -23,6 +23,8 @@
  */
 
 #include <stdio.h>
+#include <glib.h>
+#include <unistd.h>
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
@@ -31,12 +33,108 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/proxy-link.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "qemu/thread.h"
+#include "qemu/main-loop.h"
+#include "qemu/config-file.h"
+#include "sysemu/sysemu.h"
+#include "block/block.h"
+
+static ProxyLinkState *proxy_link;
+PCIDevice *remote_pci_dev;
+
+static void process_msg(GIOCondition cond)
+{
+    ProcMsg *msg = NULL;
+    Error *err = NULL;
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        error_setg(&err, "socket closed, cond is %d", cond);
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(ProcMsg));
+
+    if (proxy_proc_recv(proxy_link, msg) < 0) {
+        error_setg(&err, "Failed to receive message");
+        goto finalize_loop;
+    }
+
+    switch (msg->cmd) {
+    case INIT:
+        break;
+    case CONF_WRITE:
+        break;
+    case CONF_READ:
+        break;
+    default:
+        error_setg(&err, "Unknown command");
+        goto finalize_loop;
+    }
+
+    g_free(msg);
+
+    return;
+
+finalize_loop:
+    error_report_err(err);
+    g_free(msg);
+    proxy_link_finalize(proxy_link);
+    proxy_link = NULL;
+}
+
+static void *remote_main_loop(void *data)
+{
+    while (1) {
+        qemu_mutex_lock_iothread();
+        main_loop_wait(false);
+        qemu_mutex_unlock_iothread();
+    }
+
+    return NULL;
+}
 
 int main(int argc, char *argv[])
 {
+    Error *err = NULL;
+    QemuThread main_loop_thread;
+
     module_call_init(MODULE_INIT_QOM);
 
+    bdrv_init_with_whitelist();
+
+    if (qemu_init_main_loop(&err)) {
+        error_report_err(err);
+        return -EBUSY;
+    }
+
+    qemu_init_cpu_loop();
+
+    page_size_init();
+
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    proxy_link = proxy_link_create();
+    if (!proxy_link) {
+        printf("Could not create proxy link\n");
+        return -1;
+    }
+
+    proxy_link_set_sock(proxy_link, STDIN_FILENO);
+    proxy_link_set_callback(proxy_link, process_msg);
+
+    qemu_thread_create(&main_loop_thread, "remote-main-loop", remote_main_loop,
+                       NULL, QEMU_THREAD_DETACHED);
+
+    start_handler(proxy_link);
+
+    qemu_thread_cancel(&main_loop_thread);
+
     return 0;
 }
-- 
1.8.3.1
