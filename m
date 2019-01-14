Received: from eggs.gnu.org ([209.51.188.92]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu01-0007bR-TU
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gitzz-0002ZH-GM
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:15389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gitzt-0002TQ-Mg
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:15 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:57 +0800
Message-Id: <1547468699-17633-4-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 3/5] i386: extend x86_apicid_* functions for
 smp_dies support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This patch rewrites the width/offset-apicid calculation with compatibility.
It keeps the original symmetry as a default method and sets the die_id
as well as node_id for leageacy numde_node auto-configuration.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/i386/pc.c               | 37 +++++++++++++++-------
 include/hw/i386/topology.h | 79 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fc65049..2f01886 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -909,7 +909,8 @@ static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_index);
+    correct_id = x86_apicid_from_cpu_idx(smp_dies, smp_cores,
+                                         smp_threads, cpu_index);
     if (compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -2137,9 +2138,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    /* if APIC ID is not set, set it based on socket/core/thread properties */
+    /*
+     * If APIC ID is not set, set it based on
+     * socket/die/core/thread properties.
+     */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (max_cpus - 1) / smp_threads / smp_cores;
+        int max_socket = (max_cpus - 1) / smp_threads / smp_cores / smp_dies;
 
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
@@ -2148,6 +2152,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
             error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
                        cpu->socket_id, max_socket);
             return;
+        } else if (cpu->die_id > max_socket) {
+            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
+                       cpu->die_id, max_socket);
+            return;
         }
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
@@ -2167,20 +2175,24 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         }
 
         topo.pkg_id = cpu->socket_id;
+        topo.die_id = cpu->die_id;
         topo.core_id = cpu->core_id;
         topo.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
+        cpu->apic_id = apicid_from_topo_ids(smp_dies, smp_cores,
+                                            smp_threads, &topo);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
-        error_setg(errp, "Invalid CPU [socket: %u, core: %u, thread: %u] with"
+        x86_topo_ids_from_apicid(cpu->apic_id, smp_dies, smp_cores,
+                                               smp_threads, &topo);
+        error_setg(errp,
+                  "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
                   " APIC ID %" PRIu32 ", valid index range 0:%d",
-                   topo.pkg_id, topo.core_id, topo.smt_id, cpu->apic_id,
-                   ms->possible_cpus->len - 1);
+                   topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
+                   cpu->apic_id, ms->possible_cpus->len - 1);
         return;
     }
 
@@ -2196,7 +2208,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
+    x86_topo_ids_from_apicid(cpu->apic_id,
+                             smp_dies, smp_cores, smp_threads, &topo);
     if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
@@ -2529,7 +2542,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            smp_cores, smp_threads, &topo);
+                            smp_dies, smp_cores, smp_threads, &topo);
    return topo.pkg_id % nb_numa_nodes;
 }
 
