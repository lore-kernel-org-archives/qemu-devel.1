Received: from eggs.gnu.org ([209.51.188.92]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8u-0003LF-0N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-000556-KE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:03 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00050R-64
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lf1-x142.google.com with SMTP id q11so5803736lfd.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:57 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:54 -0800
Message-Id: <20190214230000.24894-8-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 07/13] target/xtensa: move WINDOW_BASE SR
 update to postprocessing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Opcodes that modify WINDOW_BASE SR don't have dependency on opcodes that
use windowed registers. If such opcodes are combined in a single
instruction they may not be correctly ordered. Instead of adding said
dependency use temporary register to store changed WINDOW_BASE value and
do actual register window rotation as a postprocessing step.
Not all opcodes that change WINDOW_BASE need this: retw, rfwo and rfwu
are also jump opcodes, so they are guaranteed to be translated last and
thus will not affect other opcodes in the same instruction.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h        |  1 +
 target/xtensa/helper.h     |  3 +--
 target/xtensa/translate.c  | 30 ++++++++++++++++++++++--------
 target/xtensa/win_helper.c | 14 ++++----------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a3bab9c5a254..dca4e4b1114b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -486,6 +486,7 @@ typedef struct CPUXtensaState {
         float64 f64;
     } fregs[16];
     float_status fp_status;
+    uint32_t windowbase_next;
 
 #ifndef CONFIG_USER_ONLY
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 2a7db35874fe..b6529a8925f3 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -3,12 +3,11 @@ DEF_HELPER_3(exception_cause, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_cause_vaddr, noreturn, env, i32, i32, i32)
 DEF_HELPER_3(debug_exception, noreturn, env, i32, i32)
 
-DEF_HELPER_2(wsr_windowbase, void, env, i32)
+DEF_HELPER_1(sync_windowbase, void, env)
 DEF_HELPER_4(entry, void, env, i32, i32, i32)
 DEF_HELPER_2(test_ill_retw, void, env, i32)
 DEF_HELPER_2(test_underflow_retw, void, env, i32)
 DEF_HELPER_2(retw, i32, env, i32)
-DEF_HELPER_2(rotw, void, env, i32)
 DEF_HELPER_3(window_check, noreturn, env, i32, i32)
 DEF_HELPER_1(restore_owb, void, env)
 DEF_HELPER_2(movsp, void, env, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 149fcd37f9a1..0213cef1b605 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -82,6 +82,7 @@ static TCGv_i32 cpu_R[16];
 static TCGv_i32 cpu_FR[16];
 static TCGv_i32 cpu_SR[256];
 static TCGv_i32 cpu_UR[256];
+static TCGv_i32 cpu_windowbase_next;
 
 #include "exec/gen-icount.h"
 
@@ -253,6 +254,11 @@ void xtensa_translate_init(void)
                     uregnames[i].name);
         }
     }
+
+    cpu_windowbase_next =
+        tcg_global_mem_new_i32(cpu_env,
+                               offsetof(CPUXtensaState, windowbase_next),
+                               "windowbase_next");
 }
 
 static inline bool option_enabled(DisasContext *dc, int opt)
@@ -557,7 +563,7 @@ static void gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 #ifndef CONFIG_USER_ONLY
 static void gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
-    gen_helper_wsr_windowbase(cpu_env, v);
+    tcg_gen_mov_i32(cpu_windowbase_next, v);
 }
 
 static void gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -859,6 +865,9 @@ static int gen_postprocess(DisasContext *dc, int slot)
     if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
         gen_check_interrupts(dc);
     }
+    if (op_flags & XTENSA_OP_SYNC_REGISTER_WINDOW) {
+        gen_helper_sync_windowbase(cpu_env);
+    }
     if (op_flags & XTENSA_OP_EXIT_TB_M1) {
         slot = -1;
     }
@@ -2267,9 +2276,7 @@ static void translate_rfw(DisasContext *dc, const uint32_t arg[],
 static void translate_rotw(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_const_i32(arg[0]);
-    gen_helper_rotw(cpu_env, tmp);
-    tcg_temp_free(tmp);
+    tcg_gen_addi_i32(cpu_windowbase_next, cpu_SR[WINDOW_BASE], arg[0]);
 }
 
 static void translate_rsil(DisasContext *dc, const uint32_t arg[],
@@ -2971,7 +2978,8 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_entry,
         .test_ill = test_ill_entry,
         .test_overflow = test_overflow_entry,
-        .op_flags = XTENSA_OP_EXIT_TB_M1,
+        .op_flags = XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "esync",
         .translate = translate_nop,
@@ -3553,7 +3561,9 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rotw",
         .translate = translate_rotw,
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+        .op_flags = XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "rsil",
         .translate = translate_rsil,
@@ -4621,7 +4631,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+        .op_flags = XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
@@ -5107,7 +5119,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+        .op_flags = XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
index 7d793d4f9cff..d7a4e2782186 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -96,9 +96,9 @@ void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta)
     xtensa_rotate_window_abs(env, env->sregs[WINDOW_BASE] + delta);
 }
 
-void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
+void HELPER(sync_windowbase)(CPUXtensaState *env)
 {
-    xtensa_rotate_window_abs(env, v);
+    xtensa_rotate_window_abs(env, env->windowbase_next);
 }
 
 void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
@@ -106,9 +106,8 @@ void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
     int callinc = (env->sregs[PS] & PS_CALLINC) >> PS_CALLINC_SHIFT;
 
     env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
-    xtensa_rotate_window(env, callinc);
-    env->sregs[WINDOW_START] |=
-        windowstart_bit(env->sregs[WINDOW_BASE], env);
+    env->windowbase_next = env->sregs[WINDOW_BASE] + callinc;
+    env->sregs[WINDOW_START] |= windowstart_bit(env->windowbase_next, env);
 }
 
 void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
@@ -196,11 +195,6 @@ uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
     return ret_pc;
 }
 
-void HELPER(rotw)(CPUXtensaState *env, uint32_t imm4)
-{
-    xtensa_rotate_window(env, imm4);
-}
-
 void xtensa_restore_owb(CPUXtensaState *env)
 {
     xtensa_rotate_window_abs(env, (env->sregs[PS] & PS_OWB) >> PS_OWB_SHIFT);
-- 
2.11.0
