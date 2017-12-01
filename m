Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIy-0006OQ-Tf
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIy-00035O-2r
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:56 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:44:37 +0000
Message-Id: <1512153879-5291-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] target/arm: Create new
 arm_v7m_mmu_idx_for_secstate_and_priv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The TT instruction is going to need to look up the MMU index
for a specified security and privilege state. Refactor the
existing arm_v7m_mmu_idx_for_secstate() into a version that
lets you specify the privilege state and one that uses the
current state of the CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d228fe6..1f414fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2334,14 +2334,16 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     }
 }
 
-/* Return the MMU index for a v7M CPU in the specified security state */
-static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
-                                                     bool secstate)
+/* Return the MMU index for a v7M CPU in the specified security and
+ * privilege state
+ */
+static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                              bool secstate,
+                                                              bool priv)
 {
-    int el = arm_current_el(env);
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
 
-    if (el != 0) {
+    if (priv) {
         mmu_idx |= 1;
     }
 
@@ -2356,6 +2358,15 @@ static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
     return mmu_idx;
 }
 
+/* Return the MMU index for a v7M CPU in the specified security state */
+static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
+                                                     bool secstate)
+{
+    bool priv = arm_current_el(env) != 0;
+
+    return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
+}
+
 /* Determine the current mmu_idx to use for normal loads/stores */
 static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
-- 
2.7.4
