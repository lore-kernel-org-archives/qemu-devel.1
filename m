Received: from eggs.gnu.org ([209.51.188.92]:59993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMM-0002Zy-9p
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMI-0005af-DK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMH-0005ZH-4F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:25 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:12 -0800
Message-Id: <20190307072212.9058-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 20/37] multi-process: Add QMP
 & HMP commands to list remote processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Add query-remote QMP command and remote-proc-list HMP command, to list
the remote processes spawned by QEMU.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands.hx        | 16 +++++++++
 hmp.h                  |  1 +
 hw/proxy/Makefile.objs |  1 +
 hw/proxy/monitor.c     | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json   | 29 ++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100644 hw/proxy/monitor.c

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 9b40359..fb3c8ba 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -725,6 +725,22 @@ STEXI
 Add device.
 ETEXI
 
+#if defined(CONFIG_MPQEMU)
+    {
+        .name       = "remote_proc_list",
+        .args_type  = "",
+        .params     = "",
+        .help       = "list remote devices and their linux process IDs",
+        .cmd        = hmp_remote_proc_list,
+    },
+
+STEXI
+@item remote_proc_list
+@findex remote_proc_list
+List remote devices and their linux process IDs.
+ETEXI
+#endif
+
     {
         .name       = "device_del",
         .args_type  = "id:s",
diff --git a/hmp.h b/hmp.h
index e0f32f0..0940634 100644
--- a/hmp.h
+++ b/hmp.h
@@ -149,5 +149,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_remote_proc_list(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index f562f5a..e642060 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
 common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
+common-obj-$(CONFIG_MPQEMU) += monitor.o
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
new file mode 100644
index 0000000..3005eec
--- /dev/null
+++ b/hw/proxy/monitor.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU monitor command handler for multi-process QEMU
+ *
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-types-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "monitor/monitor.h"
+#include "qemu/option.h"
+#include "hmp.h"
+#include "hw/boards.h"
+#include "hw/i386/pc.h"
+#include "hw/proxy/qemu-proxy.h"
+
+/*
+ * TODO: Is there a callback where the allocated memory for QMP could be free'd
+ */
+RemoteProcList *qmp_query_remote(Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    RemoteProcList *proclist, *proc;
+    GHashTableIter itr;
+    PCIProxyDev *pdev;
+    PCIProxyDevClass *k;
+    DeviceState *d;
+    char *id;
+
+    proclist = NULL;
+
+    g_hash_table_iter_init(&itr, pcms->remote_devs);
+
+    while (g_hash_table_iter_next(&itr, (gpointer *)&id, (gpointer *)&pdev)) {
+        k = PCI_PROXY_DEV_GET_CLASS(pdev);
+        d = DEVICE(pdev);
+
+        proc = g_malloc0(sizeof(RemoteProcList));
+        proc->next = proclist;
+        proclist = proc;
+        proc->value = g_malloc0(sizeof(RemoteProc));
+        proc->value->pid = pdev->remote_pid;
+        proc->value->id = g_strdup(d->id);
+        proc->value->proc = g_strdup(k->command);
+    }
+
+    return proclist;
+}
+
+void hmp_remote_proc_list(Monitor *mon, const QDict *qdict)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    GHashTableIter itr;
+    PCIProxyDev *pdev;
+    PCIProxyDevClass *k;
+    char *id;
+
+    g_hash_table_iter_init(&itr, pcms->remote_devs);
+
+    monitor_printf(mon, "%8.8s\t%16.16s\t%16.16s\t%16.16s\n\n", "PID", "RID",
+                   "QEMU ID", "PROCESS NAME");
+
+    while (g_hash_table_iter_next(&itr, (gpointer *)&id, (gpointer *)&pdev)) {
+        k = PCI_PROXY_DEV_GET_CLASS(pdev);
+
+        monitor_printf(mon, "%8.8d\t%16.16s\t%16.16s\t%16.16s\n",
+                       pdev->remote_pid, pdev->rid, id, k->command);
+    }
+}
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b8afbb..05394c4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -647,6 +647,23 @@
            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
 ##
+# @RemoteProc:
+#
+# Remote process information.
+#
+# @id: Device ID
+#
+# @pid: Linux Process ID
+#
+# @proc: Process name
+#
+# Since:  3.0.93
+##
+{ 'struct': 'RemoteProc',
+  'data': {'id': 'str', 'pid': 'int32', 'proc': 'str' },
+  'if': 'defined(CONFIG_MPQEMU)' }
+
+##
 # @BlockMeasureInfo:
 #
 # Image file size calculation information.  This structure describes the size
@@ -768,6 +785,18 @@
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'] }
 
+##
+# @query-remote:
+#
+# Get a list of all the remote processes spawned by QEMU.
+#
+# Returns: a list of @RemoteProc describing each remote process.
+#
+# Since: 3.0.93
+#
+##
+{ 'command': 'query-remote', 'returns': ['RemoteProc'],
+  'if': 'defined(CONFIG_MPQEMU)' }
 
 ##
 # @BlockDeviceTimedStats:
-- 
1.8.3.1
