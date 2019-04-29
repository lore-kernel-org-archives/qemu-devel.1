Received: from eggs.gnu.org ([209.51.188.92]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f0-00051k-8R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ev-0006pZ-CF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006V7-PH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y5so180516wma.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:11 +0100
Message-Id: <20190429170030.11323-24-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/42] target/arm: New helper function
 arm_v7m_mmu_idx_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a new helper function which returns the MMU index to use
for v7M, where the caller specifies all of the security
state, privilege level and whether the execution priority
is negative, and reimplement the existing
arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.

We are going to need this for the lazy-FP-stacking code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-21-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d4996a4d204..920cf367020 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2911,6 +2911,13 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
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
index 84e3790a9de..1ed5f1a2513 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13230,8 +13230,8 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                bool secstate, bool priv)
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri)
 {
     ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
 
@@ -13239,7 +13239,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
         mmu_idx |= ARM_MMU_IDX_M_PRIV;
     }
 
-    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+    if (negpri) {
         mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
     }
 
@@ -13250,6 +13250,14 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
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
