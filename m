Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQg-00086E-E0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQf-0004HD-ER
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:00:03 +0100
Message-Id: <1506092407-26985-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 16/20] target/arm: Factor out "get mmuidx for
 specified security state"
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

For the SG instruction and secure function return we are going
to want to do memory accesses using the MMU index of the CPU
in secure state, even though the CPU is currently in non-secure
state. Write arm_v7m_mmu_idx_for_secstate() to do this job,
and use it in cpu_mmu_index().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 70c1f85..89d49cd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2329,23 +2329,33 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the MMU index for a v7M CPU in the specified security state */
+static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
+                                                     bool secstate)
+{
+    int el = arm_current_el(env);
+    ARMMMUIdx mmu_idx;
+
+    if (el == 0) {
+        mmu_idx = secstate ? ARMMMUIdx_MSUser : ARMMMUIdx_MUser;
+    } else {
+        mmu_idx = secstate ? ARMMMUIdx_MSPriv : ARMMMUIdx_MPriv;
+    }
+
+    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+        mmu_idx = secstate ? ARMMMUIdx_MSNegPri : ARMMMUIdx_MNegPri;
+    }
+
+    return mmu_idx;
+}
+
 /* Determine the current mmu_idx to use for normal loads/stores */
 static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
     int el = arm_current_el(env);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-        ARMMMUIdx mmu_idx;
-
-        if (el == 0) {
-            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSUser : ARMMMUIdx_MUser;
-        } else {
-            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSPriv : ARMMMUIdx_MPriv;
-        }
-
-        if (armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
-            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSNegPri : ARMMMUIdx_MNegPri;
-        }
+        ARMMMUIdx mmu_idx = arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
 
         return arm_to_core_mmu_idx(mmu_idx);
     }
-- 
2.7.4
