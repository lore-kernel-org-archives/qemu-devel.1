Received: from eggs.gnu.org ([209.51.188.92]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0002lH-Ux
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007MF-ID
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007DK-9D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id y185so1177885wmd.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:31 +0000
Message-Id: <20190118145805.6852-16-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/49] target/arm: Add new_pc argument to
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  2 +-
 target/arm/helper-a64.c    | 10 +++++-----
 target/arm/translate-a64.c |  7 ++++++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 55299896c46..aff8d6c9f39 100644
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
index 66ff70dcdbb..101fa6d3eaa 100644
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
index 3f08db580bf..2df2323646b 100644
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
2.20.1
