Received: from eggs.gnu.org ([209.51.188.92]:34860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfY-00055v-KR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfW-0001V6-JC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfU-0001Qs-Fy
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so25318242wmk.4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:38 +0100
Message-Id: <20190416125744.27770-21-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/26] target/arm: New helper function
 arm_v7m_mmu_idx_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Add a new helper function which returns the MMU index to use
for v7M, where the caller specifies all of the security
state, privilege level and whether the execution priority
is negative, and reimplement the existing
arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.

We are going to need this for the lazy-FP-stacking code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Suggestions for better function name welcome.
arm_v7m_mmu_idx_for_secstate_and_priv_and_negpri()
just seems way too long and unwieldy...
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 500e0ab4c5d..0a1b82dc996 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2912,6 +2912,13 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     }
 }
 
+/*
+ * Return the MMU index for a v7M CPU with all relevant information
+ * manually specified.
+ */
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri);
+
 /* Return the MMU index for a v7M CPU in the specified security and
  * privilege state.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2feb3f664fe..c8e30b40366 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13235,8 +13235,8 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                bool secstate, bool priv)
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
 
@@ -13244,7 +13244,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
         mmu_idx |= ARM_MMU_IDX_M_PRIV;
     }
 
-    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+    if (negpri) {
         mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
     }
 
@@ -13255,6 +13255,14 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
     return mmu_idx;
 }
 
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                bool secstate, bool priv)
+{
+    bool negpri = armv7m_nvic_neg_prio_requested(env->nvic, secstate);
+
+    return arm_v7m_mmu_idx_all(env, secstate, priv, negpri);
+}
+
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 {
-- 
2.20.1
