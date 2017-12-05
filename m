Received: from eggs.gnu.org ([2001:4830:134:3::10]:56581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB1-0000zg-It
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB0-0002Ja-45
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:31 +0000
Message-Id: <1512503192-2239-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/12] target/arm: Remove fsr argument from
 get_phys_addr() and arm_tlb_fill()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>

All of the callers of get_phys_addr() and arm_tlb_fill() now ignore
the FSR values they return, so we can just remove the argument
entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    | 45 ++++++++++++++-------------------------------
 target/arm/op_helper.c |  3 +--
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 67b9a52..876854d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -690,7 +690,7 @@ static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
 /* Do a page table walk and add page to TLB if possible */
 bool arm_tlb_fill(CPUState *cpu, vaddr address,
                   MMUAccessType access_type, int mmu_idx,
-                  uint32_t *fsr, ARMMMUFaultInfo *fi);
+                  ARMMMUFaultInfo *fi);
 
 /* Return true if the stage 1 translation regime is using LPAE format page
  * tables */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 17192f8..c23e424 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -28,7 +28,7 @@ typedef struct ARMCacheAttrs {
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
-                          target_ulong *page_size, uint32_t *fsr,
+                          target_ulong *page_size,
                           ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
@@ -2160,7 +2160,6 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     hwaddr phys_addr;
     target_ulong page_size;
     int prot;
-    uint32_t fsr_unused;
     bool ret;
     uint64_t par64;
     MemTxAttrs attrs = {};
@@ -2168,7 +2167,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     ARMCacheAttrs cacheattrs = {};
 
     ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
-                        &prot, &page_size, &fsr_unused, &fi, &cacheattrs);
+                        &prot, &page_size, &fi, &cacheattrs);
     /* TODO: this is not the correct condition to use to decide whether
      * to report a PAR in 64-bit or 32-bit format.
      */
@@ -6981,7 +6980,6 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     target_ulong page_size;
     hwaddr physaddr;
     int prot;
-    uint32_t fsr;
 
     v8m_security_lookup(env, addr, MMU_INST_FETCH, mmu_idx, &sattrs);
     if (!sattrs.nsc || sattrs.ns) {
@@ -6995,7 +6993,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
         return false;
     }
     if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx,
-                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi, NULL)) {
+                      &physaddr, &attrs, &prot, &page_size, &fi, NULL)) {
         /* the MPU lookup failed */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
@@ -9752,14 +9750,13 @@ static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
  * @attrs: set to the memory transaction attributes to use
  * @prot: set to the permissions for the page containing phys_ptr
  * @page_size: set to the size of the page containing phys_ptr
- * @fsr: set to the DFSR/IFSR value on failure
  * @fi: set to fault info if the translation fails
  * @cacheattrs: (if non-NULL) set to the cacheability/shareability attributes
  */
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
-                          target_ulong *page_size, uint32_t *fsr,
+                          target_ulong *page_size,
                           ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
@@ -9774,7 +9771,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
 
             ret = get_phys_addr(env, address, access_type,
                                 stage_1_mmu_idx(mmu_idx), &ipa, attrs,
-                                prot, page_size, fsr, fi, cacheattrs);
+                                prot, page_size, fi, cacheattrs);
 
             /* If S1 fails or S2 is disabled, return early.  */
             if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
@@ -9787,7 +9784,6 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fi,
                                      cacheattrs != NULL ? &cacheattrs2 : NULL);
-            *fsr = arm_fi_to_lfsc(fi);
             fi->s2addr = ipa;
             /* Combine the S1 and S2 perms.  */
             *prot &= s2_prot;
@@ -9833,17 +9829,14 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, address, access_type, mmu_idx,
                                        phys_ptr, attrs, prot, fi);
-            *fsr = arm_fi_to_sfsc(fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
                                        phys_ptr, prot, fi);
-            *fsr = arm_fi_to_sfsc(fi);
         } else {
             /* Pre-v7 MPU */
             ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
                                        phys_ptr, prot, fi);
-            *fsr = arm_fi_to_sfsc(fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
@@ -9869,24 +9862,15 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        bool ret = get_phys_addr_lpae(env, address, access_type, mmu_idx,
-                                      phys_ptr, attrs, prot, page_size,
-                                      fi, cacheattrs);
-
-        *fsr = arm_fi_to_lfsc(fi);
-        return ret;
+        return get_phys_addr_lpae(env, address, access_type, mmu_idx,
+                                  phys_ptr, attrs, prot, page_size,
+                                  fi, cacheattrs);
     } else if (regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        bool ret = get_phys_addr_v6(env, address, access_type, mmu_idx,
-                                    phys_ptr, attrs, prot, page_size, fi);
-
-        *fsr = arm_fi_to_sfsc(fi);
-        return ret;
+        return get_phys_addr_v6(env, address, access_type, mmu_idx,
+                                phys_ptr, attrs, prot, page_size, fi);
     } else {
-        bool ret = get_phys_addr_v5(env, address, access_type, mmu_idx,
+        return get_phys_addr_v5(env, address, access_type, mmu_idx,
                                     phys_ptr, prot, page_size, fi);
-
-        *fsr = arm_fi_to_sfsc(fi);
-        return ret;
     }
 }
 
@@ -9895,7 +9879,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
  * fsr with ARM DFSR/IFSR fault register format value on failure.
  */
 bool arm_tlb_fill(CPUState *cs, vaddr address,
-                  MMUAccessType access_type, int mmu_idx, uint32_t *fsr,
+                  MMUAccessType access_type, int mmu_idx,
                   ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -9908,7 +9892,7 @@ bool arm_tlb_fill(CPUState *cs, vaddr address,
 
     ret = get_phys_addr(env, address, access_type,
                         core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
-                        &attrs, &prot, &page_size, fsr, fi, NULL);
+                        &attrs, &prot, &page_size, fi, NULL);
     if (!ret) {
         /* Map a single [sub]page.  */
         phys_addr &= TARGET_PAGE_MASK;
@@ -9930,14 +9914,13 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     target_ulong page_size;
     int prot;
     bool ret;
-    uint32_t fsr;
     ARMMMUFaultInfo fi = {};
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
 
     *attrs = (MemTxAttrs) {};
 
     ret = get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
-                        attrs, &prot, &page_size, &fsr, &fi, NULL);
+                        attrs, &prot, &page_size, &fi, NULL);
 
     if (ret) {
         return -1;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 38e6993..c2bb4f3 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -176,10 +176,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
               int mmu_idx, uintptr_t retaddr)
 {
     bool ret;
-    uint32_t fsr = 0;
     ARMMMUFaultInfo fi = {};
 
-    ret = arm_tlb_fill(cs, addr, access_type, mmu_idx, &fsr, &fi);
+    ret = arm_tlb_fill(cs, addr, access_type, mmu_idx, &fi);
     if (unlikely(ret)) {
         ARMCPU *cpu = ARM_CPU(cs);
 
-- 
2.7.4
