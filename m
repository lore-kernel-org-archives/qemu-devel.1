Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0614C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9fCm6fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0614C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UeY-0002mP-Qn
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQy-0000ey-Cp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQv-0006z6-Vt
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:08 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQv-0006yj-QF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:05 -0400
Received: by mail-yb1-xb41.google.com with SMTP id y21so1328936ybi.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2MVezhOnSXMFe1BhwqdhtO91Z2Tkal6SpzZGZbQLrrE=;
 b=Y9fCm6fRzR5Do4wFxbVCzycW+dRB9A5U21RQxCwNvF21GV2IgfRoxPjayXsvMOh/yi
 krMy3ZAU9hgZSJ/qoKMiQLIbGAaovclhudGyXZLGcb1gDePHV9bj4iN4R8V1GuOKo3de
 s2zhlnd0+KaMaHcFfbTwIikOlnqKnH5SlayauMm/7+usalz1a+/9E6qPP6vQMRAn0wtm
 yu/O0uH5I7dEqk40ZfFIAzh8WAFFidMLkrIWvmwZK1RYhblANmPj06ojR1eadNZr+tXX
 ZzNylor+akBybUu1ufCBgzzdJi9sIhiXYGD251Gp4SN/hCYU5U8otKKxyG2v5xFLeWtB
 uqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2MVezhOnSXMFe1BhwqdhtO91Z2Tkal6SpzZGZbQLrrE=;
 b=YaeOlLz2gKoITIeW41uqzKhEMdFC+jS6gypiInIEHoGsg5yTDoBmb7mPMY7RaVXlnT
 u+DN7zxkSg/tESDyu9j2S6ZaJQhfNXWBp1rq2Nx3KlW8rTI+z/RSRxnxkx0uSbJ1Njxf
 0sVYG/r0C5umE0N2X/0jHNQoftKtw1I1QeepoaVy1gp2uDcA0iuVX7uOl+kaTM33ZoOi
 swlleuQFdPWr2jq4mnMoeyP/UBSV/8DV54o1TDBEkG6CiYlpGw/qYWp4WVGI3hvDXmRs
 09hFK+H9G1y/hC7+U6MxEr4fLqUmElhgg5d7M9QLaEAUfMZui6JPkIzB1lVe5/MY8tJi
 IwLg==
X-Gm-Message-State: APjAAAV9MF8KBCv6W0nl3MgH2Nvo62W/4xHmJcPvnNsulqe8Uw+FquX8
 skf9gBdL0Dd6mQEoXPi7p4QUudyb
X-Google-Smtp-Source: APXvYqyDR9X7Yj5/mbMoHZLigfKava5RCY8urorR5JBSWk8bL5FE/psxWZeToP3Q6UlPUMbWe27C+Q==
X-Received: by 2002:a25:dc87:: with SMTP id
 y129mr15425092ybe.424.1566408604920; 
 Wed, 21 Aug 2019 10:30:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:04 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:40 -0400
Message-Id: <20190821172951.15333-5-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 04/75] target/i386: use prefix from
 DisasContext
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use prefix from DisasContext instead of the local helper variable
prefixes.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 110 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7226c67d2e..99a9097c49 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6351,7 +6351,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa4: /* movsS */
     case 0xa5:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_movs(s, ot);
@@ -6361,7 +6361,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaa: /* stosS */
     case 0xab:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_stos(s, ot);
@@ -6370,7 +6370,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xac: /* lodsS */
     case 0xad:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_lods(s, ot);
