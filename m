Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzZ-0005KX-3V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzT-0004g0-Ue
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzT-0004f9-LE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:47 -0300
Message-Id: <20170919201850.14772-10-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] numa: cpu: calculate/set default node-ids
 after all -numa CLI options are parsed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Calculating default node-ids for CPUs in possible_cpu_arch_ids()
is rather fragile since defaults calculation uses nb_numa_nodes but
callback might be potentially called early before all -numa CLI
options are parsed, which would lead to cpus assigned only upto
nb_numa_nodes at the time possible_cpu_arch_ids() is called.

Issue was introduced by
(7c88e65 numa: mirror cpu to node mapping in MachineState::possible_cpus)
and for example CLI:
  -smp 4 -numa node,cpus=0 -numa node
would set props.node-id in possible_cpus array for every non
explicitly mapped CPU to the first node.

Issue is not visible to guest nor to mgmt interface due to
  1) implictly mapped cpus are forced to the first node in
     case of partial mapping
  2) in case of default mapping possible_cpu_arch_ids() is
     called after all -numa options are parsed (resulting
     in correct mapping).

However it's fragile to rely on late execution of
possible_cpu_arch_ids(), therefore add machine specific
callback that returns node-id for CPU and use it to calculate/
set defaults at machine_numa_finish_init() time when all -numa
options are parsed.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1496314408-163972-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  4 ++++
 hw/arm/virt.c       | 14 ++++++--------
 hw/core/machine.c   |  1 +
 hw/i386/pc.c        | 20 +++++++++++---------
 hw/ppc/spapr.c      | 15 ++++++---------
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6b67adaef6..156e0a5701 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -123,6 +123,9 @@ typedef struct {
  *    Returns an array of @CPUArchId architecture-dependent CPU IDs
  *    which includes CPU IDs for present and possible to hotplug CPUs.
  *    Caller is responsible for freeing returned list.
+ * @get_default_cpu_node_id:
+ *    returns default board specific node_id value for CPU slot specified by
+ *    index @idx in @ms->possible_cpus[]
  * @has_hotpluggable_cpus:
  *    If true, board supports CPUs creation with -device/device_add.
  * @default_cpu_type:
@@ -196,6 +199,7 @@ struct MachineClass {
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
+    int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
 };
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 65d68bc50d..9e18b410d7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1554,6 +1554,11 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
     return possible_cpus->cpus[cpu_index].props;
 }
 
+static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx % nb_numa_nodes;
+}
+
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
@@ -1572,14 +1577,6 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
             virt_cpu_mp_affinity(vms, n);
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
         ms->possible_cpus->cpus[n].props.thread_id = n;
-
-        /* default distribution of CPUs over NUMA nodes */
-        if (nb_numa_nodes) {
-            /* preset values but do not enable them i.e. 'has_node_id = false',
-             * numa init code will enable them later if manual mapping wasn't
-             * present on CLI */
-            ms->possible_cpus->cpus[n].props.node_id = n % nb_numa_nodes;
-        }
     }
     return ms->possible_cpus;
 }
@@ -1603,6 +1600,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 41b53a17ad..80647edc2a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -724,6 +724,7 @@ static void machine_numa_finish_init(MachineState *machine)
             /* fetch default mapping from board and enable it */
             CpuInstanceProperties props = cpu_slot->props;
 
+            props.node_id = mc->get_default_cpu_node_id(machine, i);
             if (!default_mapping) {
                 /* record slots with not set mapping,
                  * TODO: make it hard error in future */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2247ac0a01..610c65aeab 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2234,6 +2234,16 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
     return possible_cpus->cpus[cpu_index].props;
 }
 
+static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+   X86CPUTopoInfo topo;
+
+   assert(idx < ms->possible_cpus->len);
+   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                            smp_cores, smp_threads, &topo);
+   return topo.pkg_id % nb_numa_nodes;
+}
+
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
@@ -2263,15 +2273,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
         ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
-
-        /* default distribution of CPUs over NUMA nodes */
-        if (nb_numa_nodes) {
-            /* preset values but do not enable them i.e. 'has_node_id = false',
-             * numa init code will enable them later if manual mapping wasn't
-             * present on CLI */
-            ms->possible_cpus->cpus[i].props.node_id =
-                topo.pkg_id % nb_numa_nodes;
-        }
     }
     return ms->possible_cpus;
 }
@@ -2316,6 +2317,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->linuxboot_dma_enabled = true;
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
+    mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f680f28a15..17ea77618c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3404,6 +3404,11 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
     return core_slot->props;
 }
 
+static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx / smp_cores % nb_numa_nodes;
+}
+
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 {
     int i;
@@ -3428,15 +3433,6 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
         machine->possible_cpus->cpus[i].arch_id = core_id;
         machine->possible_cpus->cpus[i].props.has_core_id = true;
         machine->possible_cpus->cpus[i].props.core_id = core_id;
-
-        /* default distribution of CPUs over NUMA nodes */
-        if (nb_numa_nodes) {
-            /* preset values but do not enable them i.e. 'has_node_id = false',
-             * numa init code will enable them later if manual mapping wasn't
-             * present on CLI */
-            machine->possible_cpus->cpus[i].props.node_id =
-                core_id / smp_threads / smp_cores % nb_numa_nodes;
-        }
     }
     return machine->possible_cpus;
 }
@@ -3587,6 +3583,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
     mc->cpu_index_to_instance_props = spapr_cpu_index_to_props;
+    mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
-- 
2.13.5
