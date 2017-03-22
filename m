Received: from eggs.gnu.org ([2001:4830:134:3::10]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgP0-00083s-T7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgP0-00022O-0q
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:14 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:36 +0100
Message-Id: <1490189568-167621-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 11/23] numa: do default mapping based
 on possible_cpus instead of node_cpu bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/numa.c b/numa.c
index 44057f1..ab41776 100644
--- a/numa.c
+++ b/numa.c
@@ -309,6 +309,7 @@ static void validate_numa_cpus(void)
 void parse_numa_opts(MachineState *ms)
 {
     int i;
+    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     for (i = 0; i < MAX_NODES; i++) {
@@ -379,11 +380,6 @@ void parse_numa_opts(MachineState *ms)
 
         numa_set_mem_ranges();
 
-        for (i = 0; i < nb_numa_nodes; i++) {
-            if (!bitmap_empty(numa_info[i].node_cpu, max_cpus)) {
-                break;
-            }
-        }
         /* Historically VCPUs were assigned in round-robin order to NUMA
          * nodes. However it causes issues with guest not handling it nice
          * in case where cores/threads from a multicore CPU appear on
@@ -391,11 +387,20 @@ void parse_numa_opts(MachineState *ms)
          * rule grouping VCPUs by socket so that VCPUs from the same socket
          * would be on the same node.
          */
-        if (!mc->cpu_index_to_instance_props) {
+        if (!mc->cpu_index_to_instance_props || !mc->possible_cpu_arch_ids) {
             error_report("default CPUs to NUMA node mapping isn't supported");
             exit(1);
         }
-        if (i == nb_numa_nodes) {
+
+        possible_cpus = mc->possible_cpu_arch_ids(ms);
+        for (i = 0; i < possible_cpus->len; i++) {
+            if (possible_cpus->cpus[i].props.has_node_id) {
+                break;
+            }
+        }
+
+        /* no CPUs are assigned to NUMA nodes */
+        if (i == possible_cpus->len) {
             for (i = 0; i < max_cpus; i++) {
                 CpuInstanceProperties props;
                 /* fetch default mapping from board and enable it */
-- 
2.7.4
