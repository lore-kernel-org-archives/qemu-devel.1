Received: from eggs.gnu.org ([2001:4830:134:3::10]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmao-0001di-22
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbman-00049F-3q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:50 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  9 Feb 2017 12:08:34 +0100
Message-Id: <1486638518-171446-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] pc: calculate topology only once when
 possible_cpus is initialised
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

Fill in CpuInstanceProperties once at board init time and
just copy them whenever query_hotpluggable_cpus() is called.
It will keep topology info always available without need
to recalculate it every time it's needed.
Considering it has NUMA node id, it will be used to keep
NUMA node to cpu mapping instead of numa_info[i].node_cpu
bitmasks.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h |  2 ++
 hw/i386/pc.c        | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 64e8c07..4023b38 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -46,9 +46,11 @@ void machine_register_compat_props(MachineState *machine);
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
  * @cpu - pointer to corresponding CPU object if it's present on NULL otherwise
+ * @props - CPU object properties, initialized by board
  */
 typedef struct {
     uint64_t arch_id;
+    CpuInstanceProperties props;
     struct CPUState *cpu;
 } CPUArchId;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a6cfc97..f03a555 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2262,7 +2262,17 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
+        X86CPUTopoInfo topo;
+
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                 smp_cores, smp_threads, &topo);
+        ms->possible_cpus->cpus[i].props.has_socket_id = true;
+        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.has_core_id = true;
+        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
+        ms->possible_cpus->cpus[i].props.has_thread_id = true;
+        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
     }
     return ms->possible_cpus;
 }
@@ -2279,23 +2289,13 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
     cpu_type = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
 
     for (i = 0; i < machine->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
-        CpuInstanceProperties *cpu_props = g_new0(typeof(*cpu_props), 1);
-        const uint32_t apic_id = machine->possible_cpus->cpus[i].arch_id;
-
-        x86_topo_ids_from_apicid(apic_id, smp_cores, smp_threads, &topo);
 
         cpu_item->type = g_strdup(cpu_type);
         cpu_item->vcpus_count = 1;
-        cpu_props->has_socket_id = true;
-        cpu_props->socket_id = topo.pkg_id;
-        cpu_props->has_core_id = true;
-        cpu_props->core_id = topo.core_id;
-        cpu_props->has_thread_id = true;
-        cpu_props->thread_id = topo.smt_id;
-        cpu_item->props = cpu_props;
+        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
+                                   sizeof(*cpu_item->props));
 
         cpu = machine->possible_cpus->cpus[i].cpu;
         if (cpu) {
-- 
2.7.4
