Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AFAC4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22B320663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmQaeiwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22B320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJYeD-00030V-Hd
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcL-0000t9-CR
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcJ-0008P7-NU
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iJYcJ-0008O0-Gr
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so16091224wrv.13
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EU/R6kg8Qa2S2tf1n/s8/Ragb+3RZKw+3SYbXSlumns=;
 b=fmQaeiwMkR5KgOrYo0gNCGB3XGQmZLxKw9DXOcxKhqH5n13tEdfY+34Ifg+jUernW2
 6TQAl3qZ4flyhgoIpDRvQ02XhEaoovDZONdBY4y0lVBbWpivrmaa/0efw7v2A1Oai7z1
 22paNfyr9SCrZLpiZsvEZIrvzbnq8fxBkvL7gyJlObfMLnlc9McONIYpO+xa3hmiTigL
 0JzIUE45sFIJyxsyLY8n3az9nrMAGV2qGmfYlzp7mDKCLdkvWD3FNGFqL0g36OHiZGeR
 u2IrCtXAxm6+SO8e6XUSdOHpDDatiScWN2m1BzVzyFzT5WNscMAW3ypM+Wy8yYMe/LDf
 jDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EU/R6kg8Qa2S2tf1n/s8/Ragb+3RZKw+3SYbXSlumns=;
 b=P2e+fSceknLyxozWqE7w4Kha9lb1f1a+kJFtHNv+HuUsxB2t4XEt1nHfzzahIgW8gM
 6FWTn6HNC7YrSHCf5PDrnW692OESm9VE5zsw+Pq2PfwVMT+vj+KKFJHNSkvW+aPc1Sl/
 1IeyMEUUSAZBSWvIWrGm9yMYC29TFjRI/8YSjb5X9UeG9A/25PxXz67MPOpPSHA0X0YE
 vMj65Lk8b86v5us2UX6yOQ8Y2k5nSrf5TyQz5w4+RsZiC/ztPkHFKhw1GhivAOEzOXxR
 nDidRc0eLKx/O6EwGZZrgPAPH+HPgbueVB+l8GCcXNvgRs0il6CinhTJZOhcUHOcNUlm
 rqYA==
X-Gm-Message-State: APjAAAULrwYr8SNZVGAV0Ijt2+bSJi6o3Sayf8sV/F5kv79tVBjrM523
 L7/GRFIR8+S+vsdUCMad+y+zWj+dm7k=
X-Google-Smtp-Source: APXvYqwNZQZnFL3442h1TRHZmt/guKg9tVmrHTUPdysMXZYAVemjWMdU82h0sq9dHmKsE1eMOpMPiQ==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr20003818wrn.14.1570952918127; 
 Sun, 13 Oct 2019 00:48:38 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-179-64-109.red.bezeqint.net. [79.179.64.109])
 by smtp.gmail.com with ESMTPSA id u26sm9277532wrd.87.2019.10.13.00.48.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 13 Oct 2019 00:48:37 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 09/13] target/avr: Add instruction translation - CPU main
 translation function
Date: Sun, 13 Oct 2019 10:48:02 +0300
Message-Id: <20191013074803.91390-11-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191013074803.91390-1-mrolnik@gmail.com>
References: <20191013074803.91390-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 234 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 21ba6004ee..6d4a023ff9 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2780,3 +2780,237 @@ static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
 
     return true;
 }
