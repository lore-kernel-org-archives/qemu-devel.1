Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR8-0002gb-JG
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR7-0005Zi-1K
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:34 -0400
From: Li Zhang <zhlcindy@gmail.com>
Date: Fri, 26 May 2017 17:21:07 +0800
Message-Id: <1495790468-23862-3-git-send-email-zhlcindy@gmail.com>
In-Reply-To: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] arm/virt: Refine code of machvirt_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Li Zhang <li.zhang@hxt-semitech.com>

From: Li Zhang <li.zhang@hxt-semitech.com>

This patch is to refine cpu related in machvirt_init and
add virt_new_cpu function which can be called by hot_add_cpu.

Signed-off-by: Li Zhang <li.zhang@hxt-semitech.com>
---
 hw/arm/virt.c | 231 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 128 insertions(+), 103 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 73c3cf7..31314c1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -110,6 +110,8 @@ static ARMPlatformBusSystemParams platform_bus_params;
 #define RAMLIMIT_GB 255
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
 
+static MemoryRegion *secure_sysmem;
+
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
  * 128MB..256MB is used for miscellaneous device I/O.
@@ -415,6 +417,116 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     }
 }
 
+static void virt_new_cpu(MachineState *ms, int id, Error **errp)
+{
+    const char *typename;
+    char **cpustr;
+    int node_id;
+
+    ObjectClass *oc;
+    CPUClass *cc;
+    CPUState *cs;
+    Object *cpuobj;
+    const CPUArchIdList *possible_cpus;
+
+    Error *err = NULL;
+    const char *cpu_model = ms->cpu_model;
+    MemoryRegion *sysmem = get_system_memory();
+
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(ms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    CPU_FOREACH(cs) {
+        if (cs->cpu_index == id) {
+            error_report("CPU %d has been created.", id);
+            return;
+        }
+    }
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    /* Separate the actual CPU model name from any appended features */
+    cpustr = g_strsplit(cpu_model, ",", 2);
+    if (!cpuname_valid(cpustr[0])) {
+        error_report("mach-virt: CPU %s not supported", cpustr[0]);
+        goto out;
+    }
+    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
+    if (!oc) {
+        error_report("Unable to find CPU definition");
+        goto out;
+    }
+
+    typename = object_class_get_name(oc);
+
+    cc = CPU_CLASS(oc);
+    cc->parse_features(typename, cpustr[1], &err);
+    if (err) {
+        error_report_err(err);
+        goto out;
+    }
+
+    cpuobj = object_new(typename);
+    object_property_set_int(cpuobj, possible_cpus->cpus[id].arch_id,
+                            "mp-affinity", NULL);
+    cs = CPU(cpuobj);
+    cs->cpu_index = id;
+
+    node_id = possible_cpus->cpus[cs->cpu_index].props.node_id;
+    if (!possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
+        /* by default CPUState::numa_node was 0 if it's not set via CLI
+         * keep it this way for now but in future we probably should
+         * refuse to start up with incomplete numa mapping */
+        node_id = 0;
+    }
+    if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
+        cs->numa_node = node_id;
+    } else {
+        /* CPU isn't device_add compatible yet, this shouldn't happen */
+        error_setg(&error_abort, "user set node-id not implemented");
+    }
+
+    if (!vms->secure) {
+        object_property_set_bool(cpuobj, false, "has_el3", NULL);
+    }
+
+    if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
+        object_property_set_bool(cpuobj, false, "has_el2", NULL);
+    }
+
+    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+        object_property_set_int(cpuobj, vms->psci_conduit,
+                                "psci-conduit", NULL);
+        /* Secondary CPUs start in PSCI powered-down state */
+        if (id > 0) {
+            object_property_set_bool(cpuobj, true, "start-powered-off", NULL);
+        }
+    }
+
+    if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
+        object_property_set_bool(cpuobj, false, "pmu", NULL);
+    }
+
+    if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
+                                "reset-cbar", &error_abort);
+    }
+
+    object_property_set_link(cpuobj, OBJECT(sysmem), "memory", &error_abort);
+
+    if (vms->secure) {
+        object_property_set_link(cpuobj, OBJECT(secure_sysmem),
+                                  "secure-memory", &error_abort);
+    }
+
+    object_property_set_int(cpuobj, id, "id", NULL);
+    object_property_set_bool(cpuobj, true, "realized", NULL);
+    object_unref(cpuobj);
+
+out:
+    g_strfreev(cpustr);
+    error_propagate(errp, err);
+}
+
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
@@ -1237,35 +1349,29 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    char **cpustr;
-    ObjectClass *oc;
-    const char *typename;
-    CPUClass *cc;
     Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
 
     if (!cpu_model) {
-        cpu_model = "cortex-a15";
+        cpu_model = kvm_enabled() ? "host" : "cortex-a15";
+        machine->cpu_model = cpu_model;
     }
 
     /* We can probe only here because during property set
      * KVM is not available yet
      */
