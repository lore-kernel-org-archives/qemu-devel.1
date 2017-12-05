Received: from eggs.gnu.org ([2001:4830:134:3::10]:56814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJBA-0001Ak-GZ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB9-0002Pi-HQ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:56 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:22 +0000
Message-Id: <1512503192-2239-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/12] target/arm: Remove fsr argument from
 arm_ld*_ptw()
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

All the callers of arm_ldq_ptw() and arm_ldl_ptw() ignore the value
that those functions store in the fsr argument on failure: if they
return failure to their callers they will always overwrite the fsr
value with something else.

Remove the argument from these functions and S1_ptw_translate().
This will simplify removing fsr from the calling functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5368ad8..30616d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8269,7 +8269,6 @@ static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Translate a S1 pagetable walk through S2 if needed.  */
 static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
-                               uint32_t *fsr,
                                ARMMMUFaultInfo *fi)
 {
     if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
@@ -8278,9 +8277,10 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         hwaddr s2pa;
         int s2prot;
         int ret;
+        uint32_t fsr;
 
         ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
-                                 &txattrs, &s2prot, &s2size, fsr, fi, NULL);
+                                 &txattrs, &s2prot, &s2size, &fsr, fi, NULL);
         if (ret) {
             fi->s2addr = addr;
             fi->stage2 = true;
@@ -8300,8 +8300,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
  * (but not if it was for a debug access).
  */
 static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
-                            ARMMMUIdx mmu_idx, uint32_t *fsr,
-                            ARMMMUFaultInfo *fi)
+                            ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -8310,7 +8309,7 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fsr, fi);
+    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fi);
     if (fi->s1ptw) {
         return 0;
     }
@@ -8322,8 +8321,7 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 }
 
 static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
-                            ARMMMUIdx mmu_idx, uint32_t *fsr,
-                            ARMMMUFaultInfo *fi)
+                            ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -8332,7 +8330,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fsr, fi);
+    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fi);
     if (fi->s1ptw) {
         return 0;
     }
@@ -8368,7 +8366,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                       mmu_idx, fsr, fi);
+                       mmu_idx, fi);
     type = (desc & 3);
     domain = (desc >> 5) & 0x0f;
     if (regime_el(env, mmu_idx) == 1) {
@@ -8405,7 +8403,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
             table = (desc & 0xfffff000) | ((address >> 8) & 0xffc);
         }
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                           mmu_idx, fsr, fi);
+                           mmu_idx, fi);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
             code = 7;
@@ -8487,7 +8485,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                       mmu_idx, fsr, fi);
+                       mmu_idx, fi);
     type = (desc & 3);
     if (type == 0 || (type == 3 && !arm_feature(env, ARM_FEATURE_PXN))) {
         /* Section translation fault, or attempt to use the encoding
@@ -8539,7 +8537,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         /* Lookup l2 entry.  */
         table = (desc & 0xfffffc00) | ((address >> 10) & 0x3fc);
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                           mmu_idx, fsr, fi);
+                           mmu_idx, fi);
         ap = ((desc >> 4) & 3) | ((desc >> 7) & 4);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
@@ -8950,7 +8948,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         descaddr |= (address >> (stride * (4 - level))) & indexmask;
         descaddr &= ~7ULL;
         nstable = extract32(tableattrs, 4, 1);
-        descriptor = arm_ldq_ptw(cs, descaddr, !nstable, mmu_idx, fsr, fi);
+        descriptor = arm_ldq_ptw(cs, descaddr, !nstable, mmu_idx, fi);
         if (fi->s1ptw) {
             goto do_fault;
         }
-- 
2.7.4
