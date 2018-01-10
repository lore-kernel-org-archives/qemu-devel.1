Received: from eggs.gnu.org ([2001:4830:134:3::10]:50576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZIDe-0008NX-G9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZIDb-00008R-59
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:23:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eZIDa-00007X-S9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:23:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12CCE5B2F8
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:23:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 10 Jan 2018 16:22:50 +0100
Message-Id: <1515597770-268979-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3] possible_cpus: add CPUArchId::type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

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
---
  v2:
     - fix NULL dereference caused by not initialized
       MachineState::cpu_type at the time parse_numa_opts()
       were called
  v3:
     - rebase on top of current master
     - fix trivial conflict due to recently merged:
         "7b8be49d NUMA: Enable adding NUMA node implicitly"
       which moved parse_numa_opts()
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
index 156b16f..57bed18 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -80,6 +80,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
  * @cpu - pointer to corresponding CPU object if it's present on NULL otherwise
+ * @type - QOM class name of possible @cpu object
  * @props - CPU object properties, initialized by board
  * #vcpus_count - number of threads provided by @cpu object
  */
@@ -88,6 +89,7 @@ typedef struct {
     int64_t vcpus_count;
     CpuInstanceProperties props;
     Object *cpu;
+    const char *type;
 } CPUArchId;
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 151592b..da39da3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1357,7 +1357,7 @@ static void machvirt_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(machine->cpu_type);
+        cpuobj = object_new(possible_cpus->cpus[n].type);
         object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
@@ -1573,6 +1573,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id =
             virt_cpu_mp_affinity(vms, n);
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c857f3f..59b960f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -362,18 +362,18 @@ static void machine_init_notify(Notifier *notifier, void *data)
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
index 3fcf318..4443158 100644
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
 
@@ -2297,6 +2298,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoInfo topo;
 
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6785a90..b727750 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2186,11 +2186,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
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
@@ -3488,6 +3483,7 @@ static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 {
     int i;
+    const char *core_type;
     int spapr_max_cores = max_cpus / smp_threads;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
@@ -3499,12 +3495,19 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
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
index 35df7e1..3807dcb 100644
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
index 444b750..d10925f 100644
--- a/vl.c
+++ b/vl.c
@@ -4608,8 +4608,6 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
-    parse_numa_opts(current_machine);
-
     /* parse features once if machine provides default cpu_type */
     if (machine_class->default_cpu_type) {
         current_machine->cpu_type = machine_class->default_cpu_type;
@@ -4618,6 +4616,7 @@ int main(int argc, char **argv, char **envp)
                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
         }
     }
+    parse_numa_opts(current_machine);
 
     machine_run_board_init(current_machine);
 
-- 
2.7.4
