Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZf4-0007oM-P7
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZf3-0007zo-6L
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZf2-0007zN-TO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:01 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:44 -0200
Message-Id: <20180119163345.10649-19-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 18/19] possible_cpus: add CPUArchId::type
 field
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

Remove dependency of possible_cpus on 1st CPU instance,
which decouples configuration data from CPU instances that
are created using that data.

Also later it would be used for enabling early cpu to numa node
configuration at runtime qmp_query_hotpluggable_cpus() should
provide a list of available cpu slots at early stage,
before machine_init() is called and the 1st cpu is created,
so that mgmt might be able to call it and use output to set
numa mapping.

Use MachineClass::possible_cpu_arch_ids() callback to set
cpu type info, along with the rest of possible cpu properties,
to let machine define which cpu type* will be used.

* for SPAPR it will be a spapr core type and for ARM/s390x/x86
  a respective descendant of CPUClass.

Move parse_numa_opts() in vl.c after cpu_model is parsed into
cpu_type so that possible_cpu_arch_ids() would know which
cpu_type to use during layout initialization.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1515597770-268979-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h        |  2 ++
 hw/arm/virt.c              |  3 ++-
 hw/core/machine.c          | 12 ++++++------
 hw/i386/pc.c               |  4 +++-
 hw/ppc/spapr.c             | 13 ++++++++-----
 hw/s390x/s390-virtio-ccw.c |  1 +
 vl.c                       |  3 +--
 7 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 041bc08971..efb0a9edfd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -83,6 +83,7 @@ void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
  * @cpu - pointer to corresponding CPU object if it's present on NULL otherwise
+ * @type - QOM class name of possible @cpu object
  * @props - CPU object properties, initialized by board
  * #vcpus_count - number of threads provided by @cpu object
  */
@@ -91,6 +92,7 @@ typedef struct {
     int64_t vcpus_count;
     CpuInstanceProperties props;
     Object *cpu;
+    const char *type;
 } CPUArchId;
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a6fdcc4f5..a4537af400 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1359,7 +1359,7 @@ static void machvirt_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(machine->cpu_type);
+        cpuobj = object_new(possible_cpus->cpus[n].type);
         object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
@@ -1575,6 +1575,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id =
             virt_cpu_mp_affinity(vms, n);
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0320a8efa1..cdc1163dc6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -377,18 +377,18 @@ static void machine_init_notify(Notifier *notifier, void *data)
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 {
     int i;
-    Object *cpu;
     HotpluggableCPUList *head = NULL;
-    const char *cpu_type;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    /* force board to initialize possible_cpus if it hasn't been done yet */
+    mc->possible_cpu_arch_ids(machine);
 
-    cpu = machine->possible_cpus->cpus[0].cpu;
-    assert(cpu); /* Boot cpu is always present */
-    cpu_type = object_get_typename(cpu);
     for (i = 0; i < machine->possible_cpus->len; i++) {
+        Object *cpu;
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
 
-        cpu_item->type = g_strdup(cpu_type);
+        cpu_item->type = g_strdup(machine->possible_cpus->cpus[i].type);
         cpu_item->vcpus_count = machine->possible_cpus->cpus[i].vcpus_count;
         cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
                                    sizeof(*cpu_item->props));
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 55686bf5d8..ccc50baa85 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1148,7 +1148,8 @@ void pc_cpus_init(PCMachineState *pcms)
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < smp_cpus; i++) {
-        pc_new_cpu(ms->cpu_type, possible_cpus->cpus[i].arch_id, &error_fatal);
+        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
+                   &error_fatal);
     }
 }
 
@@ -2307,6 +2308,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoInfo topo;
 
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 278f9de1e7..a781dd22e7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2226,11 +2226,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     int boot_cores_nr = smp_cpus / smp_threads;
     int i;
 
-    if (!type) {
-        error_report("Unable to find sPAPR CPU Core definition");
-        exit(1);
-    }
-
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     if (mc->has_hotpluggable_cpus) {
         if (smp_cpus % smp_threads) {
@@ -3545,6 +3540,7 @@ static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 {
     int i;
+    const char *core_type;
     int spapr_max_cores = max_cpus / smp_threads;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
@@ -3556,12 +3552,19 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
         return machine->possible_cpus;
     }
 
+    core_type = spapr_get_cpu_core_type(machine->cpu_type);
+    if (!core_type) {
+        error_report("Unable to find sPAPR CPU Core definition");
+        exit(1);
+    }
+
     machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                              sizeof(CPUArchId) * spapr_max_cores);
     machine->possible_cpus->len = spapr_max_cores;
     for (i = 0; i < machine->possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
+        machine->possible_cpus->cpus[i].type = core_type;
         machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
         machine->possible_cpus->cpus[i].arch_id = core_id;
         machine->possible_cpus->cpus[i].props.has_core_id = true;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 35df7e19c5..3807dcb097 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -414,6 +414,7 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = i;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
diff --git a/vl.c b/vl.c
index 2586f25952..e725ecbc08 100644
--- a/vl.c
+++ b/vl.c
@@ -4611,8 +4611,6 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
-    parse_numa_opts(current_machine);
-
     /* parse features once if machine provides default cpu_type */
     if (machine_class->default_cpu_type) {
         current_machine->cpu_type = machine_class->default_cpu_type;
@@ -4621,6 +4619,7 @@ int main(int argc, char **argv, char **envp)
                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
         }
     }
+    parse_numa_opts(current_machine);
 
     machine_run_board_init(current_machine);
 
-- 
2.14.3
