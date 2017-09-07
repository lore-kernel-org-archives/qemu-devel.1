Received: from eggs.gnu.org ([2001:4830:134:3::10]:51194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nN-0004Wl-LX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nJ-0005YQ-0i
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:57 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:34429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1nI-0005YC-R4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:52 -0400
Received: by mail-pf0-x22f.google.com with SMTP id e1so822675pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:44:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:44:46 -0700
Message-Id: <20170907184447.22752-3-richard.henderson@linaro.org>
In-Reply-To: <20170907184447.22752-1-richard.henderson@linaro.org>
References: <20170907184447.22752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/3] target/hppa: Convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cb4a3e6cb4..993438a60b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -38,7 +38,7 @@ typedef struct DisasCond {
 } DisasCond;
 
 typedef struct DisasContext {
-    struct TranslationBlock *tb;
+    DisasContextBase base;
     CPUState *cs;
 
     target_ulong iaoq_f;
@@ -52,7 +52,6 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
-    bool singlestep_enabled;
     bool psw_n_nonzero;
 } DisasContext;
 
@@ -476,7 +475,7 @@ static DisasJumpType gen_illegal(DisasContext *ctx)
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((ctx->tb->cflags & CF_LAST_IO) || ctx->singlestep_enabled) {
+    if ((ctx->base.tb->cflags & CF_LAST_IO) || ctx->base.singlestep_enabled) {
         return false;
     }
     return true;
@@ -499,11 +498,11 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         tcg_gen_goto_tb(which);
         tcg_gen_movi_tl(cpu_iaoq_f, f);
         tcg_gen_movi_tl(cpu_iaoq_b, b);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + which);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + which);
     } else {
         copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
         copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
@@ -3737,11 +3736,11 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     DisasJumpType ret;
     int num_insns, max_insns, i;
 
-    ctx.tb = tb;
+    ctx.base.tb = tb;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
     ctx.cs = cs;
     ctx.iaoq_f = tb->pc;
     ctx.iaoq_b = tb->cs_base;
-    ctx.singlestep_enabled = cs->singlestep_enabled;
 
     ctx.ntemps = 0;
     for (i = 0; i < ARRAY_SIZE(ctx.temps); ++i) {
@@ -3755,7 +3754,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
-    if (ctx.singlestep_enabled || singlestep) {
+    if (ctx.base.singlestep_enabled || singlestep) {
         max_insns = 1;
     } else if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
@@ -3868,7 +3867,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         nullify_save(&ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-        if (ctx.singlestep_enabled) {
+        if (ctx.base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
-- 
2.13.5
