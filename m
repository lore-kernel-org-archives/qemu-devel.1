Received: from eggs.gnu.org ([2001:4830:134:3::10]:49838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVHRE-0002JD-SU
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVHRB-0002JC-10
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:12:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 23:11:36 +1000
Message-Id: <20170712131140.18146-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170712131140.18146-1-david@gibson.dropbear.id.au>
References: <20170712131140.18146-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv7 1/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org, danielhb@linux.vnet.ibm.com
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
extension to allow run time resizing of a guest's hash page table.  It
also adds a new machine property for controlling whether this new
facility is available.

For now we only allow resizing with TCG, allowing it with KVM will require
kernel changes as well.

Finally, it adds a new string to the hypertas property in the device
tree, advertising to the guest the availability of the HPT resizing
hypercalls.  This is a tentative suggested value, and would need to be
standardized by PAPR before being merged.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   | 36 ++++++++++++++++++++++++
 hw/ppc/trace-events    |  2 ++
 include/hw/ppc/spapr.h | 11 ++++++++
 target/ppc/kvm.c       | 13 +++++++++
 target/ppc/kvm_ppc.h   |  5 ++++
 6 files changed, 142 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 12b3f09..e95c2ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -874,6 +874,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
         add_str(hypertas, "hcall-multi-tce");
     }
+
+    if (spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) {
+        add_str(hypertas, "hcall-hpt-resize");
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
                      hypertas->str, hypertas->len));
     g_string_free(hypertas, TRUE);
@@ -2148,12 +2153,41 @@ static void ppc_spapr_init(MachineState *machine)
     hwaddr node0_size = spapr_node0_size();
     long load_limit, fw_size;
     char *filename;
+    Error *resize_hpt_err = NULL;
 
     msi_nonbroken = true;
 
     QLIST_INIT(&spapr->phbs);
     QTAILQ_INIT(&spapr->pending_dimm_unplugs);
 
+    /* Check HPT resizing availability */
+    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
+    if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
+        /*
+         * If the user explicitly requested a mode we should either
+         * supply it, or fail completely (which we do below).  But if
+         * it's not set explicitly, we reset our mode to something
+         * that works
+         */
+        if (resize_hpt_err) {
+            spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
+            error_free(resize_hpt_err);
+            resize_hpt_err = NULL;
+        } else {
+            spapr->resize_hpt = smc->resize_hpt_default;
+        }
+    }
+
+    assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
+
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
+        /*
+         * User requested HPT resize, but this host can't supply it.  Bail out
+         */
+        error_report_err(resize_hpt_err);
+        exit(1);
+    }
+
     /* Allocate RMA if necessary */
     rma_alloc_size = kvmppc_alloc_rma(&rma);
 
@@ -2579,6 +2613,40 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
     spapr->use_hotplug_event_source = value;
 }
 
+static char *spapr_get_resize_hpt(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    switch (spapr->resize_hpt) {
+    case SPAPR_RESIZE_HPT_DEFAULT:
+        return g_strdup("default");
+    case SPAPR_RESIZE_HPT_DISABLED:
+        return g_strdup("disabled");
+    case SPAPR_RESIZE_HPT_ENABLED:
+        return g_strdup("enabled");
+    case SPAPR_RESIZE_HPT_REQUIRED:
+        return g_strdup("required");
+    }
+    assert(0);
+}
+
+static void spapr_set_resize_hpt(Object *obj, const char *value, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    if (strcmp(value, "default") == 0) {
+        spapr->resize_hpt = SPAPR_RESIZE_HPT_DEFAULT;
+    } else if (strcmp(value, "disabled") == 0) {
+        spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
+    } else if (strcmp(value, "enabled") == 0) {
+        spapr->resize_hpt = SPAPR_RESIZE_HPT_ENABLED;
+    } else if (strcmp(value, "required") == 0) {
+        spapr->resize_hpt = SPAPR_RESIZE_HPT_REQUIRED;
+    } else {
+        error_setg(errp, "Bad value for \"resize-hpt\" property");
+    }
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -2603,6 +2671,12 @@ static void spapr_machine_initfn(Object *obj)
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
                             "Maximum permitted CPU compatibility mode",
                             &error_fatal);
