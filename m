Received: from eggs.gnu.org ([2001:4830:134:3::10]:32777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxE3-0001je-Qs
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxE2-0007oh-Do
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxE2-0007nr-4o
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:19 -0300
Message-Id: <20170605185927.12111-3-ehabkost@redhat.com>
In-Reply-To: <20170605185927.12111-1-ehabkost@redhat.com>
References: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] numa: consolidate cpu_preplug
 fixups/checks for pc/arm/spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1496161442-96665-2-git-send-email-imammedo@redhat.com>
[ehabkost: Fix indentation]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h |  1 +
 hw/arm/virt.c         | 16 ++--------------
 hw/i386/pc.c          | 17 +----------------
 hw/ppc/spapr.c        | 17 +----------------
 numa.c                | 23 +++++++++++++++++++++++
 5 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 7ffde5b119..610eece211 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -35,4 +35,5 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
+void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4db2d4207c..010f7244bf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1372,7 +1372,6 @@ static void machvirt_init(MachineState *machine)
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
         CPUState *cs;
-        int node_id;
 
         if (n >= smp_cpus) {
             break;
@@ -1385,19 +1384,8 @@ static void machvirt_init(MachineState *machine)
         cs = CPU(cpuobj);
         cs->cpu_index = n;
 
-        node_id = possible_cpus->cpus[cs->cpu_index].props.node_id;
-        if (!possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
-            /* by default CPUState::numa_node was 0 if it's not set via CLI
-             * keep it this way for now but in future we probably should
-             * refuse to start up with incomplete numa mapping */
-             node_id = 0;
-        }
-        if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
-            cs->numa_node = node_id;
-        } else {
-            /* CPU isn't device_add compatible yet, this shouldn't happen */
-            error_setg(&error_abort, "user set node-id not implemented");
-        }
+        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
+                          &error_fatal);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 107a34125b..5b07be61cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1893,7 +1893,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
                             DeviceState *dev, Error **errp)
 {
     int idx;
-    int node_id;
     CPUState *cs;
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
@@ -1984,21 +1983,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cs = CPU(cpu);
     cs->cpu_index = idx;
 
-    node_id = cpu_slot->props.node_id;
-    if (!cpu_slot->props.has_node_id) {
-        /* by default CPUState::numa_node was 0 if it's not set via CLI
-         * keep it this way for now but in future we probably should
-         * refuse to start up with incomplete numa mapping */
-        node_id = 0;
-    }
-    if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
-        cs->numa_node = node_id;
-    } else if (cs->numa_node != node_id) {
-            error_setg(errp, "node-id %d must match numa node specified"
-                "with -numa option for cpu-index %d",
-                cs->numa_node, cs->cpu_index);
-            return;
-    }
+    numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1279..94563cd8f5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2922,11 +2922,9 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
-    sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
     char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
     const char *type = object_get_typename(OBJECT(dev));
     CPUArchId *core_slot;
-    int node_id;
     int index;
 
     if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
@@ -2967,20 +2965,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    node_id = core_slot->props.node_id;
-    if (!core_slot->props.has_node_id) {
-        /* by default CPUState::numa_node was 0 if it's not set via CLI
-         * keep it this way for now but in future we probably should
-         * refuse to start up with incomplete numa mapping */
-        node_id = 0;
-    }
-    if (sc->node_id == CPU_UNSET_NUMA_NODE_ID) {
-        sc->node_id = node_id;
-    } else if (sc->node_id != node_id) {
-        error_setg(&local_err, "node-id %d must match numa node specified"
-            "with -numa option for cpu-index %d", sc->node_id, cc->core_id);
-        goto out;
-    }
+    numa_cpu_pre_plug(core_slot, dev, &local_err);
 
 out:
     g_free(base_core_type);
diff --git a/numa.c b/numa.c
index be50c62aa9..1c35a79b57 100644
--- a/numa.c
+++ b/numa.c
@@ -533,6 +533,29 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
+{
+    int mapped_node_id; /* set by -numa option */
+    int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
+
+    /* by default CPUState::numa_node was 0 if it wasn't set explicitly
+     * TODO: make it error when incomplete numa mapping support is removed
+     */
+    mapped_node_id = slot->props.node_id;
+    if (!slot->props.has_node_id) {
+        mapped_node_id = 0;
+    }
+
+    if (node_id == CPU_UNSET_NUMA_NODE_ID) {
+        /* due to bug in libvirt, it doesn't pass node-id from props on
+         * device_add as expected, so we have to fix it up here */
+        object_property_set_int(OBJECT(dev), mapped_node_id, "node-id", errp);
+    } else if (node_id != mapped_node_id) {
+        error_setg(errp, "node-id=%d must match numa node specified "
+                   "with -numa option", node_id);
+    }
+}
+
 static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                            const char *name,
                                            uint64_t ram_size)
-- 
2.11.0.259.g40922b1