@@ -6379,9 +6379,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xae: /* scasS */
     case 0xaf:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & PREFIX_REPNZ) {
+        if (s->prefix & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
-        } else if (prefixes & PREFIX_REPZ) {
+        } else if (s->prefix & PREFIX_REPZ) {
             gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_scas(s, ot);
@@ -6391,9 +6391,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa6: /* cmpsS */
     case 0xa7:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & PREFIX_REPNZ) {
+        if (s->prefix & PREFIX_REPNZ) {
             gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
-        } else if (prefixes & PREFIX_REPZ) {
+        } else if (s->prefix & PREFIX_REPZ) {
             gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_cmps(s, ot);
@@ -6404,8 +6404,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base, 
-                     SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes) | 4);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+                     SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix) | 4);
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
@@ -6419,8 +6419,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     svm_is_rep(prefixes) | 4);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+                     svm_is_rep(s->prefix) | 4);
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
@@ -6439,7 +6439,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
+                     SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -6457,7 +6457,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     svm_is_rep(prefixes));
+                     svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6476,7 +6476,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
+                     SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -6493,7 +6493,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     svm_is_rep(prefixes));
+                     svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6935,7 +6935,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
-        if ((prefixes & PREFIX_REPZ)
+        if ((s->prefix & PREFIX_REPZ)
             && (b & 1
                 ? s->cpuid_ext3_features & CPUID_EXT3_ABM
                 : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
@@ -7028,14 +7028,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /* misc */
     case 0x90: /* nop */
         /* XXX: correct lock test for all insn */
-        if (prefixes & PREFIX_LOCK) {
+        if (s->prefix & PREFIX_LOCK) {
             goto illegal_op;
         }
         /* If REX_B is set, then this is xchg eax, r8d, not a nop.  */
         if (REX_B(s)) {
             goto do_xchg_reg_eax;
         }
-        if (prefixes & PREFIX_REPZ) {
+        if (s->prefix & PREFIX_REPZ) {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
@@ -7597,7 +7597,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 0xee: /* rdpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -7605,7 +7605,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -7808,18 +7808,18 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            if (prefixes & PREFIX_REPZ) {
+            if (s->prefix & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_LTU, cpu_bndl[reg]);
-            } else if (prefixes & PREFIX_REPNZ) {
+            } else if (s->prefix & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -7827,14 +7827,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 tcg_gen_not_i64(notu, cpu_bndu[reg]);
                 gen_bndck(env, s, modrm, TCG_COND_GTU, notu);
                 tcg_temp_free_i64(notu);
-            } else if (prefixes & PREFIX_DATA) {
+            } else if (s->prefix & PREFIX_DATA) {
                 /* bndmov -- from reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4 || (s->prefix & PREFIX_LOCK)) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -7863,7 +7863,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* bndldx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -7898,10 +7898,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            if (mod != 3 && (prefixes & PREFIX_REPZ)) {
+            if (mod != 3 && (s->prefix & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -7926,22 +7926,22 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* bnd registers are now in-use */
                 gen_set_hflag(s, HF_MPX_IU_MASK);
                 break;
-            } else if (prefixes & PREFIX_REPNZ) {
+            } else if (s->prefix & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_GTU, cpu_bndu[reg]);
-            } else if (prefixes & PREFIX_DATA) {
+            } else if (s->prefix & PREFIX_DATA) {
                 /* bndmov -- to reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4 || (s->prefix & PREFIX_LOCK)) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -7968,7 +7968,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* bndstx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -8016,7 +8016,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 ot = MO_64;
             else
                 ot = MO_32;
-            if ((prefixes & PREFIX_LOCK) && (reg == 0) &&
+            if ((s->prefix & PREFIX_LOCK) && (reg == 0) &&
                 (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
                 reg = 8;
             }
@@ -8117,7 +8117,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* fxsave */
             if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
@@ -8130,7 +8130,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(1): /* fxrstor */
             if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
@@ -8169,8 +8169,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(4): /* xsave */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8181,8 +8181,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(5): /* xrstor */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8197,10 +8197,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_MEM_OP(6): /* xsaveopt / clwb */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
-            if (prefixes & PREFIX_DATA) {
+            if (s->prefix & PREFIX_DATA) {
                 /* clwb */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLWB)) {
                     goto illegal_op;
@@ -8210,7 +8210,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* xsaveopt */
                 if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                     || (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT) == 0
-                    || (prefixes & (PREFIX_REPZ | PREFIX_REPNZ))) {
+                    || (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))) {
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
@@ -8221,10 +8221,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_MEM_OP(7): /* clflush / clflushopt */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
-            if (prefixes & PREFIX_DATA) {
+            if (s->prefix & PREFIX_DATA) {
                 /* clflushopt */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLFLUSHOPT)) {
                     goto illegal_op;
@@ -8244,8 +8244,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
         case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
             if (CODE64(s)
-                && (prefixes & PREFIX_REPZ)
-                && !(prefixes & PREFIX_LOCK)
+                && (s->prefix & PREFIX_REPZ)
+                && !(s->prefix & PREFIX_LOCK)
                 && (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE)) {
                 TCGv base, treg, src, dst;
 
@@ -8274,10 +8274,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto unknown_op;
 
         case 0xf8: /* sfence / pcommit */
-            if (prefixes & PREFIX_DATA) {
+            if (s->prefix & PREFIX_DATA) {
                 /* pcommit */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_PCOMMIT)
-                    || (prefixes & PREFIX_LOCK)) {
+                    || (s->prefix & PREFIX_LOCK)) {
                     goto illegal_op;
                 }
                 break;
@@ -8285,21 +8285,21 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* fallthru */
         case 0xf9 ... 0xff: /* sfence */
             if (!(s->cpuid_features & CPUID_SSE)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
             break;
         case 0xe8 ... 0xef: /* lfence */
             if (!(s->cpuid_features & CPUID_SSE)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
             break;
         case 0xf0 ... 0xf7: /* mfence */
             if (!(s->cpuid_features & CPUID_SSE2)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
@@ -8327,8 +8327,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_eob(s);
         break;
     case 0x1b8: /* SSE4.2 popcnt */
-        if ((prefixes & (PREFIX_REPZ | PREFIX_LOCK | PREFIX_REPNZ)) !=
-             PREFIX_REPZ)
+        if ((s->prefix & (PREFIX_REPZ | PREFIX_LOCK | PREFIX_REPNZ)) !=
+            PREFIX_REPZ)
             goto illegal_op;
         if (!(s->cpuid_ext_features & CPUID_EXT_POPCNT))
             goto illegal_op;
-- 
2.20.1


