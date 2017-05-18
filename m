Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGVC-0003Ql-Mp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGVB-00027c-Im
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 May 2017 10:09:29 +0200
Message-Id: <1495094971-177754-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] numa: consolidate cpu_preplug
 fixups/checks for pc/arm/spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  1 +
 hw/arm/virt.c         | 16 ++--------------
 hw/i386/pc.c          | 17 +----------------
 hw/ppc/spapr.c        | 17 +----------------
 numa.c                | 22 ++++++++++++++++++++++
 5 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 7ffde5b..610eece 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -35,4 +35,5 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
+void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c7c8159..ce676df 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1351,7 +1351,6 @@ static void machvirt_init(MachineState *machine)
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
         CPUState *cs;
-        int node_id;
 
         if (n >= smp_cpus) {
             break;
@@ -1364,19 +1363,8 @@ static void machvirt_init(MachineState *machine)
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
index e36a375..d83c158 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1895,7 +1895,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
                             DeviceState *dev, Error **errp)
 {
     int idx;
-    int node_id;
     CPUState *cs;
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
@@ -1986,21 +1985,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
index 0980d73..c7fee8b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2831,11 +2831,9 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -2870,20 +2868,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index ca73145..0115bfd 100644
--- a/numa.c
+++ b/numa.c
@@ -534,6 +534,28 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
+{
+    int node_id = object_property_get_int(OBJECT(dev), "node-id", errp);
+
+    if (node_id == CPU_UNSET_NUMA_NODE_ID) {
+        /* by default CPUState::numa_node was 0 if it wasn't set explicitly
+         * TODO: make it error when incomplete numa mapping support is removed
+         */
+        node_id = 0;
+
+        /* due to bug in libvirt, it doesn't pass node-id from props on
+         * device_add as expected, so we have to fix it up here */
+        if (slot->props.has_node_id) {
+            node_id = slot->props.node_id;
+        }
+        object_property_set_int(OBJECT(dev), node_id, "node-id", errp);
+    } else if (node_id != slot->props.node_id) {
+        error_setg(errp, "node-id=%d must match numa node specified "
+                   "with -numa option", node_id);
+    }
+}
+
 static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                            const char *name,
                                            uint64_t ram_size)
-- 
2.7.4
