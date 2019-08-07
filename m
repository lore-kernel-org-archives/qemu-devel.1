Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ABBC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F119121743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsTJ1jy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F119121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDzi-0006BA-75
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxN-00013L-Gh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxL-0004kF-Sl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:33270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxL-0004iu-LM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:47 -0400
Received: by mail-pg1-x532.google.com with SMTP id n190so1981158pgn.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rO+a4ZP5jWR/KlxPWwiR76ooj5F0S+A/mpDiKuebxZ8=;
 b=SsTJ1jy7wLifKzmc1r0VUxXvAgcUvtjhe+s0eeNm9Oe3WWyRTl/4vj4poaffj27stp
 e5tUiMtsT3vQHEgBv2h8ww9Hre6Ei1mE8Ihz7GgmJVFNy7NL1ojtScG3H4A3nxPhMJ4f
 L8C99lu/ydx7TpJToxMvwRn9vXMHlYsBJaJn+o6oiT4l4P5lwwBanXBN4A2/d1GU6YMt
 AYJVeiV7wCsw6WsIYR9x2i1rDvRAt1+s5t3D/n9p8PuTK1dcSxup/5yBRvMsv7Y7TQLY
 Excs27fg6GyWxW7PDQYJZHPYN+mOMFHcmXy5jjk040ZxwoO9eQEppCoYgwWFkit+u2rk
 Kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rO+a4ZP5jWR/KlxPWwiR76ooj5F0S+A/mpDiKuebxZ8=;
 b=fsjSJBDHuJvWudd+tOZwuFCdEYHkTdexVeppZQdhfK2fP0eQfHWEkvns9ae39dCbrO
 ISYMS1XZyEqwSapFXYnfQo5gugoQUqCBoWTiYLspTyZEHP+47n+beeK2AIyyD8Pxm57w
 La7BaG3l66ErBvKaqAhZSuup1ryC7XKJbxHIxdFKBwxcVYXx6Uu49ByvOJFMKwkh9B1h
 Cm5xG3d+XuMfnjfzhqjFED2uCR0BpGFxxOO8HqZ26Drg7DFo3L7VmvvCfpLrdRzxzsmE
 UpIKAbxEbZC5bXTK4S37xk7jzOwGvIUbPu1aJx58LQ9gFVC9joztgWSEZsRFFlndLeho
 hOvA==
X-Gm-Message-State: APjAAAXPAdqZhrB++5GnmlHb22/lFnMMijc0bOZWnmaF01do03rO4SUf
 oysoaeNib2YDcARj6VeLq8qop3u+bdc=
X-Google-Smtp-Source: APXvYqw+9FGzHjgHJbyzeX6BHe7KgFTNqJqlhM2IS8INkXNXAjkTGeQKMlNDTOdOYNBPFVUPQfnaOg==
X-Received: by 2002:a17:90a:338b:: with SMTP id
 n11mr6486729pjb.21.1565153626202; 
 Tue, 06 Aug 2019 21:53:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:26 -0700
Message-Id: <20190807045335.1361-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: [Qemu-devel] [PATCH 02/11] target/arm: Introduce pc_curr
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

Add a new field to retain the address of the instruction currently
being translated.  The 32-bit uses are all within subroutines used
by a32 and t32.  This will become less obvious when t16 support is
merged with a32+t32, and having a clear definition will help.

Convert aarch64 as well for consistency.  Note that there is one
instance of a pre-assert fprintf that used the wrong value for the
address of the current instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h |  2 +-
 target/arm/translate.h     |  2 ++
 target/arm/translate-a64.c | 21 +++++++++++----------
 target/arm/translate.c     | 14 ++++++++------
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9ab40872d8..9cd2b3d238 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -25,7 +25,7 @@ void unallocated_encoding(DisasContext *s);
         qemu_log_mask(LOG_UNIMP,                                         \
                       "%s:%d: unsupported instruction encoding 0x%08x "  \
                       "at pc=%016" PRIx64 "\n",                          \
-                      __FILE__, __LINE__, insn, s->pc - 4);              \
+                      __FILE__, __LINE__, insn, s->pc_curr);             \
         unallocated_encoding(s);                                         \
     } while (0)
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e2056..525603eb30 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -10,6 +10,8 @@ typedef struct DisasContext {
     const ARMISARegisters *isar;
 
     target_ulong pc;
+    /* The address of the current instruction being translated. */
+    target_ulong pc_curr;
     target_ulong page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a2..da447eedcc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1248,7 +1248,7 @@ static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
  */
 static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
 {
-    uint64_t addr = s->pc + sextract32(insn, 0, 26) * 4 - 4;
+    uint64_t addr = s->pc_curr + sextract32(insn, 0, 26) * 4;
 
     if (insn & (1U << 31)) {
         /* BL Branch with link */
@@ -1276,7 +1276,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     sf = extract32(insn, 31, 1);
     op = extract32(insn, 24, 1); /* 0: CBZ; 1: CBNZ */
     rt = extract32(insn, 0, 5);
-    addr = s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 19) * 4;
 
     tcg_cmp = read_cpu_reg(s, rt, sf);
     label_match = gen_new_label();
@@ -1305,7 +1305,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
 
     bit_pos = (extract32(insn, 31, 1) << 5) | extract32(insn, 19, 5);
     op = extract32(insn, 24, 1); /* 0: TBZ; 1: TBNZ */
-    addr = s->pc + sextract32(insn, 5, 14) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 14) * 4;
     rt = extract32(insn, 0, 5);
 
     tcg_cmp = tcg_temp_new_i64();
@@ -1336,7 +1336,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-    addr = s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 19) * 4;
     cond = extract32(insn, 0, 4);
 
     reset_btype(s);
