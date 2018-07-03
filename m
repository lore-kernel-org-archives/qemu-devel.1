Received: from eggs.gnu.org ([2001:4830:134:3::10]:40043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKb-0002xh-Tg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKZ-00077Z-15
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:58:00 +1000
Message-Id: <20180703055804.13449-32-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 31/35] target/ppc/kvm: don't pass cpu to
 kvm_get_smmu_info()
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

In a future patch the machine code will need to retrieve the MMU
information from KVM during machine initialization before the CPUs
are created.

Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, we
don't need to have a CPU object around. We just need for KVM to
be initialized and use the kvm_state global. This patch just does
that.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b6000f12b9..9211ee2ee1 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -248,19 +248,19 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
 
 
 #if defined(TARGET_PPC64)
-static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info,
-                              Error **errp)
+static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
 {
-    CPUState *cs = CPU(cpu);
     int ret;
 
-    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
+    assert(kvm_state != NULL);
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
         error_setg(errp, "KVM doesn't expose the MMU features it supports");
         error_append_hint(errp, "Consider switching to a newer KVM\n");
         return;
     }
 
-    ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_SMMU_INFO, info);
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_SMMU_INFO, info);
     if (ret == 0) {
         return;
     }
@@ -326,14 +326,13 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     static struct kvm_ppc_smmu_info smmu_info;
 
     if (!kvm_enabled()) {
         return false;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info, &error_fatal);
+    kvm_get_smmu_info(&smmu_info, &error_fatal);
     return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
 }
 
@@ -348,7 +347,7 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
         return;
     }
 
-    kvm_get_smmu_info(cpu, &smmu_info, &local_err);
+    kvm_get_smmu_info(&smmu_info, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -2091,7 +2090,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
 
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
-    kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info, &error_fatal);
+    kvm_get_smmu_info(&info, &error_fatal);
     rampagesize = qemu_getrampagesize();
     best_page_shift = 0;
 
-- 
2.17.1
