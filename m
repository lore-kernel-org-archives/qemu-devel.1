Received: from eggs.gnu.org ([209.51.188.92]:43181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVba-0002qq-9i
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0007P6-I3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbT-0007Cq-4M
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id l9so15347830wrt.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:30 +0000
Message-Id: <20190118145805.6852-15-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/49] target/arm: Move helper_exception_return
 to helper-a64.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

This function is only used by AArch64.  Code movement only.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h |   2 +
 target/arm/helper.h     |   1 -
 target/arm/helper-a64.c | 155 ++++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c  | 155 ----------------------------------------
 4 files changed, 157 insertions(+), 156 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 28aa0af69dd..55299896c46 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -86,6 +86,8 @@ DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
+DEF_HELPER_1(exception_return, void, env)
+
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacda, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8c9590091b0..53a38188c66 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -79,7 +79,6 @@ DEF_HELPER_2(get_cp_reg64, i64, env, ptr)
 
 DEF_HELPER_3(msr_i_pstate, void, env, i32, i32)
 DEF_HELPER_1(clear_pstate_ss, void, env)
-DEF_HELPER_1(exception_return, void, env)
 
 DEF_HELPER_2(get_r13_banked, i32, env, i32)
 DEF_HELPER_3(set_r13_banked, void, env, i32, i32)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 61799d20e13..66ff70dcdbb 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -887,6 +887,161 @@ uint32_t HELPER(advsimd_f16touinth)(uint32_t a, void *fpstp)
     return float16_to_uint16(a, fpst);
 }
 
