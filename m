Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxa-0004Pa-PC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxZ-0005Nf-Rt
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:26 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxZ-0005NL-MW
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:25 -0500
Received: by mail-oi1-x236.google.com with SMTP id v6so3644512oif.2
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:53 -0600
Message-Id: <20181214052410.11863-11-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 10/27] target/arm: Add new_pc argument to
 helper_exception_return
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  2 +-
 target/arm/helper-a64.c    | 10 +++++-----
 target/arm/translate-a64.c |  7 ++++++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 55299896c4..aff8d6c9f3 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -86,7 +86,7 @@ DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
-DEF_HELPER_1(exception_return, void, env)
+DEF_HELPER_2(exception_return, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index f70c8d9818..79cc9cf47b 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -925,7 +925,7 @@ static int el_from_spsr(uint32_t spsr)
     }
 }
 
-void HELPER(exception_return)(CPUARMState *env)
+void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
 {
     int cur_el = arm_current_el(env);
     unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
@@ -991,9 +991,9 @@ void HELPER(exception_return)(CPUARMState *env)
         aarch64_sync_64_to_32(env);
 
         if (spsr & CPSR_T) {
-            env->regs[15] = env->elr_el[cur_el] & ~0x1;
+            env->regs[15] = new_pc & ~0x1;
         } else {
-            env->regs[15] = env->elr_el[cur_el] & ~0x3;
+            env->regs[15] = new_pc & ~0x3;
         }
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
@@ -1005,7 +1005,7 @@ void HELPER(exception_return)(CPUARMState *env)
             env->pstate &= ~PSTATE_SS;
         }
         aarch64_restore_sp(env, new_el);
-        env->pc = env->elr_el[cur_el];
+        env->pc = new_pc;
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
@@ -1031,7 +1031,7 @@ illegal_return:
      * no change to exception level, execution state or stack pointer
      */
     env->pstate |= PSTATE_IL;
-    env->pc = env->elr_el[cur_el];
+    env->pc = new_pc;
     spsr &= PSTATE_NZCV | PSTATE_DAIF;
     spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF);
     pstate_write(env, spsr);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d034a5edf3..c84c2dbb66 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1981,6 +1981,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
 static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
     unsigned int opc, op2, op3, rn, op4;
+    TCGv_i64 dst;
 
     opc = extract32(insn, 21, 4);
     op2 = extract32(insn, 16, 5);
@@ -2011,7 +2012,11 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
-        gen_helper_exception_return(cpu_env);
+        dst = tcg_temp_new_i64();
+        tcg_gen_ld_i64(dst, cpu_env,
+                       offsetof(CPUARMState, elr_el[s->current_el]));
+        gen_helper_exception_return(cpu_env, dst);
+        tcg_temp_free_i64(dst);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
         }
-- 
2.17.2
