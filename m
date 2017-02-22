Received: from eggs.gnu.org ([2001:4830:134:3::10]:38465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cgaeG-0000f1-Tn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cgaeD-0003lU-Py
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:24:16 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Feb 2017 18:24:08 +0100
Message-Id: <1487784248-112130-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC] spapr: ensure that all threads within core are
 on the same NUMA node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, mdroth@linux.vnet.ibm.com, agraf@suse.de

Threads within a core probably shouldn't be on different
NUMA nodes, so if user has misconfured command line make
fail to start and let user fix it.
For now use the first thread on the core as source
of core's node-id.

I'm suggesting this to make sure that it would be possible
later map legacy cpu-index based CLI to core-id based
internal map in possible_cpus array and completly eleminate
numa_info[XXX].node_cpu bitmaps, leaving only possible_cpus
as storage of mapping information.

CCing SPAPR mantainers for oppinion if enforcement
makas sense from plaform poin of view and if we could go
ahead with this or I should look for another way
to deal with legacy -numa CLI.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
CC: qemu-ppc@nongnu.org
CC: lvivier@redhat.com
CC: David Gibson <david@gibson.dropbear.id.au>
CC: thuth@redhat.com
CC: mdroth@linux.vnet.ibm.com
CC: agraf@suse.de
---
 hw/ppc/spapr_cpu_core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 55cd045..1499a8b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -50,8 +50,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
                            Error **errp)
 {
     CPUPPCState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-    int i;
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
@@ -70,12 +68,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
         }
     }
 
-    /* Set NUMA node for the added CPUs  */
-    i = numa_get_node_for_cpu(cs->cpu_index);
-    if (i < nb_numa_nodes) {
-            cs->numa_node = i;
-    }
-
     xics_cpu_setup(spapr->xics, cpu);
 
     qemu_register_reset(spapr_cpu_reset, cpu);
@@ -159,11 +151,13 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
 
@@ -172,6 +166,19 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
2.7.4
