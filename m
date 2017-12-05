Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB7-000185-Vo
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB6-0002Nv-TU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:25 +0000
Message-Id: <1512503192-2239-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/12] target/arm: Convert get_phys_addr_lpae()
 to not return FSC values
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

Make get_phys_addr_v6() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e95e3d..a2a0784 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,7 +34,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
-                               target_ulong *page_size_ptr, uint32_t *fsr,
+                               target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
@@ -8277,10 +8277,9 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         hwaddr s2pa;
         int s2prot;
         int ret;
-        uint32_t fsr;
 
         ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
-                                 &txattrs, &s2prot, &s2size, &fsr, fi, NULL);
+                                 &txattrs, &s2prot, &s2size, fi, NULL);
         if (ret) {
             fi->s2addr = addr;
             fi->stage2 = true;
@@ -8603,15 +8602,6 @@ do_fault:
     return true;
 }
 
-/* Fault type for long-descriptor MMU fault reporting; this corresponds
- * to bits [5..2] in the STATUS field in long-format DFSR/IFSR.
- */
-typedef enum {
-    translation_fault = 1,
-    access_fault = 2,
-    permission_fault = 3,
-} MMUFaultType;
-
 /*
  * check_s2_mmu_setup
  * @cpu:        ARMCPU
@@ -8713,13 +8703,13 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
-                               target_ulong *page_size_ptr, uint32_t *fsr,
+                               target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
     /* Read an LPAE long-descriptor translation table. */
-    MMUFaultType fault_type = translation_fault;
+    ARMFaultType fault_type = ARMFault_Translation;
     uint32_t level;
     uint32_t epd = 0;
     int32_t t0sz, t1sz;
@@ -8829,7 +8819,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         ttbr_select = 1;
     } else {
         /* in the gap between the two regions, this is a Translation fault */
-        fault_type = translation_fault;
+        fault_type = ARMFault_Translation;
         goto do_fault;
     }
 
@@ -8915,7 +8905,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         ok = check_s2_mmu_setup(cpu, aarch64, startlevel,
                                 inputsize, stride);
         if (!ok) {
-            fault_type = translation_fault;
+            fault_type = ARMFault_Translation;
             goto do_fault;
         }
         level = startlevel;
@@ -9001,7 +8991,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     /* Here descaddr is the final physical address, and attributes
      * are all in attrs.
      */
-    fault_type = access_fault;
+    fault_type = ARMFault_AccessFlag;
     if ((attrs & (1 << 8)) == 0) {
         /* Access flag */
         goto do_fault;
@@ -9019,7 +9009,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         *prot = get_S1prot(env, mmu_idx, aarch64, ap, ns, xn, pxn);
     }
 
-    fault_type = permission_fault;
+    fault_type = ARMFault_Permission;
     if (!(*prot & (1 << access_type))) {
         goto do_fault;
     }
@@ -9051,8 +9041,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     return false;
 
 do_fault:
-    /* Long-descriptor format IFSR/DFSR value */
-    *fsr = (1 << 9) | (fault_type << 2) | level;
+    fi->type = fault_type;
+    fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
     fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
     return true;
@@ -9778,8 +9768,9 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             /* S1 is done. Now do S2 translation.  */
             ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_S2NS,
                                      phys_ptr, attrs, &s2_prot,
-                                     page_size, fsr, fi,
+                                     page_size, fi,
                                      cacheattrs != NULL ? &cacheattrs2 : NULL);
+            *fsr = arm_fi_to_lfsc(fi);
             fi->s2addr = ipa;
             /* Combine the S1 and S2 perms.  */
             *prot &= s2_prot;
@@ -9858,8 +9849,12 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, address, access_type, mmu_idx, phys_ptr,
-                                  attrs, prot, page_size, fsr, fi, cacheattrs);
+        bool ret = get_phys_addr_lpae(env, address, access_type, mmu_idx,
+                                      phys_ptr, attrs, prot, page_size,
+                                      fi, cacheattrs);
+
+        *fsr = arm_fi_to_lfsc(fi);
+        return ret;
     } else if (regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         bool ret = get_phys_addr_v6(env, address, access_type, mmu_idx,
                                     phys_ptr, attrs, prot, page_size, fi);
-- 
2.7.4
