Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E33C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60D21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6ma9FoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60D21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDyk-00044a-Jf
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxT-0001OB-VQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxR-0004rp-97
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:34299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxR-0004rJ-0b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id n9so36572536pgc.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xrT2xFFVDlQRNqGts9PkM7GHiRTgWtKew7tGQ/78WS0=;
 b=L6ma9FoDbjRzteryq+o3Zbx5vbETFPPUKLUbZE5N+KE/IcDFfkRABX/9SlFN8uLpTw
 qm5lBDCOhWz1VaVGxBeQcpT2M4P1nMzGxjprVCsiOeTqTpDd0pJWd4A2/htUQMgZdcMF
 +PGerbWmeTgiKzZT7yhj26r2MkC4wRt9kKu8LnOqcVcUNPUtZPB3JiaeTrmfpt/1RpSA
 rKgp4BvSI3zoeHa7+MVmRmCeUpTzPXl1j6RzHT3uLzFINF9/FhjmhNczBSNI5nk4ld9e
 aasExstnIe+df9xFc1RS8P0xUVuCNN8i5YXuj0gnnPC3juscMq4oX15oMjcDhyq8qkFd
 0FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xrT2xFFVDlQRNqGts9PkM7GHiRTgWtKew7tGQ/78WS0=;
 b=tZkKSzjMGYcNxvVwg0QzwSq0tC0gn+N6u0pUBxyx1R/hwmHxMBfWug2PcK1saUfoNT
 6KCiI7/qLJUCXv9+G6k51FzUeTb2ztjrj3OfypEpGGV2CDEV4Ku8tBXt0wpQWqiEB8eC
 QxQsRVP+tPOYUNFqlE/fBD9ARAFX4estkaoa7s1ndOfASPAoh5CnnBQuzbOQvStfGLSt
 06SrCL2Vd4Hxa9Gn86sUiFmb3dCmB2ZpbPWQFLP95OnscPoVpU7wKCaE7jqg+P3xukNI
 VpIJafvl+zNvxIyd8cTbJuodiqD2gJ70enr9MfSBWRKZcckinKCduW1MyTRRwSqxtlO7
 kV4g==
X-Gm-Message-State: APjAAAXV83lrddrp42pt0JtyD1FpOGK2JhjYNu/BX1CS9YyMIzIvPZNP
 EOHgEkjdWYl3EMF9eFm8sOhjVu84Ti8=
X-Google-Smtp-Source: APXvYqwtRdsCo9NUouZOEQNCR9JQjeIIVhbh5hmWtd9YDgv/yCbZfBHPN0XdGaEDqx1xXXPz5tSg1A==
X-Received: by 2002:a62:2ad3:: with SMTP id q202mr7531046pfq.161.1565153631369; 
 Tue, 06 Aug 2019 21:53:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:30 -0700
Message-Id: <20190807045335.1361-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PATCH 06/11] target/arm: Replace s->pc with
 s->base.pc_next
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must update s->base.pc_next when we return from the translate_insn
hook to the main translator loop.  By incrementing s->base.pc_next
immediately after reading the insn word, "pc_next" contains the address
of the next instruction throughout translation.

All remaining uses of s->pc are referencing the address of the next insn,
so this is now a simple global replacement.  Remove the "s->pc" field.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   1 -
 target/arm/translate-a64.c |  51 +++++++++---------
 target/arm/translate.c     | 103 ++++++++++++++++++-------------------
 3 files changed, 72 insertions(+), 83 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 525603eb30..de600073d8 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -9,7 +9,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
 
