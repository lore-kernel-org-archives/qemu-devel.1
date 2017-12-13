Received: from eggs.gnu.org ([2001:4830:134:3::10]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWo-0004z8-8s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWn-0008Bw-7Q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWm-0008Ay-W9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWl-0007p3-VC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:34 +0000
Message-Id: <1513188761-20784-37-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/43] target/arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Now that do_ats_write() is entirely in control of whether to
generate a 32-bit PAR or a 64-bit PAR, we can make it use the
correct (complicated) condition for doing so.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1512503192-2239-13-git-send-email-peter.maydell@linaro.org
[PMM: Rebased Edgar's patch on top of get_phys_addr() refactoring;
 use arm_s1_regime_using_lpae_format() rather than
 regime_using_lpae_format() because the latter will assert
 if passed ARMMMUIdx_S12NSE0 or ARMMMUIdx_S12NSE1;
 updated commit message appropriately]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c469e6a..d1395f9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2162,16 +2162,41 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     int prot;
     bool ret;
     uint64_t par64;
+    bool format64 = false;
     MemTxAttrs attrs = {};
     ARMMMUFaultInfo fi = {};
     ARMCacheAttrs cacheattrs = {};
 
     ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
                         &prot, &page_size, &fi, &cacheattrs);
-    /* TODO: this is not the correct condition to use to decide whether
-     * to report a PAR in 64-bit or 32-bit format.
-     */
-    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
+
+    if (is_a64(env)) {
+        format64 = true;
+    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        /*
+         * ATS1Cxx:
+         * * TTBCR.EAE determines whether the result is returned using the
+         *   32-bit or the 64-bit PAR format
+         * * Instructions executed in Hyp mode always use the 64bit format
+         *
+         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
+         * * The Non-secure TTBCR.EAE bit is set to 1
+         * * The implementation includes EL2, and the value of HCR.VM is 1
+         *
+         * ATS1Hx always uses the 64bit format (not supported yet).
+         */
+        format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
+
+        if (arm_feature(env, ARM_FEATURE_EL2)) {
+            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+                format64 |= env->cp15.hcr_el2 & HCR_VM;
+            } else {
+                format64 |= arm_current_el(env) == 2;
+            }
+        }
+    }
+
+    if (format64) {
         /* Create a 64-bit PAR */
         par64 = (1 << 11); /* LPAE bit always set */
         if (!ret) {
-- 
2.7.4
