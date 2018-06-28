Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYTxQ-0008Ki-VY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYTxN-0005aZ-O6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:15:20 -0400
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:54982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYTxN-0005Y3-DU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:15:17 -0400
Received: from player738.ha.ovh.net (unknown [10.109.108.75])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9BE2C1BFE5D
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:15:15 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Jun 2018 12:14:51 +0200
Message-ID: <153018089136.336571.15410439376219137880.stgit@bahia>
In-Reply-To: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] target/ppc/kvm: don't pass cpu to
 kvm_get_smmu_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

In a future patch the machine code will need to retrieve the MMU
information from KVM during machine initialization before the CPUs
are created.

Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, it only
needs the kvm_state global variable to be set. The fallback code only
needs informations from the machine's CPU model class.

So this patch basically drops the CPU argument to kvm_get_smmu_info()
and kvm_get_fallback_smmu_info(). The kvm_state and current_machine
globals are used instead to reach out to KVM and CPU model details
respectively.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c        |   37 ++++++++++++++++++-------------------
 target/ppc/mmu-hash64.h |    8 +++++++-
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4df4ff6cbff2..9fae89ff8175 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -248,11 +248,12 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
 
 
 #if defined(TARGET_PPC64)
-static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
-                                       struct kvm_ppc_smmu_info *info)
+static void kvm_get_fallback_smmu_info(struct kvm_ppc_smmu_info *info)
 {
-    CPUPPCState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
+    const PowerPCCPUClass *pcc;
+
+    assert(current_machine != NULL);
+    pcc = POWERPC_CPU_CLASS(object_class_by_name(current_machine->cpu_type));
 
     memset(info, 0, sizeof(*info));
 
@@ -278,7 +279,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
      *   implements KVM_CAP_PPC_GET_SMMU_INFO and thus doesn't hit
      *   this fallback.
      */
-    if (kvmppc_is_pr(cs->kvm_state)) {
+    if (kvmppc_is_pr(kvm_state)) {
         /* No flags */
         info->flags = 0;
         info->slb_size = 64;
@@ -300,12 +301,12 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
         /* HV KVM has backing store size restrictions */
         info->flags = KVM_PPC_PAGE_SIZES_REAL;
 
-        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
+        if (hash64_opts_has(pcc->hash64_opts, PPC_HASH64_1TSEG)) {
             info->flags |= KVM_PPC_1T_SEGMENTS;
         }
 
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
+        if (pcc->mmu_model == POWERPC_MMU_2_06 ||
+            pcc->mmu_model == POWERPC_MMU_2_07) {
             info->slb_size = 32;
         } else {
             info->slb_size = 64;
@@ -319,8 +320,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
         i++;
 
         /* 64K on MMU 2.06 and later */
-        if (env->mmu_model == POWERPC_MMU_2_06 ||
-            env->mmu_model == POWERPC_MMU_2_07) {
+        if (pcc->mmu_model == POWERPC_MMU_2_06 ||
+            pcc->mmu_model == POWERPC_MMU_2_07) {
             info->sps[i].page_shift = 16;
             info->sps[i].slb_enc = 0x110;
             info->sps[i].enc[0].page_shift = 16;
@@ -336,19 +337,18 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
     }
 }
 
-static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
+static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info)
 {
-    CPUState *cs = CPU(cpu);
     int ret;
 
-    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
-        ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
+    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
+        ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_SMMU_INFO, info);
         if (ret == 0) {
             return;
         }
     }
 
-    kvm_get_fallback_smmu_info(cpu, info);
+    kvm_get_fallback_smmu_info(info);
 }
 
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
@@ -408,14 +408,13 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     static struct kvm_ppc_smmu_info smmu_info;
 
     if (!kvm_enabled()) {
         return false;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info);
+    kvm_get_smmu_info(&smmu_info);
     return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
 }
 
@@ -429,7 +428,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
         return;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info);
+    kvm_get_smmu_info(&smmu_info);
 
     if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)
         && !(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
@@ -2168,7 +2167,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
 
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
-    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
+    kvm_get_smmu_info(&info);
     rampagesize = qemu_getrampagesize();
     best_page_shift = 0;
 
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f11efc9cbc1f..00a249f26bc3 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -169,9 +169,15 @@ struct PPCHash64Options {
 extern const PPCHash64Options ppc_hash64_opts_basic;
 extern const PPCHash64Options ppc_hash64_opts_POWER7;
 
+static inline bool hash64_opts_has(const PPCHash64Options *opts,
+                                   unsigned feature)
+{
+    return !!(opts->flags & feature);
+}
+
 static inline bool ppc_hash64_has(PowerPCCPU *cpu, unsigned feature)
 {
-    return !!(cpu->hash64_opts->flags & feature);
+    return hash64_opts_has(cpu->hash64_opts, feature);
 }
 
 #endif /* CONFIG_USER_ONLY */
