Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C8-PK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UR-6i
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006SY-39
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNiX9l146857
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp2120.oracle.com with ESMTP id 2mxn0qnjq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmlJn018531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmlgv023388
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:33 -0400
Message-Id: <11dd17274b257d93b2ccf94ce5d0c64081556920.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 6/8] multi-process QEMU: remote process
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

Initialize remote process main loop and add the message
handling logic. Handle SYNC_SYSMEM message by updating
its "system_memory" container using shared file descriptors
received from QEMU.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/scsi/qemu-scsi-dev.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/hw/scsi/qemu-scsi-dev.c b/hw/scsi/qemu-scsi-dev.c
index 21aba91..ede0c4b 100644
--- a/hw/scsi/qemu-scsi-dev.c
+++ b/hw/scsi/qemu-scsi-dev.c
@@ -23,22 +23,93 @@
  */
 
 #include <stdio.h>
+#include <glib.h>
+#include <unistd.h>
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "remote/pcihost.h"
 #include "remote/machine.h"
 #include "hw/boards.h"
+#include "remote/memory.h"
+#include "io/proxy-link.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu-common.h"
 
 static RemMachineState *machine;
+static ProxyLinkState *proxy_link;
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
+    if (proxy_proc_recv(proxy_link, msg)) {
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
 
 int main(int argc, char *argv[])
 {
+    Error *err = NULL;
+
     module_call_init(MODULE_INIT_QOM);
 
     machine = REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE));
 
     current_machine = MACHINE(machine);
 
+    if (qemu_init_main_loop(&err)) {
+        error_report_err(err);
+        return -EBUSY;
+    }
+
+    qemu_init_cpu_loop();
+
+    page_size_init();
+
+    proxy_link = proxy_link_create();
+    if (!proxy_link) {
+        printf("Could not create proxy link\n");
+        return -1;
+    }
+
+    proxy_link_set_sock(proxy_link, STDIN_FILENO);
+    proxy_link_set_callback(proxy_link, process_msg);
+
+    start_handler(proxy_link);
+
     return 0;
 }
-- 
1.8.3.1
