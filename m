Received: from eggs.gnu.org ([209.51.188.92]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfaR-00066I-73
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfVU-0007IF-Ni
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:45:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqfVU-0007GT-F8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:45:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so164505otk.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20190204132126.3255-1-richard.henderson@linaro.org>
	<20190204132126.3255-4-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:45:43 +0000
Message-ID: <CAFEAcA84U00c=_q2Okkpd3vpwEC6O7KHMcz5NDTch+yOLLtd-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] target/arm: Compute TB_FLAGS for
 TBI for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Feb 2019 at 13:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Enables, but does not turn on, TBI for CONFIG_USER_ONLY.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This patch turns out to break compilation of the linux-user
targets with clang, which is stricter than gcc about warning about
unused static functions.

I propose to squash in the following fixup patch:

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c99b69074a5..935c6f9bfa7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9601,6 +9601,8 @@ static inline uint32_t regime_el(CPUARMState
*env, ARMMMUIdx mmu_idx)
     }
 }

+#ifndef CONFIG_USER_ONLY
+
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
@@ -9656,6 +9658,22 @@ static inline bool
regime_translation_big_endian(CPUARMState *env,
     return (regime_sctlr(env, mmu_idx) & SCTLR_EE) != 0;
 }

+/* Return the TTBR associated with this translation regime */
+static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
+                                   int ttbrn)
+{
+    if (mmu_idx == ARMMMUIdx_S2NS) {
+        return env->cp15.vttbr_el2;
+    }
+    if (ttbrn == 0) {
+        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
+    } else {
+        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
+    }
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
@@ -9676,20 +9694,6 @@ static inline ARMMMUIdx
stage_1_mmu_idx(ARMMMUIdx mmu_idx)
     return mmu_idx;
 }

-/* Return the TTBR associated with this translation regime */
-static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
-                                   int ttbrn)
-{
-    if (mmu_idx == ARMMMUIdx_S2NS) {
-        return env->cp15.vttbr_el2;
-    }
-    if (ttbrn == 0) {
-        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
-    } else {
-        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
-    }
-}
-
 /* Return true if the translation regime is using LPAE format page tables */
 static inline bool regime_using_lpae_format(CPUARMState *env,
                                             ARMMMUIdx mmu_idx)
@@ -9715,6 +9719,7 @@ bool arm_s1_regime_using_lpae_format(CPUARMState
*env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }

+#ifndef CONFIG_USER_ONLY
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
@@ -9733,7 +9738,6 @@ static inline bool regime_is_user(CPUARMState
*env, ARMMMUIdx mmu_idx)
     }
 }

-#ifndef CONFIG_USER_ONLY
 /* Translate section/page access permissions to page
  * R/W protection flags
  *

thanks
-- PMM
