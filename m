Received: from eggs.gnu.org ([2001:4830:134:3::10]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS9-0004o7-H9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS2-0004bM-Mg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS2-0004Yp-Bf
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqRv-0005QN-5d
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:25:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:34 +0100
Message-Id: <1504527967-29248-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/36] target/arm: Consolidate PMSA handling in
 get_phys_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently get_phys_addr() has PMSAv7 handling before the
"is translation disabled?" check, and then PMSAv5 after it.
Tidy this up by making the PMSAv5 code handle the "MPU disabled"
case itself, so that we have all the PMSA code in one place.
This will make adding the PMSAv8 code slightly cleaner, and
also means that pre-v7 PMSA cores benefit from the MPU lookup
logging that the PMSAv7 codepath had.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e148be..8190682 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8418,6 +8418,13 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
     uint32_t base;
     bool is_user = regime_is_user(env, mmu_idx);
 
+    if (regime_translation_disabled(env, mmu_idx)) {
+        /* MPU disabled.  */
+        *phys_ptr = address;
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return false;
+    }
+
     *phys_ptr = address;
     for (n = 7; n >= 0; n--) {
         base = env->cp15.c6_region[n];
@@ -8567,16 +8574,20 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         }
     }
 
-    /* pmsav7 has special handling for when MPU is disabled so call it before
-     * the common MMU/MPU disabled check below.
-     */
-    if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
         bool ret;
         *page_size = TARGET_PAGE_SIZE;
-        ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
-                                   phys_ptr, prot, fsr);
-        qemu_log_mask(CPU_LOG_MMU, "PMSAv7 MPU lookup for %s at 0x%08" PRIx32
+
+        if (arm_feature(env, ARM_FEATURE_V7)) {
+            /* PMSAv7 */
+            ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
+                                       phys_ptr, prot, fsr);
+        } else {
+            /* Pre-v7 MPU */
+            ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
+                                       phys_ptr, prot, fsr);
+        }
+        qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
                       access_type == MMU_DATA_LOAD ? "reading" :
                       (access_type == MMU_DATA_STORE ? "writing" : "execute"),
@@ -8589,21 +8600,16 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         return ret;
     }
 
+    /* Definitely a real MMU, not an MPU */
+
     if (regime_translation_disabled(env, mmu_idx)) {
-        /* MMU/MPU disabled.  */
+        /* MMU disabled. */
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
         return 0;
     }
 
-    if (arm_feature(env, ARM_FEATURE_PMSA)) {
-        /* Pre-v7 MPU */
-        *page_size = TARGET_PAGE_SIZE;
-        return get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
-                                    phys_ptr, prot, fsr);
-    }
-
     if (regime_using_lpae_format(env, mmu_idx)) {
         return get_phys_addr_lpae(env, address, access_type, mmu_idx, phys_ptr,
                                   attrs, prot, page_size, fsr, fi);
-- 
2.7.4
