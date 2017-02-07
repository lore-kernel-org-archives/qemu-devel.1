Received: from eggs.gnu.org ([2001:4830:134:3::10]:51695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavyh-00055p-I7
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavye-0002sa-Fq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:57:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavye-0002sF-5j
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:57:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172ruRW061457
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:57:55 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28f4px28bt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:57:54 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:57:51 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:47 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <a8621842537496c91b6d021ad329e6fa6404cc17.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 4/9] target-ppc: support
 KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Query and cache the value of two new KVM capabilities that indicate
KVM's support for new radix and hash modes of the MMU.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 target/ppc/kvm.c     | 14 ++++++++++++++
 target/ppc/kvm_ppc.h | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 390d6342cc..8d6fd1b067 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -81,6 +81,8 @@ static int cap_papr;
 static int cap_htab_fd;
 static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
+static int cap_mmu_radix;
+static int cap_mmu_hash;
 
 static uint32_t debug_inst_opcode;
 
@@ -134,6 +136,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_htab_fd = kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls = kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
+    cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
+    cap_mmu_hash = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
@@ -2408,6 +2412,16 @@ bool kvmppc_has_cap_htm(void)
     return cap_htm;
 }
 
+bool kvmppc_has_cap_mmu_radix(void)
+{
+    return cap_mmu_radix;
+}
+
+bool kvmppc_has_cap_mmu_hash(void)
+{
+    return cap_mmu_hash;
+}
+
 static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc = OBJECT_CLASS(pcc);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 4b43283913..1c1b94847c 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -56,6 +56,8 @@ void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
                              target_ulong pte0, target_ulong pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
+bool kvmppc_has_cap_mmu_radix(void);
+bool kvmppc_has_cap_mmu_hash(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -255,6 +257,16 @@ static inline bool kvmppc_has_cap_htm(void)
     return false;
 }
 
+static inline bool kvmppc_has_cap_mmu_radix(void)
+{
+    return false;
+}
+
+static inline bool kvmppc_has_cap_mmu_hash(void)
+{
+    return false;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.11.0
