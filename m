Received: from eggs.gnu.org ([2001:4830:134:3::10]:32803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFjwU-0005z4-74
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFjwT-00058k-As
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:24:22 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 30 May 2017 18:23:59 +0200
Message-Id: <1496161442-96665-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] numa: make hmp 'info numa' fetch numa
 nodes from qmp_query_cpus() result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

HMP command 'info numa' is the last external user that access
CPUState::numa_node field directly. In order to move it to CPU
classes that actually use it, eliminate direct access and use
an alternative approach by using result of qmp_query_cpus(),
which provides topology properties CPU threads are associated
with (including node-id).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 monitor.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index baa73c9..9d91631 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1696,23 +1696,26 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
 {
     int i;
-    CPUState *cpu;
     uint64_t *node_mem;
+    CpuInfoList *cpu_list, *cpu;
 
+    cpu_list = qmp_query_cpus(&error_abort);
     node_mem = g_new0(uint64_t, nb_numa_nodes);
     query_numa_node_mem(node_mem);
     monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
     for (i = 0; i < nb_numa_nodes; i++) {
         monitor_printf(mon, "node %d cpus:", i);
-        CPU_FOREACH(cpu) {
-            if (cpu->numa_node == i) {
-                monitor_printf(mon, " %d", cpu->cpu_index);
+        for (cpu = cpu_list; cpu; cpu = cpu->next) {
+            if (cpu->value->has_props && cpu->value->props->has_node_id &&
+                cpu->value->props->node_id == i) {
+                monitor_printf(mon, " %" PRIi64, cpu->value->CPU);
             }
         }
         monitor_printf(mon, "\n");
         monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
                        node_mem[i] >> 20);
     }
+    qapi_free_CpuInfoList(cpu_list);
     g_free(node_mem);
 }
 
-- 
2.7.4
