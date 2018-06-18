Received: from eggs.gnu.org ([2001:4830:134:3::10]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm3-0008OF-H7
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm1-0001Re-Sh
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:36:06 +1000
Message-Id: <20180618063606.2513-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 9/9] spapr: Don't rewrite mmu capabilities in
 KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

Currently during KVM initialization on POWER, kvm_fixup_page_sizes()
rewrites a bunch of information in the cpu state to reflect the
capabilities of the host MMU and KVM.  This overwrites the information
that's already there reflecting how the TCG implementation of the MMU will
operate.

This means that we can get guest-visibly different behaviour between KVM
and TCG (and between different KVM implementations).  That's bad.  It also
prevents migration between KVM and TCG.

The pseries machine type now has filtering of the pagesizes it allows the
guest to use which means it can present a consistent model of the MMU
across all accelerators.

So, we can now replace kvm_fixup_page_sizes() with kvm_check_mmu() which
merely verifies that the expected cpu model can be faithfully handled by
KVM, rather than updating the cpu model to match KVM.

We call kvm_check_mmu() from the spapr cpu reset code.  This is a hack:
conceptually it makes more sense where fixup_page_sizes() was - in the KVM
cpu init path.  However, doing that would require moving the platform's
pagesize filtering much earlier, which would require a lot of work making
further adjustments.  There wouldn't be a lot of concrete point to doing
that, since the only KVM implementation which has the awkward MMU
restrictions is KVM HV, which can only work with an spapr guest anyway.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c     |   2 +-
 hw/ppc/spapr_cpu_core.c |   2 +
 target/ppc/kvm.c        | 133 ++++++++++++++++++++--------------------
 target/ppc/kvm_ppc.h    |   5 ++
 4 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0584c7c6ab..bc89a4cd70 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -308,7 +308,7 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
 void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
                           Error **errp)
 {
-    hwaddr maxpagesize = (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MPS]);
+    hwaddr maxpagesize = (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXPAGESIZE]);
 
     if (!kvmppc_hpt_needs_host_contiguous_pages()) {
         return;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 324623190d..4e8fa28796 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -78,6 +78,8 @@ static void spapr_cpu_reset(void *opaque)
     spapr_cpu->dtl_size = 0;
 
     spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
+
+    kvm_check_mmu(cpu, &error_fatal);
 }
 
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9cfbd388ad..b386335014 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -419,93 +419,93 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void)
     return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
 }
 
