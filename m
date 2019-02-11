Received: from eggs.gnu.org ([209.51.188.92]:37791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNr-00051I-NT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLNq-0004Io-5J
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:07 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLNp-0004H3-RI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:06 -0500
Received: by mail-pg1-x543.google.com with SMTP id z11so335240pgu.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:32 -0800
Message-Id: <20190211235258.542-3-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 02/28] target/arm: Split helper_msr_i_pstate
 into 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

The EL0+UMA check is unique to DAIF.  While SPSel had avoided the
check by nature of already checking EL >= 1, the other post v8.0
extensions to MSR (imm) allow EL0 and do not require UMA.  Avoid
the unconditional write to pc and use raise_exception_ra to unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  3 +++
 target/arm/helper.h        |  1 -
 target/arm/internals.h     | 15 ++++++++++++++
 target/arm/helper-a64.c    | 30 +++++++++++++++++++++++++++
 target/arm/op_helper.c     | 42 --------------------------------------
 target/arm/translate-a64.c | 41 ++++++++++++++++++++++---------------
 6 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index aff8d6c9f3..a915c1247f 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -19,6 +19,9 @@
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
+DEF_HELPER_2(msr_i_spsel, void, env, i32)
+DEF_HELPER_2(msr_i_daifset, void, env, i32)
+DEF_HELPER_2(msr_i_daifclear, void, env, i32)
 DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c6..28b1dd6252 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -77,7 +77,6 @@ DEF_HELPER_2(get_cp_reg, i32, env, ptr)
 DEF_HELPER_3(set_cp_reg64, void, env, ptr, i64)
 DEF_HELPER_2(get_cp_reg64, i64, env, ptr)
 
-DEF_HELPER_3(msr_i_pstate, void, env, i32, i32)
 DEF_HELPER_1(clear_pstate_ss, void, env)
 
 DEF_HELPER_2(get_r13_banked, i32, env, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a4bd1becb7..587a1ddf58 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -968,4 +968,19 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
+static inline int exception_target_el(CPUARMState *env)
+{
+    int target_el = MAX(1, arm_current_el(env));
+
+    /*
+     * No such thing as secure EL1 if EL3 is aarch32,
+     * so update the target EL to EL3 in this case.
+     */
+    if (arm_is_secure(env) && !arm_el_is_aa64(env, 3) && target_el == 1) {
+        target_el = 3;
+    }
+
+    return target_el;
+}
+
 #endif
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 101fa6d3ea..87b8f36122 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -61,6 +61,36 @@ uint64_t HELPER(rbit64)(uint64_t x)
     return revbit64(x);
 }
 
+void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
+{
+    update_spsel(env, imm);
+}
+
+static void daif_check(CPUARMState *env, uint32_t op,
+                       uint32_t imm, uintptr_t ra)
+{
+    /* DAIF update to PSTATE. This is OK from EL0 only if UMA is set.  */
+    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+        raise_exception_ra(env, EXCP_UDEF,
+                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
+                                               extract32(op, 3, 3), 4,
+                                               imm, 0x1f, 0),
+                           exception_target_el(env), ra);
+    }
+}
+
+void HELPER(msr_i_daifset)(CPUARMState *env, uint32_t imm)
+{
+    daif_check(env, 0x1e, imm, GETPC());
+    env->daif |= (imm << 6) & PSTATE_DAIF;
+}
+
+void HELPER(msr_i_daifclear)(CPUARMState *env, uint32_t imm)
+{
+    daif_check(env, 0x1f, imm, GETPC());
+    env->daif &= ~((imm << 6) & PSTATE_DAIF);
+}
+
 /* Convert a softfloat float_relation_ (as returned by
  * the float*_compare functions) to the correct ARM
  * NZCV flag state.
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c998eadfaa..c5721a866d 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -68,20 +68,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     cpu_loop_exit_restore(cs, ra);
 }
 
-static int exception_target_el(CPUARMState *env)
-{
-    int target_el = MAX(1, arm_current_el(env));
-
-    /* No such thing as secure EL1 if EL3 is aarch32, so update the target EL
-     * to EL3 in this case.
-     */
-    if (arm_is_secure(env) && !arm_el_is_aa64(env, 3) && target_el == 1) {
-        target_el = 3;
-    }
-
-    return target_el;
-}
-
 uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
                           uint32_t maxindex)
 {
@@ -875,34 +861,6 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
     return res;
 }
 
-void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
-{
-    /* MSR_i to update PSTATE. This is OK from EL0 only if UMA is set.
-     * Note that SPSel is never OK from EL0; we rely on handle_msr_i()
-     * to catch that case at translate time.
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
-        uint32_t syndrome = syn_aa64_sysregtrap(0, extract32(op, 0, 3),
-                                                extract32(op, 3, 3), 4,
-                                                imm, 0x1f, 0);
-        raise_exception(env, EXCP_UDEF, syndrome, exception_target_el(env));
-    }
-
-    switch (op) {
-    case 0x05: /* SPSel */
-        update_spsel(env, imm);
-        break;
-    case 0x1e: /* DAIFSet */
-        env->daif |= (imm << 6) & PSTATE_DAIF;
-        break;
-    case 0x1f: /* DAIFClear */
-        env->daif &= ~((imm << 6) & PSTATE_DAIF);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 void HELPER(clear_pstate_ss)(CPUARMState *env)
 {
     env->pstate &= ~PSTATE_SS;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 27b90d5778..13e010d27b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1647,29 +1647,38 @@ static void handle_sync(DisasContext *s, uint32_t insn,
 static void handle_msr_i(DisasContext *s, uint32_t insn,
                          unsigned int op1, unsigned int op2, unsigned int crm)
 {
+    TCGv_i32 t1;
     int op = op1 << 3 | op2;
+
+    /* End the TB by default, chaining is ok.  */
+    s->base.is_jmp = DISAS_TOO_MANY;
+
     switch (op) {
     case 0x05: /* SPSel */
         if (s->current_el == 0) {
-            unallocated_encoding(s);
-            return;
+            goto do_unallocated;
         }
-        /* fall through */
-    case 0x1e: /* DAIFSet */
-    case 0x1f: /* DAIFClear */
-    {
-        TCGv_i32 tcg_imm = tcg_const_i32(crm);
-        TCGv_i32 tcg_op = tcg_const_i32(op);
-        gen_a64_set_pc_im(s->pc - 4);
-        gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
-        tcg_temp_free_i32(tcg_imm);
-        tcg_temp_free_i32(tcg_op);
-        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
-        gen_a64_set_pc_im(s->pc);
-        s->base.is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);
+        t1 = tcg_const_i32(crm & PSTATE_SP);
+        gen_helper_msr_i_spsel(cpu_env, t1);
+        tcg_temp_free_i32(t1);
         break;
-    }
+
+    case 0x1e: /* DAIFSet */
+        t1 = tcg_const_i32(crm);
+        gen_helper_msr_i_daifset(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        break;
+
+    case 0x1f: /* DAIFClear */
+        t1 = tcg_const_i32(crm);
+        gen_helper_msr_i_daifclear(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
+        s->base.is_jmp = DISAS_UPDATE;
+        break;
+
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
-- 
2.17.2
