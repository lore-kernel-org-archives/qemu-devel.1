Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C86C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862CB206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aizWusaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862CB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Qb-0005KN-3M
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DH-0005w9-5U
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DE-0008Fr-VC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:03 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DE-0008Fa-Q0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:00 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y21so390985ybi.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BvKEqCsxGM1icK/UDvmsFoZ3TKzQweETmIyLpTRUtPE=;
 b=aizWusaGB/wPKp3jkFCKMuJn199x1vyRRS6u2bjFeEHoTj44c2rG3jHsMNkT6fwudG
 5b/PZ6AuCNziTK7yFb7Kh/q5TGgKoRuIXWwQrqSSVhi1pvMGz8ZpEbVYtpTUZQZZXLlK
 v6aSQVtfJVwSv8gyTRFlZWZ64PSXfNx0QvrXvMWpU1mq878o+TbvmOmWLlyAD3fUGjPB
 sZdYjQVsmOkSVraumS3FbPFf4v1dwHXuRqmYNURiI8EanYZ4JatvNVskiKDDSHYYyQ9Y
 AiruCvh4TYkdDDt7N6rhdjAgbTRwlKsJ5PJlqpVnRGN82wFLVyo6T7f1za7u1npdq2yZ
 CDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BvKEqCsxGM1icK/UDvmsFoZ3TKzQweETmIyLpTRUtPE=;
 b=Q79hZ/meO37SJuLAIlwdVEo1Yxn8MtvqlktM8K2C/7t8ngE3OTv5N8PEhAoXt94WKy
 Xie3FwdJqhgTzyIxk56EYPu0LlDGsBrca7HurUHU+7DJr/bYpmwOdTuPOgdbSJrpzCie
 BWjiEHSk4nGZoVzBgCldFWDeYn8LzLmd9+/RjDwWV+R/PXkmdZ6eMUPH8I4b3a1yfWTC
 0Xb6Iw2mJmTgVpt8huqIU80KClq3l3FRF4zF1cw3xwGtQpiCdJMuIdpy1hzDKXLRo+td
 +uSPB2za7z7ldCoJi9IO9VX5bNlZOxqy0jwSRu2TKc5D/yt6Nis3irzQNhfAqgJ2OOTy
 CBNA==
X-Gm-Message-State: APjAAAVBigxT1EQGbBeYC2wR9wiZt44ZGGOAejCHxzwkoKdlB+PxAjKI
 RD+K2szoJplpnzTAp2BWSfH9UuMv
X-Google-Smtp-Source: APXvYqyGwNgF/nckxqKd+0OLghzhMF/CQeZBQXNKhbu8i18EMa2xa7PAy4rOess1yaPMp5dn6BiVww==
X-Received: by 2002:a25:83c8:: with SMTP id v8mr1870864ybm.346.1565834999872; 
 Wed, 14 Aug 2019 19:09:59 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:09:59 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:47 -0400
Message-Id: <20190815020928.9679-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 05/46] target/i386: use prefix from
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

Reduce scope of the local variable prefixes to enforce use of prefix
from DisasContext instead.

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 113 ++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index bb13877df7..40a4844b64 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4491,7 +4491,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
-    int b, prefixes;
+    int b;
     int shift;
     TCGMemOp ot;
     int modrm, reg, rm, mod, op, opreg, val;
@@ -4499,6 +4499,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     target_ulong pc_start = s->base.pc_next;
 
     {
+    int prefixes;
     TCGMemOp aflag, dflag;
 
     s->pc_start = s->pc = pc_start;
@@ -6356,7 +6357,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa4: /* movsS */
     case 0xa5:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_movs(s, ot);
@@ -6366,7 +6367,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaa: /* stosS */
     case 0xab:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_stos(s, ot);
@@ -6375,7 +6376,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xac: /* lodsS */
     case 0xad:
         ot = mo_b_d(b, s->dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_lods(s, ot);
@@ -6384,9 +6385,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6396,9 +6397,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6409,8 +6410,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6424,8 +6425,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6444,7 +6445,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
+                     SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -6463,7 +6464,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     svm_is_rep(prefixes));
+                     svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6483,7 +6484,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
+                     SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -6501,7 +6502,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
-                     svm_is_rep(prefixes));
+                     svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6944,7 +6945,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
-        if ((prefixes & PREFIX_REPZ)
+        if ((s->prefix & PREFIX_REPZ)
             && (b & 1
                 ? s->cpuid_ext3_features & CPUID_EXT3_ABM
                 : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
@@ -7037,14 +7038,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7607,7 +7608,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 0xee: /* rdpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -7615,7 +7616,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -7819,18 +7820,18 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7838,14 +7839,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7874,7 +7875,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* bndldx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -7909,10 +7910,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7937,22 +7938,22 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7979,7 +7980,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* bndstx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
+                    || (s->prefix & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -8027,7 +8028,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 ot = MO_64;
             else
                 ot = MO_32;
-            if ((prefixes & PREFIX_LOCK) && (reg == 0) &&
+            if ((s->prefix & PREFIX_LOCK) && (reg == 0) &&
                 (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
                 reg = 8;
             }
@@ -8131,7 +8132,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* fxsave */
             if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
@@ -8144,7 +8145,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(1): /* fxrstor */
             if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
+                || (s->prefix & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
@@ -8183,8 +8184,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(4): /* xsave */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8195,8 +8196,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(5): /* xrstor */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8211,10 +8212,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -8224,7 +8225,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* xsaveopt */
                 if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                     || (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT) == 0
-                    || (prefixes & (PREFIX_REPZ | PREFIX_REPNZ))) {
+                    || (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))) {
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
@@ -8235,10 +8236,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -8258,8 +8259,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
         case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
             if (CODE64(s)
-                && (prefixes & PREFIX_REPZ)
-                && !(prefixes & PREFIX_LOCK)
+                && (s->prefix & PREFIX_REPZ)
+                && !(s->prefix & PREFIX_LOCK)
                 && (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE)) {
                 TCGv base, treg, src, dst;
 
@@ -8288,10 +8289,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -8299,21 +8300,21 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -8341,8 +8342,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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