-static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
+void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
 {
-    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
-        return true;
-    }
-
-    return (1ul << shift) <= rampgsize;
-}
-
-static long max_cpu_page_size;
-
-static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
-{
-    static struct kvm_ppc_smmu_info smmu_info;
-    static bool has_smmu_info;
-    CPUPPCState *env = &cpu->env;
+    struct kvm_ppc_smmu_info smmu_info;
     int iq, ik, jq, jk;
 
-    /* We only handle page sizes for 64-bit server guests for now */
-    if (!(env->mmu_model & POWERPC_MMU_64)) {
+    /* For now, we only have anything to check on hash64 MMUs */
+    if (!cpu->hash64_opts || !kvm_enabled()) {
         return;
     }
 
-    /* Collect MMU info from kernel if not already */
-    if (!has_smmu_info) {
-        kvm_get_smmu_info(cpu, &smmu_info);
-        has_smmu_info = true;
-    }
+    kvm_get_smmu_info(cpu, &smmu_info);
 
-    if (!max_cpu_page_size) {
-        max_cpu_page_size = qemu_getrampagesize();
+    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
+        && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
+        error_setg(errp,
+                   "KVM does not support 1TiB segments which guest expects");
+        return;
     }
 
-    /* Convert to QEMU form */
-    memset(cpu->hash64_opts->sps, 0, sizeof(*cpu->hash64_opts->sps));
-
-    /* If we have HV KVM, we need to forbid CI large pages if our
-     * host page size is smaller than 64K.
-     */
-    if (kvmppc_hpt_needs_host_contiguous_pages()) {
-        if (getpagesize() >= 0x10000) {
-            cpu->hash64_opts->flags |= PPC_HASH64_CI_LARGEPAGE;
-        } else {
-            cpu->hash64_opts->flags &= ~PPC_HASH64_CI_LARGEPAGE;
-        }
+    if (smmu_info.slb_size < cpu->hash64_opts->slb_size) {
+        error_setg(errp, "KVM only supports %u SLB entries, but guest needs %u",
+                   smmu_info.slb_size, cpu->hash64_opts->slb_size);
+        return;
     }
 
     /*
-     * XXX This loop should be an entry wide AND of the capabilities that
-     *     the selected CPU has with the capabilities that KVM supports.
+     * Verify that every pagesize supported by the cpu model is
+     * supported by KVM with the same encodings
      */
-    for (ik = iq = 0; ik < KVM_PPC_PAGE_SIZES_MAX_SZ; ik++) {
+    for (iq = 0; iq < ARRAY_SIZE(cpu->hash64_opts->sps); iq++) {
         PPCHash64SegmentPageSizes *qsps = &cpu->hash64_opts->sps[iq];
-        struct kvm_ppc_one_seg_page_size *ksps = &smmu_info.sps[ik];
+        struct kvm_ppc_one_seg_page_size *ksps;
 
-        if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
-                                 ksps->page_shift)) {
-            continue;
-        }
-        qsps->page_shift = ksps->page_shift;
-        qsps->slb_enc = ksps->slb_enc;
-        for (jk = jq = 0; jk < KVM_PPC_PAGE_SIZES_MAX_SZ; jk++) {
-            if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
-                                     ksps->enc[jk].page_shift)) {
-                continue;
-            }
-            qsps->enc[jq].page_shift = ksps->enc[jk].page_shift;
-            qsps->enc[jq].pte_enc = ksps->enc[jk].pte_enc;
-            if (++jq >= PPC_PAGE_SIZES_MAX_SZ) {
+        for (ik = 0; ik < ARRAY_SIZE(smmu_info.sps); ik++) {
+            if (qsps->page_shift == smmu_info.sps[ik].page_shift) {
                 break;
             }
         }
-        if (++iq >= PPC_PAGE_SIZES_MAX_SZ) {
-            break;
+        if (ik >= ARRAY_SIZE(smmu_info.sps)) {
+            error_setg(errp, "KVM doesn't support for base page shift %u",
+                       qsps->page_shift);
+            return;
+        }
+
+        ksps = &smmu_info.sps[ik];
+        if (ksps->slb_enc != qsps->slb_enc) {
+            error_setg(errp,
+"KVM uses SLB encoding 0x%x for page shift %u, but guest expects 0x%x",
+                       ksps->slb_enc, ksps->page_shift, qsps->slb_enc);
+            return;
+        }
+
+        for (jq = 0; jq < ARRAY_SIZE(qsps->enc); jq++) {
+            for (jk = 0; jk < ARRAY_SIZE(ksps->enc); jk++) {
+                if (qsps->enc[jq].page_shift == ksps->enc[jk].page_shift) {
+                    break;
+                }
+            }
+
+            if (jk >= ARRAY_SIZE(ksps->enc)) {
+                error_setg(errp, "KVM doesn't support page shift %u/%u",
+                           qsps->enc[jq].page_shift, qsps->page_shift);
+                return;
+            }
+            if (qsps->enc[jq].pte_enc != ksps->enc[jk].pte_enc) {
+                error_setg(errp,
+"KVM uses PTE encoding 0x%x for page shift %u/%u, but guest expects 0x%x",
+                           ksps->enc[jk].pte_enc, qsps->enc[jq].page_shift,
+                           qsps->page_shift, qsps->enc[jq].pte_enc);
+                return;
+            }
         }
     }
-    cpu->hash64_opts->slb_size = smmu_info.slb_size;
-    if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
-        cpu->hash64_opts->flags &= ~PPC_HASH64_1TSEG;
-    }
-}
-#else /* defined (TARGET_PPC64) */
 
-static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
-{
+    if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
+        /* Mostly what guest pagesizes we can use are related to the
+         * host pages used to map guest RAM, which is handled in the
+         * platform code. Cache-Inhibited largepages (64k) however are
+         * used for I/O, so if they're mapped to the host at all it
+         * will be a normal mapping, not a special hugepage one used
+         * for RAM. */
+        if (getpagesize() < 0x10000) {
+            error_setg(errp,
+"KVM can't supply 64kiB CI pages, which guest expects\n");
+        }
+    }
 }
-
 #endif /* !defined (TARGET_PPC64) */
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
@@ -551,9 +551,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     CPUPPCState *cenv = &cpu->env;
     int ret;
 
-    /* Gather server mmu info from KVM and update the CPU state */
-    kvm_fixup_page_sizes(cpu);
-
     /* Synchronize sregs with kvm */
     ret = kvm_arch_sync_sregs(cpu);
     if (ret) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 443fca0a4e..657582bb32 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -71,6 +71,7 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
+void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 
 #else
 
@@ -227,6 +228,10 @@ static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
     return false;
 }
 
+static inline void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
+{
+}
+
 static inline bool kvmppc_has_cap_spapr_vfio(void)
 {
     return false;
-- 
2.17.1
