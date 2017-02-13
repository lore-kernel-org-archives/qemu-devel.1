Received: from eggs.gnu.org ([2001:4830:134:3::10]:45754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO9C-0005KJ-I4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO98-0001kh-JN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:58 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO98-0001kW-Dn
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:54 -0500
Received: by mail-qt0-x244.google.com with SMTP id w20so14932102qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:36 +1100
Message-Id: <20170213212536.31871-25-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 24/24] target/openrisc: Optimize for r0 being
 zero
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

The HW does not special-case r0, but the ABI specifies that r0 should
contain 0.  If we expose this fact to the optimizer, we can simplify
a lot of the generated code.  We must of course verify that r0==0, but
that is trivial to do with a TB flag.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h              |  5 ++-
 target/openrisc/exception_helper.c |  1 +
 target/openrisc/translate.c        | 83 ++++++++++++++++++++++++++++----------
 3 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 50a36ba..418a0e6 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -389,6 +389,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 #include "exec/cpu-all.h"
 
 #define TB_FLAGS_DFLAG 1
+#define TB_FLAGS_R0_0  2
 #define TB_FLAGS_OVE   SR_OVE
 
 static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
@@ -397,7 +398,9 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = env->dflag | (env->sr & SR_OVE);
+    *flags = (env->dflag
+              | (env->gpr[0] == 0 ? TB_FLAGS_R0_0 : 0)
+              | (env->sr & SR_OVE));
 }
 
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 1536053..a8a5f69 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exception.h"
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 313dae2..7c4cbf2 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -50,6 +50,7 @@ typedef struct DisasContext {
 static TCGv_env cpu_env;
 static TCGv cpu_sr;
 static TCGv cpu_R[32];
+static TCGv cpu_R0;
 static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_ppc;
@@ -109,6 +110,7 @@ void openrisc_translate_init(void)
                                       offsetof(CPUOpenRISCState, gpr[i]),
                                       regnames[i]);
     }
+    cpu_R0 = cpu_R[0];
 }
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
@@ -149,6 +151,15 @@ static void check_ov64s(DisasContext *dc)
 }
 #endif*/
 
+/* We're about to write to REG.  On the off-chance that the user is
+   writing to R0, re-instate the architectural register.  */
+#define check_r0_write(reg)             \
+    do {                                \
+        if (unlikely(reg == 0)) {       \
+            cpu_R[0] = cpu_R0;          \
+        }                               \
+    } while (0)
+
 static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 {
     if (unlikely(dc->singlestep_enabled)) {
@@ -496,7 +507,7 @@ static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
     tcg_temp_free(ea);
 }
 
-static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
+static void gen_swa(DisasContext *dc, int b, TCGv ra, int32_t ofs)
 {
     TCGv ea, val;
     TCGLabel *lab_fail, *lab_done;
@@ -504,6 +515,12 @@ static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, ra, ofs);
 
+    /* For TB_FLAGS_R0_0, the branch below invalidates the temporary assigned
+       to cpu_R[0].  Since l.swa is quite often immediately followed by a
+       branch, don't bother reallocating; finish the TB using the "real" R0.
+       This also takes care of RB input across the branch.  */
+    cpu_R[0] = cpu_R0;
+
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
@@ -511,7 +528,7 @@ static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              rb, dc->mem_idx, MO_TEUL);
+                              cpu_R[b], dc->mem_idx, MO_TEUL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
     tcg_temp_free(val);
 
@@ -781,6 +798,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x1b: /* l.lwa */
         LOG_DIS("l.lwa r%d, r%d, %d\n", rd, ra, I16);
+        check_r0_write(rd);
         gen_lwa(dc, cpu_R[rd], cpu_R[ra], I16);
         break;
 
@@ -856,16 +874,16 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
         goto do_load;
 
     do_load:
