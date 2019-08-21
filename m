Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D61C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A62206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A62206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PgF-0002Vv-AA
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35882)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeD-0000YR-Se
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeC-0008Kr-IP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:29 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:48758
 helo=mail.uni-paderborn.de)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeC-0008KN-CR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:28 -0400
Received: from pova.uni-paderborn.de ([131.234.189.23]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.89 zuban)
 id 1i0PeB-0001Et-Kw; Wed, 21 Aug 2019 14:23:27 +0200
Received: from mail.uni-paderborn.de by pova with queue id 3651404-2;
 Wed, 21 Aug 2019 12:23:26 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:13 +0200
Message-Id: <20190821122315.18015-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.21.121517, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Spam-Score: 0.0 ()
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: [Qemu-devel] [PATCH v2 3/5] target/tricore: Use translate_loop
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
v1 -> v2:
    - save hflags in tricore_tr_init_disas_context()

 target/tricore/translate.c | 118 +++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6b10ae5c47..5fb42abe35 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8772,7 +8772,7 @@ static void decode_32Bit_opc(DisasContext *ctx)
     }
 }
 
-static void decode_opc(DisasContext *ctx, int *is_branch)
+static void decode_opc(DisasContext *ctx)
 {
     /* 16-Bit Instruction */
     if ((ctx->opcode & 0x1) == 0) {
@@ -8785,57 +8785,87 @@ static void decode_opc(DisasContext *ctx, int *is_branch)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
+                                          CPUState *cs)
 {
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUTriCoreState *env = cs->env_ptr;
-    DisasContext ctx;
-    target_ulong pc_start;
-    int num_insns = 0;
-
-    pc_start = tb->pc;
-    ctx.base.pc_next = pc_start;
-    ctx.base.tb = tb;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.base.is_jmp = DISAS_NEXT;
-    ctx.mem_idx = cpu_mmu_index(env, false);
-    ctx.hflags = (uint32_t)tb->flags;
-    ctx.env = env;
-
-    tcg_clear_temp_count();
-    gen_tb_start(tb);
-    while (ctx.base.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx.base.pc_next);
-        num_insns++;
-
-        ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
-        decode_opc(&ctx, 0);
-
-        if (num_insns >= max_insns || tcg_op_buf_full()) {
-            gen_save_pc(ctx.pc_succ_insn);
-            tcg_gen_exit_tb(NULL, 0);
-            break;
+    ctx->mem_idx = cpu_mmu_index(env, false);
+    ctx->hflags = (uint32_t)ctx->base.tb->flags;
+}
+
+static void tricore_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
+
+static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next);
+}
+
+static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                      const CPUBreakpoint *bp)
+{
+    return false;
+}
+
+static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUTriCoreState *env = cpu->env_ptr;
+
+    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+    decode_opc(ctx);
+    ctx->base.pc_next = ctx->pc_succ_insn;
+
+    if (ctx->base.is_jmp == DISAS_NEXT) {
+        target_ulong page_start;
+
+        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
+        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
+            ctx->base.is_jmp = DISAS_TOO_MANY;
         }
-        ctx.base.pc_next = ctx.pc_succ_insn;
     }
+}
 
-    gen_tb_end(tb, num_insns);
-    tb->size = ctx.base.pc_next - pc_start;
-    tb->icount = num_insns;
+static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    if (tcg_check_temp_count()) {
-        printf("LEAK at %08x\n", env->PC);
+    switch (ctx->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        gen_goto_tb(ctx, 0, ctx->base.pc_next);
+        break;
+    case DISAS_NORETURN:
+        break;
+    default:
+        g_assert_not_reached();
     }
+}
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+static void tricore_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps tricore_tr_ops = {
+    .init_disas_context = tricore_tr_init_disas_context,
+    .tb_start           = tricore_tr_tb_start,
+    .insn_start         = tricore_tr_insn_start,
+    .breakpoint_check   = tricore_tr_breakpoint_check,
+    .translate_insn     = tricore_tr_translate_insn,
+    .tb_stop            = tricore_tr_tb_stop,
+    .disas_log          = tricore_tr_disas_log,
+};
+
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+{
+    DisasContext ctx;
+    translator_loop(&tricore_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void
-- 
2.23.0