+
+    object_property_add_str(obj, "resize-hpt",
+                            spapr_get_resize_hpt, spapr_set_resize_hpt, NULL);
+    object_property_set_description(obj, "resize-hpt",
+                                    "Resizing of the Hash Page Table (enabled, disabled, required)",
+                                    NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
@@ -3397,6 +3471,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
     mc->has_hotpluggable_cpus = true;
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8624ce8..6ea8fa7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -354,6 +354,38 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
+                                         sPAPRMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong shift = args[1];
+
+    if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
+        return H_AUTHORITY;
+    }
+
+    trace_spapr_h_resize_hpt_prepare(flags, shift);
+    return H_HARDWARE;
+}
+
+static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
+                                        sPAPRMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong shift = args[1];
+
+    if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
+        return H_AUTHORITY;
+    }
+
+    trace_spapr_h_resize_hpt_commit(flags, shift);
+    return H_HARDWARE;
+}
+
 static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                 target_ulong opcode, target_ulong *args)
 {
@@ -1246,6 +1278,10 @@ static void hypercall_register_types(void)
     /* hcall-bulk */
     spapr_register_hypercall(H_BULK_REMOVE, h_bulk_remove);
 
+    /* hcall-hpt-resize */
+    spapr_register_hypercall(H_RESIZE_HPT_PREPARE, h_resize_hpt_prepare);
+    spapr_register_hypercall(H_RESIZE_HPT_COMMIT, h_resize_hpt_commit);
+
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 3e8e3cf..dae17d4 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -16,6 +16,8 @@ spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 # hw/ppc/spapr_hcall.c
 spapr_cas_pvr_try(uint32_t pvr) "%x"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%x, explicit_match=%u, new=%x"
+spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 
 # hw/ppc/spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 45de983..32bf550 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -42,6 +42,13 @@ typedef struct sPAPRMachineClass sPAPRMachineClass;
 #define SPAPR_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
 
+typedef enum {
+    SPAPR_RESIZE_HPT_DEFAULT = 0,
+    SPAPR_RESIZE_HPT_DISABLED,
+    SPAPR_RESIZE_HPT_ENABLED,
+    SPAPR_RESIZE_HPT_REQUIRED,
+} sPAPRResizeHPT;
+
 /**
  * sPAPRMachineClass:
  */
@@ -58,6 +65,7 @@ struct sPAPRMachineClass {
                           uint64_t *buid, hwaddr *pio, 
                           hwaddr *mmio32, hwaddr *mmio64,
                           unsigned n_dma, uint32_t *liobns, Error **errp);
+    sPAPRResizeHPT resize_hpt_default;
 };
 
 /**
@@ -73,6 +81,7 @@ struct sPAPRMachineState {
     ICSState *ics;
     sPAPRRTCState rtc;
 
+    sPAPRResizeHPT resize_hpt;
     void *htab;
     uint32_t htab_shift;
     uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_TABLE */
@@ -367,6 +376,8 @@ struct sPAPRMachineState {
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
+#define H_RESIZE_HPT_PREPARE    0x36C
+#define H_RESIZE_HPT_COMMIT     0x370
 #define H_CLEAN_SLB             0x374
 #define H_INVALIDATE_PID        0x378
 #define H_REGISTER_PROC_TBL     0x37C
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f7a7ea5..8bafd1e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -22,6 +22,7 @@
 #include <linux/kvm.h>
 
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "cpu-models.h"
@@ -2709,3 +2710,15 @@ int kvmppc_enable_hwrng(void)
 
     return kvmppc_enable_hcall(kvm_state, H_RANDOM);
 }
+
+void kvmppc_check_papr_resize_hpt(Error **errp)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    /* TODO: Check for resize-capable KVM implementations */
+
+    error_setg(errp,
+               "Hash page table resizing not available with this KVM version");
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index eab7c8f..9be706c 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -63,6 +63,7 @@ bool kvmppc_has_cap_mmu_hash_v3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
+void kvmppc_check_papr_resize_hpt(Error **errp);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
@@ -297,6 +298,10 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return NULL;
 }
 
+static inline void kvmppc_check_papr_resize_hpt(Error **errp)
+{
+    return;
+}
 #endif
 
 #ifndef CONFIG_KVM
-- 
2.9.4
