Received: from eggs.gnu.org ([2001:4830:134:3::10]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gKZNG-0002Il-09
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gKZNB-0001uJ-H9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:44:45 -0500
Received: from [107.173.13.209] (port=33936 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gKZNB-0001re-4A
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:44:41 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  8 Nov 2018 12:44:06 +1100
Message-Id: <20181108014406.29818-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] ppc/spapr: Receive and store device tree
 blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

SLOF receives a device tree and updates it with various properties
before switching to the guest kernel and QEMU is not aware of any changes
made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
sense to pass the SLOF final device tree to QEMU to let it implement
RTAS related tasks better, such as PCI host bus adapter hotplug.

Specifially, now QEMU can find out the actual XICS phandle (for PHB
hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
assisted NMI - FWNMI).

This stores the initial DT blob in the sPAPR machine and replaces it
in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.

This adds an @update_dt_enabled machine property to allow backward
migration.

SLOF already has a hypercall since
https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  7 ++++++-
 hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  2 ++
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad4d7cfd97..f5dcaf44cb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -100,6 +100,7 @@ struct sPAPRMachineClass {
 
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
+    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
@@ -136,6 +137,9 @@ struct sPAPRMachineState {
     int vrma_adjust;
     ssize_t rtas_size;
     void *rtas_blob;
+    uint32_t fdt_size;
+    uint32_t fdt_initial_size;
+    void *fdt_blob;
     long kernel_size;
     bool kernel_le;
     uint32_t initrd_base;
@@ -462,7 +466,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
 
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c08130facb..5e2d4d211c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
     /* Load the fdt */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
-    g_free(fdt);
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = fdt_totalsize(fdt);
+    spapr->fdt_initial_size = spapr->fdt_size;
+    spapr->fdt_blob = fdt;
 
     /* Set up the entry state */
     spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
@@ -1887,6 +1890,27 @@ static const VMStateDescription vmstate_spapr_irq_map = {
     },
 };
 
+static bool spapr_dtb_needed(void *opaque)
+{
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
+
+    return smc->update_dt_enabled;
+}
+
+static const VMStateDescription vmstate_spapr_dtb = {
+    .name = "spapr_dtb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_dtb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
+        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NULL,
+                                     fdt_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -1915,6 +1939,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
         &vmstate_spapr_irq_map,
+        &vmstate_spapr_dtb,
         NULL
     }
 };
@@ -3849,6 +3874,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = spapr_machine_device_unplug;
 
     smc->dr_lmb_enabled = true;
+    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
@@ -3965,6 +3991,7 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
 
     smc->legacy_irq_allocation = true;
     smc->irq = &spapr_irq_xics_legacy;
+    smc->update_dt_enabled = false;
 }
 
 DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f..d5833f3f8d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1717,6 +1717,36 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
 
     args[0] = characteristics;
     args[1] = behaviour;
+    return H_SUCCESS;
+}
+
+static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                target_ulong opcode, target_ulong *args)
+{
+    target_ulong dt = ppc64_phys_to_real(args[0]);
+    struct fdt_header hdr = { 0 };
+    unsigned cb;
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+
+    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    cb = fdt32_to_cpu(hdr.totalsize);
+
+    if (fdt_check_full(spapr->fdt_blob, cb)) {
+        trace_spapr_update_dt_failed(spapr->fdt_initial_size, cb,
+            fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }
+
+    if (!smc->update_dt_enabled) {
+        return H_SUCCESS;
+    }
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = cb;
+    spapr->fdt_blob = g_malloc0(cb);
+    cpu_physical_memory_read(dt, spapr->fdt_blob, cb);
+
+    trace_spapr_update_dt(cb);
 
     return H_SUCCESS;
 }
@@ -1822,6 +1852,8 @@ static void hypercall_register_types(void)
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
+
+    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index dc5e65aee9..4432a5ce74 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -22,6 +22,8 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_update_dt(unsigned cb) "New blob %u bytes"
+spapr_update_dt_failed(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-- 
2.17.1
