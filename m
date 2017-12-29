Received: from eggs.gnu.org ([2001:4830:134:3::10]:50711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDC-00030J-W4
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDB-0004fq-Nj
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:11 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDB-0004fY-Hp
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:09 -0500
Received: by mail-pf0-x242.google.com with SMTP id j28so21823768pfk.8
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:22 -0800
Message-Id: <20171229063145.29167-16-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/38] target/hppa: Do not set cs_base to iaoq_b
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

We will need to use cs_base for iasq_f.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       | 13 +++++++++++--
 target/hppa/cpu.c       |  4 +++-
 target/hppa/translate.c | 22 ++++++++++++----------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 94f9c8ca2b..babad0d2c1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -240,15 +240,24 @@ void hppa_translate_init(void);
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
+/* Since PSW_V will never need to be in tb->flags, reuse it.
+ * TB_FLAG_NONSEQ indicates that the two instructions in the insn queue
+ * are non-sequential.
+ */
+#define TB_FLAG_NONSEQ  PSW_V
+
 static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
                                         target_ulong *cs_base,
                                         uint32_t *pflags)
 {
+    bool nonseq = env->iaoq_b != env->iaoq_f + 4;
+
     *pc = env->iaoq_f;
-    *cs_base = env->iaoq_b;
+    *cs_base = 0;
     /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
     *pflags = (env->psw & (PSW_W | PSW_C | PSW_D))
-            | env->psw_n * PSW_N;
+            | env->psw_n * PSW_N
+            | nonseq * TB_FLAG_NONSEQ;
 }
 
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6b2d22118d..715233c59a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -38,7 +38,9 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     HPPACPU *cpu = HPPA_CPU(cs);
 
     cpu->env.iaoq_f = tb->pc;
-    cpu->env.iaoq_b = tb->cs_base;
+    if (!(tb->flags & TB_FLAG_NONSEQ)) {
+        cpu->env.iaoq_b = tb->pc + 4;
+    }
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e0d626dfe1..4d5974c94d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -770,9 +770,9 @@ static void gen_goto_tb(DisasContext *ctx, int which,
                         target_ureg f, target_ureg b)
 {
     if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
+        tcg_gen_movi_reg(cpu_iaoq_b, b);
         tcg_gen_goto_tb(which);
         tcg_gen_movi_reg(cpu_iaoq_f, f);
-        tcg_gen_movi_reg(cpu_iaoq_b, b);
         tcg_gen_exit_tb((uintptr_t)ctx->base.tb + which);
     } else {
         copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
@@ -1792,11 +1792,17 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
         }
         next = get_temp(ctx);
         tcg_gen_mov_reg(next, dest);
-        ctx->iaoq_n = -1;
-        ctx->iaoq_n_var = next;
         if (is_n) {
+            if (use_nullify_skip(ctx)) {
+                tcg_gen_mov_reg(cpu_iaoq_f, next);
+                tcg_gen_addi_reg(cpu_iaoq_b, next, 4);
+                nullify_set(ctx, 0);
+                return DISAS_IAQ_N_UPDATED;
+            }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
+        ctx->iaoq_n = -1;
+        ctx->iaoq_n_var = next;
     } else if (is_n && use_nullify_skip(ctx)) {
         /* The (conditional) branch, B, nullifies the next insn, N,
            and we're allowed to skip execution N (no single-step or
@@ -4222,7 +4228,8 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
                     ? ctx->privilege : MMU_PHYS_IDX);
 #endif
     ctx->iaoq_f = ctx->base.pc_first;
-    ctx->iaoq_b = ctx->base.tb->cs_base;
+    ctx->iaoq_b = (ctx->base.tb->flags & TB_FLAG_NONSEQ
+                   ? -1 : ctx->iaoq_f + 4);
     ctx->base.pc_first &= -4;
 
     ctx->iaoq_n = -1;
@@ -4232,11 +4239,6 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     bound = MIN(max_insns, bound);
 
-    /* If the instruction queue includes a priority change, split the TB.  */
-    if ((ctx->iaoq_f ^ ctx->iaoq_b) & 3) {
-        bound = 1;
-    }
-
     ctx->ntempr = 0;
     ctx->ntempl = 0;
     memset(ctx->tempr, 0, sizeof(ctx->tempr));
@@ -4440,7 +4442,7 @@ void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->iaoq_f = data[0];
-    if (data[1] != -1) {
+    if (data[1] != (target_ureg)-1) {
         env->iaoq_b = data[1];
     }
     /* Since we were executing the instruction at IAOQ_F, and took some
-- 
2.14.3
