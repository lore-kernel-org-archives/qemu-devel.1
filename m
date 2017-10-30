Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbK-0007tP-EQ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbJ-0006IB-Fs
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9GbJ-0006Hs-7Q
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:01 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 30 Oct 2017 20:23:56 +0000
Message-Id: <20171030202356.11047-3-dgilbert@redhat.com>
In-Reply-To: <20171030202356.11047-1-dgilbert@redhat.com>
References: <20171030202356.11047-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] monitor: fix dangling CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org, lu.zhipeng@zte.com.cn

From: Greg Kurz <groug@kaod.org>

If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
causes QEMU to exit:

(qemu) device_del cpu1
(qemu) info cpus
qemu:qemu_cpu_kick_thread: No such process

This happens because "cpu" stores the pointer to the selected CPU into
the monitor structure. When the CPU is hot-unplugged, we end up with a
dangling pointer. The "info cpus" command then does:

hmp_info_cpus()
 monitor_get_cpu_index()
  mon_get_cpu()
   cpu_synchronize_state() <--- called with dangling pointer

This could cause a QEMU crash as well.

This patch switches the monitor to store the QOM path instead of a
pointer to the current CPU. The path is then resolved when needed.
If the resolution fails, we assume that the CPU was removed and the
path is resetted to the default (ie, path of first_cpu).

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <150822818243.26242.12993827911736928961.stgit@bahia.lan>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7a802a345e..e36fb5308d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -200,7 +200,7 @@ struct Monitor {
 
     ReadLineState *rs;
     MonitorQMP qmp;
-    CPUState *mon_cpu;
+    gchar *mon_cpu_path;
     BlockCompletionFunc *password_completion_cb;
     void *password_opaque;
     mon_cmd_t *cmd_table;
@@ -579,6 +579,7 @@ static void monitor_data_init(Monitor *mon)
 
 static void monitor_data_destroy(Monitor *mon)
 {
+    g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         json_message_parser_destroy(&mon->qmp.parser);
@@ -1047,20 +1048,32 @@ int monitor_set_cpu(int cpu_index)
     if (cpu == NULL) {
         return -1;
     }
-    cur_mon->mon_cpu = cpu;
+    g_free(cur_mon->mon_cpu_path);
+    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
 CPUState *mon_get_cpu(void)
 {
-    if (!cur_mon->mon_cpu) {
+    CPUState *cpu;
+
+    if (cur_mon->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
+                                                    TYPE_CPU, NULL);
+        if (!cpu) {
+            g_free(cur_mon->mon_cpu_path);
+            cur_mon->mon_cpu_path = NULL;
+        }
+    }
+    if (!cur_mon->mon_cpu_path) {
         if (!first_cpu) {
             return NULL;
         }
         monitor_set_cpu(first_cpu->cpu_index);
+        cpu = first_cpu;
     }
-    cpu_synchronize_state(cur_mon->mon_cpu);
-    return cur_mon->mon_cpu;
+    cpu_synchronize_state(cpu);
+    return cpu;
 }
 
 CPUArchState *mon_get_cpu_env(void)
-- 
2.14.3