-        {
-            TCGv t0 = tcg_temp_new();
-            tcg_gen_addi_tl(t0, cpu_R[ra], I16);
-            tcg_gen_qemu_ld_tl(cpu_R[rd], t0, dc->mem_idx, mop);
-            tcg_temp_free(t0);
-        }
+        check_r0_write(rd);
+        t0 = tcg_temp_new();
+        tcg_gen_addi_tl(t0, cpu_R[ra], I16);
+        tcg_gen_qemu_ld_tl(cpu_R[rd], t0, dc->mem_idx, mop);
+        tcg_temp_free(t0);
         break;
 
     case 0x27:    /* l.addi */
         LOG_DIS("l.addi r%d, r%d, %d\n", rd, ra, I16);
+        check_r0_write(rd);
         t0 = tcg_const_tl(I16);
         gen_add(dc, cpu_R[rd], cpu_R[ra], t0);
         tcg_temp_free(t0);
@@ -873,6 +891,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x28:    /* l.addic */
         LOG_DIS("l.addic r%d, r%d, %d\n", rd, ra, I16);
+        check_r0_write(rd);
         t0 = tcg_const_tl(I16);
         gen_addc(dc, cpu_R[rd], cpu_R[ra], t0);
         tcg_temp_free(t0);
@@ -880,21 +899,25 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x29:    /* l.andi */
         LOG_DIS("l.andi r%d, r%d, %d\n", rd, ra, K16);
+        check_r0_write(rd);
         tcg_gen_andi_tl(cpu_R[rd], cpu_R[ra], K16);
         break;
 
     case 0x2a:    /* l.ori */
         LOG_DIS("l.ori r%d, r%d, %d\n", rd, ra, K16);
+        check_r0_write(rd);
         tcg_gen_ori_tl(cpu_R[rd], cpu_R[ra], K16);
         break;
 
     case 0x2b:    /* l.xori */
         LOG_DIS("l.xori r%d, r%d, %d\n", rd, ra, I16);
+        check_r0_write(rd);
         tcg_gen_xori_tl(cpu_R[rd], cpu_R[ra], I16);
         break;
 
     case 0x2c:    /* l.muli */
         LOG_DIS("l.muli r%d, r%d, %d\n", rd, ra, I16);
+        check_r0_write(rd);
         t0 = tcg_const_tl(I16);
         gen_mul(dc, cpu_R[rd], cpu_R[ra], t0);
         tcg_temp_free(t0);
@@ -902,6 +925,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x2d:    /* l.mfspr */
         LOG_DIS("l.mfspr r%d, r%d, %d\n", rd, ra, K16);
