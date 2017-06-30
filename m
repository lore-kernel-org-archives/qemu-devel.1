Received: from eggs.gnu.org ([2001:4830:134:3::10]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRl-0008Tq-G2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0007ub-51
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:22 +1000
Message-Id: <20170630104632.27942-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/21] spapr: fix migration of ICPState objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
sPAPRCPUCore") moved ICPState objects from the machine to CPU cores.
This is an improvement since we no longer allocate ICPState objects
that will never be used. But it has the side-effect of breaking
migration of older machine types from older QEMU versions.

This patch allows spapr to register dummy "icp/server" entries to vmstate.
These entries use a dedicated VMStateDescription that can swallow and
discard state of an incoming migration stream, and that don't send anything
on outgoing migration.

As for real ICPState objects, the instance_id is the cpu_index of the
corresponding vCPU, which happens to be equal to the generated instance_id
of older machine types.

The machine can unregister/register these entries when CPUs are dynamically
plugged/unplugged.

This is only available for pseries-2.9 and older machines, thanks to a
compat property.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6c276af..ef944f7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -127,9 +127,49 @@ error:
     return NULL;
 }
 
+static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
+{
+    /* Dummy entries correspond to unused ICPState objects in older QEMUs,
+     * and newer QEMUs don't even have them. In both cases, we don't want
+     * to send anything on the wire.
+     */
+    return false;
+}
+
+static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
+    .name = "icp/server",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pre_2_10_vmstate_dummy_icp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UNUSED(4), /* uint32_t xirr */
+        VMSTATE_UNUSED(1), /* uint8_t pending_priority */
+        VMSTATE_UNUSED(1), /* uint8_t mfrr */
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void pre_2_10_vmstate_register_dummy_icp(int i)
+{
+    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
+                     (void *)(uintptr_t) i);
+}
+
+static void pre_2_10_vmstate_unregister_dummy_icp(int i)
+{
+    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
+                       (void *)(uintptr_t) i);
+}
+
+static inline int xics_max_server_number(void)
+{
+    return DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);
+}
+
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
@@ -151,6 +191,17 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
             return;
         }
     }
+
+    if (smc->pre_2_10_has_unused_icps) {
+        int i;
+
+        for (i = 0; i < xics_max_server_number(); i++) {
+            /* Dummy entries get deregistered when real ICPState objects
+             * are registered during CPU core hotplug.
+             */
+            pre_2_10_vmstate_register_dummy_icp(i);
+        }
+    }
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
@@ -979,7 +1030,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     void *fdt;
     sPAPRPHBState *phb;
     char *buf;
-    int smt = kvmppc_smt_threads();
 
     fdt = g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -1019,7 +1069,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDLE_XICP);
+    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2845,9 +2895,24 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
+    if (smc->pre_2_10_has_unused_icps) {
+        sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
+        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
+        const char *typename = object_class_get_name(scc->cpu_class);
+        size_t size = object_type_get_instance_size(typename);
+        int i;
+
+        for (i = 0; i < cc->nr_threads; i++) {
+            CPUState *cs = CPU(sc->threads + i * size);
+
+            pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
+        }
+    }
+
     assert(core_slot);
     core_slot->cpu = NULL;
     object_unparent(OBJECT(dev));
@@ -2899,6 +2964,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(spapr);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
     CPUState *cs = CPU(core->threads);
@@ -2955,6 +3021,21 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         }
     }
     core_slot->cpu = OBJECT(dev);
+
+    if (smc->pre_2_10_has_unused_icps) {
+        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
+        const char *typename = object_class_get_name(scc->cpu_class);
+        size_t size = object_type_get_instance_size(typename);
+        int i;
+
+        for (i = 0; i < cc->nr_threads; i++) {
+            sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
+            void *obj = sc->threads + i * size;
+
+            cs = CPU(obj);
+            pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
+        }
+    }
 }
 
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -3409,9 +3490,12 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
 
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
     mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    smc->pre_2_10_has_unused_icps = true;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2ddb052..a66bbac 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -53,6 +53,7 @@ struct sPAPRMachineClass {
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
+    bool pre_2_10_has_unused_icps;
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
                           hwaddr *mmio32, hwaddr *mmio64,
-- 
2.9.4
