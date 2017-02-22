Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVA-00037Q-JE
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV7-000872-Cf
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:37 +1100
Message-Id: <20170222063348.32176-33-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 32/43] machine: move possible_cpus to
 MachineState
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

so that it would be possible to reuse it with
spapr/virt-aarch64 targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc.c         | 57 ++++++++++++++++++++++++++--------------------------
 include/hw/boards.h  |  1 +
 include/hw/i386/pc.h |  1 -
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 60b0946..04c6e59 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -707,7 +707,8 @@ static void pc_build_smbios(PCMachineState *pcms)
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
-    X86CPU *cpu = X86_CPU(pcms->possible_cpus->cpus[0].cpu);
+    MachineState *ms = MACHINE(pcms);
+    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
@@ -1111,7 +1112,7 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
     ObjectClass *oc;
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    MachineState *ms = MACHINE(qdev_get_machine());
     int64_t apic_id = x86_cpu_apic_id_from_index(id);
     Error *local_err = NULL;
 
@@ -1127,8 +1128,8 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
         return;
     }
 
-    assert(pcms->possible_cpus->cpus[0].cpu); /* BSP is always present */
-    oc = OBJECT_CLASS(CPU_GET_CLASS(pcms->possible_cpus->cpus[0].cpu));
+    assert(ms->possible_cpus->cpus[0].cpu); /* BSP is always present */
+    oc = OBJECT_CLASS(CPU_GET_CLASS(ms->possible_cpus->cpus[0].cpu));
     pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1178,11 +1179,11 @@ void pc_cpus_init(PCMachineState *pcms)
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
-    pcms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                                    sizeof(CPUArchId) * max_cpus);
+    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                       sizeof(CPUArchId) * max_cpus);
     for (i = 0; i < max_cpus; i++) {
-        pcms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
-        pcms->possible_cpus->len++;
+        machine->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        machine->possible_cpus->len++;
         if (i < smp_cpus) {
             pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_fatal);
         }
@@ -1191,7 +1192,8 @@ void pc_cpus_init(PCMachineState *pcms)
 
 static void pc_build_feature_control_file(PCMachineState *pcms)
 {
-    X86CPU *cpu = X86_CPU(pcms->possible_cpus->cpus[0].cpu);
+    MachineState *ms = MACHINE(pcms);
+    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
     CPUX86State *env = &cpu->env;
     uint32_t unused, ecx, edx;
     uint64_t feature_control_bits = 0;
@@ -1787,21 +1789,20 @@ static int pc_apic_cmp(const void *a, const void *b)
 }
 
 /* returns pointer to CPUArchId descriptor that matches CPU's apic_id
- * in pcms->possible_cpus->cpus, if pcms->possible_cpus->cpus has no
+ * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
  * entry corresponding to CPU's apic_id returns NULL.
  */
-static CPUArchId *pc_find_cpu_slot(PCMachineState *pcms, CPUState *cpu,
-                                   int *idx)
+static CPUArchId *pc_find_cpu_slot(MachineState *ms, CPUState *cpu, int *idx)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchId apic_id, *found_cpu;
 
     apic_id.arch_id = cc->get_arch_id(CPU(cpu));
-    found_cpu = bsearch(&apic_id, pcms->possible_cpus->cpus,
-        pcms->possible_cpus->len, sizeof(*pcms->possible_cpus->cpus),
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
         pc_apic_cmp);
     if (found_cpu && idx) {
-        *idx = found_cpu - pcms->possible_cpus->cpus;
+        *idx = found_cpu - ms->possible_cpus->cpus;
     }
     return found_cpu;
 }
@@ -1831,7 +1832,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    found_cpu = pc_find_cpu_slot(pcms, CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
     found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
@@ -1844,7 +1845,7 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    pc_find_cpu_slot(pcms, CPU(dev), &idx);
+    pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
     assert(idx != -1);
     if (idx == 0) {
         error_setg(&local_err, "Boot CPU is unpluggable");
@@ -1878,7 +1879,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    found_cpu = pc_find_cpu_slot(pcms, CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
     found_cpu->cpu = NULL;
     object_unparent(OBJECT(dev));
 
@@ -1936,13 +1937,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
     }
 
-    cpu_slot = pc_find_cpu_slot(pcms, CPU(dev), &idx);
+    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
     if (!cpu_slot) {
+        MachineState *ms = MACHINE(pcms);
+
         x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
         error_setg(errp, "Invalid CPU [socket: %u, core: %u, thread: %u] with"
                   " APIC ID %" PRIu32 ", valid index range 0:%d",
                    topo.pkg_id, topo.core_id, topo.smt_id, cpu->apic_id,
-                   pcms->possible_cpus->len - 1);
+                   ms->possible_cpus->len - 1);
         return;
     }
 
@@ -2253,9 +2256,8 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
 {
-    PCMachineState *pcms = PC_MACHINE(machine);
-    assert(pcms->possible_cpus);
-    return pcms->possible_cpus;
+    assert(machine->possible_cpus);
+    return machine->possible_cpus;
 }
 
 static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
@@ -2263,19 +2265,18 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
     int i;
     CPUState *cpu;
     HotpluggableCPUList *head = NULL;
-    PCMachineState *pcms = PC_MACHINE(machine);
     const char *cpu_type;
 
-    cpu = pcms->possible_cpus->cpus[0].cpu;
+    cpu = machine->possible_cpus->cpus[0].cpu;
     assert(cpu); /* BSP is always present */
     cpu_type = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
 
-    for (i = 0; i < pcms->possible_cpus->len; i++) {
+    for (i = 0; i < machine->possible_cpus->len; i++) {
         X86CPUTopoInfo topo;
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
         CpuInstanceProperties *cpu_props = g_new0(typeof(*cpu_props), 1);
-        const uint32_t apic_id = pcms->possible_cpus->cpus[i].arch_id;
+        const uint32_t apic_id = machine->possible_cpus->cpus[i].arch_id;
 
         x86_topo_ids_from_apicid(apic_id, smp_cores, smp_threads, &topo);
 
@@ -2289,7 +2290,7 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
         cpu_props->thread_id = topo.smt_id;
         cpu_item->props = cpu_props;
 
-        cpu = pcms->possible_cpus->cpus[i].cpu;
+        cpu = machine->possible_cpus->cpus[i].cpu;
         if (cpu) {
             cpu_item->has_qom_path = true;
             cpu_item->qom_path = object_get_canonical_path(OBJECT(cpu));
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ac891a8..64e8c07 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -178,6 +178,7 @@ struct MachineState {
     char *initrd_filename;
     const char *cpu_model;
     AccelState *accelerator;
+    CPUArchIdList *possible_cpus;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 079e8d9..d1f4554 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -73,7 +73,6 @@ struct PCMachineState {
     /* CPU and apic information: */
     bool apic_xrupt_override;
     unsigned apic_id_limit;
-    CPUArchIdList *possible_cpus;
     uint16_t boot_cpus;
 
     /* NUMA information: */
-- 
2.9.3