-    target_ulong pc;
     /* The address of the current instruction being translated. */
     target_ulong pc_curr;
     target_ulong page_start;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index da447eedcc..e640e116b0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -268,7 +268,7 @@ static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
 
 static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -276,7 +276,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception(excp, syndrome, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -286,7 +286,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset,
 {
     TCGv_i32 tcg_syn;
 
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     tcg_syn = tcg_const_i32(syndrome);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -1252,7 +1252,7 @@ static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
 
     if (insn & (1U << 31)) {
         /* BL Branch with link */
-        tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+        tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
     }
 
     /* B Branch / BL Branch with link */
@@ -1285,7 +1285,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
 
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1316,7 +1316,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
     tcg_temp_free_i64(tcg_cmp);
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1344,7 +1344,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
         /* genuinely conditional branches */
         TCGLabel *label_match = gen_new_label();
         arm_gen_test_cc(cond, label_match);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         gen_set_label(label_match);
         gen_goto_tb(s, 1, addr);
     } else {
@@ -1505,7 +1505,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * any pending interrupts immediately.
          */
         reset_btype(s);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         return;
 
     case 7: /* SB */
@@ -1517,7 +1517,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * MB and end the TB instead.
          */
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         return;
 
     default:
@@ -2029,7 +2029,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         gen_a64_set_pc(s, dst);
         /* BLR also needs to load return address */
         if (opc == 1) {
-            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
         }
         break;
 
@@ -2056,7 +2056,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         gen_a64_set_pc(s, dst);
         /* BLRAA also needs to load return address */
         if (opc == 9) {
-            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
         }
         break;
 
@@ -14044,10 +14044,10 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 {
     uint32_t insn;
 
-    s->pc_curr = s->pc;
-    insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    s->pc_curr = s->base.pc_next;
+    insn = arm_ldl_code(env, s->base.pc_next, s->sctlr_b);
     s->insn = insn;
-    s->pc += 4;
+    s->base.pc_next += 4;
 
     s->fp_access_checked = false;
 
@@ -14144,7 +14144,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     int bound, core_mmu_idx;
 
     dc->isar = &arm_cpu->isar;
-    dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
     dc->aarch64 = 1;
@@ -14217,7 +14216,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(dc->pc, 0, 0);
+    tcg_gen_insn_start(dc->base.pc_next, 0, 0);
     dc->insn_start = tcg_last_op();
 }
 
@@ -14227,7 +14226,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (bp->flags & BP_CPU) {
-        gen_a64_set_pc_im(dc->pc);
+        gen_a64_set_pc_im(dc->base.pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it likely won't be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
@@ -14238,7 +14237,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
            to for it to be properly cleared -- thus we
            increment the PC here so that the logic setting
            tb->size below does the right thing.  */
-        dc->pc += 4;
+        dc->base.pc_next += 4;
         dc->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -14269,7 +14268,6 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         disas_a64_insn(env, dc);
     }
 
-    dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
 
@@ -14285,7 +14283,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         switch (dc->base.is_jmp) {
         default:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
         case DISAS_JUMP:
@@ -14302,11 +14300,11 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         default:
         case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
@@ -14318,11 +14316,11 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_SWI:
             break;
         case DISAS_WFE:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfe(cpu_env);
             break;
         case DISAS_YIELD:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_yield(cpu_env);
             break;
         case DISAS_WFI:
@@ -14332,7 +14330,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
              */
             TCGv_i32 tmp = tcg_const_i32(4);
 
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfi(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
@@ -14343,9 +14341,6 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         }
         }
     }
-
-    /* Functions above can change dc->pc, so re-align db->pc_next */
-    dc->base.pc_next = dc->pc;
 }
 
 static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 100f958e33..dfbaa592ab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1051,7 +1051,7 @@ static inline void gen_blxns(DisasContext *s, int rm)
      * We do however need to set the PC, because the blxns helper reads it.
      * The blxns helper may throw an exception.
      */
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     gen_helper_v7m_blxns(cpu_env, var);
     tcg_temp_free_i32(var);
     s->base.is_jmp = DISAS_EXIT;
@@ -1237,7 +1237,7 @@ static inline void gen_hvc(DisasContext *s, int imm16)
      * for single stepping.)
      */
     s->svc_imm = imm16;
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     s->base.is_jmp = DISAS_HVC;
 }
 
