Received: from eggs.gnu.org ([2001:4830:134:3::10]:43396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM6M-0003ir-UT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM6L-0007H2-EN
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:38 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGM6L-0007Fe-5X
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:37 -0400
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so22460360pgc.7
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:13:37 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 22:11:52 +1200
Message-Id: <1525860713-3476-6-git-send-email-mjc@sifive.com>
In-Reply-To: <1525860713-3476-1-git-send-email-mjc@sifive.com>
References: <1525860713-3476-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 5/6] target/riscv: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, "Emilio G. Cota" <cota@braap.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 158 ++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 78 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 68979abfd7ed..1788668c6f28 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1837,78 +1837,71 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPURISCVState *env = cs->env_ptr;
-    DisasContext ctx;
-    target_ulong page_start;
-    int num_insns;
-    int max_insns;
-
-    ctx.base.pc_first = tb->pc;
-    ctx.base.pc_next = ctx.base.pc_first;
-    /* once we have GDB, the rest of the translate.c implementation should be
-       ready for singlestep */
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.base.tb = tb;
-    ctx.base.is_jmp = DISAS_NEXT;
-
-    page_start = ctx.base.pc_first & TARGET_PAGE_MASK;
-    ctx.pc_succ_insn = ctx.base.pc_first;
-    ctx.flags = tb->flags;
-    ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
-    ctx.frm = -1;  /* unknown rounding mode */
-
-    num_insns = 0;
-    max_insns = tb_cflags(ctx.base.tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-    gen_tb_start(tb);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    while (ctx.base.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx.base.pc_next);
-        num_insns++;
+    ctx->pc_succ_insn = ctx->base.pc_first;
+    ctx->flags = ctx->base.tb->flags;
+    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
+    ctx->frm = -1;  /* unknown rounding mode */
+}
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
-            tcg_gen_movi_tl(cpu_pc, ctx.base.pc_next);
-            ctx.base.is_jmp = DISAS_NORETURN;
-            gen_exception_debug();
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            ctx.base.pc_next += 4;
-            goto done_generating;
-        }
+static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
 
-        if (num_insns == max_insns && (tb_cflags(ctx.base.tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next);
+}
+
+static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_exception_debug();
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 4;
+    return true;
+}
+
+
+static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPURISCVState *env = cpu->env_ptr;
 
-        ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
-        decode_opc(env, &ctx);
-        ctx.base.pc_next = ctx.pc_succ_insn;
-
-        if (ctx.base.is_jmp == DISAS_NEXT &&
-            (cs->singlestep_enabled ||
-             ctx.base.pc_next - page_start >= TARGET_PAGE_SIZE ||
-             tcg_op_buf_full() ||
-             num_insns >= max_insns ||
-             singlestep)) {
-            ctx.base.is_jmp = DISAS_TOO_MANY;
+    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+    decode_opc(env, ctx);
+    ctx->base.pc_next = ctx->pc_succ_insn;
+
+    if (ctx->base.is_jmp == DISAS_NEXT) {
+        target_ulong page_start;
+
+        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
+        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
+            ctx->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-    if (tb_cflags(ctx.base.tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
-    switch (ctx.base.is_jmp) {
+}
+
+static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    switch (ctx->base.is_jmp) {
     case DISAS_TOO_MANY:
-        tcg_gen_movi_tl(cpu_pc, ctx.base.pc_next);
-        if (cs->singlestep_enabled) {
+        tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+        if (ctx->base.singlestep_enabled) {
             gen_exception_debug();
         } else {
             tcg_gen_exit_tb(0);
@@ -1919,20 +1912,29 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     default:
         g_assert_not_reached();
     }
-done_generating:
-    gen_tb_end(tb, num_insns);
-    tb->size = ctx.base.pc_next - ctx.base.pc_first;
-    tb->icount = num_insns;
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(ctx.base.pc_first)) {
-        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
-        log_target_disas(cs, ctx.base.pc_first,
-                         ctx.base.pc_next - ctx.base.pc_first);
-        qemu_log("\n");
-    }
-#endif
+}
+
+static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps riscv_tr_ops = {
+    .init_disas_context = riscv_tr_init_disas_context,
+    .tb_start           = riscv_tr_tb_start,
+    .insn_start         = riscv_tr_insn_start,
+    .breakpoint_check   = riscv_tr_breakpoint_check,
+    .translate_insn     = riscv_tr_translate_insn,
+    .tb_stop            = riscv_tr_tb_stop,
+    .disas_log          = riscv_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext ctx;
+
+    translator_loop(&riscv_tr_ops, &ctx.base, cs, tb);
 }
 
 void riscv_translate_init(void)
-- 
2.7.0
