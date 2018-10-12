Received: from eggs.gnu.org ([2001:4830:134:3::10]:55315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeN-0007zD-Fl
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeM-0002w0-Mm
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:29 +0100
Message-Id: <20181012144235.19646-5-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/10] target/arm: Implement HCR.DC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The HCR.DC virtualization configuration register bit has the
following effects:
 * SCTLR.M behaves as if it is 0 for all purposes except
   direct reads of the bit
 * HCR.VM behaves as if it is 1 for all purposes except
   direct reads of the bit
 * the memory type produced by the first stage of the EL1&EL0
   translation regime is Normal Non-Shareable,
   Inner Write-Back Read-Allocate Write-Allocate,
   Outer Write-Back Read-Allocate Write-Allocate.

Implement this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cbec6844a44..84b40031b6f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2300,13 +2300,15 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
          * * The Non-secure TTBCR.EAE bit is set to 1
          * * The implementation includes EL2, and the value of HCR.VM is 1
          *
+         * (Note that HCR.DC makes HCR.VM behave as if it is 1.)
+         *
          * ATS1Hx always uses the 64bit format (not supported yet).
          */
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
             if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-                format64 |= env->cp15.hcr_el2 & HCR_VM;
+                format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
             }
@@ -8711,7 +8713,8 @@ static inline bool regime_translation_disabled(CPUARMState *env,
     }
 
     if (mmu_idx == ARMMMUIdx_S2NS) {
-        return (env->cp15.hcr_el2 & HCR_VM) == 0;
+        /* HCR.DC means HCR.VM behaves as 1 */
+        return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
 
     if (env->cp15.hcr_el2 & HCR_TGE) {
@@ -8721,6 +8724,12 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
+    if ((env->cp15.hcr_el2 & HCR_DC) &&
+        (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
+        /* HCR.DC means SCTLR_EL1.M behaves as 0 */
+        return true;
+    }
+
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
 }
 
@@ -10701,6 +10710,16 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
 
             /* Combine the S1 and S2 cache attributes, if needed */
             if (!ret && cacheattrs != NULL) {
+                if (env->cp15.hcr_el2 & HCR_DC) {
+                    /*
+                     * HCR.DC forces the first stage attributes to
+                     *  Normal Non-Shareable,
+                     *  Inner Write-Back Read-Allocate Write-Allocate,
+                     *  Outer Write-Back Read-Allocate Write-Allocate.
+                     */
+                    cacheattrs->attrs = 0xff;
+                    cacheattrs->shareability = 0;
+                }
                 *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
             }
 
-- 
2.19.0
