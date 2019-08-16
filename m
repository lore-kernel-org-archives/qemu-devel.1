Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE9C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E6A20578
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCC6gSw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E6A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycEW-0004zn-Hv
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6m-0003KS-HX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6k-0005P0-Ls
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6k-0005NN-DW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 207so4029479wma.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j84/g0oOWSuF2eIUk7fO9+M3370kgvOYjABlA5jzGcs=;
 b=wCC6gSw1wU3Z/PQeUVuV2wEGIJhI5vaajGeoahFmISh1MdCsMbiXurigpbHX2vuXPe
 dmrzACxBg8Ers5E0JjV897szPAKaGHr/igRQFpFhG1k3zgjhknh8yUN3qmp2zvYFrq3m
 MPlZPPVJK00+q7w0ZS5ClbRi03XlLxd4JY/Nl4MJKg9VypDyuP1vArhoJ6sY8zaRuGZM
 /AvLUUzdcfQS/zZXVUvxIBFWEOLBS5J2awO18IhQ2zZRg8fviNLWZjMRN1pa9QDPmjF+
 NgcjD7EMdQ3pY3027vskUCTENLd6OZpRuXgUYxebSbejZ4B1JoydZ1A+KRk2ylqCWWr6
 roqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j84/g0oOWSuF2eIUk7fO9+M3370kgvOYjABlA5jzGcs=;
 b=gqSrkmDu0NxTa8EEURQu3N7qjJkpJmICZtjvarX3dMf/lAW4wuur0yVObq/1gVdsXd
 fZFEW2H7jHdPV/GOtoCZQcwJKHq14ycpaRslPJtYd+s6OPcOG/HTEJxwVKuvaD2bwwcU
 Ryiuu46J/ENv6b8zJJXeMx2u+envtiXMo7YXRVxnHaM1UR5H+DErWfPIAIG4EmqmdVRr
 ba84Qfpm25Tb+vDChCOF/e2jJV+2AIHjImC1LOonaFWPhQYgmEXl0+yhTeqIaaS8TSr0
 D8qTYfHF621XBAtA4ScZn1bDmwWhGcYu+eI7DX+fTzSG09gG4qIyf6Onr9yhsSqKaINC
 VBlA==
X-Gm-Message-State: APjAAAW6jznANA9A7TuR9x3uzXD2RL+DZJEa1DP3Kfps6pPTrqesrqry
 ndawHHza+qEYY5y5jHjplEF+UZvPBnl3sg==
X-Google-Smtp-Source: APXvYqwon+BkF4y2MBq90VvPNkSS9w6x2ezdic+kMd7v/dbVfhrkAcs28FUrt2fVURJUHWuIwuS+3g==
X-Received: by 2002:a05:600c:22d7:: with SMTP id
 23mr7773419wmg.0.1565961448455; 
 Fri, 16 Aug 2019 06:17:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:57 +0100
Message-Id: <20190816131719.28244-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 07/29] target/arm: Introduce pc_curr
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Add a new field to retain the address of the instruction currently
being translated.  The 32-bit uses are all within subroutines used
by a32 and t32.  This will become less obvious when t16 support is
merged with a32+t32, and having a clear definition will help.

