Received: from eggs.gnu.org ([2001:4830:134:3::10]:55629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxX-0004Ow-6Z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxV-0005Ky-B1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxT-0005Jn-Dr
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id 40so4318573oth.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:46 -0600
Message-Id: <20181214052410.11863-4-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/27] target/arm: Add PAuth active bit to
 tbflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

There are 5 bits of state that could be added, but to save
space within tbflags, add only a single enable bit.
Helpers will determine the rest of the state at runtime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
----
v2: Fix whitespace, comment grammar.
---
 target/arm/cpu.h           |  4 ++++
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 19 +++++++++++++++++++
 target/arm/translate-a64.c |  1 +
 4 files changed, 26 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cd2519d43e..898243c93e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3032,6 +3032,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #define ARM_TBFLAG_SVEEXC_EL_MASK   (0x3 << ARM_TBFLAG_SVEEXC_EL_SHIFT)
 #define ARM_TBFLAG_ZCR_LEN_SHIFT    4
 #define ARM_TBFLAG_ZCR_LEN_MASK     (0xf << ARM_TBFLAG_ZCR_LEN_SHIFT)
+#define ARM_TBFLAG_PAUTH_ACTIVE_SHIFT  8
+#define ARM_TBFLAG_PAUTH_ACTIVE_MASK   (1ull << ARM_TBFLAG_PAUTH_ACTIVE_SHIFT)
 
 /* some convenience accessor macros */
 #define ARM_TBFLAG_AARCH64_STATE(F) \
@@ -3074,6 +3076,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     (((F) & ARM_TBFLAG_SVEEXC_EL_MASK) >> ARM_TBFLAG_SVEEXC_EL_SHIFT)
 #define ARM_TBFLAG_ZCR_LEN(F) \
     (((F) & ARM_TBFLAG_ZCR_LEN_MASK) >> ARM_TBFLAG_ZCR_LEN_SHIFT)
+#define ARM_TBFLAG_PAUTH_ACTIVE(F) \
+    (((F) & ARM_TBFLAG_PAUTH_ACTIVE_MASK) >> ARM_TBFLAG_PAUTH_ACTIVE_SHIFT)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1550aa8bc7..d8a8bb4e9c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -68,6 +68,8 @@ typedef struct DisasContext {
     bool is_ldex;
     /* True if a single-step exception will be taken to the current EL */
     bool ss_same_el;
+    /* True if v8.3-PAuth is active.  */
+    bool pauth_active;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* TCG op of the current insn_start.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 644599b29d..bd0cff5c27 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12981,6 +12981,25 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
             flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
         }
+
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            /*
+             * In order to save space in flags, we record only whether
+             * pauth is "inactive", meaning all insns are implemented as
+             * a nop, or "active" when some action must be performed.
+             * The decision of which action to take is left to a helper.
+             */
+            uint64_t sctlr;
+            if (current_el == 0) {
+                /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+                sctlr = env->cp15.sctlr_el[1];
+            } else {
+                sctlr = env->cp15.sctlr_el[current_el];
+            }
+            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
+                flags |= ARM_TBFLAG_PAUTH_ACTIVE_MASK;
+            }
+        }
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e1da1e4d6f..7c1cc1ce8e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13407,6 +13407,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
     dc->sve_excp_el = ARM_TBFLAG_SVEEXC_EL(dc->base.tb->flags);
     dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;
+    dc->pauth_active = ARM_TBFLAG_PAUTH_ACTIVE(dc->base.tb->flags);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.2