+static int el_from_spsr(uint32_t spsr)
+{
+    /* Return the exception level that this SPSR is requesting a return to,
+     * or -1 if it is invalid (an illegal return)
+     */
+    if (spsr & PSTATE_nRW) {
+        switch (spsr & CPSR_M) {
+        case ARM_CPU_MODE_USR:
+            return 0;
+        case ARM_CPU_MODE_HYP:
+            return 2;
+        case ARM_CPU_MODE_FIQ:
+        case ARM_CPU_MODE_IRQ:
+        case ARM_CPU_MODE_SVC:
+        case ARM_CPU_MODE_ABT:
+        case ARM_CPU_MODE_UND:
+        case ARM_CPU_MODE_SYS:
+            return 1;
+        case ARM_CPU_MODE_MON:
+            /* Returning to Mon from AArch64 is never possible,
+             * so this is an illegal return.
+             */
+        default:
+            return -1;
+        }
+    } else {
+        if (extract32(spsr, 1, 1)) {
+            /* Return with reserved M[1] bit set */
+            return -1;
+        }
+        if (extract32(spsr, 0, 4) == 1) {
+            /* return to EL0 with M[0] bit set */
+            return -1;
+        }
+        return extract32(spsr, 2, 2);
+    }
+}
+
+void HELPER(exception_return)(CPUARMState *env)
+{
+    int cur_el = arm_current_el(env);
+    unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
+    uint32_t spsr = env->banked_spsr[spsr_idx];
+    int new_el;
+    bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
+
+    aarch64_save_sp(env, cur_el);
+
+    arm_clear_exclusive(env);
+
+    /* We must squash the PSTATE.SS bit to zero unless both of the
+     * following hold:
+     *  1. debug exceptions are currently disabled
+     *  2. singlestep will be active in the EL we return to
+     * We check 1 here and 2 after we've done the pstate/cpsr write() to
+     * transition to the EL we're going to.
+     */
+    if (arm_generate_debug_exceptions(env)) {
+        spsr &= ~PSTATE_SS;
+    }
+
+    new_el = el_from_spsr(spsr);
+    if (new_el == -1) {
+        goto illegal_return;
+    }
+    if (new_el > cur_el
+        || (new_el == 2 && !arm_feature(env, ARM_FEATURE_EL2))) {
+        /* Disallow return to an EL which is unimplemented or higher
+         * than the current one.
+         */
+        goto illegal_return;
+    }
+
+    if (new_el != 0 && arm_el_is_aa64(env, new_el) != return_to_aa64) {
+        /* Return to an EL which is configured for a different register width */
+        goto illegal_return;
+    }
+
+    if (new_el == 2 && arm_is_secure_below_el3(env)) {
+        /* Return to the non-existent secure-EL2 */
+        goto illegal_return;
+    }
+
+    if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
+        goto illegal_return;
+    }
+
+    qemu_mutex_lock_iothread();
+    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+
+    if (!return_to_aa64) {
+        env->aarch64 = 0;
+        /* We do a raw CPSR write because aarch64_sync_64_to_32()
+         * will sort the register banks out for us, and we've already
+         * caught all the bad-mode cases in el_from_spsr().
+         */
+        cpsr_write(env, spsr, ~0, CPSRWriteRaw);
+        if (!arm_singlestep_active(env)) {
+            env->uncached_cpsr &= ~PSTATE_SS;
+        }
+        aarch64_sync_64_to_32(env);
+
+        if (spsr & CPSR_T) {
+            env->regs[15] = env->elr_el[cur_el] & ~0x1;
+        } else {
+            env->regs[15] = env->elr_el[cur_el] & ~0x3;
+        }
+        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
+                      "AArch32 EL%d PC 0x%" PRIx32 "\n",
+                      cur_el, new_el, env->regs[15]);
+    } else {
+        env->aarch64 = 1;
+        pstate_write(env, spsr);
+        if (!arm_singlestep_active(env)) {
+            env->pstate &= ~PSTATE_SS;
+        }
+        aarch64_restore_sp(env, new_el);
+        env->pc = env->elr_el[cur_el];
+        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
+                      "AArch64 EL%d PC 0x%" PRIx64 "\n",
+                      cur_el, new_el, env->pc);
+    }
+    /*
+     * Note that cur_el can never be 0.  If new_el is 0, then
+     * el0_a64 is return_to_aa64, else el0_a64 is ignored.
+     */
+    aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
+
+    qemu_mutex_lock_iothread();
+    arm_call_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
+
+    return;
+
+illegal_return:
+    /* Illegal return events of various kinds have architecturally
+     * mandated behaviour:
+     * restore NZCV and DAIF from SPSR_ELx
+     * set PSTATE.IL
+     * restore PC from ELR_ELx
+     * no change to exception level, execution state or stack pointer
+     */
+    env->pstate |= PSTATE_IL;
+    env->pc = env->elr_el[cur_el];
+    spsr &= PSTATE_NZCV | PSTATE_DAIF;
+    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF);
+    pstate_write(env, spsr);
+    if (!arm_singlestep_active(env)) {
+        env->pstate &= ~PSTATE_SS;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
+                  "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
+}
+
 /*
  * Square Root and Reciprocal square root
  */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8b31c6a13b8..c998eadfaa8 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1029,161 +1029,6 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
     }
 }
 
