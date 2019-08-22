Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B451C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7F2233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="tV7Y8FIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7F2233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kF3-0007Aw-VH
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDJ-0005tn-0g
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDH-0005Yp-Mb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:04 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:43944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1i0kDH-0005Xk-Gt
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Udo5UNzRaPQGVA87Ml0p/xu1ugcYhhbjqb9ss0Zd6CU=; b=tV7Y8FISZ1nhlOKJhvMXuhCy84
 PKxYbFFRdGesBhj+2pl+8BczwCKvWinZ85xmFxDRLEseIN/ZTZZqL9xi/azv93CPBTKeqFK6ORQW3
 M4jn1RV0gdqy1tygt+yidb6gSbbRu+fUnmPf/XBCCsEWxobAxuC4CFns//XWUK9Alz8Y=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 12:20:44 +0200
Message-Id: <20190822102046.8765-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
References: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.22.101216, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 3/5] target/tricore: Use translate_loop
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
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


