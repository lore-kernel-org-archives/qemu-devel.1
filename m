Received: from eggs.gnu.org ([2001:4830:134:3::10]:39854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8I7-0007O2-OM
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8I3-00059x-M7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:18:59 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 10 Feb 2017 11:18:49 +0100
Message-Id: <1486721929-180336-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486638518-171446-7-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-7-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/7] spapr: reuse machine->possible_cpus
 instead of cores[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

Replace SPAPR specific cores[] array with generic
machine->possible_cpus and store core objects there.
It makes cores bookkeeping similar to x86 cpus and
will allow to unify similar code.
It would allow to replace cpu_index based NUMA node
mapping with iproperty based one (for -device created
cores) since possible_cpus carries board defined
topology/layout.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
v2:
  - remove extra ';' at the end of expression (David Gibson)

CC: David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
CC: Alexander Graf <agraf@suse.de> (supporter:sPAPR)
CC: qemu-ppc@nongnu.org 
CC: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: ehabkost@redhat.com
CC: drjones@redhat.com
CC: Marcel Apfelbaum <marcel@redhat.com>
---
 include/hw/ppc/spapr.h |   1 -
 hw/ppc/spapr.c         | 129 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a2d8964..f9b17d8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -94,7 +94,6 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
-    Object **cores;
 };
 
 #define H_SUCCESS         0
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 37cb338..a0aa69e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1751,13 +1751,28 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
     }
 }
 
+/* find cpu slot in machine->possible_cpus by core_id */
+static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
+{
+    int index = id / smp_threads;
+
+    if (index >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    if (idx) {
+        *idx = index;
+    }
+    return &ms->possible_cpus->cpus[index];
+}
+
 static void spapr_init_cpus(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     char *type = spapr_get_cpu_core_type(machine->cpu_model);
     int smt = kvmppc_smt_threads();
-    int spapr_max_cores, spapr_cores;
+    const CPUArchIdList *possible_cpus;
+    int boot_cores_nr = smp_cpus / smp_threads;
     int i;
 
     if (!type) {
@@ -1765,6 +1780,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
         exit(1);
     }
 
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
     if (mc->query_hotpluggable_cpus) {
         if (smp_cpus % smp_threads) {
             error_report("smp_cpus (%u) must be multiple of threads (%u)",
@@ -1776,21 +1792,15 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
                          max_cpus, smp_threads);
             exit(1);
         }
-
-        spapr_max_cores = max_cpus / smp_threads;
-        spapr_cores = smp_cpus / smp_threads;
     } else {
         if (max_cpus != smp_cpus) {
             error_report("This machine version does not support CPU hotplug");
             exit(1);
         }
-
-        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
-        spapr_cores = spapr_max_cores;
+        boot_cores_nr = possible_cpus->len;
     }
 
-    spapr->cores = g_new0(Object *, spapr_max_cores);
-    for (i = 0; i < spapr_max_cores; i++) {
+    for (i = 0; i < possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
         if (mc->query_hotpluggable_cpus) {
@@ -1802,7 +1812,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
             qemu_register_reset(spapr_drc_reset, drc);
         }
 
-        if (i < spapr_cores) {
+        if (i < boot_cores_nr) {
             Object *core  = object_new(type);
             int nr_threads = smp_threads;
 
@@ -2491,10 +2501,11 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    MachineState *ms = MACHINE(qdev_get_machine());
     CPUCore *cc = CPU_CORE(dev);
+    CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
-    spapr->cores[cc->core_id / smp_threads] = NULL;
+    core_slot->cpu = NULL;
     object_unparent(OBJECT(dev));
 }
 
@@ -2510,19 +2521,24 @@ static
 void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
-    CPUCore *cc = CPU_CORE(dev);
-    int smt = kvmppc_smt_threads();
-    int index = cc->core_id / smp_threads;
-    sPAPRDRConnector *drc =
-        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
+    int index;
+    sPAPRDRConnector *drc;
     sPAPRDRConnectorClass *drck;
     Error *local_err = NULL;
+    CPUCore *cc = CPU_CORE(dev);
+    int smt = kvmppc_smt_threads();
 
+    if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index)) {
+        error_setg(errp, "Unable to find CPU core with core-id: %d",
+                   cc->core_id);
+        return;
+    }
     if (index == 0) {
         error_setg(errp, "Boot CPU core may not be unplugged");
         return;
     }
 
+    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -2547,11 +2563,17 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Error *local_err = NULL;
     void *fdt = NULL;
     int fdt_offset = 0;
-    int index = cc->core_id / smp_threads;
     int smt = kvmppc_smt_threads();
+    CPUArchId *core_slot;
+    int index;
 
+    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
+    if (!core_slot) {
+        error_setg(errp, "Unable to find CPU core with core-id: %d",
+                   cc->core_id);
+        return;
+    }
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
-    spapr->cores[index] = OBJECT(dev);
 
     g_assert(drc || !mc->query_hotpluggable_cpus);
 
@@ -2568,7 +2590,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
         if (local_err) {
             g_free(fdt);
-            spapr->cores[index] = NULL;
             error_propagate(errp, local_err);
             return;
         }
@@ -2590,6 +2611,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
         }
     }
+    core_slot->cpu = OBJECT(dev);
 }
 
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -2597,13 +2619,12 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
-    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    int spapr_max_cores = max_cpus / smp_threads;
-    int index;
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
     const char *type = object_get_typename(OBJECT(dev));
