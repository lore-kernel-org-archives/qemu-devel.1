Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-00038A-AQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV8-00088q-10
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:39 +1100
Message-Id: <20170222063348.32176-35-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 34/43] pc: calculate topology only once when
 possible_cpus is initialised
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

Fill in CpuInstanceProperties once at board init time and
just copy them whenever query_hotpluggable_cpus() is called.
It will keep topology info always available without need
to recalculate it every time it's needed.
Considering it has NUMA node id, it will be used to keep
NUMA node to cpu mapping instead of numa_info[i].node_cpu
bitmasks.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc.c        | 24 ++++++++++++------------
 include/hw/boards.h |  2 ++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a187748..50ba977 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2268,7 +2268,17 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
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
@@ -2285,23 +2295,13 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
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
 
-- 
2.9.3
