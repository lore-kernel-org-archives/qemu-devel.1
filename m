Received: from eggs.gnu.org ([2001:4830:134:3::10]:39417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tql-00088P-AE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tqk-0000kb-9m
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:57:47 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  3 May 2017 14:57:00 +0200
Message-Id: <1493816238-33120-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/24] spapr: add node-id property to sPAPR
 core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

it will allow switching from cpu_index to core based numa
mapping in follow up patches.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_cpu_core.h |  1 +
 include/qom/cpu.h               |  2 ++
 hw/ppc/spapr.c                  | 17 +++++++++++++++++
 hw/ppc/spapr_cpu_core.c         | 11 ++++++++---
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 3c35665..93051e9 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -27,6 +27,7 @@ typedef struct sPAPRCPUCore {
 
     /*< public >*/
     void *threads;
+    int node_id;
 } sPAPRCPUCore;
 
 typedef struct sPAPRCPUCoreClass {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5d10359..55214ce 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -258,6 +258,8 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on_cpu_data data);
 
 struct qemu_work_item;
 
+#define CPU_UNSET_NUMA_NODE_ID -1
+
 /**
  * CPUState:
  * @cpu_index: CPU index (informative).
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 33405a0..7f58ee4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2824,9 +2824,11 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
+    sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
     char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
     const char *type = object_get_typename(OBJECT(dev));
     CPUArchId *core_slot;
+    int node_id;
     int index;
 
     if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
@@ -2861,6 +2863,21 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
+    node_id = numa_get_node_for_cpu(cc->core_id);
+    if (node_id == nb_numa_nodes) {
+        /* by default CPUState::numa_node was 0 if it's not set via CLI
+         * keep it this way for now but in future we probably should
+         * refuse to start up with incomplete numa mapping */
+        node_id = 0;
+    }
+    if (sc->node_id == CPU_UNSET_NUMA_NODE_ID) {
+        sc->node_id = node_id;
+    } else if (sc->node_id != node_id) {
+        error_setg(&local_err, "node-id %d must match numa node specified"
+            "with -numa option for cpu-index %d", sc->node_id, cc->core_id);
+        goto out;
+    }
+
 out:
     g_free(base_core_type);
     error_propagate(errp, local_err);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4389ef4..9de7a56 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -176,7 +176,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     const char *typename = object_class_get_name(scc->cpu_class);
     size_t size = object_type_get_instance_size(typename);
     Error *local_err = NULL;
-    int core_node_id = numa_get_node_for_cpu(cc->core_id);;
     void *obj;
     int i, j;
 
@@ -194,10 +193,10 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
         /* Set NUMA node for the added CPUs  */
         node_id = numa_get_node_for_cpu(cs->cpu_index);
-        if (node_id != core_node_id) {
+        if (node_id != sc->node_id) {
             error_setg(&local_err, "Invalid node-id=%d of thread[cpu-index: %d]"
                 " on CPU[core-id: %d, node-id: %d], node-id must be the same",
-                 node_id, cs->cpu_index, cc->core_id, core_node_id);
+                 node_id, cs->cpu_index, cc->core_id, sc->node_id);
             goto err;
         }
         if (node_id < nb_numa_nodes) {
@@ -263,6 +262,11 @@ static const char *spapr_core_models[] = {
     "POWER9_v1.0",
 };
 
+static Property spapr_cpu_core_properties[] = {
+    DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -270,6 +274,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
 
     dc->realize = spapr_cpu_core_realize;
     dc->unrealize = spapr_cpu_core_unrealizefn;
+    dc->props = spapr_cpu_core_properties;
     scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
     g_assert(scc->cpu_class);
 }
-- 
2.7.4