@@ -1252,14 +1252,14 @@ static inline void gen_smc(DisasContext *s)
     tmp = tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     s->base.is_jmp = DISAS_SMC;
 }
 
 static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1268,7 +1268,7 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                int syn, uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception(excp, syn, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1278,7 +1278,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
     TCGv_i32 tcg_syn;
 
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     tcg_syn = tcg_const_i32(syn);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -1288,7 +1288,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
-    tcg_gen_movi_i32(cpu_R[15], s->pc);
+    tcg_gen_movi_i32(cpu_R[15], s->base.pc_next);
     s->base.is_jmp = DISAS_EXIT;
 }
 
@@ -2924,7 +2924,7 @@ static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
     return (s->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK) ||
-           ((s->pc - 1) & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+           ((s->base.pc_next - 1) & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -3294,17 +3294,17 @@ static void gen_nop_hint(DisasContext *s, int val)
          */
     case 1: /* yield */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_YIELD;
         }
         break;
     case 3: /* wfi */
-        gen_set_pc_im(s, s->pc);
+        gen_set_pc_im(s, s->base.pc_next);
         s->base.is_jmp = DISAS_WFI;
         break;
     case 2: /* wfe */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_WFE;
         }
         break;
@@ -7255,7 +7255,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             if (isread) {
                 return 1;
             }
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_WFI;
             return 0;
         default:
@@ -7819,7 +7819,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_goto_tb(s, 0, s->pc);
+                gen_goto_tb(s, 0, s->base.pc_next);
                 return;
             case 7: /* sb */
                 if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -7830,7 +7830,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * for TCG; MB and end the TB instead.
                  */
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->pc);
+                gen_goto_tb(s, 0, s->base.pc_next);
                 return;
             default:
                 goto illegal_op;
@@ -7886,7 +7886,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             int32_t offset;
 
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, s->pc);
+            tcg_gen_movi_i32(tmp, s->base.pc_next);
             store_reg(s, 14, tmp);
             /* Sign-extend the 24-bit offset */
             offset = (((int32_t)insn) << 8) >> 8;
@@ -8071,7 +8071,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* branch link/exchange thumb (blx) */
             tmp = load_reg(s, rm);
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             break;
@@ -9237,7 +9237,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 /* branch (and link) */
                 if (insn & (1 << 24)) {
                     tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, s->pc);
+                    tcg_gen_movi_i32(tmp, s->base.pc_next);
                     store_reg(s, 14, tmp);
                 }
                 offset = sextract32(insn << 2, 0, 26);
@@ -9259,7 +9259,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm = extract32(insn, 0, 24);
             s->base.is_jmp = DISAS_SWI;
             break;
@@ -10341,7 +10341,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
                 if (insn & (1 << 14)) {
                     /* Branch and link.  */
-                    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
+                    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
                 }
 
                 offset += read_pc(s);
@@ -10464,7 +10464,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_goto_tb(s, 0, s->pc);
+                            gen_goto_tb(s, 0, s->base.pc_next);
                             break;
                         case 7: /* sb */
                             if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -10475,7 +10475,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * for TCG; MB and end the TB instead.
                              */
                             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->pc);
+                            gen_goto_tb(s, 0, s->base.pc_next);
                             break;
                         default:
                             goto illegal_op;
@@ -11136,7 +11136,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 /* BLX/BX */
                 tmp = load_reg(s, rm);
                 if (link) {
-                    val = (uint32_t)s->pc | 1;
+                    val = (uint32_t)s->base.pc_next | 1;
                     tmp2 = tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp2, val);
                     store_reg(s, 14, tmp2);
