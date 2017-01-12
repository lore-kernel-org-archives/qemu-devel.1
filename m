Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjv-0002qj-An
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0006Op-EY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:35 +1100
Message-Id: <20170112020327.24882-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/67] pseries: Always use core objects for CPU
 construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

Currently the pseries machine has two paths for constructing CPUs.  On
newer machine type versions, which support cpu hotplug, it constructs
cpu core objects, which in turn construct CPU threads.  For older machine
versions it individually constructs the CPU threads.

This division is going to make some future changes to the cpu construction
harder, so this patch unifies them.  Now cpu core objects are always
created.  This requires some updates to allow core objects to be created
without a full complement of threads (since older versions allowed a
number of cpus not a multiple of the threads-per-core).  Likewise it needs
some changes to the cpu core hot/cold plug path so as not to choke on the
old machine types without hotplug support.

For good measure, we move the cpu construction to its own subfunction,
spapr_init_cpus().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          | 125 +++++++++++++++++++++++++++---------------------
 hw/ppc/spapr_cpu_core.c |  37 +++++++-------
 include/hw/ppc/spapr.h  |   1 -
 3 files changed, 90 insertions(+), 73 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 208ef7b..4869fce 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1753,11 +1753,80 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
     }
 }
 
+static void spapr_init_cpus(sPAPRMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    char *type = spapr_get_cpu_core_type(machine->cpu_model);
+    int smt = kvmppc_smt_threads();
+    int spapr_max_cores, spapr_cores;
+    int i;
+
+    if (!type) {
+        error_report("Unable to find sPAPR CPU Core definition");
+        exit(1);
+    }
+
+    if (mc->query_hotpluggable_cpus) {
+        if (smp_cpus % smp_threads) {
+            error_report("smp_cpus (%u) must be multiple of threads (%u)",
+                         smp_cpus, smp_threads);
+            exit(1);
+        }
+        if (max_cpus % smp_threads) {
+            error_report("max_cpus (%u) must be multiple of threads (%u)",
+                         max_cpus, smp_threads);
+            exit(1);
+        }
+
+        spapr_max_cores = max_cpus / smp_threads;
+        spapr_cores = smp_cpus / smp_threads;
+    } else {
+        if (max_cpus != smp_cpus) {
+            error_report("This machine version does not support CPU hotplug");
+            exit(1);
+        }
+
+        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
+        spapr_cores = spapr_max_cores;
+    }
+
+    spapr->cores = g_new0(Object *, spapr_max_cores);
+    for (i = 0; i < spapr_max_cores; i++) {
+        int core_id = i * smp_threads;
+
+        if (mc->query_hotpluggable_cpus) {
+            sPAPRDRConnector *drc =
+                spapr_dr_connector_new(OBJECT(spapr),
+                                       SPAPR_DR_CONNECTOR_TYPE_CPU,
+                                       (core_id / smp_threads) * smt);
+
+            qemu_register_reset(spapr_drc_reset, drc);
+        }
+
+        if (i < spapr_cores) {
+            Object *core  = object_new(type);
+            int nr_threads = smp_threads;
+
+            /* Handle the partially filled core for older machine types */
+            if ((i + 1) * smp_threads >= smp_cpus) {
+                nr_threads = smp_cpus - i * smp_threads;
+            }
+
+            object_property_set_int(core, nr_threads, "nr-threads",
+                                    &error_fatal);
+            object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
+                                    &error_fatal);
+            object_property_set_bool(core, true, "realized", &error_fatal);
+        }
+    }
+    g_free(type);
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void ppc_spapr_init(MachineState *machine)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -1772,21 +1841,6 @@ static void ppc_spapr_init(MachineState *machine)
     long load_limit, fw_size;
     char *filename;
     int smt = kvmppc_smt_threads();
-    int spapr_cores = smp_cpus / smp_threads;
-    int spapr_max_cores = max_cpus / smp_threads;
-
-    if (mc->query_hotpluggable_cpus) {
-        if (smp_cpus % smp_threads) {
-            error_report("smp_cpus (%u) must be multiple of threads (%u)",
-                         smp_cpus, smp_threads);
-            exit(1);
-        }
-        if (max_cpus % smp_threads) {
-            error_report("max_cpus (%u) must be multiple of threads (%u)",
-                         max_cpus, smp_threads);
-            exit(1);
-        }
-    }
 
     msi_nonbroken = true;
 
