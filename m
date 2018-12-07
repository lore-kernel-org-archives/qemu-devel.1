Received: from eggs.gnu.org ([2001:4830:134:3::10]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUy-0007yn-KW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUx-0007Fn-AG
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDUx-0007FK-3M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id x23so3004975oix.3
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:09 -0600
Message-Id: <20181207103631.28193-5-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/26] target/arm: Add PAuth helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

The cryptographic internals are stubbed out for now,
but the enable and trap bits are checked.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h |  12 +++
 target/arm/internals.h  |   6 ++
 target/arm/helper-a64.c | 169 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 9d3a907049..70f6145b11 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -85,3 +85,15 @@ DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
+
+DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacda, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacdb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacga, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autia, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autib, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 78e026d6e9..6bc0daf560 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -259,6 +259,7 @@ enum arm_exception_class {
     EC_CP14DTTRAP             = 0x06,
     EC_ADVSIMDFPACCESSTRAP    = 0x07,
     EC_FPIDTRAP               = 0x08,
+    EC_PACTRAP                = 0x09,
     EC_CP14RRTTRAP            = 0x0c,
     EC_ILLEGALSTATE           = 0x0e,
     EC_AA32_SVC               = 0x11,
@@ -426,6 +427,11 @@ static inline uint32_t syn_sve_access_trap(void)
     return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_pactrap(void)
+{
+    return EC_PACTRAP << ARM_EL_EC_SHIFT;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 61799d20e1..4aa34d4a3a 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -898,4 +898,173 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
     return float16_sqrt(a, s);
 }
 
+/*
+ * Helpers for ARMv8.3-PAuth.
+ */
 
+static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
+                                 uint64_t key0, uint64_t key1)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
+                             uint64_t *key, bool data)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
+                           uint64_t *key, bool data, int keynumber)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_strip(CPUARMState *env, uint64_t a, bool data)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
+                                     uintptr_t ra)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+
+    cs->exception_index = EXCP_UDEF;
+    env->exception.syndrome = syn_pactrap();
+    env->exception.target_el = target_el;
+    cpu_loop_exit_restore(cs, ra);
+}
+
+static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
+{
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        bool trap = !(hcr & HCR_API);
+        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
+        /* FIXME: PMM mentioned a "late breaking spec change" here.  */
+        if (trap) {
+            pauth_trap(env, 2, ra);
+        }
+    }
+    if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+        if (!(env->cp15.scr_el3 & SCR_API)) {
+            pauth_trap(env, 3, ra);
+        }
+    }
+}
+
+static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
+{
+    uint32_t sctlr;
+    if (el == 0) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        sctlr = env->cp15.sctlr_el[1];
+    } else {
+        sctlr = env->cp15.sctlr_el[el];
+    }
+    return (sctlr & bit) != 0;
+}
+
+uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, env->apia_key, false);
+}
+
+uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, env->apib_key, false);
+}
+
+uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, env->apda_key, true);
+}
+
+uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, env->apdb_key, true);
+}
+
+uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    uint64_t pac;
+
+    pauth_check_trap(env, arm_current_el(env), GETPC());
+    pac = pauth_computepac(x, y, env->apga_key[1], env->apga_key[0]);
+
+    return pac & 0xffffffff00000000ull;
+}
+
+uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, env->apia_key, false, 0);
+}
+
+uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, env->apib_key, false, 1);
+}
+
+uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, env->apda_key, true, 0);
+}
+
+uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, env->apdb_key, true, 1);
+}
+
+uint64_t HELPER(xpaci)(CPUARMState *env, uint64_t a)
+{
+    pauth_check_trap(env, arm_current_el(env), GETPC());
+    return pauth_strip(env, a, false);
+}
+
+uint64_t HELPER(xpacd)(CPUARMState *env, uint64_t a)
+{
+    pauth_check_trap(env, arm_current_el(env), GETPC());
+    return pauth_strip(env, a, true);
+}
-- 
2.17.2
