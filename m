Received: from eggs.gnu.org ([2001:4830:134:3::10]:47696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYq1C-0001Fk-8o
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYq17-0005GA-JQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:42 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:39482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYq17-0005Bb-AS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:37 -0400
Received: from player755.ha.ovh.net (unknown [10.109.108.51])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id CED331D753
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 11:48:35 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 29 Jun 2018 11:48:32 +0200
Message-ID: <153026571205.394407.1842744312813398945.stgit@bahia.lan>
In-Reply-To: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
References: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/3] target/ppc/kvm: don't pass cpu to
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

In a future patch the machine code will need to retrieve the MMU
information from KVM during machine initialization before the CPUs
are created.

Actually, KVM_PPC_GET_SMMU_INFO is a VM class ioctl, and thus, we
don't need to have a CPU object around. We just need for KVM to
be initialized and use the kvm_state global. This patch just does
that.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - fallback code was dropped by a previous patch
---
 target/ppc/kvm.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b6000f12b98f..9211ee2ee1a0 100644
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
 
