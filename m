Received: from eggs.gnu.org ([2001:4830:134:3::10]:39352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavn-0001t6-5i
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavl-0003vP-BL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:50:07 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 11 Dec 2018 16:49:25 +1100
Message-Id: <20181211054926.56717-3-aik@ozlabs.ru>
In-Reply-To: <20181211054926.56717-1-aik@ozlabs.ru>
References: <20181211054926.56717-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 2/3] ppc/spapr: Receive and store device
 tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
 hw/ppc/spapr.c         | 31 ++++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  3 +++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1987640..86c90df 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -102,6 +102,7 @@ struct sPAPRMachineClass {
 
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
+    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
@@ -138,6 +139,9 @@ struct sPAPRMachineState {
     int vrma_adjust;
     ssize_t rtas_size;
     void *rtas_blob;
+    uint32_t fdt_size;
+    uint32_t fdt_initial_size;
+    void *fdt_blob;
     long kernel_size;
     bool kernel_le;
     uint32_t initrd_base;
@@ -464,7 +468,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
 
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8a18250..984bf32 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1654,7 +1654,10 @@ static void spapr_machine_reset(void)
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
@@ -1908,6 +1911,27 @@ static const VMStateDescription vmstate_spapr_irq_map = {
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
@@ -1937,6 +1961,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_ibs,
         &vmstate_spapr_irq_map,
         &vmstate_spapr_cap_nested_kvm_hv,
+        &vmstate_spapr_dtb,
         NULL
     }
 };
@@ -3871,6 +3896,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = spapr_machine_device_unplug;
 
     smc->dr_lmb_enabled = true;
+    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
@@ -3981,8 +4007,11 @@ static void spapr_machine_3_1_instance_options(MachineState *machine)
 
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_4_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
+    smc->update_dt_enabled = false;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d0..dfd3cf3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1717,6 +1717,46 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
 
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
+    void *fdt;
+
+    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    cb = fdt32_to_cpu(hdr.totalsize);
+
+    if (!smc->update_dt_enabled) {
+        return H_SUCCESS;
+    }
+
+    /* Check that the fdt did not grow out of proportion */
+    if (cb > spapr->fdt_initial_size * 2) {
+        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
+            fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }
+
+    fdt = g_malloc0(cb);
+    cpu_physical_memory_read(dt, fdt, cb);
+
+    /* Check the fdt consostency */
+    if (fdt_check_full(fdt, cb)) {
+        trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
+            fdt32_to_cpu(hdr.magic));
+        return H_PARAMETER;
+    }
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = cb;
+    spapr->fdt_blob = fdt;
+    trace_spapr_update_dt(cb);
 
     return H_SUCCESS;
 }
@@ -1822,6 +1862,8 @@ static void hypercall_register_types(void)
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
+
+    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index dc5e65a..0af155e 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -22,6 +22,9 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_update_dt(unsigned cb) "New blob %u bytes"
+spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
+spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-- 
2.17.1