@@ -1866,44 +1920,7 @@ static void ppc_spapr_init(MachineState *machine)
 
     ppc_cpu_parse_features(machine->cpu_model);
 
-    if (mc->query_hotpluggable_cpus) {
-        char *type = spapr_get_cpu_core_type(machine->cpu_model);
-
-        if (type == NULL) {
-            error_report("Unable to find sPAPR CPU Core definition");
-            exit(1);
-        }
-
-        spapr->cores = g_new0(Object *, spapr_max_cores);
-        for (i = 0; i < spapr_max_cores; i++) {
-            int core_id = i * smp_threads;
-            sPAPRDRConnector *drc =
-                spapr_dr_connector_new(OBJECT(spapr),
-                                       SPAPR_DR_CONNECTOR_TYPE_CPU,
-                                       (core_id / smp_threads) * smt);
-
-            qemu_register_reset(spapr_drc_reset, drc);
-
-            if (i < spapr_cores) {
-                Object *core  = object_new(type);
-                object_property_set_int(core, smp_threads, "nr-threads",
-                                        &error_fatal);
-                object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
-                                        &error_fatal);
-                object_property_set_bool(core, true, "realized", &error_fatal);
-            }
-        }
-        g_free(type);
-    } else {
-        for (i = 0; i < smp_cpus; i++) {
-            PowerPCCPU *cpu = cpu_ppc_init(machine->cpu_model);
-            if (cpu == NULL) {
-                error_report("Unable to find PowerPC CPU definition");
-                exit(1);
-            }
-            spapr_cpu_init(spapr, cpu, &error_fatal);
-       }
-    }
+    spapr_init_cpus(spapr);
 
     if (kvm_enabled()) {
         /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel devices */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c18632b..f532689 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -46,7 +46,8 @@ static void spapr_cpu_destroy(PowerPCCPU *cpu)
     qemu_unregister_reset(spapr_cpu_reset, cpu);
 }
 
-void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu, Error **errp)
+static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+                           Error **errp)
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
@@ -166,11 +167,11 @@ void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                      Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(spapr);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
     CPUState *cs = CPU(core->threads);
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     Error *local_err = NULL;
     void *fdt = NULL;
     int fdt_offset = 0;
@@ -180,7 +181,7 @@ void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
     spapr->cores[index] = OBJECT(dev);
 
-    g_assert(drc);
+    g_assert(drc || !mc->query_hotpluggable_cpus);
 
     /*
      * Setup CPU DT entries only for hotplugged CPUs. For boot time or
@@ -190,13 +191,15 @@ void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
     }
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
-    if (local_err) {
-        g_free(fdt);
-        spapr->cores[index] = NULL;
-        error_propagate(errp, local_err);
-        return;
+    if (drc) {
+        sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
+        if (local_err) {
+            g_free(fdt);
+            spapr->cores[index] = NULL;
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
     if (dev->hotplugged) {
@@ -209,8 +212,11 @@ void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         /*
          * Set the right DRC states for cold plugged CPU.
          */
-        drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
-        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
+        if (drc) {
+            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
+            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
+        }
     }
 }
 
@@ -227,7 +233,7 @@ void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
     const char *type = object_get_typename(OBJECT(dev));
 
-    if (!mc->query_hotpluggable_cpus) {
+    if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
         error_setg(&local_err, "CPU hotplug not supported for this machine");
         goto out;
     }
@@ -237,11 +243,6 @@ void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    if (cc->nr_threads != smp_threads) {
-        error_setg(&local_err, "threads must be %d", smp_threads);
-        goto out;
-    }
-
     if (cc->core_id % smp_threads) {
         error_setg(&local_err, "invalid core id %d", cc->core_id);
         goto out;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd5bcf7..f8d444d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -614,7 +614,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
                                             uint32_t count, uint32_t index);
 void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
-void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu, Error **errp);
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
 
-- 
2.9.3
