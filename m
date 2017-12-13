Received: from eggs.gnu.org ([2001:4830:134:3::10]:51634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWh-0004qE-D8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWg-00081m-7h
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWf-00080N-WB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:02 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWf-0007kY-0E
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:24 +0000
Message-Id: <1513188761-20784-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/43] target/arm: Remove fsr argument from
 arm_ld*_ptw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

All the callers of arm_ldq_ptw() and arm_ldl_ptw() ignore the value
that those functions store in the fsr argument on failure: if they
return failure to their callers they will always overwrite the fsr
value with something else.

Remove the argument from these functions and S1_ptw_translate().
This will simplify removing fsr from the calling functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: 1512503192-2239-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6140e84..c43159e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8266,7 +8266,6 @@ static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Translate a S1 pagetable walk through S2 if needed.  */
 static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
-                               uint32_t *fsr,
                                ARMMMUFaultInfo *fi)
 {
     if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
@@ -8275,9 +8274,10 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
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
@@ -8297,8 +8297,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
  * (but not if it was for a debug access).
  */
 static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
-                            ARMMMUIdx mmu_idx, uint32_t *fsr,
-                            ARMMMUFaultInfo *fi)
+                            ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -8307,7 +8306,7 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fsr, fi);
+    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fi);
     if (fi->s1ptw) {
         return 0;
     }
@@ -8319,8 +8318,7 @@ static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 }
 
 static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
-                            ARMMMUIdx mmu_idx, uint32_t *fsr,
-                            ARMMMUFaultInfo *fi)
+                            ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -8329,7 +8327,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fsr, fi);
+    addr = S1_ptw_translate(env, mmu_idx, addr, attrs, fi);
     if (fi->s1ptw) {
         return 0;
     }
@@ -8365,7 +8363,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                       mmu_idx, fsr, fi);
+                       mmu_idx, fi);
     type = (desc & 3);
     domain = (desc >> 5) & 0x0f;
     if (regime_el(env, mmu_idx) == 1) {
@@ -8402,7 +8400,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
             table = (desc & 0xfffff000) | ((address >> 8) & 0xffc);
         }
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                           mmu_idx, fsr, fi);
+                           mmu_idx, fi);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
             code = 7;
@@ -8484,7 +8482,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                       mmu_idx, fsr, fi);
+                       mmu_idx, fi);
     type = (desc & 3);
     if (type == 0 || (type == 3 && !arm_feature(env, ARM_FEATURE_PXN))) {
         /* Section translation fault, or attempt to use the encoding
@@ -8536,7 +8534,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         /* Lookup l2 entry.  */
         table = (desc & 0xfffffc00) | ((address >> 10) & 0x3fc);
         desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
-                           mmu_idx, fsr, fi);
+                           mmu_idx, fi);
         ap = ((desc >> 4) & 3) | ((desc >> 7) & 4);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
@@ -8947,7 +8945,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
