Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTrXj-0005pK-5L
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTrXf-0004zi-5k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTrXe-0004ym-Sp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:51 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 15:48:45 +0100
Message-Id: <1484750925-176844-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] numa: access CPU's node id via property in
 hmp_info_numa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Move vcpu's assocciated numa_node field out of generic CPUState
into inherited classes that actually care about cpu<->numa mapping
and make monitor 'info numa' get vcpu's assocciated node id via
node-id property.
It allows to drop implicit node id intialization in
numa_post_machine_init() and would allow switching to mapping
defined by target's CpuInstanceProperties instead of global
numa_info[i].node_cpu bitmaps.

As side effect it fixes 'info numa' displaying wrong mapping
for CPUs specified with -device/device_add.
Before patch following CLI would produce:
QEMU -smp 1,sockets=3,maxcpus=3 \
       -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0 \
       -numa node,nodeid=0,cpus=0 \
       -numa node,nodeid=1,cpus=1 \
       -numa node,nodeid=2,cpus=2
(qemu) device_add qemu64-x86_64-cpu,socket-id=2,core-id=0,thread-id=0
(qemu) info numa
3 nodes
node 0 cpus: 0 1 2
node 0 size: 40 MB
node 1 cpus:
node 1 size: 40 MB
node 2 cpus:
node 2 size: 48 MB

after patch all CPUs are on nodes they are supposed to be:
(qemu) device_add qemu64-x86_64-cpu,socket-id=2,core-id=0,thread-id=0
(qemu) info numa
3 nodes
node 0 cpus: 0
node 0 size: 40 MB
node 1 cpus: 1
node 1 size: 40 MB
node 2 cpus: 2
node 2 size: 48 MB

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Dou Liyang <douly.fnst@cn.fujitsu.com>
CC: fanc.fnst@cn.fujitsu.com
CC: caoj.fnst@cn.fujitsu.com
CC: stefanha@redhat.com
CC: izumi.taku@jp.fujitsu.com
CC: vilanova@ac.upc.edu
CC: ehabkost@redhat.com
CC: peter.maydell@linaro.org
CC: Andrew Jones <drjones@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Thomas Huth <thuth@redhat.com>
---
 include/qom/cpu.h           |  2 --
 include/sysemu/numa.h       |  1 -
 target/arm/cpu.h            |  2 ++
 target/i386/cpu.h           |  1 +
 target/ppc/cpu.h            |  2 ++
 hw/arm/virt.c               | 12 ++++++++----
 hw/i386/pc.c                |  5 +++++
 hw/ppc/spapr.c              |  2 +-
 hw/ppc/spapr_cpu_core.c     |  2 +-
 monitor.c                   |  7 +++++--
 numa.c                      | 15 ---------------
 target/arm/cpu.c            |  1 +
 target/i386/cpu.c           |  1 +
 target/ppc/translate_init.c |  1 +
 vl.c                        |  2 --
 15 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e..ae637a9 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -257,7 +257,6 @@ struct qemu_work_item;
  * @cpu_index: CPU index (informative).
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
- * @numa_node: NUMA node this CPU is belonging to.
  * @host_tid: Host thread ID.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
