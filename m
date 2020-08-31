Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4712FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14CE2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMOVuMS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14CE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmXf-0006jV-4S
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKW-0004fT-TU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:54423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKS-00060r-Sh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id mm21so22826pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h8ixAKf5iBBm6uV3Q0Hu5wc/Ce959qgsl6yMfOofqSw=;
 b=jMOVuMS4/GlAgCquzd5DzaEEW+fElE5ujf7k58+e/DWxuzTN3RMcFg62fkZi5n57lR
 9L5eA5axFf1Lgu5i9qOiXRe9z1BY9QETHl/xn3FRcFrRJW5Y7BgCRmF/Fy1lhruh0sKk
 bUyV9faKxqva58Kk8Q3Y20tcqoPQoGA1+iViwf4kmol0zcVDvofBnzIBN3nmMM2CTqQH
 5GOrEi+bTpDGRG8JIZaJvX17Etbu7s1gP+vFHeBdaPpxzZtOs9JjxdFcVZdt5zJ94YGi
 +QpatJuF1B1y+fBhguwRSHY5czAtSPWTX6jJ4QpGadvP06ceG2JbK5U+SHWAQfvnfLwr
 n/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h8ixAKf5iBBm6uV3Q0Hu5wc/Ce959qgsl6yMfOofqSw=;
 b=VX3Yu1uq6e33SEtvy9XsVkjx6WlyXZaFKB3a3Siv+GdjKNs0fsthAGo68i5mwvuV8N
 cAPN/YIadQ9nqHBizhLn/L2oiXjc5+25TntCo4NWMu42fg+W/LYFyv8rpdLuRlr2z5WO
 yQN9JWjhOTC+3SNWGeZjBzaga7QPqH9q/Wf9UpCjb+qz34cAS58IqfvnKYjV815vGNXe
 rYPgFXzKbyFApNFxeM4voDWzpMWvBeYrVYhgPNKGMKtTFIiWShfDRSh97T4yICpVa3t/
 B30beCrMeplxzTDKTKNyiJmgiT+YHJvNWmicbbehX7LLF17lW3V91tKMkwtUTxrDcLFF
 swPg==
X-Gm-Message-State: AOAM531qWLxj24iHx6zxloBvoYLjJuuJSIXnQ1dQ8Lw6tDx0C7zIuOoG
 ON3vJVDCIoZsne0LT9CQDZT0AuKL2Gdvjg==
X-Google-Smtp-Source: ABdhPJyxAL03Xu3S1di4j0rCYvTRN+ApGDT6n/ryN6AZTkewtUkh43Uc93OnbUktV/2Bzy5Eu+93hA==
X-Received: by 2002:a17:902:d201:: with SMTP id
 t1mr1591129ply.174.1598890002986; 
 Mon, 31 Aug 2020 09:06:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/76] target/microblaze: Convert to translator_loop
Date: Mon, 31 Aug 2020 09:05:14 -0700
Message-Id: <20200831160601.833692-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finish the conversion to the generic translator_loop.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 289 ++++++++++++++++++----------------
 1 file changed, 149 insertions(+), 140 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 45b1555f85..6a9710d76d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1595,172 +1595,181 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     }
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
-    CPUMBState *env = cs->env_ptr;
-    MicroBlazeCPU *cpu = env_archcpu(env);
-    uint32_t pc_start;
-    struct DisasContext ctx;
-    struct DisasContext *dc = &ctx;
-    uint32_t page_start, org_flags;
-    uint32_t npc;
-    int num_insns;
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    int bound;
 
-    pc_start = tb->pc;
     dc->cpu = cpu;
-    org_flags = dc->synced_flags = dc->tb_flags = tb->flags;
-
-    dc->jmp = 0;
+    dc->synced_flags = dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
-    if (dc->delayed_branch) {
-        dc->jmp = JMP_INDIRECT;
-    }
-    dc->base.pc_first = pc_start;
-    dc->base.pc_next = pc_start;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.tb = tb;
 
