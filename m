Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB1-0000zL-3Q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB0-0002Jo-7W
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:32 +0000
Message-Id: <1512503192-2239-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/12] target/arm: Extend PAR format
 determination
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Now that do_ats_write() is entirely in control of whether to
generate a 32-bit PAR or a 64-bit PAR, we can make it use the
correct (complicated) condition for doing so.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
index c23e424..d526db4 100644
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
