Received: from eggs.gnu.org ([2001:4830:134:3::10]:47210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQf-00085G-IK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQe-0004Fw-L8
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:00:02 +0100
Message-Id: <1506092407-26985-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 15/20] target/arm: Fix calculation of secure
 mm_idx values
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

In cpu_mmu_index() we try to do this:
        if (env->v7m.secure) {
            mmu_idx += ARMMMUIdx_MSUser;
        }
but it will give the wrong answer, because ARMMMUIdx_MSUser
includes the 0x40 ARM_MMU_IDX_M field, and so does the
mmu_idx we're adding to, and we'll end up with 0x8n rather
than 0x4n. This error is then nullified by the call to
arm_to_core_mmu_idx() which masks out the high part, but
we're about to factor out the code that calculates the
ARMMMUIdx values so it can be used without passing it through
arm_to_core_mmu_idx(), so fix this bug first.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 441e584..70c1f85 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2335,14 +2335,16 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
     int el = arm_current_el(env);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-        ARMMMUIdx mmu_idx = el == 0 ? ARMMMUIdx_MUser : ARMMMUIdx_MPriv;
+        ARMMMUIdx mmu_idx;
 
-        if (armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
-            mmu_idx = ARMMMUIdx_MNegPri;
+        if (el == 0) {
+            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSUser : ARMMMUIdx_MUser;
+        } else {
+            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSPriv : ARMMMUIdx_MPriv;
         }
 
-        if (env->v7m.secure) {
-            mmu_idx += ARMMMUIdx_MSUser;
+        if (armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
+            mmu_idx = env->v7m.secure ? ARMMMUIdx_MSNegPri : ARMMMUIdx_MNegPri;
         }
 
         return arm_to_core_mmu_idx(mmu_idx);
-- 
2.7.4