+
+
+void avr_cpu_tcg_init(void)
+{
+    int i;
+
+#define AVR_REG_OFFS(x) offsetof(CPUAVRState, x)
+    cpu_pc = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(pc_w), "pc");
+    cpu_Cf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregC), "Cf");
+    cpu_Zf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregZ), "Zf");
+    cpu_Nf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregN), "Nf");
+    cpu_Vf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregV), "Vf");
+    cpu_Sf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregS), "Sf");
+    cpu_Hf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregH), "Hf");
+    cpu_Tf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregT), "Tf");
+    cpu_If = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregI), "If");
+    cpu_rampD = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampD), "rampD");
+    cpu_rampX = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampX), "rampX");
+    cpu_rampY = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampY), "rampY");
+    cpu_rampZ = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampZ), "rampZ");
+    cpu_eind = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(eind), "eind");
+    cpu_sp = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sp), "sp");
+    cpu_skip = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(skip), "skip");
+
+    for (i = 0; i < NO_CPU_REGISTERS; i++) {
+        cpu_r[i] = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(r[i]),
+                                          reg_names[i]);
+    }
+#undef AVR_REG_OFFS
+}
+
+static void translate(DisasContext *ctx)
+{
+    uint32_t opcode = next_word(ctx);
+
+    if (!decode_insn(ctx, opcode)) {
+        gen_helper_unsupported(cpu_env);
+        ctx->bstate = DISAS_NORETURN;
+    }
+}
+
+/* Standardize the cpu_skip condition to NE.  */
+static bool canonicalize_skip(DisasContext *ctx)
+{
+    switch (ctx->skip_cond) {
+    case TCG_COND_NEVER:
+        /* Normal case: cpu_skip is known to be false.  */
+        return false;
+
+    case TCG_COND_ALWAYS:
+        /*
+         * Breakpoint case: cpu_skip is known to be true, via TB_FLAGS_SKIP.
+         * The breakpoint is on the instruction being skipped, at the start
+         * of the TranslationBlock.  No need to update.
+         */
+        return false;
+
+    case TCG_COND_NE:
+        if (ctx->skip_var1 == NULL) {
+            tcg_gen_mov_tl(cpu_skip, ctx->skip_var0);
+        } else {
+            tcg_gen_xor_tl(cpu_skip, ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 = NULL;
+        }
+        break;
+
+    default:
+        /* Convert to a NE condition vs 0. */
+        if (ctx->skip_var1 == NULL) {
+            tcg_gen_setcondi_tl(ctx->skip_cond, cpu_skip, ctx->skip_var0, 0);
+        } else {
+            tcg_gen_setcond_tl(ctx->skip_cond, cpu_skip,
+                               ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 = NULL;
+        }
+        ctx->skip_cond = TCG_COND_NE;
+        break;
+    }
+    if (ctx->free_skip_var0) {
+        tcg_temp_free(ctx->skip_var0);
+        ctx->free_skip_var0 = false;
+    }
+    ctx->skip_var0 = cpu_skip;
+    return true;
+}
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+{
+    CPUAVRState *env = cs->env_ptr;
+    DisasContext ctx = {
+        .tb = tb,
+        .cs = cs,
+        .env = env,
+        .memidx = 0,
+        .bstate = DISAS_NEXT,
+        .skip_cond = TCG_COND_NEVER,
+        .singlestep = cs->singlestep_enabled,
+    };
+    target_ulong pc_start = tb->pc / 2;
+    int num_insns = 0;
+
+    if (tb->flags & TB_FLAGS_FULL_ACCESS) {
+        /*
+         * This flag is set by ST/LD instruction we will regenerate it ONLY
+         * with mem/cpu memory access instead of mem access
+         */
+        max_insns = 1;
+    }
+    if (ctx.singlestep) {
+        max_insns = 1;
+    }
+
+    gen_tb_start(tb);
+
+    ctx.npc = pc_start;
+    if (tb->flags & TB_FLAGS_SKIP) {
+        ctx.skip_cond = TCG_COND_ALWAYS;
+        ctx.skip_var0 = cpu_skip;
+    }
+
+    do {
+        TCGLabel *skip_label = NULL;
+
+        /* translate current instruction */
+        tcg_gen_insn_start(ctx.npc);
+        num_insns++;
+
+        /*
+         * this is due to some strange GDB behavior
+         * let's assume main has address 0x100
+         * b main   - sets breakpoint at address 0x00000100 (code)
+         * b *0x100 - sets breakpoint at address 0x00800100 (data)
+         */
+        if (unlikely(!ctx.singlestep &&
+                (cpu_breakpoint_test(cs, OFFSET_CODE + ctx.npc * 2, BP_ANY) ||
+                 cpu_breakpoint_test(cs, OFFSET_DATA + ctx.npc * 2, BP_ANY)))) {
+            canonicalize_skip(&ctx);
+            tcg_gen_movi_tl(cpu_pc, ctx.npc);
+            gen_helper_debug(cpu_env);
+            goto done_generating;
+        }
+
+        /* Conditionally skip the next instruction, if indicated.  */
+        if (ctx.skip_cond != TCG_COND_NEVER) {
+            skip_label = gen_new_label();
+            if (ctx.skip_var0 == cpu_skip) {
+                /*
+                 * Copy cpu_skip so that we may zero it before the branch.
+                 * This ensures that cpu_skip is non-zero after the label
+                 * if and only if the skipped insn itself sets a skip.
+                 */
+                ctx.free_skip_var0 = true;
+                ctx.skip_var0 = tcg_temp_new();
+                tcg_gen_mov_tl(ctx.skip_var0, cpu_skip);
+                tcg_gen_movi_tl(cpu_skip, 0);
+            }
+            if (ctx.skip_var1 == NULL) {
+                tcg_gen_brcondi_tl(ctx.skip_cond, ctx.skip_var0, 0, skip_label);
+            } else {
+                tcg_gen_brcond_tl(ctx.skip_cond, ctx.skip_var0,
+                                  ctx.skip_var1, skip_label);
+                ctx.skip_var1 = NULL;
+            }
+            if (ctx.free_skip_var0) {
+                tcg_temp_free(ctx.skip_var0);
+                ctx.free_skip_var0 = false;
+            }
+            ctx.skip_cond = TCG_COND_NEVER;
+            ctx.skip_var0 = NULL;
+        }
+
+        translate(&ctx);
+
+        if (skip_label) {
+            canonicalize_skip(&ctx);
+            gen_set_label(skip_label);
+            if (ctx.bstate == DISAS_NORETURN) {
+                ctx.bstate = DISAS_CHAIN;
+            }
+        }
+    } while (ctx.bstate == DISAS_NEXT
+             && num_insns < max_insns
+             && (ctx.npc - pc_start) * 2 < TARGET_PAGE_SIZE - 4
+             && !tcg_op_buf_full());
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    bool nonconst_skip = canonicalize_skip(&ctx);
+
+    switch (ctx.bstate) {
+    case DISAS_NORETURN:
+        assert(!nonconst_skip);
+        break;
+    case DISAS_NEXT:
+    case DISAS_TOO_MANY:
+    case DISAS_CHAIN:
+        if (!nonconst_skip) {
+            /* Note gen_goto_tb checks singlestep.  */
+            gen_goto_tb(&ctx, 1, ctx.npc);
+            break;
+        }
+        tcg_gen_movi_tl(cpu_pc, ctx.npc);
+        /* fall through */
+    case DISAS_LOOKUP:
+        if (!ctx.singlestep) {
+            tcg_gen_lookup_and_goto_ptr();
+            break;
+        }
+        /* fall through */
+    case DISAS_EXIT:
+        if (ctx.singlestep) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+done_generating:
+    gen_tb_end(tb, num_insns);
+
+    tb->size = (ctx.npc - pc_start) * 2;
+    tb->icount = num_insns;
+}
+
+void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
+                            target_ulong *data)
+{
+    env->pc_w = data[0];
+}
-- 
2.17.2 (Apple Git-113)


