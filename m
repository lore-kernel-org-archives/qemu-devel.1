Received: from eggs.gnu.org ([2001:4830:134:3::10]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUV-0000SP-4e
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUR-0007cp-0Z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:23 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:48 +1000
Message-Id: <20170608070351.1434-3-sjitindarsingh@gmail.com>
In-Reply-To: <20170608070351.1434-1-sjitindarsingh@gmail.com>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 2/5] target/ppc: Implement large decrementer
 support for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The large decrementer is an operating mode of the decrementer.
The decrementer is normally a 32-bit register.
When operating in large decrementer mode the decrementer is a d-bit
register which is sign extended to 64-bits (where d is implementation
dependant).

Implement support for a KVM guest to use the decrementer in large
decrementer mode. This means adding functions to query the large
decrementer support of the hypervisor and to enable the large
decrementer with the hypervisor.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h | 25 ++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce..b2c94a0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -88,6 +88,7 @@ static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
 static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
+static int cap_large_decr;
 
 static uint32_t debug_inst_opcode;
 
@@ -393,6 +394,19 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     }
 }
 
+void kvmppc_configure_large_decrementer(CPUState *cs, bool enable_ld)
+{
+    uint64_t lpcr;
+
+    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    if (enable_ld) {
+        lpcr |= LPCR_LD;
+    } else {
+        lpcr &= LPCR_LD;
+    }
+    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+}
+
 static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
 {
     if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
@@ -2004,6 +2018,11 @@ uint32_t kvmppc_get_dfp(void)
     return kvmppc_read_int_cpu_dt("ibm,dfp");
 }
 
+uint32_t kvmppc_get_dec_bits(void)
+{
+    return kvmppc_read_int_cpu_dt("ibm,dec-bits");
+}
+
 static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pvinfo)
  {
      PowerPCCPU *cpu = ppc_env_get_cpu(env);
@@ -2380,6 +2399,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 
 #if defined(TARGET_PPC64)
     pcc->radix_page_info = kvm_get_radix_page_info();
+    pcc->large_decr_bits = kvmppc_get_dec_bits();
 
     if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
         /*
@@ -2424,6 +2444,45 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+void kvmppc_check_cap_large_decr(void)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUState *cs = CPU(cpu);
+    bool large_dec_support;
+    uint32_t dec_bits;
+    uint64_t lpcr;
+
+    /*
+     * Try and set the LPCR_LD (large decrementer) bit to enable the large
+     * decrementer. A hypervisor with large decrementer capabilities will allow
+     * this so the value read back after this will have the LPCR_LD bit set.
+     * Otherwise the bit will be cleared meaning we can't use the large
+     * decrementer.
+     */
+    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    lpcr |= LPCR_LD;
+    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    large_dec_support = !!(lpcr & LPCR_LD);
+    /* Probably a good idea to clear it again */
+    lpcr &= ~LPCR_LD;
+    kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+
+    /*
+     * Check for the ibm,dec-bits property on the host, if it isn't there then
+     * something has gone wrong and we're better off not letting the guest use
+     * the large decrementer.
+     */
+    dec_bits = kvmppc_get_dec_bits();
+
+    cap_large_decr = large_dec_support && dec_bits;
+}
+
+bool kvmppc_has_cap_large_decr(void)
+{
+    return cap_large_decr;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f48243d..c49c7f0 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -17,6 +17,7 @@ uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
 uint32_t kvmppc_get_vmx(void);
 uint32_t kvmppc_get_dfp(void);
+uint32_t kvmppc_get_dec_bits(void);
 bool kvmppc_get_host_model(char **buf);
 bool kvmppc_get_host_serial(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
@@ -36,6 +37,8 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
+void kvmppc_check_cap_large_decr(void);
+void kvmppc_configure_large_decrementer(CPUState *cs, bool enable_ld);
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
@@ -60,6 +63,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
+bool kvmppc_has_cap_large_decr(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -98,6 +102,11 @@ static inline uint32_t kvmppc_get_dfp(void)
     return 0;
 }
 
+static inline uint32_t kvmppc_get_dec_bits(void)
+{
+    return 0;
+}
+
 static inline int kvmppc_get_hasidle(CPUPPCState *env)
 {
     return 0;
@@ -170,6 +179,17 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline void kvmppc_check_cap_large_decr(void)
+{
+    return;
+}
+
+static inline void kvmppc_configure_large_decrementer(CPUState *cs,
+                                                      bool enable_ld)
+{
+    return;
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline off_t kvmppc_alloc_rma(void **rma)
 {
@@ -282,6 +302,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
     return false;
 }
 
+static inline bool kvmppc_has_cap_large_decr(void)
+{
+    return false;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.9.4