@@ -306,7 +305,6 @@ struct CPUState {
 
     int nr_cores;
     int nr_threads;
-    int numa_node;
 
     struct QemuThread *thread;
 #ifdef _WIN32
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 8f09dcf..b8015a5 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -25,7 +25,6 @@ typedef struct node_info {
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineClass *mc);
-void numa_post_machine_init(void);
 void query_numa_node_mem(uint64_t node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7bd16ee..ef263f1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -662,6 +662,8 @@ struct ARMCPU {
 
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
+
+    int32_t numa_nid;
 };
 
 static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6c1902b..e43dcc2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1264,6 +1264,7 @@ struct X86CPU {
     int32_t socket_id;
     int32_t core_id;
     int32_t thread_id;
+    int32_t numa_nid;
 };
 
 static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2a50c43..2d12ad5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1154,6 +1154,7 @@ do {                                            \
  * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
  * @max_compat: Maximal supported logical PVR from the command line
  * @cpu_version: Current logical PVR, zero if in "raw" mode
+ * @numa_nid: Numa node id the CPU belongs to
  *
  * A PowerPC CPU.
  */
@@ -1166,6 +1167,7 @@ struct PowerPCCPU {
     int cpu_dt_id;
     uint32_t max_compat;
     uint32_t cpu_version;
+    int32_t numa_nid;
 
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..b86b5fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -329,7 +329,6 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
-    unsigned int i;
 
     /*
      * From Documentation/devicetree/bindings/arm/cpus.txt
@@ -379,9 +378,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                                   armcpu->mp_affinity);
         }
 
-        i = numa_get_node_for_cpu(cpu);
-        if (i < nb_numa_nodes) {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id", i);
+        if (armcpu->numa_nid < nb_numa_nodes) {
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
+                                  armcpu->numa_nid);
         }
 
         g_free(nodename);
@@ -1333,6 +1332,11 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        if (nb_numa_nodes) {
+            object_property_set_int(cpuobj, numa_get_node_for_cpu(n),
+                                    "node-id", NULL);
+        }
+
         object_property_set_bool(cpuobj, true, "realized", NULL);
     }
     fdt_add_timer_nodes(vms);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f721fde..9d2b265 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1978,6 +1978,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cs = CPU(cpu);
     cs->cpu_index = idx;
+
+    idx = numa_get_node_for_cpu(cs->cpu_index);
+    if (idx < nb_numa_nodes) {
+        cpu->numa_nid = idx;
+    }
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 208ef7b..efcd925 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -182,7 +182,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
-                                cpu_to_be32(cs->numa_node),
+                                cpu_to_be32(cpu->numa_nid),
                                 cpu_to_be32(index)};
 
     /* Advertise NUMA via ibm,associativity */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c18632b..7f6661b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -71,7 +71,7 @@ void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu, Error **errp)
     /* Set NUMA node for the added CPUs  */
     i = numa_get_node_for_cpu(cs->cpu_index);
     if (i < nb_numa_nodes) {
-            cs->numa_node = i;
+        cpu->numa_nid = i;
     }
 
     xics_cpu_setup(spapr->xics, cpu);
diff --git a/monitor.c b/monitor.c
index 0841d43..8856d5b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1544,9 +1544,12 @@ static void hmp_info_numa(Monitor *mon, const QDict *qdict)
     for (i = 0; i < nb_numa_nodes; i++) {
         monitor_printf(mon, "node %d cpus:", i);
         CPU_FOREACH(cpu) {
-            if (cpu->numa_node == i) {
-                monitor_printf(mon, " %d", cpu->cpu_index);
+            Error *err = NULL;
+            int64_t nid = object_property_get_int(OBJECT(cpu), "node-id", &err);
+            if (nid == i && !err) {
+                    monitor_printf(mon, " %d", cpu->cpu_index);
             }
+            error_free(err);
         }
         monitor_printf(mon, "\n");
         monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
diff --git a/numa.c b/numa.c
index 379bc8a..5f68497 100644
--- a/numa.c
+++ b/numa.c
@@ -394,21 +394,6 @@ void parse_numa_opts(MachineClass *mc)
     }
 }
 
-void numa_post_machine_init(void)
-{
-    CPUState *cpu;
-    int i;
-
-    CPU_FOREACH(cpu) {
-        for (i = 0; i < nb_numa_nodes; i++) {
-            assert(cpu->cpu_index < max_cpus);
-            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
-                cpu->numa_node = i;
-            }
-        }
-    }
-}
-
 static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                            const char *name,
                                            uint64_t ram_size)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9104611..8caf853 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1515,6 +1515,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
+    DEFINE_PROP_INT32("node-id", ARMCPU, numa_nid, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aba11ae..85c52f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3649,6 +3649,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
+    DEFINE_PROP_INT32("node-id", X86CPU, numa_nid, 0),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
     DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index e6a835c..64bd7be 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10520,6 +10520,7 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
 
 static Property ppc_cpu_properties[] = {
     DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
+    DEFINE_PROP_INT32("node-id", PowerPCCPU, numa_nid, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/vl.c b/vl.c
index c643d3f..afe40ce 100644
--- a/vl.c
+++ b/vl.c
@@ -4549,8 +4549,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
-- 
2.7.4
