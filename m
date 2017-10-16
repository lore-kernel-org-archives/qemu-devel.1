Received: from eggs.gnu.org ([2001:4830:134:3::10]:34019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Ar-0004bg-Fr
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Aq-00077a-AT
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e48Aq-00076a-1A
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:28 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 16 Oct 2017 18:22:53 +0200
Message-Id: <1508170976-96869-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 3/6] possible_cpus: add CPUArchId::type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

For enabling early cpu to numa node configuration at runtime
qmp_query_hotpluggable_cpus() should provide a list of available
cpu slots at early stage, before machine_init() is called and
the 1st cpu is created, so that mgmt might be able to call it
and use output to set numa mapping.
Use MachineClass::possible_cpu_arch_ids() callback to set
cpu type info, along with the rest of possible cpu properties,
to let machine define which cpu type* will be used.

* for SPAPR it will be a spapr core type and for ARM/s390x/x86
  a respective descendant of CPUClass.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h        |  2 ++
 hw/arm/virt.c              |  3 ++-
 hw/core/machine.c          | 12 ++++++------
 hw/i386/pc.c               |  4 +++-
 hw/ppc/spapr.c             | 13 ++++++++-----
 hw/s390x/s390-virtio-ccw.c |  1 +
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 156e0a5..2c3e958 100644
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
index 9e18b41..88319db 100644
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
index f482211..1e1fca5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -363,18 +363,18 @@ static void machine_init_notify(Notifier *notifier, void *data)
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
index 8e307f7..99afb2f1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1147,7 +1147,8 @@ void pc_cpus_init(PCMachineState *pcms)
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < smp_cpus; i++) {
-        pc_new_cpu(ms->cpu_type, possible_cpus->cpus[i].arch_id, &error_fatal);
+        pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
+                   &error_fatal);
     }
 }
 
@@ -2269,6 +2270,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoInfo topo;
 
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 29de845..9f455e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2129,11 +2129,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
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
@@ -3419,6 +3414,7 @@ static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
 {
     int i;
+    const char *core_type;
     int spapr_max_cores = max_cpus / smp_threads;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
@@ -3430,12 +3426,19 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
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
index f64db51..ae73fb6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -385,6 +385,7 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = i;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
-- 
2.7.4
