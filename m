Received: from eggs.gnu.org ([2001:4830:134:3::10]:37813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcB-0002SN-0z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc9-0007oB-CY
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tc9-0007ns-2d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:23 -0300
Message-Id: <20170511191843.13784-10-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/29] numa: move source of default CPUs to NUMA
 node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Originally CPU threads were by default assigned in
round-robin fashion. However it was causing issues in
guest since CPU threads from the same socket/core could
be placed on different NUMA nodes.
Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
fixed it by grouping threads within a socket on the same node
introducing cpu_index_to_socket_id() callback and commit
20bb648d (spapr: Fix default NUMA node allocation for threads)
reused callback to fix similar issues for SPAPR machine
even though socket doesn't make much sense there.

As result QEMU ended up having 3 default distribution rules
used by 3 targets /virt-arm, spapr, pc/.

In effort of moving NUMA mapping for CPUs into possible_cpus,
generalize default mapping in numa.c by making boards decide
on default mapping and let them explicitly tell generic
numa code to which node a CPU thread belongs to by replacing
cpu_index_to_socket_id() with @cpu_index_to_instance_props()
which provides default node_id assigned by board to specified
cpu_index.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1494415802-227633-2-git-send-email-imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h   |  8 ++++++--
 include/sysemu/numa.h |  2 +-
 hw/arm/virt.c         | 20 ++++++++++++++++++--
 hw/i386/pc.c          | 23 +++++++++++++++++------
 hw/ppc/spapr.c        | 28 +++++++++++++++++++++-------
 numa.c                | 24 +++++++++++-------------
 vl.c                  |  2 +-
 7 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 99458eb859..3ffa255fb8 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -74,7 +74,10 @@ typedef struct {
  *    of HotplugHandler object, which handles hotplug operation
  *    for a given @dev. It may return NULL if @dev doesn't require
  *    any actions to be performed by hotplug handler.
- * @cpu_index_to_socket_id:
+ * @cpu_index_to_instance_props:
+ *    used to provide @cpu_index to socket/core/thread number mapping, allowing
+ *    legacy code to perform maping from cpu_index to topology properties
+ *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
  *    used to provide @cpu_index to socket number mapping, allowing
  *    a machine to group CPU threads belonging to the same socket/package
  *    Returns: socket number given cpu_index belongs to.
@@ -141,7 +144,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
-    unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
+    CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
+                                                         unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
 };
 
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 70e56214e5..027830cf7e 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -26,7 +26,7 @@ struct node_info {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
-void parse_numa_opts(MachineClass *mc);
+void parse_numa_opts(MachineState *ms);
 void numa_post_machine_init(void);
 void query_numa_node_mem(uint64_t node_mem[]);
 extern QemuOptsList qemu_numa_opts;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acc748ec40..dfd6fd446c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1539,6 +1539,16 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static CpuInstanceProperties
+virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
@@ -1558,8 +1568,13 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
         ms->possible_cpus->cpus[n].props.thread_id = n;
 
-        /* TODO: add 'has_node/node' here to describe
-           to which node core belongs */
+        /* default distribution of CPUs over NUMA nodes */
+        if (nb_numa_nodes) {
+            /* preset values but do not enable them i.e. 'has_node_id = false',
+             * numa init code will enable them later if manual mapping wasn't
+             * present on CLI */
+            ms->possible_cpus->cpus[n].props.node_id = n % nb_numa_nodes;
+        }
     }
     return ms->possible_cpus;
 }
@@ -1581,6 +1596,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3b372a18f..01693d54ca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2243,12 +2243,14 @@ static void pc_machine_reset(void)
     }
 }
 
-static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
+static CpuInstanceProperties
+pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
-    X86CPUTopoInfo topo;
-    x86_topo_ids_from_idx(smp_cores, smp_threads, cpu_index,
-                          &topo);
-    return topo.pkg_id;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
@@ -2280,6 +2282,15 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
         ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
+
+        /* default distribution of CPUs over NUMA nodes */
+        if (nb_numa_nodes) {
+            /* preset values but do not enable them i.e. 'has_node_id = false',
+             * numa init code will enable them later if manual mapping wasn't
+             * present on CLI */
+            ms->possible_cpus->cpus[i].props.node_id =
+                topo.pkg_id % nb_numa_nodes;
+        }
     }
     return ms->possible_cpus;
 }
