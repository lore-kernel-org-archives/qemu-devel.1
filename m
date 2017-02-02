Received: from eggs.gnu.org ([2001:4830:134:3::10]:42318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZIuL-0006Oh-2x
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZIuJ-0001Uu-FJ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:02:45 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 Feb 2017 16:02:34 +0100
Message-Id: <1486047755-93584-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
References: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] spapr: move spapr_core_[foo]plug()
 callbacks close to machine code in spapr.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

spapr_core_pre_plug/spapr_core_plug/spapr_core_unplug() are managing
wiring CPU core into spapr machine state and not internal CPU core state.
So move them from spapr_cpu_core.c to spapr.c where other similar
(spapr_memory_[foo]plug()) callbacks are located, which also matches
x86 target practice.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/ppc/spapr_cpu_core.h |   6 --
 hw/ppc/spapr.c                  | 138 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c         | 138 ----------------------------------------
 3 files changed, 138 insertions(+), 144 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 50292f4..3c35665 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -34,12 +34,6 @@ typedef struct sPAPRCPUCoreClass {
     ObjectClass *cpu_class;
 } sPAPRCPUCoreClass;
 
-void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                         Error **errp);
 char *spapr_get_cpu_core_type(const char *model);
-void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                     Error **errp);
-void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                       Error **errp);
 void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7a..8c2efd8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2488,6 +2488,144 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
     return fdt;
 }
 
+static void spapr_core_release(DeviceState *dev, void *opaque)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUCore *cc = CPU_CORE(dev);
+
+    spapr->cores[cc->core_id / smp_threads] = NULL;
+    object_unparent(OBJECT(dev));
+}
+
+static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    CPUCore *cc = CPU_CORE(dev);
+    int smt = kvmppc_smt_threads();
+    int index = cc->core_id / smp_threads;
+    sPAPRDRConnector *drc =
+        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
+    sPAPRDRConnectorClass *drck;
+    Error *local_err = NULL;
+
+    if (index == 0) {
+        error_setg(errp, "Boot CPU core may not be unplugged");
+        return;
+    }
+
+    g_assert(drc);
+
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    spapr_hotplug_req_remove_by_index(drc);
+}
+
+static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(spapr);
+    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
+    CPUCore *cc = CPU_CORE(dev);
+    CPUState *cs = CPU(core->threads);
+    sPAPRDRConnector *drc;
+    Error *local_err = NULL;
+    void *fdt = NULL;
+    int fdt_offset = 0;
+    int index = cc->core_id / smp_threads;
+    int smt = kvmppc_smt_threads();
+
+    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
+    spapr->cores[index] = OBJECT(dev);
+
+    g_assert(drc || !mc->query_hotpluggable_cpus);
+
+    /*
+     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
+     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
+     */
+    if (dev->hotplugged) {
+        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
+    }
+
+    if (drc) {
+        sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
+        if (local_err) {
+            g_free(fdt);
+            spapr->cores[index] = NULL;
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    if (dev->hotplugged) {
+        /*
+         * Send hotplug notification interrupt to the guest only in case
+         * of hotplugged CPUs.
+         */
+        spapr_hotplug_req_add_by_index(drc);
+    } else {
+        /*
+         * Set the right DRC states for cold plugged CPU.
+         */
+        if (drc) {
+            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
+            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
+        }
+    }
+}
+
+static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
+{
+    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    int spapr_max_cores = max_cpus / smp_threads;
+    int index;
+    Error *local_err = NULL;
+    CPUCore *cc = CPU_CORE(dev);
+    char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
+    const char *type = object_get_typename(OBJECT(dev));
+
+    if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
+        error_setg(&local_err, "CPU hotplug not supported for this machine");
+        goto out;
+    }
+
+    if (strcmp(base_core_type, type)) {
+        error_setg(&local_err, "CPU core type should be %s", base_core_type);
+        goto out;
+    }
+
+    if (cc->core_id % smp_threads) {
+        error_setg(&local_err, "invalid core id %d", cc->core_id);
+        goto out;
+    }
+
+    index = cc->core_id / smp_threads;
+    if (index < 0 || index >= spapr_max_cores) {
+        error_setg(&local_err, "core id %d out of range", cc->core_id);
+        goto out;
+    }
+
+    if (spapr->cores[index]) {
+        error_setg(&local_err, "core %d already populated", cc->core_id);
+        goto out;
+    }
+
+out:
+    g_free(base_core_type);
+    error_propagate(errp, local_err);
+}
+
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b9e5f80..55cd045 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -109,15 +109,6 @@ char *spapr_get_cpu_core_type(const char *model)
     return core_type;
 }
 