+        check_r0_write(rd);
         {
 #if defined(CONFIG_USER_ONLY)
             return;
@@ -936,7 +960,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x33: /* l.swa */
         LOG_DIS("l.swa r%d, r%d, %d\n", ra, rb, I5_11);
-        gen_swa(dc, cpu_R[rb], cpu_R[ra], I5_11);
+        gen_swa(dc, rb, cpu_R[ra], I5_11);
         break;
 
 /* not used yet, open it when we need or64.  */
@@ -1023,6 +1047,7 @@ static void dec_logic(DisasContext *dc, uint32_t insn)
     L6 = extract32(insn, 0, 6);
     S6 = L6 & (TARGET_LONG_BITS - 1);
 
+    check_r0_write(rd);
     switch (op0) {
     case 0x00:    /* l.slli */
         LOG_DIS("l.slli r%d, r%d, %d\n", rd, ra, L6);
@@ -1059,6 +1084,7 @@ static void dec_M(DisasContext *dc, uint32_t insn)
     rd = extract32(insn, 21, 5);
     K16 = extract32(insn, 0, 16);
 
+    check_r0_write(rd);
     switch (op0) {
     case 0x0:    /* l.movhi */
         LOG_DIS("l.movhi  r%d, %d\n", rd, K16);
@@ -1266,47 +1292,49 @@ static void dec_float(DisasContext *dc, uint32_t insn)
     switch (op0) {
     case 0x00:    /* lf.add.s */
         LOG_DIS("lf.add.s r%d, r%d, r%d\n", rd, ra, rb);
+        check_r0_write(rd);
         gen_helper_float_add_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x01:    /* lf.sub.s */
         LOG_DIS("lf.sub.s r%d, r%d, r%d\n", rd, ra, rb);
+        check_r0_write(rd);
         gen_helper_float_sub_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
-
     case 0x02:    /* lf.mul.s */
         LOG_DIS("lf.mul.s r%d, r%d, r%d\n", rd, ra, rb);
-        if (ra != 0 && rb != 0) {
-            gen_helper_float_mul_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        } else {
-            tcg_gen_ori_tl(fpcsr, fpcsr, FPCSR_ZF);
-            tcg_gen_movi_i32(cpu_R[rd], 0x0);
-        }
+        check_r0_write(rd);
+        gen_helper_float_mul_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x03:    /* lf.div.s */
         LOG_DIS("lf.div.s r%d, r%d, r%d\n", rd, ra, rb);
+        check_r0_write(rd);
         gen_helper_float_div_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x04:    /* lf.itof.s */
         LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
+        check_r0_write(rd);
         gen_helper_itofs(cpu_R[rd], cpu_env, cpu_R[ra]);
         break;
 
     case 0x05:    /* lf.ftoi.s */
         LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
+        check_r0_write(rd);
         gen_helper_ftois(cpu_R[rd], cpu_env, cpu_R[ra]);
         break;
 
     case 0x06:    /* lf.rem.s */
         LOG_DIS("lf.rem.s r%d, r%d, r%d\n", rd, ra, rb);
+        check_r0_write(rd);
         gen_helper_float_rem_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x07:    /* lf.madd.s */
         LOG_DIS("lf.madd.s r%d, r%d, r%d\n", rd, ra, rb);
+        check_r0_write(rd);
         gen_helper_float_madd_s(cpu_R[rd], cpu_env, cpu_R[rd],
                                 cpu_R[ra], cpu_R[rb]);
         break;
@@ -1346,53 +1374,56 @@ static void dec_float(DisasContext *dc, uint32_t insn)
     case 0x10:     lf.add.d
         LOG_DIS("lf.add.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_float_add_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x11:     lf.sub.d
         LOG_DIS("lf.sub.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_float_sub_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x12:     lf.mul.d
         LOG_DIS("lf.mul.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
-        if (ra != 0 && rb != 0) {
-            gen_helper_float_mul_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-        } else {
-            tcg_gen_ori_tl(fpcsr, fpcsr, FPCSR_ZF);
-            tcg_gen_movi_i64(cpu_R[rd], 0x0);
-        }
+        check_r0_write(rd);
+        gen_helper_float_mul_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x13:     lf.div.d
         LOG_DIS("lf.div.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_float_div_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x14:     lf.itof.d
         LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_itofd(cpu_R[rd], cpu_env, cpu_R[ra]);
         break;
 
     case 0x15:     lf.ftoi.d
         LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_ftoid(cpu_R[rd], cpu_env, cpu_R[ra]);
         break;
 
     case 0x16:     lf.rem.d
         LOG_DIS("lf.rem.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_float_rem_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x17:     lf.madd.d
         LOG_DIS("lf.madd.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
+        check_r0_write(rd);
         gen_helper_float_madd_d(cpu_R[rd], cpu_env, cpu_R[rd],
                                 cpu_R[ra], cpu_R[rb]);
         break;
@@ -1526,6 +1557,14 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
 
     gen_tb_start(tb);
 
+    /* Allow the TCG optimizer to see that R0 == 0,
+       when it's true, which is the common case.  */
+    if (dc->tb_flags & TB_FLAGS_R0_0) {
+        cpu_R[0] = tcg_const_tl(0);
+    } else {
+        cpu_R[0] = cpu_R0;
+    }
+
     do {
         tcg_gen_insn_start(dc->pc, (dc->delayed_branch ? 1 : 0)
 			   | (num_insns ? 2 : 0));
-- 
2.9.3
