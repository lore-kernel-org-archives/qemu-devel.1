Received: from eggs.gnu.org ([2001:4830:134:3::10]:56002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI1-0001Jm-QC
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI0-0003Ju-PW
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:47 +1000
Message-Id: <20170424015927.8933-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/47] target-ppc: support KVM_CAP_PPC_MMU_RADIX,
 KVM_CAP_PPC_MMU_HASH_V3
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

Query and cache the value of two new KVM capabilities that indicate
KVM's support for new radix and hash modes of the MMU.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c     | 14 ++++++++++++++
 target/ppc/kvm_ppc.h | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9dc2f7f..38db27b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -86,6 +86,8 @@ static int cap_papr;
 static int cap_htab_fd;
 static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
+static int cap_mmu_radix;
+static int cap_mmu_hash_v3;
 
 static uint32_t debug_inst_opcode;
 
@@ -140,6 +142,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_htab_fd = kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls = kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
+    cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
+    cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
@@ -2354,6 +2358,16 @@ bool kvmppc_has_cap_htm(void)
     return cap_htm;
 }
 
+bool kvmppc_has_cap_mmu_radix(void)
+{
+    return cap_mmu_radix;
+}
+
+bool kvmppc_has_cap_mmu_hash_v3(void)
+{
+    return cap_mmu_hash_v3;
+}
+
 static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc = OBJECT_CLASS(pcc);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 08ecf75..64189a4 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -54,6 +54,8 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n);
 void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
+bool kvmppc_has_cap_mmu_radix(void);
+bool kvmppc_has_cap_mmu_hash_v3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -254,6 +256,16 @@ static inline bool kvmppc_has_cap_htm(void)
     return false;
 }
 
+static inline bool kvmppc_has_cap_mmu_radix(void)
+{
+    return false;
+}
+
+static inline bool kvmppc_has_cap_mmu_hash_v3(void)
+{
+    return false;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.9.3