+    CPUArchId *core_slot;
+    int index;
 
     if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
         error_setg(&local_err, "CPU hotplug not supported for this machine");
@@ -2620,13 +2641,13 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    index = cc->core_id / smp_threads;
-    if (index < 0 || index >= spapr_max_cores) {
+    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
+    if (!core_slot) {
         error_setg(&local_err, "core id %d out of range", cc->core_id);
         goto out;
     }
 
-    if (spapr->cores[index]) {
+    if (core_slot->cpu) {
         error_setg(&local_err, "core %d already populated", cc->core_id);
         goto out;
     }
@@ -2758,29 +2779,58 @@ static unsigned spapr_cpu_index_to_socket_id(unsigned cpu_index)
     return cpu_index / smp_threads / smp_cores;
 }
 
+static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
+{
+    int i;
+    int spapr_max_cores = max_cpus / smp_threads;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (!mc->query_hotpluggable_cpus) {
+        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
+    }
+    if (machine->possible_cpus) {
+        assert(machine->possible_cpus->len == spapr_max_cores);
+        return machine->possible_cpus;
+    }
+
+    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                             sizeof(CPUArchId) * spapr_max_cores);
+    machine->possible_cpus->len = spapr_max_cores;
+    for (i = 0; i < machine->possible_cpus->len; i++) {
+        int core_id = i * smp_threads;
+
+        machine->possible_cpus->cpus[i].arch_id = core_id;
+        machine->possible_cpus->cpus[i].props.has_core_id = true;
+        machine->possible_cpus->cpus[i].props.core_id = core_id;
+        /* TODO: add 'has_node/node' here to describe
+           to which node core belongs */
+    }
+    return machine->possible_cpus;
+}
+
 static HotpluggableCPUList *spapr_query_hotpluggable_cpus(MachineState *machine)
 {
     int i;
+    Object *cpu;
     HotpluggableCPUList *head = NULL;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    int spapr_max_cores = max_cpus / smp_threads;
+    const char *cpu_type;
 
-    for (i = 0; i < spapr_max_cores; i++) {
+    cpu = machine->possible_cpus->cpus[0].cpu;
+    assert(cpu); /* Boot cpu is always present */
+    cpu_type = object_get_typename(cpu);
+    for (i = 0; i < machine->possible_cpus->len; i++) {
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
-        CpuInstanceProperties *cpu_props = g_new0(typeof(*cpu_props), 1);
 
-        cpu_item->type = spapr_get_cpu_core_type(machine->cpu_model);
-        cpu_item->vcpus_count = smp_threads;
-        cpu_props->has_core_id = true;
-        cpu_props->core_id = i * smp_threads;
-        /* TODO: add 'has_node/node' here to describe
-           to which node core belongs */
+        cpu_item->type = g_strdup(cpu_type);
+        cpu_item->vcpus_count = smp_threads; // TODO: ??? generalize
+        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
+                                   sizeof(*cpu_item->props));
 
-        cpu_item->props = cpu_props;
-        if (spapr->cores[i]) {
+        cpu = machine->possible_cpus->cpus[i].cpu;
+        if (cpu) {
             cpu_item->has_qom_path = true;
-            cpu_item->qom_path = object_get_canonical_path(spapr->cores[i]);
+            cpu_item->qom_path = object_get_canonical_path(cpu);
         }
         list_item->value = cpu_item;
         list_item->next = head;
@@ -2872,6 +2922,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = spapr_machine_device_plug;
     hc->unplug = spapr_machine_device_unplug;
     mc->cpu_index_to_socket_id = spapr_cpu_index_to_socket_id;
+    mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-- 
2.7.4
