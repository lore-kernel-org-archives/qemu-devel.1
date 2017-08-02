Received: from eggs.gnu.org ([2001:4830:134:3::10]:49675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlF-0003fJ-0H
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlE-0004sf-0X
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:49 +0100
Message-Id: <1501692241-23310-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/15] target/arm: Consolidate PMSA handling in
 get_phys_addr()
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

Currently get_phys_addr() has PMSAv7 handling before the
"is translation disabled?" check, and then PMSAv5 after it.
Tidy this up by making the PMSAv5 code handle the "MPU disabled"
case itself, so that we have all the PMSA code in one place.
This will make adding the PMSAv8 code slightly cleaner, and
also means that pre-v7 PMSA cores benefit from the MPU lookup
logging that the PMSAv7 codepath had.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b78d277..fd83a21 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8423,6 +8423,13 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
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
@@ -8572,16 +8579,20 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
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
@@ -8594,21 +8605,16 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
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
