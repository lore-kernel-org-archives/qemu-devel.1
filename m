Received: from eggs.gnu.org ([2001:4830:134:3::10]:57037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoA-0002Gn-5t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto8-0007Pd-O1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTto8-0007PK-FA
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:00 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:26 +0100
Message-Id: <1484759609-264075-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 10/13] numa: replace cpu_index_to_socket_id()
 with cpu_index_to_instance_props()
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

new cpu_index_to_instance_props() returns topo info which
includes socket_id so it could be used as drop in replacement
in the only user parse_numa_opts().

In follow up path cpu_index_to_instance_props() will be used in
compat code to set legacy index based cpu<->node mapping using
new machine.cpu property.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h | 11 ++++++-----
 hw/i386/pc.c        | 14 ++++++++------
 hw/ppc/spapr.c      | 13 ++++++++++---
 numa.c              |  7 +++++--
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6364617..daceee5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -70,10 +70,10 @@ typedef struct {
  *    of HotplugHandler object, which handles hotplug operation
  *    for a given @dev. It may return NULL if @dev doesn't require
  *    any actions to be performed by hotplug handler.
- * @cpu_index_to_socket_id:
- *    used to provide @cpu_index to socket number mapping, allowing
- *    a machine to group CPU threads belonging to the same socket/package
- *    Returns: socket number given cpu_index belongs to.
+ * @cpu_index_to_instance_props:
+ *    used to provide @cpu_index to socket/core/thread number mapping, allowing
+ *    legacy code to perform maping from cpu_index to topology properties
+ *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
  * @hw_version:
  *    Value of QEMU_VERSION when the machine was added to QEMU.
  *    Set only by old machines because they need to keep
@@ -135,7 +135,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
-    unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
+    CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
+                                                         unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     HotpluggableCPUList *(*query_hotpluggable_cpus)(MachineState *machine);
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1d33a5e..5066339 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2286,12 +2286,14 @@ static void pc_machine_reset(void)
     }
 }
 
-static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
+static CpuInstanceProperties
+pc_cpu_index_to_instance_props(MachineState *ms, unsigned cpu_index)
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
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
@@ -2398,7 +2400,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     mc->get_hotplug_handler = pc_get_hotpug_handler;
-    mc->cpu_index_to_socket_id = pc_cpu_index_to_socket_id;
+    mc->cpu_index_to_instance_props = pc_cpu_index_to_instance_props;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
     mc->query_hotpluggable_cpus = pc_query_hotpluggable_cpus;
     mc->default_boot_order = "cad";
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index efcd925..17eec87 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2571,11 +2571,18 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static unsigned spapr_cpu_index_to_socket_id(unsigned cpu_index)
+static CpuInstanceProperties
+spapr_cpu_index_to_instance_props(MachineState *ms, unsigned cpu_index)
 {
     /* Allocate to NUMA nodes on a "socket" basis (not that concept of
      * socket means much for the paravirtualized PAPR platform) */
-    return cpu_index / smp_threads / smp_cores;
+    CpuInstanceProperties topo = {
+        .socket_id = cpu_index / smp_threads / smp_cores,
+        .has_socket_id = true,
+        .has_core_id = false,
+        .has_thread_id = false,
+    };
+    return topo;
 }
 
 static HotpluggableCPUList *spapr_query_hotpluggable_cpus(MachineState *machine)
@@ -2688,7 +2695,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
     hc->unplug = spapr_machine_device_unplug;
-    mc->cpu_index_to_socket_id = spapr_cpu_index_to_socket_id;
+    mc->cpu_index_to_instance_props = spapr_cpu_index_to_instance_props;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
diff --git a/numa.c b/numa.c
index 0164cd7..887ee58 100644
--- a/numa.c
+++ b/numa.c
@@ -404,8 +404,11 @@ void parse_numa_opts(MachineState *ms)
         if (i == nb_numa_nodes) {
             for (i = 0; i < max_cpus; i++) {
                 unsigned node_id = i % nb_numa_nodes;
-                if (mc->cpu_index_to_socket_id) {
-                    node_id = mc->cpu_index_to_socket_id(i) % nb_numa_nodes;
+                if (mc->cpu_index_to_instance_props) {
+                    CpuInstanceProperties topo;
+                    topo = mc->cpu_index_to_instance_props(ms, i);
+                    assert(topo.has_socket_id);
+                    node_id = topo.socket_id % nb_numa_nodes;
                 }
 
                 set_bit(i, numa_info[node_id].node_cpu);
-- 
2.7.4