@@ -11710,7 +11710,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         if (cond == 0xf) {
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm = extract32(insn, 0, 8);
             s->base.is_jmp = DISAS_SWI;
             break;
@@ -11739,7 +11739,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
 
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             break;
@@ -11764,7 +11764,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             tcg_gen_addi_i32(tmp, tmp, offset);
 
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
         } else {
@@ -11784,16 +11784,16 @@ undef:
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 {
-    /* Return true if the insn at dc->pc might cross a page boundary.
+    /* Return true if the insn at dc->base.pc_next might cross a page boundary.
      * (False positives are OK, false negatives are not.)
      * We know this is a Thumb insn, and our caller ensures we are
-     * only called if dc->pc is less than 4 bytes from the page
+     * only called if dc->base.pc_next is less than 4 bytes from the page
      * boundary, so we cross the page if the first 16 bits indicate
      * that this is a 32 bit insn.
      */
-    uint16_t insn = arm_lduw_code(env, s->pc, s->sctlr_b);
+    uint16_t insn = arm_lduw_code(env, s->base.pc_next, s->sctlr_b);
 
-    return !thumb_insn_is_16bit(s, s->pc, insn);
+    return !thumb_insn_is_16bit(s, s->base.pc_next, insn);
 }
 
 static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
@@ -11805,7 +11805,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint32_t condexec, core_mmu_idx;
 
     dc->isar = &cpu->isar;
-    dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
     dc->aarch64 = 0;
@@ -11935,7 +11934,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(dc->pc,
+    tcg_gen_insn_start(dc->base.pc_next,
                        (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                        0);
     dc->insn_start = tcg_last_op();
@@ -11948,7 +11947,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 
     if (bp->flags & BP_CPU) {
         gen_set_condexec(dc);
-        gen_set_pc_im(dc, dc->pc);
+        gen_set_pc_im(dc, dc->base.pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it's likely not going to be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
@@ -11961,7 +11960,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
            tb->size below does the right thing.  */
         /* TODO: Advance PC by correct instruction length to
          * avoid disassembler error messages */
-        dc->pc += 2;
+        dc->base.pc_next += 2;
         dc->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -11972,7 +11971,7 @@ static bool arm_pre_translate_insn(DisasContext *dc)
 {
 #ifdef CONFIG_USER_ONLY
     /* Intercept jump to the magic kernel page.  */
-    if (dc->pc >= 0xffff0000) {
+    if (dc->base.pc_next >= 0xffff0000) {
         /* We always get here via a jump, so know we are not in a
            conditional execution block.  */
         gen_exception_internal(EXCP_KERNEL_TRAP);
@@ -12008,7 +12007,6 @@ static void arm_post_translate_insn(DisasContext *dc)
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
-    dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
 
@@ -12022,10 +12020,10 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
-    dc->pc_curr = dc->pc;
-    insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    dc->pc_curr = dc->base.pc_next;
+    insn = arm_ldl_code(env, dc->base.pc_next, dc->sctlr_b);
     dc->insn = insn;
-    dc->pc += 4;
+    dc->base.pc_next += 4;
     disas_arm_insn(dc, insn);
 
     arm_post_translate_insn(dc);
@@ -12091,15 +12089,15 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
-    dc->pc_curr = dc->pc;
-    insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
-    is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
-    dc->pc += 2;
+    dc->pc_curr = dc->base.pc_next;
+    insn = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
+    is_16bit = thumb_insn_is_16bit(dc, dc->base.pc_next, insn);
+    dc->base.pc_next += 2;
     if (!is_16bit) {
-        uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
+        uint32_t insn2 = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
-        dc->pc += 2;
+        dc->base.pc_next += 2;
     }
     dc->insn = insn;
 
@@ -12147,8 +12145,8 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
      * but isn't very efficient).
      */
     if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->pc - dc->page_start >= TARGET_PAGE_SIZE
-            || (dc->pc - dc->page_start >= TARGET_PAGE_SIZE - 3
+        && (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE
+            || (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE - 3
                 && insn_crosses_page(env, dc)))) {
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
@@ -12193,7 +12191,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
@@ -12214,13 +12212,13 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch(dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
         case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
@@ -12266,15 +12264,12 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_set_label(dc->condlabel);
         gen_set_condexec(dc);
         if (unlikely(is_singlestepping(dc))) {
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             gen_singlestep_exception(dc);
         } else {
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
         }
     }
-
-    /* Functions above can change dc->pc, so re-align db->pc_next */
-    dc->base.pc_next = dc->pc;
 }
 
 static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
-- 
2.17.1


