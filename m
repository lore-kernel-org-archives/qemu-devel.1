Received: from eggs.gnu.org ([2001:4830:134:3::10]:53562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnw-0006dq-E0
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAns-0003JB-Dx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:20 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:41 +0100
Message-Id: <1503414539-28762-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/20] target/arm: Implement new PMSAv8
 behaviour
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

Implement the behavioural side of the new PMSAv8 specification.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7920153..887490a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8416,6 +8416,111 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
     return !(*prot & (1 << access_type));
 }
 
+static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
+                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                                 hwaddr *phys_ptr, int *prot, uint32_t *fsr)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    bool is_user = regime_is_user(env, mmu_idx);
+    int n;
+    int matchregion = -1;
+    bool hit = false;
+
+    *phys_ptr = address;
+    *prot = 0;
+
+    /* Unlike the ARM ARM pseudocode, we don't need to check whether this
+     * was an exception vector read from the vector table (which is always
+     * done using the default system address map), because those accesses
+     * are done in arm_v7m_load_vector(), which always does a direct
+     * read using address_space_ldl(), rather than going via this function.
+     */
+    if (regime_translation_disabled(env, mmu_idx)) { /* MPU disabled */
+        hit = true;
+    } else if (m_is_ppb_region(env, address)) {
+        hit = true;
+    } else if (pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
+        hit = true;
+    } else {
+        for (n = (int)cpu->pmsav7_dregion - 1; n >= 0; n--) {
+            /* region search */
+            /* Note that the base address is bits [31:5] from the register
+             * with bits [4:0] all zeroes, but the limit address is bits
+             * [31:5] from the register with bits [4:0] all ones.
+             */
+            uint32_t base = env->pmsav8.rbar[n] & ~0x1f;
+            uint32_t limit = env->pmsav8.rlar[n] | 0x1f;
+
+            if (!(env->pmsav8.rlar[n] & 0x1)) {
+                /* Region disabled */
+                continue;
+            }
+
+            if (address < base || address > limit) {
+                continue;
+            }
+
+            if (hit) {
+                /* Multiple regions match -- always a failure (unlike
+                 * PMSAv7 where highest-numbered-region wins)
+                 */
+                *fsr = 0x00d; /* permission fault */
+                return true;
+            }
+
+            matchregion = n;
+            hit = true;
+
+            if (base & ~TARGET_PAGE_MASK) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPU_RBAR[%d]: No support for MPU region base"
+                              "address of 0x%" PRIx32 ". Minimum alignment is "
+                              "%d\n",
+                              n, base, TARGET_PAGE_BITS);
+                continue;
+            }
+            if ((limit + 1) & ~TARGET_PAGE_MASK) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPU_RBAR[%d]: No support for MPU region limit"
+                              "address of 0x%" PRIx32 ". Minimum alignment is "
+                              "%d\n",
+                              n, limit, TARGET_PAGE_BITS);
+                continue;
+            }
+        }
+    }
+
+    if (!hit) {
+        /* background fault */
+        *fsr = 0;
+        return true;
+    }
+
+    if (matchregion == -1) {
+        /* hit using the background region */
+        get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
+    } else {
+        uint32_t ap = extract32(env->pmsav8.rbar[matchregion], 1, 2);
+        uint32_t xn = extract32(env->pmsav8.rbar[matchregion], 0, 1);
+
+        if (m_is_system_region(env, address)) {
+            /* System space is always execute never */
+            xn = 1;
+        }
+
+        *prot = simple_ap_to_rw_prot(env, mmu_idx, ap);
+        if (*prot && !xn) {
+            *prot |= PAGE_EXEC;
+        }
+        /* We don't need to look the attribute up in the MAIR0/MAIR1
+         * registers because that only tells us about cacheability.
+         */
+    }
+
+    *fsr = 0x00d; /* Permission fault */
+    return !(*prot & (1 << access_type));
+}
+
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
@@ -8585,7 +8690,11 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         bool ret;
         *page_size = TARGET_PAGE_SIZE;
 
-        if (arm_feature(env, ARM_FEATURE_V7)) {
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            /* PMSAv8 */
+            ret = get_phys_addr_pmsav8(env, address, access_type, mmu_idx,
+                                       phys_ptr, prot, fsr);
+        } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
                                        phys_ptr, prot, fsr);
-- 
2.7.4
