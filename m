Received: from eggs.gnu.org ([2001:4830:134:3::10]:38310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVH-0003GA-Hr
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVD-0008Ff-3J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:43 +1100
Message-Id: <20170222063348.32176-39-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 38/43] machine: unify
 [pc_|spapr_]query_hotpluggable_cpus() callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

All callbacks FOO_query_hotpluggable_cpus() are practically
the same except of setting vcpus_count to different values.
Convert them to a generic machine_query_hotpluggable_cpus()
callback by moving vcpus_count initialization to per machine
specific callback possible_cpu_arch_ids().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/core/machine.c   | 31 +++++++++++++++++++++++++++++++
 hw/i386/pc.c        | 36 ++----------------------------------
 hw/ppc/spapr.c      | 34 ++--------------------------------
 include/hw/boards.h |  3 +++
 4 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b0fd91f..0699750 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -357,6 +357,37 @@ static void machine_init_notify(Notifier *notifier, void *data)
     foreach_dynamic_sysbus_device(error_on_sysbus_device, NULL);
 }
 
+HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
+{
+    int i;
+    Object *cpu;
+    HotpluggableCPUList *head = NULL;
+    const char *cpu_type;
+
+    cpu = machine->possible_cpus->cpus[0].cpu;
+    assert(cpu); /* Boot cpu is always present */
+    cpu_type = object_get_typename(cpu);
+    for (i = 0; i < machine->possible_cpus->len; i++) {
+        HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
+        HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
+
+        cpu_item->type = g_strdup(cpu_type);
+        cpu_item->vcpus_count = machine->possible_cpus->cpus[i].vcpus_count;
+        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
+                                   sizeof(*cpu_item->props));
+
+        cpu = machine->possible_cpus->cpus[i].cpu;
+        if (cpu) {
+            cpu_item->has_qom_path = true;
+            cpu_item->qom_path = object_get_canonical_path(cpu);
+        }
+        list_item->value = cpu_item;
+        list_item->next = head;
+        head = list_item;
+    }
+    return head;
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 138022d..f96cfc6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2272,6 +2272,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoInfo topo;
 
+        ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  smp_cores, smp_threads, &topo);
@@ -2285,39 +2286,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
-{
-    int i;
-    Object *cpu;
-    HotpluggableCPUList *head = NULL;
-    const char *cpu_type;
-
-    cpu = machine->possible_cpus->cpus[0].cpu;
-    assert(cpu); /* BSP is always present */
-    cpu_type = object_get_typename(cpu);
-
-    for (i = 0; i < machine->possible_cpus->len; i++) {
-        HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
-        HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
-
-        cpu_item->type = g_strdup(cpu_type);
-        cpu_item->vcpus_count = 1;
-        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
-                                   sizeof(*cpu_item->props));
-
-        cpu = machine->possible_cpus->cpus[i].cpu;
-        if (cpu) {
-            cpu_item->has_qom_path = true;
-            cpu_item->qom_path = object_get_canonical_path(cpu);
-        }
-
-        list_item->value = cpu_item;
-        list_item->next = head;
-        head = list_item;
-    }
-    return head;
-}
-
 static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     /* cpu index isn't used */
@@ -2358,7 +2326,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_socket_id = pc_cpu_index_to_socket_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
-    mc->query_hotpluggable_cpus = pc_query_hotpluggable_cpus;
+    mc->query_hotpluggable_cpus = machine_query_hotpluggable_cpus;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
     mc->block_default_type = IF_IDE;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a0aa69e..49768eb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2799,6 +2799,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
     for (i = 0; i < machine->possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
+        machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
         machine->possible_cpus->cpus[i].arch_id = core_id;
         machine->possible_cpus->cpus[i].props.has_core_id = true;
         machine->possible_cpus->cpus[i].props.core_id = core_id;
@@ -2808,37 +2809,6 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
     return machine->possible_cpus;
 }
 
-static HotpluggableCPUList *spapr_query_hotpluggable_cpus(MachineState *machine)
-{
-    int i;
-    Object *cpu;
-    HotpluggableCPUList *head = NULL;
-    const char *cpu_type;
-
-    cpu = machine->possible_cpus->cpus[0].cpu;
-    assert(cpu); /* Boot cpu is always present */
-    cpu_type = object_get_typename(cpu);
-    for (i = 0; i < machine->possible_cpus->len; i++) {
-        HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
-        HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
-
-        cpu_item->type = g_strdup(cpu_type);
-        cpu_item->vcpus_count = smp_threads; // TODO: ??? generalize
-        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
-                                   sizeof(*cpu_item->props));
-
-        cpu = machine->possible_cpus->cpus[i].cpu;
-        if (cpu) {
-            cpu_item->has_qom_path = true;
-            cpu_item->qom_path = object_get_canonical_path(cpu);
-        }
-        list_item->value = cpu_item;
-        list_item->next = head;
-        head = list_item;
-    }
-    return head;
-}
-
 static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
                                 uint64_t *buid, hwaddr *pio,
                                 hwaddr *mmio32, hwaddr *mmio64,
@@ -2927,7 +2897,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
-    mc->query_hotpluggable_cpus = spapr_query_hotpluggable_cpus;
+    mc->query_hotpluggable_cpus = machine_query_hotpluggable_cpus;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 60209df..9040dbb 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -41,15 +41,18 @@ int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
 void machine_register_compat_props(MachineState *machine);
+HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 
 /**
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
  * @cpu - pointer to corresponding CPU object if it's present on NULL otherwise
  * @props - CPU object properties, initialized by board
+ * #vcpus_count - number of threads provided by @cpu object
  */
 typedef struct {
     uint64_t arch_id;
+    int64_t vcpus_count;
     CpuInstanceProperties props;
     Object *cpu;
 } CPUArchId;
-- 
2.9.3
