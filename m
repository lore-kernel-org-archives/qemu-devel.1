Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWe-0004mW-8l
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWd-0007wy-Ag
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:00 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWd-0007um-3J
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWc-0007ic-4g
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:58 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:20 +0000
Message-Id: <1513188761-20784-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/43] target/arm: Create new
 arm_v7m_mmu_idx_for_secstate_and_priv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The TT instruction is going to need to look up the MMU index
for a specified security and privilege state. Refactor the
existing arm_v7m_mmu_idx_for_secstate() into a version that
lets you specify the privilege state and one that uses the
current state of the CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1512153879-5291-6-git-send-email-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/cpu.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c42d62d..9631670 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2339,14 +2339,16 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
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
         mmu_idx |= ARM_MMU_IDX_M_PRIV;
     }
 
@@ -2361,6 +2363,15 @@ static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
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