-    if (pc_start & 3) {
-        cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
+    bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
+    dc->base.max_insns = MIN(dc->base.max_insns, bound);
+}
+
+static void mb_tr_tb_start(DisasContextBase *dcb, CPUState *cs)
+{
+}
+
+static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
+{
+    tcg_gen_insn_start(dcb->pc_next);
+}
+
+static bool mb_tr_breakpoint_check(DisasContextBase *dcb, CPUState *cs,
+                                   const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    gen_raise_exception_sync(dc, EXCP_DEBUG);
+
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
+    dc->base.pc_next += 4;
+    return true;
+}
+
+static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+    CPUMBState *env = cs->env_ptr;
+
+    /* TODO: This should raise an exception, not terminate qemu. */
+    if (dc->base.pc_next & 3) {
+        cpu_abort(cs, "Microblaze: unaligned PC=%x\n",
+                  (uint32_t)dc->base.pc_next);
     }
 
-    page_start = pc_start & TARGET_PAGE_MASK;
-    num_insns = 0;
+    dc->clear_imm = 1;
+    decode(dc, cpu_ldl_code(env, dc->base.pc_next));
+    if (dc->clear_imm) {
+        dc->tb_flags &= ~IMM_FLAG;
+    }
+    dc->base.pc_next += 4;
 
-    gen_tb_start(tb);
-    do
-    {
-        tcg_gen_insn_start(dc->base.pc_next);
-        num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
-            gen_raise_exception_sync(dc, EXCP_DEBUG);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->base.pc_next += 4;
-            break;
+    if (dc->delayed_branch && --dc->delayed_branch == 0) {
+        if (dc->tb_flags & DRTI_FLAG) {
+            do_rti(dc);
         }
-
-        /* Pretty disas.  */
-        LOG_DIS("%8.8x:\t", (uint32_t)dc->base.pc_next);
-
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
+        if (dc->tb_flags & DRTB_FLAG) {
+            do_rtb(dc);
         }
-
-        dc->clear_imm = 1;
-        decode(dc, cpu_ldl_code(env, dc->base.pc_next));
-        if (dc->clear_imm)
-            dc->tb_flags &= ~IMM_FLAG;
-        dc->base.pc_next += 4;
-
-        if (dc->delayed_branch) {
-            dc->delayed_branch--;
-            if (!dc->delayed_branch) {
-                if (dc->tb_flags & DRTI_FLAG)
-                    do_rti(dc);
-                 if (dc->tb_flags & DRTB_FLAG)
-                    do_rtb(dc);
-                if (dc->tb_flags & DRTE_FLAG)
-                    do_rte(dc);
-                /* Clear the delay slot flag.  */
-                dc->tb_flags &= ~D_FLAG;
-                /* If it is a direct jump, try direct chaining.  */
-                if (dc->jmp == JMP_INDIRECT) {
-                    TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
-                    eval_cond_jmp(dc, cpu_btarget, tmp_pc);
-                    tcg_temp_free_i32(tmp_pc);
-                    dc->base.is_jmp = DISAS_JUMP;
-                } else if (dc->jmp == JMP_DIRECT) {
-                    t_sync_flags(dc);
-                    gen_goto_tb(dc, 0, dc->jmp_pc);
-                } else if (dc->jmp == JMP_DIRECT_CC) {
-                    TCGLabel *l1 = gen_new_label();
-                    t_sync_flags(dc);
-                    /* Conditional jmp.  */
-                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
-                    gen_goto_tb(dc, 1, dc->base.pc_next);
-                    gen_set_label(l1);
-                    gen_goto_tb(dc, 0, dc->jmp_pc);
-                }
-                break;
-            }
+        if (dc->tb_flags & DRTE_FLAG) {
+            do_rte(dc);
         }
-        if (dc->base.singlestep_enabled) {
-            break;
-        }
-    } while (!dc->base.is_jmp && !dc->cpustate_changed
-             && !tcg_op_buf_full()
-             && !singlestep
-             && (dc->base.pc_next - page_start < TARGET_PAGE_SIZE)
-             && num_insns < max_insns);
-
-    npc = dc->base.pc_next;
-    if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
-        if (dc->tb_flags & D_FLAG) {
-            dc->base.is_jmp = DISAS_UPDATE;
-            tcg_gen_movi_i32(cpu_pc, npc);
-            sync_jmpstate(dc);
-        } else
-            npc = dc->jmp_pc;
+        /* Clear the delay slot flag.  */
+        dc->tb_flags &= ~D_FLAG;
+        dc->base.is_jmp = DISAS_JUMP;
     }
 
-    /* Force an update if the per-tb cpu state has changed.  */
-    if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
+    /* Force an exit if the per-tb cpu state has changed.  */
+    if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
         dc->base.is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_i32(cpu_pc, npc);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     }
