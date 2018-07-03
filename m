Received: from eggs.gnu.org ([2001:4830:134:3::10]:40168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKf-00032T-G5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKa-0007A8-BQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:33 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:59 +1000
Message-Id: <20180703055804.13449-31-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 30/35] target/ppc/kvm: get rid of
 kvm_get_fallback_smmu_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Now that we're checking our MMU configuration is supported by KVM,
rather than adjusting it to KVM, it doesn't really make sense to
have a fallback for kvm_get_smmu_info(). If KVM is too old or buggy
to provide the details, we should rather treat this as an error.

This patch thus adds error reporting to kvm_get_smmu_info() and get
rid of the fallback code. QEMU will now terminate if KVM fails to
provide MMU details. This may break some very old setups, but the
simplification is worth the sacrifice.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 117 ++++++++---------------------------------------
 1 file changed, 20 insertions(+), 97 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4df4ff6cbf..b6000f12b9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -248,107 +248,25 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
 
 
 #if defined(TARGET_PPC64)
-static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
-                                       struct kvm_ppc_smmu_info *info)
+static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info,
+                              Error **errp)
 {
-    CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    int ret;
 
-    memset(info, 0, sizeof(*info));
-
-    /* We don't have the new KVM_PPC_GET_SMMU_INFO ioctl, so
-     * need to "guess" what the supported page sizes are.
-     *
-     * For that to work we make a few assumptions:
-     *
-     * - Check whether we are running "PR" KVM which only supports 4K
-     *   and 16M pages, but supports them regardless of the backing
-     *   store characteritics. We also don't support 1T segments.
-     *
-     *   This is safe as if HV KVM ever supports that capability or PR
-     *   KVM grows supports for more page/segment sizes, those versions
-     *   will have implemented KVM_CAP_PPC_GET_SMMU_INFO and thus we
-     *   will not hit this fallback
-     *
-     * - Else we are running HV KVM. This means we only support page
-     *   sizes that fit in the backing store. Additionally we only
-     *   advertize 64K pages if the processor is ARCH 2.06 and we assume
-     *   P7 encodings for the SLB and hash table. Here too, we assume
-     *   support for any newer processor will mean a kernel that
-     *   implements KVM_CAP_PPC_GET_SMMU_INFO and thus doesn't hit
-     *   this fallback.
-     */
-    if (kvmppc_is_pr(cs->kvm_state)) {
-        /* No flags */
-        info->flags = 0;
-        info->slb_size = 64;
-
-        /* Standard 4k base page size segment */
-        info->sps[0].page_shift = 12;
-        info->sps[0].slb_enc = 0;
-        info->sps[0].enc[0].page_shift = 12;
-        info->sps[0].enc[0].pte_enc = 0;
-
-        /* Standard 16M large page size segment */
-        info->sps[1].page_shift = 24;
-        info->sps[1].slb_enc = SLB_VSID_L;
-        info->sps[1].enc[0].page_shift = 24;
-        info->sps[1].enc[0].pte_enc = 0;
-    } else {
-        int i = 0;
-
-        /* HV KVM has backing store size restrictions */
-        info->flags = KVM_PPC_PAGE_SIZES_REAL;
-
-        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
-            info->flags |= KVM_PPC_1T_SEGMENTS;
-        }
-
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
-            info->slb_size = 32;
-        } else {
-            info->slb_size = 64;
-        }
-
-        /* Standard 4k base page size segment */
-        info->sps[i].page_shift = 12;
-        info->sps[i].slb_enc = 0;
-        info->sps[i].enc[0].page_shift = 12;
-        info->sps[i].enc[0].pte_enc = 0;
-        i++;
-
-        /* 64K on MMU 2.06 and later */
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
-            info->sps[i].page_shift = 16;
-            info->sps[i].slb_enc = 0x110;
-            info->sps[i].enc[0].page_shift = 16;
-            info->sps[i].enc[0].pte_enc = 1;
-            i++;
-        }
-
-        /* Standard 16M large page size segment */
-        info->sps[i].page_shift = 24;
-        info->sps[i].slb_enc = SLB_VSID_L;
-        info->sps[i].enc[0].page_shift = 24;
-        info->sps[i].enc[0].pte_enc = 0;
+    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
+        error_setg(errp, "KVM doesn't expose the MMU features it supports");
+        error_append_hint(errp, "Consider switching to a newer KVM\n");
+        return;
     }
-}
-
-static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
-{
-    CPUState *cs = CPU(cpu);
-    int ret;
 
-    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
-        ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
-        if (ret == 0) {
-            return;
-        }
+    ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
+    if (ret == 0) {
+        return;
     }
 
-    kvm_get_fallback_smmu_info(cpu, info);
+    error_setg_errno(errp, -ret,
+                     "KVM failed to provide the MMU features it supports");
 }
 
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
@@ -415,7 +333,7 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void)
         return false;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info);
+    kvm_get_smmu_info(cpu, &smmu_info, &error_fatal);
     return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
 }
 
@@ -423,13 +341,18 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
 {
     struct kvm_ppc_smmu_info smmu_info;
     int iq, ik, jq, jk;
+    Error *local_err = NULL;
 
     /* For now, we only have anything to check on hash64 MMUs */
     if (!cpu->hash64_opts || !kvm_enabled()) {
         return;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info);
+    kvm_get_smmu_info(cpu, &smmu_info, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
         && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
@@ -2168,7 +2091,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
 
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
-    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
+    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info, &error_fatal);
     rampagesize = qemu_getrampagesize();
     best_page_shift = 0;
 
-- 
2.17.1
