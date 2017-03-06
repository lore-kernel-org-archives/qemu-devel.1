Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwn-00058t-MM
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwk-0003t3-FT
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Mar 2017 15:08:20 +1100
Message-Id: <20170306040823.28482-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170306040823.28482-1-david@gibson.dropbear.id.au>
References: <20170306040823.28482-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/5] spapr: ensure that all threads within core
 are on the same NUMA node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Threads within a core shouldn't be on different
NUMA nodes, so if user has misconfgured command
line, fail QEMU at start up to force user fix it.

For now use the first thread on the core as source
of core's node-id. Later when cpu-numa refactoring
lands  it will be switched to core's node-id from
possible_cpus[].

This prevents the same problems as commit 20bb648d
"spapr: Fix default NUMA node allocation for threads",
but for the case of manually configured NUMA node
mappings, instead of just the default case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d37832d..6883f09 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -63,8 +63,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
                            Error **errp)
 {
     CPUPPCState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-    int i;
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
@@ -82,12 +80,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
         }
     }
 
-    /* Set NUMA node for the added CPUs  */
-    i = numa_get_node_for_cpu(cs->cpu_index);
-    if (i < nb_numa_nodes) {
-            cs->numa_node = i;
-    }
-
     xics_cpu_setup(XICS_FABRIC(spapr), cpu);
 
     qemu_register_reset(spapr_cpu_reset, cpu);
@@ -171,11 +163,13 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     const char *typename = object_class_get_name(scc->cpu_class);
     size_t size = object_type_get_instance_size(typename);
     Error *local_err = NULL;
+    int core_node_id = numa_get_node_for_cpu(cc->core_id);;
     void *obj;
     int i, j;
 
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
+        int node_id;
         char id[32];
         CPUState *cs;
 
@@ -184,6 +178,19 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         object_initialize(obj, size, typename);
         cs = CPU(obj);
         cs->cpu_index = cc->core_id + i;
+
+        /* Set NUMA node for the added CPUs  */
+        node_id = numa_get_node_for_cpu(cs->cpu_index);
+        if (node_id != core_node_id) {
+            error_setg(&local_err, "Invalid node-id=%d of thread[cpu-index: %d]"
+                " on CPU[core-id: %d, node-id: %d], node-id must be the same",
+                 node_id, cs->cpu_index, cc->core_id, core_node_id);
+            goto err;
+        }
+        if (node_id < nb_numa_nodes) {
+            cs->numa_node = node_id;
+        }
+
         snprintf(id, sizeof(id), "thread[%d]", i);
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
         if (local_err) {
-- 
2.9.3