-static int el_from_spsr(uint32_t spsr)
-{
-    /* Return the exception level that this SPSR is requesting a return to,
-     * or -1 if it is invalid (an illegal return)
-     */
-    if (spsr & PSTATE_nRW) {
-        switch (spsr & CPSR_M) {
-        case ARM_CPU_MODE_USR:
-            return 0;
-        case ARM_CPU_MODE_HYP:
-            return 2;
-        case ARM_CPU_MODE_FIQ:
-        case ARM_CPU_MODE_IRQ:
-        case ARM_CPU_MODE_SVC:
-        case ARM_CPU_MODE_ABT:
-        case ARM_CPU_MODE_UND:
-        case ARM_CPU_MODE_SYS:
-            return 1;
-        case ARM_CPU_MODE_MON:
-            /* Returning to Mon from AArch64 is never possible,
-             * so this is an illegal return.
-             */
-        default:
-            return -1;
-        }
-    } else {
-        if (extract32(spsr, 1, 1)) {
-            /* Return with reserved M[1] bit set */
-            return -1;
-        }
-        if (extract32(spsr, 0, 4) == 1) {
-            /* return to EL0 with M[0] bit set */
-            return -1;
-        }
-        return extract32(spsr, 2, 2);
-    }
-}
-
-void HELPER(exception_return)(CPUARMState *env)
-{
-    int cur_el = arm_current_el(env);
-    unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
-    uint32_t spsr = env->banked_spsr[spsr_idx];
-    int new_el;
-    bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
-
-    aarch64_save_sp(env, cur_el);
-
-    arm_clear_exclusive(env);
-
-    /* We must squash the PSTATE.SS bit to zero unless both of the
-     * following hold:
-     *  1. debug exceptions are currently disabled
-     *  2. singlestep will be active in the EL we return to
-     * We check 1 here and 2 after we've done the pstate/cpsr write() to
-     * transition to the EL we're going to.
-     */
-    if (arm_generate_debug_exceptions(env)) {
-        spsr &= ~PSTATE_SS;
-    }
-
-    new_el = el_from_spsr(spsr);
-    if (new_el == -1) {
-        goto illegal_return;
-    }
-    if (new_el > cur_el
-        || (new_el == 2 && !arm_feature(env, ARM_FEATURE_EL2))) {
-        /* Disallow return to an EL which is unimplemented or higher
-         * than the current one.
-         */
-        goto illegal_return;
-    }
-
-    if (new_el != 0 && arm_el_is_aa64(env, new_el) != return_to_aa64) {
-        /* Return to an EL which is configured for a different register width */
-        goto illegal_return;
-    }
-
-    if (new_el == 2 && arm_is_secure_below_el3(env)) {
-        /* Return to the non-existent secure-EL2 */
-        goto illegal_return;
-    }
-
-    if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
-        goto illegal_return;
-    }
-
-    qemu_mutex_lock_iothread();
-    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
-    qemu_mutex_unlock_iothread();
-
-    if (!return_to_aa64) {
-        env->aarch64 = 0;
-        /* We do a raw CPSR write because aarch64_sync_64_to_32()
-         * will sort the register banks out for us, and we've already
-         * caught all the bad-mode cases in el_from_spsr().
-         */
-        cpsr_write(env, spsr, ~0, CPSRWriteRaw);
-        if (!arm_singlestep_active(env)) {
-            env->uncached_cpsr &= ~PSTATE_SS;
-        }
-        aarch64_sync_64_to_32(env);
-
-        if (spsr & CPSR_T) {
-            env->regs[15] = env->elr_el[cur_el] & ~0x1;
-        } else {
-            env->regs[15] = env->elr_el[cur_el] & ~0x3;
-        }
-        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
-                      "AArch32 EL%d PC 0x%" PRIx32 "\n",
-                      cur_el, new_el, env->regs[15]);
-    } else {
-        env->aarch64 = 1;
-        pstate_write(env, spsr);
-        if (!arm_singlestep_active(env)) {
-            env->pstate &= ~PSTATE_SS;
-        }
-        aarch64_restore_sp(env, new_el);
-        env->pc = env->elr_el[cur_el];
-        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
-                      "AArch64 EL%d PC 0x%" PRIx64 "\n",
-                      cur_el, new_el, env->pc);
-    }
-    /*
-     * Note that cur_el can never be 0.  If new_el is 0, then
-     * el0_a64 is return_to_aa64, else el0_a64 is ignored.
-     */
-    aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
-
-    qemu_mutex_lock_iothread();
-    arm_call_el_change_hook(arm_env_get_cpu(env));
-    qemu_mutex_unlock_iothread();
-
-    return;
-
-illegal_return:
-    /* Illegal return events of various kinds have architecturally
-     * mandated behaviour:
-     * restore NZCV and DAIF from SPSR_ELx
-     * set PSTATE.IL
-     * restore PC from ELR_ELx
-     * no change to exception level, execution state or stack pointer
-     */
-    env->pstate |= PSTATE_IL;
-    env->pc = env->elr_el[cur_el];
-    spsr &= PSTATE_NZCV | PSTATE_DAIF;
-    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF);
-    pstate_write(env, spsr);
-    if (!arm_singlestep_active(env)) {
-        env->pstate &= ~PSTATE_SS;
-    }
-    qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
-                  "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
-}
-
 /* Return true if the linked breakpoint entry lbn passes its checks */
 static bool linked_bp_matches(ARMCPU *cpu, int lbn)
 {
-- 
2.20.1