+    if (!vms->gic_version && !kvm_enabled()) {
+        error_report("gic-version=host requires KVM");
+        exit(1);
+    }
     if (!vms->gic_version) {
-        if (!kvm_enabled()) {
-            error_report("gic-version=host requires KVM");
-            exit(1);
-        }
-
         vms->gic_version = kvm_arm_vgic_probe();
         if (!vms->gic_version) {
             error_report("Unable to determine GIC version supported by host");
@@ -1273,14 +1379,6 @@ static void machvirt_init(MachineState *machine)
         }
     }
 
-    /* Separate the actual CPU model name from any appended features */
-    cpustr = g_strsplit(cpu_model, ",", 2);
-
-    if (!cpuname_valid(cpustr[0])) {
-        error_report("mach-virt: CPU %s not supported", cpustr[0]);
-        exit(1);
-    }
-
     /* If we have an EL3 boot ROM then the assumption is that it will
      * implement PSCI itself, so disable QEMU's internal implementation
      * so it doesn't get in the way. Instead of starting secondary
@@ -1328,12 +1426,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->secure) {
-        if (kvm_enabled()) {
-            error_report("mach-virt: KVM does not support Security extensions");
-            exit(1);
-        }
+    if (vms->secure && kvm_enabled()) {
+        error_report("mach-virt: KVM does not support Security extensions");
+        exit(1);
+    }
 
+    if (vms->secure) {
         /* The Secure view of the world is the same as the NonSecure,
          * but with a few extra devices. Create it as a container region
          * containing the system memory at low priority; any secure-only
@@ -1347,91 +1445,18 @@ static void machvirt_init(MachineState *machine)
 
     create_fdt(vms);
 
-    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!oc) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
-    typename = object_class_get_name(oc);
-
-    /* convert -smp CPU options specified by the user into global props */
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < possible_cpus->len; n++) {
-        Object *cpuobj;
-        CPUState *cs;
-        int node_id;
-
         if (n >= smp_cpus) {
             break;
         }
-
-        cpuobj = object_new(typename);
-        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
-                                "mp-affinity", NULL);
-
-        cs = CPU(cpuobj);
-        cs->cpu_index = n;
-
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
-
-        if (!vms->secure) {
-            object_property_set_bool(cpuobj, false, "has_el3", NULL);
-        }
-
-        if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
-            object_property_set_bool(cpuobj, false, "has_el2", NULL);
-        }
-
-        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            object_property_set_int(cpuobj, vms->psci_conduit,
-                                    "psci-conduit", NULL);
-
-            /* Secondary CPUs start in PSCI powered-down state */
-            if (n > 0) {
-                object_property_set_bool(cpuobj, true,
-                                         "start-powered-off", NULL);
-            }
-        }
-
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
-            object_property_set_bool(cpuobj, false, "pmu", NULL);
-        }
-
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
-                                    "reset-cbar", &error_abort);
-        }
-
-        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
-                                 &error_abort);
-        if (vms->secure) {
-            object_property_set_link(cpuobj, OBJECT(secure_sysmem),
-                                     "secure-memory", &error_abort);
+        virt_new_cpu(machine, n, &err);
+        if (err) {
+            error_report("mach-virt: creating a new cpu failed.");
+            exit(1);
         }
-
-        object_property_set_bool(cpuobj, true, "realized", NULL);
-        object_unref(cpuobj);
     }
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
     fdt_add_psci_node(vms);
-- 
2.7.4