-    t_sync_flags(dc);
+}
+
+static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    assert(!dc->abort_at_next_insn);
 
     if (dc->base.is_jmp == DISAS_NORETURN) {
-        /* nothing more to generate */
-    } else if (unlikely(cs->singlestep_enabled)) {
-        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
-
-        if (dc->base.is_jmp != DISAS_JUMP) {
-            tcg_gen_movi_i32(cpu_pc, npc);
-        }
-        gen_helper_raise_exception(cpu_env, tmp);
-        tcg_temp_free_i32(tmp);
-    } else {
-        switch (dc->base.is_jmp) {
-            case DISAS_NEXT:
-                gen_goto_tb(dc, 1, npc);
-                break;
-            case DISAS_JUMP:
-            case DISAS_UPDATE:
-                /* indicate that the hash table must be used
-                   to find the next TB */
-                tcg_gen_exit_tb(NULL, 0);
-                break;
-            default:
-                g_assert_not_reached();
-        }
+        /* We have already exited the TB. */
+        return;
     }
-    gen_tb_end(tb, num_insns);
 
-    tb->size = dc->base.pc_next - pc_start;
-    tb->icount = num_insns;
+    t_sync_flags(dc);
+    if (dc->tb_flags & D_FLAG) {
+        sync_jmpstate(dc);
+        dc->jmp = JMP_NOJMP;
+    }
 
+    switch (dc->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        assert(dc->jmp == JMP_NOJMP);
+        gen_goto_tb(dc, 0, dc->base.pc_next);
+        return;
+
+    case DISAS_UPDATE:
+        assert(dc->jmp == JMP_NOJMP);
+        if (unlikely(cs->singlestep_enabled)) {
+            gen_raise_exception(dc, EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        return;
+
+    case DISAS_JUMP:
+        switch (dc->jmp) {
+        case JMP_INDIRECT:
+            {
+                TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
+                eval_cond_jmp(dc, cpu_btarget, tmp_pc);
+                tcg_temp_free_i32(tmp_pc);
+
+                if (unlikely(cs->singlestep_enabled)) {
+                    gen_raise_exception(dc, EXCP_DEBUG);
+                } else {
+                    tcg_gen_exit_tb(NULL, 0);
+                }
+            }
+            return;
+
+        case JMP_DIRECT_CC:
+            {
+                TCGLabel *l1 = gen_new_label();
+                tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
+                gen_goto_tb(dc, 1, dc->base.pc_next);
+                gen_set_label(l1);
+            }
+            /* fall through */
+
+        case JMP_DIRECT:
+            gen_goto_tb(dc, 0, dc->jmp_pc);
+            return;
+        }
+        /* fall through */
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void mb_tr_disas_log(const DisasContextBase *dcb, CPUState *cs)
+{
 #ifdef DEBUG_DISAS
 #if !SIM_COMPAT
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        FILE *logfile = qemu_log_lock();
-        qemu_log("--------------\n");
-        log_target_disas(cs, pc_start, dc->base.pc_next - pc_start);
-        qemu_log_unlock(logfile);
-    }
+    qemu_log("IN: %s\n", lookup_symbol(dcb->pc_first));
+    log_target_disas(cs, dcb->pc_first, dcb->tb->size);
 #endif
 #endif
-    assert(!dc->abort_at_next_insn);
+}
+
+static const TranslatorOps mb_tr_ops = {
+    .init_disas_context = mb_tr_init_disas_context,
+    .tb_start           = mb_tr_tb_start,
+    .insn_start         = mb_tr_insn_start,
+    .breakpoint_check   = mb_tr_breakpoint_check,
+    .translate_insn     = mb_tr_translate_insn,
+    .tb_stop            = mb_tr_tb_stop,
+    .disas_log          = mb_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
+{
+    DisasContext dc;
+    translator_loop(&mb_tr_ops, &dc.base, cpu, tb, max_insns);
 }
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-- 
2.25.1


