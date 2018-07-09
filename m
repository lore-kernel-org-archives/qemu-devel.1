Received: from eggs.gnu.org ([2001:4830:134:3::10]:49460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcaOQ-0005xF-F0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcaOO-0004DE-Lv
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:10 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcaOO-0004Cu-Do
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:08 -0400
Received: by mail-pf0-x234.google.com with SMTP id u16-v6so14185360pfh.3
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:56:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Jul 2018 10:56:03 -0700
Message-Id: <20180709175603.1320-2-richard.henderson@linaro.org>
In-Reply-To: <20180709175603.1320-1-richard.henderson@linaro.org>
References: <20180709175603.1320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 1/1] target/sh4: Fix translator.c
 assertion failure for gUSA
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

The translator loop does not allow the tb_start hook to set
dc->base.is_jmp; the only hook allowed to do that is translate_insn.

Split the work between init_disas_context where we validate
the gUSA parameters, and translate_insn where we emit code.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 81 +++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c716b74a0f..1b9a201d6d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1895,35 +1895,18 @@ static void decode_opc(DisasContext * ctx)
    any sequence via cpu_exec_step_atomic, we can recognize the "normal"
    sequences and transform them into atomic operations as seen by the host.
 */
-static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
+static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 {
     uint16_t insns[5];
     int ld_adr, ld_dst, ld_mop;
     int op_dst, op_src, op_opc;
     int mv_src, mt_dst, st_src, st_mop;
     TCGv op_arg;
-
     uint32_t pc = ctx->base.pc_next;
     uint32_t pc_end = ctx->base.tb->cs_base;
-    int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
     int max_insns = (pc_end - pc) / 2;
     int i;
 
-    if (pc != pc_end + backup || max_insns < 2) {
-        /* This is a malformed gUSA region.  Don't do anything special,
-           since the interpreter is likely to get confused.  */
-        ctx->envflags &= ~GUSA_MASK;
-        return 0;
-    }
-
-    if (ctx->tbflags & GUSA_EXCLUSIVE) {
-        /* Regardless of single-stepping or the end of the page,
-           we must complete execution of the gUSA region while
-           holding the exclusive lock.  */
-        *pmax_insns = max_insns;
-        return 0;
-    }
-
     /* The state machine below will consume only a few insns.
        If there are more than that in a region, fail now.  */
     if (max_insns > ARRAY_SIZE(insns)) {
@@ -2140,7 +2123,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     /*
      * Emit the operation.
      */
-    tcg_gen_insn_start(pc, ctx->envflags);
     switch (op_opc) {
     case -1:
         /* No operation found.  Look for exchange pattern.  */
@@ -2235,7 +2217,8 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     /* The entire region has been translated.  */
     ctx->envflags &= ~GUSA_MASK;
     ctx->base.pc_next = pc_end;
-    return max_insns;
+    ctx->base.num_insns += max_insns - 1;
+    return;
 
  fail:
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
@@ -2243,7 +2226,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 
     /* Restart with the EXCLUSIVE bit set, within a TB run via
        cpu_exec_step_atomic holding the exclusive lock.  */
-    tcg_gen_insn_start(pc, ctx->envflags);
     ctx->envflags |= GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(cpu_env);
@@ -2254,7 +2236,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
        entire region consumed via ctx->base.pc_next so that it's immediately
        available in the disassembly dump.  */
     ctx->base.pc_next = pc_end;
-    return 1;
+    ctx->base.num_insns += max_insns - 1;
 }
 #endif
 
@@ -2262,19 +2244,39 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUSH4State *env = cs->env_ptr;
+    uint32_t tbflags;
     int bound;
 
-    ctx->tbflags = (uint32_t)ctx->base.tb->flags;
-    ctx->envflags = ctx->base.tb->flags & TB_FLAG_ENVFLAGS_MASK;
-    ctx->memidx = (ctx->tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
+    ctx->tbflags = tbflags = ctx->base.tb->flags;
+    ctx->envflags = tbflags & TB_FLAG_ENVFLAGS_MASK;
+    ctx->memidx = (tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
     ctx->delayed_pc = -1; /* use delayed pc from env pointer */
     ctx->features = env->features;
-    ctx->has_movcal = (ctx->tbflags & TB_FLAG_PENDING_MOVCA);
-    ctx->gbank = ((ctx->tbflags & (1 << SR_MD)) &&
-                  (ctx->tbflags & (1 << SR_RB))) * 0x10;
-    ctx->fbank = ctx->tbflags & FPSCR_FR ? 0x10 : 0;
+    ctx->has_movcal = (tbflags & TB_FLAG_PENDING_MOVCA);
+    ctx->gbank = ((tbflags & (1 << SR_MD)) &&
+                  (tbflags & (1 << SR_RB))) * 0x10;
+    ctx->fbank = tbflags & FPSCR_FR ? 0x10 : 0;
+
+    if (tbflags & GUSA_MASK) {
+        uint32_t pc = ctx->base.pc_next;
+        uint32_t pc_end = ctx->base.tb->cs_base;
+        int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
+        int max_insns = (pc_end - pc) / 2;
+
+        if (pc != pc_end + backup || max_insns < 2) {
+            /* This is a malformed gUSA region.  Don't do anything special,
+               since the interpreter is likely to get confused.  */
+            ctx->envflags &= ~GUSA_MASK;
+        } else if (tbflags & GUSA_EXCLUSIVE) {
+            /* Regardless of single-stepping or the end of the page,
+               we must complete execution of the gUSA region while
+               holding the exclusive lock.  */
+            ctx->base.max_insns = max_insns;
+            return;
+        }
+    }
 
     /* Since the ISA is fixed-width, we can bound by the number
        of instructions remaining on the page.  */
@@ -2284,14 +2286,6 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void sh4_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
 {
-#ifdef CONFIG_USER_ONLY
-    DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUSH4State *env = cs->env_ptr;
-
-    if (ctx->tbflags & GUSA_MASK) {
-        ctx->base.num_insns = decode_gusa(ctx, env, &ctx->base.max_insns);
-    }
-#endif
 }
 
 static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
@@ -2323,6 +2317,19 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     CPUSH4State *env = cs->env_ptr;
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
+#ifdef CONFIG_USER_ONLY
+    if (unlikely(ctx->envflags & GUSA_MASK)
+        && !(ctx->envflags & GUSA_EXCLUSIVE)) {
+        /* We're in an gUSA region, and we have not already fallen
+           back on using an exclusive region.  Attempt to parse the
+           region into a single supported atomic operation.  Failure
+           is handled within the parser by raising an exception to
+           retry using an exclusive region.  */
+        decode_gusa(ctx, env);
+        return;
+    }
+#endif
+
     ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
-- 
2.17.1
