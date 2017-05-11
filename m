Received: from eggs.gnu.org ([2001:4830:134:3::10]:37909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcN-0002eW-Lv
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcK-0007sf-OI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcK-0007s9-Ij
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:29 -0300
Message-Id: <20170511191843.13784-16-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] numa: do default mapping based on
 possible_cpus instead of node_cpu bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <1494415802-227633-8-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/numa.c b/numa.c
index 7db5dde873..c89fc2d4a5 100644
--- a/numa.c
+++ b/numa.c
@@ -458,6 +458,7 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
 void parse_numa_opts(MachineState *ms)
 {
     int i;
+    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     for (i = 0; i < MAX_NODES; i++) {
@@ -519,18 +520,21 @@ void parse_numa_opts(MachineState *ms)
 
         numa_set_mem_ranges();
 
-        for (i = 0; i < nb_numa_nodes; i++) {
-            if (!bitmap_empty(numa_info[i].node_cpu, max_cpus)) {
-                break;
-            }
-        }
-
         /* assign CPUs to nodes using board provided default mapping */
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
2.11.0.259.g40922b1