@@ -2556,9 +2569,11 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 smp_cores, smp_threads, &topo);
+                                 smp_dies, smp_cores, smp_threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.has_die_id = true;
+        ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 1ebaee0..1e344db 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,6 +47,8 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoInfo {
     unsigned pkg_id;
+    unsigned node_id;
+    unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoInfo;
@@ -62,87 +64,122 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
 
 /* Bit width of the SMT_ID (thread ID) field on the APIC ID
  */
-static inline unsigned apicid_smt_width(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_smt_width(unsigned nr_dies,
+                                        unsigned nr_cores,
+                                        unsigned nr_threads)
 {
     return apicid_bitwidth_for_count(nr_threads);
 }
 
 /* Bit width of the Core_ID field
  */
-static inline unsigned apicid_core_width(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_core_width(unsigned nr_dies,
+                                         unsigned nr_cores,
+                                         unsigned nr_threads)
 {
     return apicid_bitwidth_for_count(nr_cores);
 }
 
+/* Bit width of the Die_ID field */
+static inline unsigned apicid_die_width(unsigned nr_dies,
+                                        unsigned nr_cores,
+                                        unsigned nr_threads)
+{
+    return apicid_bitwidth_for_count(nr_dies);
+}
+
 /* Bit offset of the Core_ID field
  */
-static inline unsigned apicid_core_offset(unsigned nr_cores,
+static inline unsigned apicid_core_offset(unsigned nr_dies,
+                                          unsigned nr_cores,
+                                          unsigned nr_threads)
+{
+    return apicid_smt_width(nr_dies, nr_cores, nr_threads);
+}
+
+/* Bit offset of the Die_ID field */
+static inline unsigned apicid_die_offset(unsigned nr_dies,
+                                          unsigned nr_cores,
                                           unsigned nr_threads)
 {
-    return apicid_smt_width(nr_cores, nr_threads);
+    return apicid_core_offset(nr_dies, nr_cores, nr_threads) +
+           apicid_core_width(nr_dies, nr_cores, nr_threads);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field
  */
-static inline unsigned apicid_pkg_offset(unsigned nr_cores, unsigned nr_threads)
+static inline unsigned apicid_pkg_offset(unsigned nr_dies,
+                                         unsigned nr_cores,
+                                         unsigned nr_threads)
 {
-    return apicid_core_offset(nr_cores, nr_threads) +
-           apicid_core_width(nr_cores, nr_threads);
+    return apicid_die_offset(nr_dies, nr_cores, nr_threads) +
+           apicid_die_width(nr_dies, nr_cores, nr_threads);
 }
 
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(unsigned nr_cores,
+static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
+                                             unsigned nr_cores,
                                              unsigned nr_threads,
                                              const X86CPUTopoInfo *topo)
 {
-    return (topo->pkg_id  << apicid_pkg_offset(nr_cores, nr_threads)) |
-           (topo->core_id << apicid_core_offset(nr_cores, nr_threads)) |
+    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
+          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
            topo->smt_id;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
  * based on (contiguous) CPU index
  */
-static inline void x86_topo_ids_from_idx(unsigned nr_cores,
+static inline void x86_topo_ids_from_idx(unsigned nr_dies,
+                                         unsigned nr_cores,
                                          unsigned nr_threads,
                                          unsigned cpu_index,
                                          X86CPUTopoInfo *topo)
 {
-    unsigned core_index = cpu_index / nr_threads;
+    topo->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo->node_id = cpu_index / (nr_cores * nr_threads);
+    topo->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo->core_id = cpu_index / nr_threads % nr_cores;
     topo->smt_id = cpu_index % nr_threads;
-    topo->core_id = core_index % nr_cores;
-    topo->pkg_id = core_index / nr_cores;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
  * based on APIC ID
  */
 static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
+                                            unsigned nr_dies,
                                             unsigned nr_cores,
                                             unsigned nr_threads,
                                             X86CPUTopoInfo *topo)
 {
     topo->smt_id = apicid &
-                   ~(0xFFFFFFFFUL << apicid_smt_width(nr_cores, nr_threads));
-    topo->core_id = (apicid >> apicid_core_offset(nr_cores, nr_threads)) &
-                   ~(0xFFFFFFFFUL << apicid_core_width(nr_cores, nr_threads));
-    topo->pkg_id = apicid >> apicid_pkg_offset(nr_cores, nr_threads);
+            ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
+    topo->core_id =
+            (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
+    topo->die_id =
+            (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
+    topo->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
+    topo->node_id = apicid / (nr_cores * nr_threads);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
  *
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
-static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_cores,
+static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
+                                                unsigned nr_cores,
                                                 unsigned nr_threads,
                                                 unsigned cpu_index)
 {
     X86CPUTopoInfo topo;
-    x86_topo_ids_from_idx(nr_cores, nr_threads, cpu_index, &topo);
-    return apicid_from_topo_ids(nr_cores, nr_threads, &topo);
+    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo);
+    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
-- 
1.8.3.1