Convert aarch64 as well for consistency.  Note that there is one
instance of a pre-assert fprintf that used the wrong value for the
address of the current instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h |  2 +-
 target/arm/translate.h     |  2 ++
 target/arm/translate-a64.c | 21 +++++++++++----------
 target/arm/translate.c     | 14 ++++++++------
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9ab40872d85..9cd2b3d2389 100644
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
index b65954c669b..53ac50bc028 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -11,6 +11,8 @@ typedef struct DisasContext {
     const ARMISARegisters *isar;
 
     target_ulong pc;
+    /* The address of the current instruction being translated. */
+    target_ulong pc_curr;
     target_ulong page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 90850eadc1b..a0b557ddcec 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1234,7 +1234,7 @@ static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
  */
 static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
 {
-    uint64_t addr = s->pc + sextract32(insn, 0, 26) * 4 - 4;
+    uint64_t addr = s->pc_curr + sextract32(insn, 0, 26) * 4;
 
     if (insn & (1U << 31)) {
         /* BL Branch with link */
@@ -1262,7 +1262,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     sf = extract32(insn, 31, 1);
     op = extract32(insn, 24, 1); /* 0: CBZ; 1: CBNZ */
     rt = extract32(insn, 0, 5);
-    addr = s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 19) * 4;
 
     tcg_cmp = read_cpu_reg(s, rt, sf);
     label_match = gen_new_label();
@@ -1291,7 +1291,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
 
     bit_pos = (extract32(insn, 31, 1) << 5) | extract32(insn, 19, 5);
     op = extract32(insn, 24, 1); /* 0: TBZ; 1: TBNZ */
-    addr = s->pc + sextract32(insn, 5, 14) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 14) * 4;
     rt = extract32(insn, 0, 5);
 
     tcg_cmp = tcg_temp_new_i64();
@@ -1322,7 +1322,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-    addr = s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr = s->pc_curr + sextract32(insn, 5, 19) * 4;
     cond = extract32(insn, 0, 4);
 
     reset_btype(s);
@@ -1706,7 +1706,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         TCGv_i32 tcg_syn, tcg_isread;
         uint32_t syndrome;
 
-        gen_a64_set_pc_im(s->pc - 4);
+        gen_a64_set_pc_im(s->pc_curr);
         tmpptr = tcg_const_ptr(ri);
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         tcg_syn = tcg_const_i32(syndrome);
@@ -1870,7 +1870,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             /* The pre HVC helper handles cases when HVC gets trapped
              * as an undefined insn by runtime configuration.
              */
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->pc_curr);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
             gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
@@ -1880,7 +1880,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 break;
             }
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->pc_curr);
             tmp = tcg_const_i32(syn_aa64_smc(imm16));
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
@@ -2601,7 +2601,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
 
     tcg_rt = cpu_reg(s, rt);
 
-    clean_addr = tcg_const_i64((s->pc - 4) + imm);
+    clean_addr = tcg_const_i64(s->pc_curr + imm);
     if (is_vector) {
         do_fp_ld(s, rt, clean_addr, size);
     } else {
@@ -3580,7 +3580,7 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
     offset = sextract64(insn, 5, 19);
     offset = offset << 2 | extract32(insn, 29, 2);
     rd = extract32(insn, 0, 5);
-    base = s->pc - 4;
+    base = s->pc_curr;
 
     if (page) {
         /* ADRP (page based) */
@@ -11519,7 +11519,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 break;
             default:
                 fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
-                        __func__, insn, fpopcode, s->pc);
+                        __func__, insn, fpopcode, s->pc_curr);
                 g_assert_not_reached();
             }
 
@@ -14030,6 +14030,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 {
     uint32_t insn;
 
+    s->pc_curr = s->pc;
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
     s->insn = insn;
     s->pc += 4;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index de941e6b3dc..fed08c63f81 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1197,7 +1197,7 @@ static inline void gen_hvc(DisasContext *s, int imm16)
      * as an undefined insn by runtime configuration (ie before
      * the insn really executes).
      */
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     gen_helper_pre_hvc(cpu_env);
     /* Otherwise we will treat this as a real exception which
      * happens after execution of the insn. (The distinction matters
@@ -1216,7 +1216,7 @@ static inline void gen_smc(DisasContext *s)
      */
     TCGv_i32 tmp;
 
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tmp = tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
@@ -3175,7 +3175,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because msr_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tcg_reg = load_reg(s, rn);
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -3197,7 +3197,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
 
     /* Sync state because mrs_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     tcg_reg = tcg_temp_new_i32();
     tcg_tgtmode = tcg_const_i32(tgtmode);
     tcg_regno = tcg_const_i32(regno);
@@ -7204,7 +7204,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
 
             gen_set_condexec(s);
-            gen_set_pc_im(s, s->pc - 4);
+            gen_set_pc_im(s, s->pc_curr);
             tmpptr = tcg_const_ptr(ri);
             tcg_syn = tcg_const_i32(syndrome);
             tcg_isread = tcg_const_i32(isread);
@@ -7614,7 +7614,7 @@ static void gen_srs(DisasContext *s,
     tmp = tcg_const_i32(mode);
     /* get_r13_banked() will raise an exception if called from System mode */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->pc_curr);
     gen_helper_get_r13_banked(addr, cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     switch (amode) {
@@ -12039,6 +12039,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
+    dc->pc_curr = dc->pc;
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
     dc->insn = insn;
     dc->pc += 4;
@@ -12107,6 +12108,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
+    dc->pc_curr = dc->pc;
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
     dc->pc += 2;
-- 
2.20.1


