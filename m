Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSE-0004r9-Hi
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS4-0004dD-0R
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS3-0004RY-NO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqRs-0005PK-7l
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:25:52 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:32 +0100
Message-Id: <1504527967-29248-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/36] target/arm: Use MMUAccessType enum rather
 than int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the ARM get_phys_addr() code, switch to using the MMUAccessType
enum and its MMU_* values rather than int and literal 0/1/2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/internals.h |  3 ++-
 target/arm/helper.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..bb06946 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -457,7 +457,8 @@ struct ARMMMUFaultInfo {
 };
 
 /* Do a page table walk and add page to TLB if possible */
-bool arm_tlb_fill(CPUState *cpu, vaddr address, int rw, int mmu_idx,
+bool arm_tlb_fill(CPUState *cpu, vaddr address,
+                  MMUAccessType access_type, int mmu_idx,
                   uint32_t *fsr, ARMMMUFaultInfo *fi);
 
 /* Return true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ec92d3..8e148be 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,13 +20,13 @@
 
 #ifndef CONFIG_USER_ONLY
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          int access_type, ARMMMUIdx mmu_idx,
+                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                           target_ulong *page_size, uint32_t *fsr,
                           ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
-                               int access_type, ARMMMUIdx mmu_idx,
+                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr, uint32_t *fsr,
                                ARMMMUFaultInfo *fi);
@@ -2135,7 +2135,7 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
-                             int access_type, ARMMMUIdx mmu_idx)
+                             MMUAccessType access_type, ARMMMUIdx mmu_idx)
 {
     hwaddr phys_addr;
     target_ulong page_size;
@@ -2194,7 +2194,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    int access_type = ri->opc2 & 1;
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
@@ -2253,7 +2253,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    int access_type = ri->opc2 & 1;
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
 
     par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S2NS);
@@ -2273,7 +2273,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    int access_type = ri->opc2 & 1;
+    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     ARMMMUIdx mmu_idx;
     int secure = arm_is_secure_below_el3(env);
 
@@ -7505,7 +7505,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
-                             int access_type, ARMMMUIdx mmu_idx,
+                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              hwaddr *phys_ptr, int *prot,
                              target_ulong *page_size, uint32_t *fsr,
                              ARMMMUFaultInfo *fi)
@@ -7621,7 +7621,7 @@ do_fault:
 }
 
 static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
-                             int access_type, ARMMMUIdx mmu_idx,
+                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                              target_ulong *page_size, uint32_t *fsr,
                              ARMMMUFaultInfo *fi)
@@ -7728,7 +7728,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         if (pxn && !regime_is_user(env, mmu_idx)) {
             xn = 1;
         }
-        if (xn && access_type == 2)
+        if (xn && access_type == MMU_INST_FETCH)
             goto do_fault;
 
         if (arm_feature(env, ARM_FEATURE_V6K) &&
@@ -7843,7 +7843,7 @@ static bool check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, int level,
 }
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
-                               int access_type, ARMMMUIdx mmu_idx,
+                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr, uint32_t *fsr,
                                ARMMMUFaultInfo *fi)
@@ -8251,7 +8251,7 @@ static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
 }
 
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
-                                 int access_type, ARMMMUIdx mmu_idx,
+                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -8410,7 +8410,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
 }
 
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
-                                 int access_type, ARMMMUIdx mmu_idx,
+                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
 {
     int n;
@@ -8437,7 +8437,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
         return true;
     }
 
-    if (access_type == 2) {
+    if (access_type == MMU_INST_FETCH) {
         mask = env->cp15.pmsav5_insn_ap;
     } else {
         mask = env->cp15.pmsav5_data_ap;
@@ -8508,7 +8508,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
  * @fsr: set to the DFSR/IFSR value on failure
  */
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          int access_type, ARMMMUIdx mmu_idx,
+                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                           target_ulong *page_size, uint32_t *fsr,
                           ARMMMUFaultInfo *fi)
@@ -8621,7 +8621,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
  * fsr with ARM DFSR/IFSR fault register format value on failure.
  */
 bool arm_tlb_fill(CPUState *cs, vaddr address,
-                  int access_type, int mmu_idx, uint32_t *fsr,
+                  MMUAccessType access_type, int mmu_idx, uint32_t *fsr,
                   ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.7.4
