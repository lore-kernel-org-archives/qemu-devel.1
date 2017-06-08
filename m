Received: from eggs.gnu.org ([2001:4830:134:3::10]:48358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxiq-0006dI-2X
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxim-0007Yk-T7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:36 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:52732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIxim-0007YS-JP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:32 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0B1423EAD8
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:43:31 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 08 Jun 2017 15:43:27 +0200
Message-ID: <149692940719.12119.1126399233332975562.stgit@bahia>
In-Reply-To: <149692935202.12119.3614006195497745877.stgit@bahia>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 6/6] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

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
---
v4: - dropped paranoid g_assert()s
---
 hw/ppc/spapr.c         |   86 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr.h |    2 +
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2951d7618d6..1379986c0c7b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -125,9 +125,50 @@ error:
     return NULL;
 }
 
+static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
+{
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
+static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachineState *spapr, int i)
+{
+    bool *flag = &spapr->pre_2_10_ignore_icp[i];
+
+    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp, flag);
+    *flag = true;
+}
+
+static void pre_2_10_vmstate_unregister_dummy_icp(sPAPRMachineState *spapr,
+                                                  int i)
+{
+    bool *flag = &spapr->pre_2_10_ignore_icp[i];
+
+    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp, flag);
+    *flag = false;
+}
+
+static inline int xics_nr_servers(void)
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
@@ -149,6 +190,15 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
             return;
         }
     }
+
+    if (smc->pre_2_10_has_unused_icps) {
+        int i;
+
+        spapr->pre_2_10_ignore_icp = g_malloc(xics_nr_servers());
+        for (i = 0; i < xics_nr_servers(); i++) {
+            pre_2_10_vmstate_register_dummy_icp(spapr, i);
+        }
+    }
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
@@ -977,7 +1027,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     void *fdt;
     sPAPRPHBState *phb;
     char *buf;
-    int smt = kvmppc_smt_threads();
 
     fdt = g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -1017,7 +1066,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDLE_XICP);
+    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2803,9 +2852,24 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    sPAPRMachineState *spapr = SPAPR_MACHINE(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
+    if (spapr->pre_2_10_ignore_icp) {
+        sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
+        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
+        const char *typename = object_class_get_name(scc->cpu_class);
+        size_t size = object_type_get_instance_size(typename);
+        int i;
+
+        for (i = 0; i < cc->nr_threads; i++) {
+            CPUState *cs = CPU(sc->threads + i * size);
+
+            pre_2_10_vmstate_register_dummy_icp(spapr, cs->cpu_index);
+        }
+    }
+
     assert(core_slot);
     core_slot->cpu = NULL;
     object_unparent(OBJECT(dev));
@@ -2913,6 +2977,21 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         }
     }
     core_slot->cpu = OBJECT(dev);
+
+    if (spapr->pre_2_10_ignore_icp) {
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
+            pre_2_10_vmstate_unregister_dummy_icp(spapr, cs->cpu_index);
+        }
+    }
 }
 
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -3362,9 +3441,12 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
 
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
index f973b0284596..64382623199d 100644
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
@@ -90,6 +91,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
+    bool *pre_2_10_ignore_icp;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