@@ -2322,7 +2333,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     mc->get_hotplug_handler = pc_get_hotpug_handler;
-    mc->cpu_index_to_socket_id = pc_cpu_index_to_socket_id;
+    mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bdc31ce56c..2077e4b3c6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2981,11 +2981,18 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static unsigned spapr_cpu_index_to_socket_id(unsigned cpu_index)
+static CpuInstanceProperties
+spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
 {
-    /* Allocate to NUMA nodes on a "socket" basis (not that concept of
-     * socket means much for the paravirtualized PAPR platform) */
-    return cpu_index / smp_threads / smp_cores;
+    CPUArchId *core_slot;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    /* make sure possible_cpu are intialized */
+    mc->possible_cpu_arch_ids(machine);
+    /* get CPU core slot containing thread that matches cpu_index */
+    core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
+    assert(core_slot);
+    return core_slot->props;
 }
 
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
@@ -3012,8 +3019,15 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
         machine->possible_cpus->cpus[i].arch_id = core_id;
         machine->possible_cpus->cpus[i].props.has_core_id = true;
         machine->possible_cpus->cpus[i].props.core_id = core_id;
-        /* TODO: add 'has_node/node' here to describe
-           to which node core belongs */
+
+        /* default distribution of CPUs over NUMA nodes */
+        if (nb_numa_nodes) {
+            /* preset values but do not enable them i.e. 'has_node_id = false',
+             * numa init code will enable them later if manual mapping wasn't
+             * present on CLI */
+            machine->possible_cpus->cpus[i].props.node_id =
+                core_id / smp_threads / smp_cores % nb_numa_nodes;
+        }
     }
     return machine->possible_cpus;
 }
@@ -3138,7 +3152,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
     hc->unplug = spapr_machine_device_unplug;
-    mc->cpu_index_to_socket_id = spapr_cpu_index_to_socket_id;
+    mc->cpu_index_to_instance_props = spapr_cpu_index_to_props;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
diff --git a/numa.c b/numa.c
index d753687dec..bcdfca2309 100644
--- a/numa.c
+++ b/numa.c
@@ -443,9 +443,10 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
-void parse_numa_opts(MachineClass *mc)
+void parse_numa_opts(MachineState *ms)
 {
     int i;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     for (i = 0; i < MAX_NODES; i++) {
         numa_info[i].node_cpu = bitmap_new(max_cpus);
@@ -511,21 +512,18 @@ void parse_numa_opts(MachineClass *mc)
                 break;
             }
         }
-        /* Historically VCPUs were assigned in round-robin order to NUMA
-         * nodes. However it causes issues with guest not handling it nice
-         * in case where cores/threads from a multicore CPU appear on
-         * different nodes. So allow boards to override default distribution
-         * rule grouping VCPUs by socket so that VCPUs from the same socket
-         * would be on the same node.
-         */
+
+        /* assign CPUs to nodes using board provided default mapping */
+        if (!mc->cpu_index_to_instance_props) {
+            error_report("default CPUs to NUMA node mapping isn't supported");
+            exit(1);
+        }
         if (i == nb_numa_nodes) {
             for (i = 0; i < max_cpus; i++) {
-                unsigned node_id = i % nb_numa_nodes;
-                if (mc->cpu_index_to_socket_id) {
-                    node_id = mc->cpu_index_to_socket_id(i) % nb_numa_nodes;
-                }
+                CpuInstanceProperties props;
+                props = mc->cpu_index_to_instance_props(ms, i);
 
-                set_bit(i, numa_info[node_id].node_cpu);
+                set_bit(i, numa_info[props.node_id].node_cpu);
             }
         }
 
diff --git a/vl.c b/vl.c
index 58023fca02..c4705b3335 100644
--- a/vl.c
+++ b/vl.c
@@ -4503,7 +4503,7 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    parse_numa_opts(machine_class);
+    parse_numa_opts(current_machine);
 
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
-- 
2.11.0.259.g40922b1