-static void spapr_core_release(DeviceState *dev, void *opaque)
-{
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    CPUCore *cc = CPU_CORE(dev);
-
-    spapr->cores[cc->core_id / smp_threads] = NULL;
-    object_unparent(OBJECT(dev));
-}
-
 static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
@@ -140,135 +131,6 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
     g_free(sc->threads);
 }
 
-void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                       Error **errp)
-{
-    CPUCore *cc = CPU_CORE(dev);
-    int smt = kvmppc_smt_threads();
-    int index = cc->core_id / smp_threads;
-    sPAPRDRConnector *drc =
-        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
-    sPAPRDRConnectorClass *drck;
-    Error *local_err = NULL;
-
-    if (index == 0) {
-        error_setg(errp, "Boot CPU core may not be unplugged");
-        return;
-    }
-
-    g_assert(drc);
-
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    spapr_hotplug_req_remove_by_index(drc);
-}
-
-void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                     Error **errp)
-{
-    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(spapr);
-    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
-    CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs = CPU(core->threads);
-    sPAPRDRConnector *drc;
-    Error *local_err = NULL;
-    void *fdt = NULL;
-    int fdt_offset = 0;
-    int index = cc->core_id / smp_threads;
-    int smt = kvmppc_smt_threads();
-
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
-    spapr->cores[index] = OBJECT(dev);
-
-    g_assert(drc || !mc->query_hotpluggable_cpus);
-
-    /*
-     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
-     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
-     */
-    if (dev->hotplugged) {
-        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-    }
-
-    if (drc) {
-        sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
-        if (local_err) {
-            g_free(fdt);
-            spapr->cores[index] = NULL;
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
-    if (dev->hotplugged) {
-        /*
-         * Send hotplug notification interrupt to the guest only in case
-         * of hotplugged CPUs.
-         */
-        spapr_hotplug_req_add_by_index(drc);
-    } else {
-        /*
-         * Set the right DRC states for cold plugged CPU.
-         */
-        if (drc) {
-            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
-            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
-        }
-    }
-}
-
-void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                         Error **errp)
-{
-    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
-    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    int spapr_max_cores = max_cpus / smp_threads;
-    int index;
-    Error *local_err = NULL;
-    CPUCore *cc = CPU_CORE(dev);
-    char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
-    const char *type = object_get_typename(OBJECT(dev));
-
-    if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
-        error_setg(&local_err, "CPU hotplug not supported for this machine");
-        goto out;
-    }
-
-    if (strcmp(base_core_type, type)) {
-        error_setg(&local_err, "CPU core type should be %s", base_core_type);
-        goto out;
-    }
-
-    if (cc->core_id % smp_threads) {
-        error_setg(&local_err, "invalid core id %d", cc->core_id);
-        goto out;
-    }
-
-    index = cc->core_id / smp_threads;
-    if (index < 0 || index >= spapr_max_cores) {
-        error_setg(&local_err, "core id %d out of range", cc->core_id);
-        goto out;
-    }
-
-    if (spapr->cores[index]) {
-        error_setg(&local_err, "core %d already populated", cc->core_id);
-        goto out;
-    }
-
-out:
-    g_free(base_core_type);
-    error_propagate(errp, local_err);
-}
-
 static void spapr_cpu_core_realize_child(Object *child, Error **errp)
 {
     Error *local_err = NULL;
-- 
2.7.4
