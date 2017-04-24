Received: from eggs.gnu.org ([2001:4830:134:3::10]:55995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI1-0001J0-FB
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI0-0003JT-6a
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:46 +1000
Message-Id: <20170424015927.8933-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/47] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
information from KVM and present the page encodings in the device tree
under ibm,processor-radix-AP-encodings. This provides page size
information to the guest which is necessary for it to use radix mode.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
[dwg: Compile fix for 32-bit targets, style nit fix]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 13 +++++++++++++
 include/sysemu/kvm.h |  1 +
 target/ppc/cpu-qom.h |  1 +
 target/ppc/cpu.h     |  4 ++++
 target/ppc/kvm.c     | 29 +++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3edc3dd..ea247e6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -459,6 +459,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     sPAPRDRConnector *drc;
     sPAPRDRConnectorClass *drck;
     int drc_index;
+    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
+    int i;
 
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
     if (drc) {
@@ -544,6 +546,17 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
+
+    if (pcc->radix_page_info) {
+        for (i = 0; i < pcc->radix_page_info->count; i++) {
+            radix_AP_encodings[i] =
+                cpu_to_be32(pcc->radix_page_info->entries[i]);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
+                          radix_AP_encodings,
+                          pcc->radix_page_info->count *
+                          sizeof(radix_AP_encodings[0]))));
+    }
 }
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 24281fc..5cc83f2 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -527,5 +527,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  * Returns: 0 on success, or a negative errno on failure.
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
+struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
 #endif
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 81500e5..d0cf6ca 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -197,6 +197,7 @@ typedef struct PowerPCCPUClass {
     int bfd_mach;
     uint32_t l1_dcache_size, l1_icache_size;
     const struct ppc_segment_page_sizes *sps;
+    struct ppc_radix_page_info *radix_page_info;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int mmu_idx);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5ee33b3..cacdd0a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -943,6 +943,10 @@ struct ppc_segment_page_sizes {
     struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
 };
 
+struct ppc_radix_page_info {
+    uint32_t count;
+    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
+};
 
 /*****************************************************************************/
 /* The whole PowerPC CPU context */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79b90a6..9dc2f7f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -50,6 +50,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #endif
 #include "elf.h"
+#include "sysemu/kvm_int.h"
 
 //#define DEBUG_KVM
 
@@ -333,6 +334,30 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
     kvm_get_fallback_smmu_info(cpu, info);
 }
 
+struct ppc_radix_page_info *kvm_get_radix_page_info(void)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+    struct ppc_radix_page_info *radix_page_info;
+    struct kvm_ppc_rmmu_info rmmu_info;
+    int i;
+
+    if (!kvm_check_extension(s, KVM_CAP_PPC_MMU_RADIX)) {
+        return NULL;
+    }
+    if (kvm_vm_ioctl(s, KVM_PPC_GET_RMMU_INFO, &rmmu_info)) {
+        return NULL;
+    }
+    radix_page_info = g_malloc0(sizeof(*radix_page_info));
+    radix_page_info->count = 0;
+    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
+        if (rmmu_info.ap_encodings[i]) {
+            radix_page_info->entries[i] = rmmu_info.ap_encodings[i];
+            radix_page_info->count++;
+        }
+    }
+    return radix_page_info;
+}
+
 static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
 {
     if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
@@ -2303,6 +2328,10 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
     if (icache_size != -1) {
         pcc->l1_icache_size = icache_size;
     }
+
+#if defined(TARGET_PPC64)
+    pcc->radix_page_info = kvm_get_radix_page_info();
+#endif /* defined(TARGET_PPC64) */
 }
 
 bool kvmppc_has_cap_epr(void)
-- 
2.9.3