@@ -1720,7 +1720,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         TCGv_i32 tcg_syn, tcg_isread;
         uint32_t syndrome;
 
-        gen_a64_set_pc_im(s->pc - 4);
+        gen_a64_set_pc_im(s->pc_curr);
         tmpptr = tcg_const_ptr(ri);
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         tcg_syn = tcg_const_i32(syndrome);
@@ -1884,7 +1884,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             /* The pre HVC helper handles cases when HVC gets trapped
              * as an undefined insn by runtime configuration.
              */
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->pc_curr);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
             gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
@@ -1894,7 +1894,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 break;
             }
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->pc_curr);
             tmp = tcg_const_i32(syn_aa64_smc(imm16));
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
@@ -2615,7 +2615,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
 
     tcg_rt = cpu_reg(s, rt);
 
-    clean_addr = tcg_const_i64((s->pc - 4) + imm);
+    clean_addr = tcg_const_i64(s->pc_curr + imm);
     if (is_vector) {
         do_fp_ld(s, rt, clean_addr, size);
     } else {
@@ -3594,7 +3594,7 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
     offset = sextract64(insn, 5, 19);
     offset = offset << 2 | extract32(insn, 29, 2);
     rd = extract32(insn, 0, 5);
-    base = s->pc - 4;
+    base = s->pc_curr;
 
     if (page) {
         /* ADRP (page based) */
@@ -11533,7 +11533,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 break;
             default:
                 fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
-                        __func__, insn, fpopcode, s->pc);
+                        __func__, insn, fpopcode, s->pc_curr);
                 g_assert_not_reached();
             }
 
@@ -14044,6 +14044,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 {
     uint32_t insn;
 
+    s->pc_curr = s->pc;
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
     s->insn = insn;
     s->pc += 4;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1f15f14022..59e35aafbf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1212,7 +1212,7 @@ static inline void gen_hvc(DisasContext *s, int imm16)
      * as an undefined insn by runtime configuration (ie before
      * the insn really executes).
      */
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     gen_helper_pre_hvc(cpu_env);
     /* Otherwise we will treat this as a real exception which
      * happens after execution of the insn. (The distinction matters
@@ -1231,7 +1231,7 @@ static inline void gen_smc(DisasContext *s)
      */
     TCGv_i32 tmp;
 
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tmp = tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
@@ -3190,7 +3190,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because msr_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tcg_reg = load_reg(s, rn);
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -3212,7 +3212,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because mrs_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tcg_reg = tcg_temp_new_i32();
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -7219,7 +7219,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
 
             gen_set_condexec(s);
-            gen_set_pc_im(s, s->pc - 4);
+            gen_set_pc_im(s, s->pc_curr);
             tmpptr = tcg_const_ptr(ri);
             tcg_syn = tcg_const_i32(syndrome);
             tcg_isread = tcg_const_i32(isread);
@@ -7629,7 +7629,7 @@ static void gen_srs(DisasContext *s,
     tmp = tcg_const_i32(mode);
     /* get_r13_banked() will raise an exception if called from System mode */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     gen_helper_get_r13_banked(addr, cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     switch (amode) {
@@ -12053,6 +12053,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
+    dc->pc_curr = dc->pc;
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
     dc->insn = insn;
     dc->pc += 4;
@@ -12121,6 +12122,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
+    dc->pc_curr = dc->pc;
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
     dc->pc += 2;
-- 
2.17.1


