Received: from eggs.gnu.org ([2001:4830:134:3::10]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3xp1-0003Ll-6t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 01:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e3xox-0003l1-W2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 01:20:15 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 16 Oct 2017 16:20:04 +1100
Message-Id: <20171016052004.31397-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

SLOF receives a device tree and updates it with various properties
before switching to the guest kernel and QEMU is not aware of any changes
made by SLOF. Since there is no real RTAS and QEMU implements it,
it makes sense to pass the SLOF device tree to QEMU so the latter could
implement RTAS related tasks better.

Specifially, now QEMU can find out the actual XICS phandle (for PHB
hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
assisted NMI - FWNMI).

This stores the initial DT blob in the sPAPR machine and replaces it
in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.

This implements a basic FDT header validity check of the new blob;
the new blob size should not increase more than twice since the reset.

This adds a machine property - update_dt_enabled - to allow backward
migration.

This requires SLOF update: "fdt: Pass the resulting device tree to QEMU".

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* store reset-time FDT blob size and compare the update size against it;
this disallows more than 2x increase between resets
* added some FDT header sanity checks
* implemented migration

---
I could store just a size of the QEMU's blob, or a tree, not sure
which one makes more sense here.

This allows up to 2 times blob increase. Not 1.5 just to avoid
float/double, just looks a bit ugly imho.
---
 include/hw/ppc/spapr.h |  7 ++++++-
 hw/ppc/spapr.c         | 31 ++++++++++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  2 ++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f564..a9ccc14823 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -60,6 +60,7 @@ struct sPAPRMachineClass {
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
+    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
     bool pre_2_10_has_unused_icps;
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
@@ -92,6 +93,9 @@ struct sPAPRMachineState {
     int vrma_adjust;
     ssize_t rtas_size;
     void *rtas_blob;
+    uint32_t fdt_size;
+    uint32_t fdt_initial_size;
+    void *fdt_blob;
     long kernel_size;
     bool kernel_le;
     uint32_t initrd_base;
@@ -400,7 +404,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
 
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff87f155d5..cb7bcc851e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1467,7 +1467,10 @@ static void ppc_spapr_reset(void)
     /* Load the fdt */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
-    g_free(fdt);
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = fdt_totalsize(fdt);
+    spapr->fdt_initial_size = spapr->fdt_size;
+    spapr->fdt_blob = fdt;
 
     /* Set up the entry state */
     first_ppc_cpu = POWERPC_CPU(first_cpu);
@@ -1675,6 +1678,27 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
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
@@ -1694,6 +1718,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_events,
+        &vmstate_spapr_dtb,
         NULL
     }
 };
@@ -3605,6 +3630,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
+    smc->update_dt_enabled = true;
     smc->tcg_default_cpu = "POWER8";
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
@@ -3703,7 +3729,10 @@ static void spapr_machine_2_10_instance_options(MachineState *machine)
 
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_11_class_options(mc);
+    smc->update_dt_enabled = false;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
 }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8d72bb7c1c..be3de41080 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1656,6 +1656,46 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
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
+    if (fdt_check_header(&hdr) ||
+        fdt32_to_cpu(hdr.boot_cpuid_phys) ||
+        fdt32_to_cpu(hdr.off_dt_struct) >= cb ||
+        fdt32_to_cpu(hdr.off_dt_strings) >= cb ||
+        fdt32_to_cpu(hdr.off_mem_rsvmap) >= cb ||
+        fdt32_to_cpu(hdr.totalsize) != fdt32_to_cpu(hdr.size_dt_strings) +
+                fdt32_to_cpu(hdr.size_dt_struct) +
+                sizeof(struct fdt_reserve_entry) +
+                sizeof(hdr) ||
+        cb / spapr->fdt_initial_size > 2) {
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
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1753,6 +1793,8 @@ static void hypercall_register_types(void)
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
+
+    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4a6a6490fa..60ee4e3a4b 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -18,6 +18,8 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_update_dt(unsigned cb) "New blob %u bytes"
+spapr_update_dt_failed(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-- 
2.11.0
