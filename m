Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236A120724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236A120724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5LK-0002oT-9r
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F9-0007S7-9q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F7-0008Jo-IB
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id h28so32284319edz.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FnHkvEbRktr9azHnojGBBoQNdyyGCCp0vyeyrT/yeAA=;
 b=dfF6Za4XQXwGZ1gKVETYyRCyOdnDl+OPCZL4PmN6l9oy9FeIwktE2PHXjflq3UankH
 oUTfsfufpG6NXBlljR7Txupl9MOTA8KSoI8Ut1pMMHirft4p3s0NWddyBk3E2r06HM+S
 /oB8K66wtwhzMnwUyFlB14rxUZJXcB+Y2XxNVyhOHwCMwj00djduWUKYzcvVusUEHWAk
 oTWhYEDdTzWFNRp6i3WBu9oCJHQ0XsIvjPCfX2GA11pv6PhXrv6afWIcW/30hfqUs3uu
 7zd5Lbiekn1i4ozjkvM/OLLj+hlFl0dvhGJS4qjSMA2oD+a5nIOjpk4AnKWYi0iEl7Tw
 tUdw==
X-Gm-Message-State: AOAM532RY2Wh+TA2eyltDeAjI6UXI+hfynxpt1f71o2mHztD6z/F0SNH
 TN8tstkdFAN5AykMU99Ljo8r+37S
X-Google-Smtp-Source: ABdhPJy6FocxLotpULqpzV/7s99p65GEqjdfX1PGK5GgGb18wAinKAhoVxgUHCnA2pOWneEZ1NT5vw==
X-Received: by 2002:aa7:d2c9:: with SMTP id k9mr41704088edr.98.1593957819946; 
 Sun, 05 Jul 2020 07:03:39 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:39 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 16/30] target/avr: Add instruction translation - CPU main
 translation function
Date: Sun,  5 Jul 2020 16:03:01 +0200
Message-Id: <20200705140315.260514-17-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.67; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add the core of translation mechanism.

Co-developed-by: Richard Henderson <richard.henderson@linaro.org>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 target/avr/translate.c | 214 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 806a0f4e78..a6e67488df 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2815,3 +2815,217 @@ static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
 
     return true;
 }
+
+
+/*
+ *  Core translation mechanism functions:
+ *
+ *    - translate()
+ *    - canonicalize_skip()
+ *    - gen_intermediate_code()
+ *    - restore_state_to_opc()
+ *
+ */
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
2.26.2


