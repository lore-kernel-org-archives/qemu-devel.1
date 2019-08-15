Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA1C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DDC2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4M32+lM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DDC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5LI-00077Y-Pq
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DI-0005ys-TI
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DG-0008Gc-7J
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:04 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DG-0008GL-1K
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:02 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m9so406862ybm.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8o3k3JHlCkb2YaP3uBSJfjThXJM3PPb/FS5zva4+e9g=;
 b=Q4M32+lMspDbRHEd4ghI+KCc6mzDhseDslddvzF6hnFf9cbRg2JvYdbpwNaC7dHYWF
 +33TxhH06S+hCleBDAX2bQA77MHSvlJTex579uL3Z56Bxs1irOXAXjsp+LHWZp6cDKt+
 gHWrlJBK/Btgv2CCLfiaHXxuRIJZt2irvZZXVDYlqdBdNdR3mfPPKBhKQKVaK+X8rl6z
 JILVZHcsek6fNgANQp4pKPNOJnjx6gZXwq7U6TQM0vHPRsBOTvMmvWSNUt0nAQbHf+8v
 LQXA+MB3VU9575nDhHwCXb534PFqRCl6dRRe7X7RSJwE81ZR1AmeTMdZxaS+c9ydaann
 MiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8o3k3JHlCkb2YaP3uBSJfjThXJM3PPb/FS5zva4+e9g=;
 b=r2K+aHnKAmV1OoAgp16czYxNlZqdgeUFnSjD7pdveFolV1Gks37bxRj5sh43hOxRnx
 4PqfzpRkiS6XRLmFL7dE6KWLbN/HifULOx0ExOuPK10igkj3ZA35m3QdEma96vQK13qA
 CkF7T5anASEFwePv/elqkiwGw1QLRbPMzXnM75wyVRqrBFiGnrhJiAYXn9p34vmco2cV
 Ap94h/VSS2iLM9w7mc59Ve66VEMM0rlSQL7ad9rss1lCk0VdZNfGVNneYLyXkBoNiyGn
 Kgp+qd9AN6ZpMgb6KuE1iMTvZpPU0vM2Q8ygeQsk5RgLM9xcwKC+0rcYSdZjyu4LVhry
 Pc+Q==
X-Gm-Message-State: APjAAAU36FKfqpY1/GxL8aEBDhY5jH0DWPCK7qzTugPRSKxkfkJKbZzb
 +7cd6b5MZueX3M5kGReMB45Sen2d
X-Google-Smtp-Source: APXvYqxCdq7gGbkof+/3F2qjnOLZwx4TZHclG7SY5o7v2tLZQqiW/ylkpdQXV4lAMVoOuhOMxmJAbA==
X-Received: by 2002:a25:f205:: with SMTP id i5mr1944910ybe.520.1565835001040; 
 Wed, 14 Aug 2019 19:10:01 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:00 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:49 -0400
Message-Id: <20190815020928.9679-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v3 07/46] target/i386: use pc_start from
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable pc_start is already a member of DisasContext. Remove the
superfluous local variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 131 ++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7532d65778..b1ba2fc3e5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4495,13 +4495,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     TCGMemOp ot;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
-    target_ulong pc_start = s->base.pc_next;
 
     {
     int prefixes;
     TCGMemOp aflag, dflag;
 
-    s->pc_start = s->pc = pc_start;
+    s->pc_start = s->pc = s->base.pc_next;
     s->override = -1;
 #ifdef TARGET_X86_64
     s->rex_x = 0;
@@ -6357,7 +6356,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa5:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_movs(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_movs(s, ot);
         }
@@ -6367,7 +6366,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xab:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_stos(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_stos(s, ot);
         }
@@ -6376,7 +6375,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xad:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_lods(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_lods(s, ot);
         }
@@ -6385,9 +6384,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaf:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & PREFIX_REPNZ) {
-            gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
+            gen_repz_scas(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (s->prefix & PREFIX_REPZ) {
-            gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
+            gen_repz_scas(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_scas(s, ot);
         }
@@ -6397,9 +6396,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa7:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & PREFIX_REPNZ) {
-            gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
+            gen_repz_cmps(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (s->prefix & PREFIX_REPZ) {
-            gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
+            gen_repz_cmps(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_cmps(s, ot);
         }
@@ -6408,10 +6407,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x6d:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base, 
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix) | 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_ins(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6423,10 +6422,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x6f:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix) | 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_outs(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6443,7 +6442,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -6462,7 +6461,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
@@ -6482,7 +6481,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xed:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -6500,7 +6499,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xef:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
@@ -6541,7 +6540,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_lret:
         if (s->pe && !s->vm86) {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_lret_protected(cpu_env, tcg_const_i32(s->dflag - 1),
                                       tcg_const_i32(val));
         } else {
@@ -6564,7 +6563,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = 0;
         goto do_lret;
     case 0xcf: /* iret */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_IRET);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IRET);
         if (!s->pe) {
             /* real mode */
             gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
@@ -6691,7 +6690,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* flags */
     case 0x9c: /* pushf */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_PUSHF);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_PUSHF);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
@@ -6701,7 +6700,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x9d: /* popf */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_POPF);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_POPF);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
@@ -7046,8 +7045,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         if (s->prefix & PREFIX_REPZ) {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_pause(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
@@ -7060,27 +7059,27 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0xcc: /* int3 */
-        gen_interrupt(s, EXCP03_INT3, pc_start - s->cs_base, s->pc - s->cs_base);
+        gen_interrupt(s, EXCP03_INT3, s->pc_start - s->cs_base, s->pc - s->cs_base);
         break;
     case 0xcd: /* int N */
         val = x86_ldub_code(env, s);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_interrupt(s, val, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_interrupt(s, val, s->pc_start - s->cs_base, s->pc - s->cs_base);
         }
         break;
     case 0xce: /* into */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
-        gen_helper_into(cpu_env, tcg_const_i32(s->pc - pc_start));
+        gen_jmp_im(s, s->pc_start - s->cs_base);
+        gen_helper_into(cpu_env, tcg_const_i32(s->pc - s->pc_start));
         break;
 #ifdef WANT_ICEBP
     case 0xf1: /* icebp (undocumented, exits to external debugger) */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_ICEBP);
-        gen_debug(s, pc_start - s->cs_base);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_ICEBP);
+        gen_debug(s, s->pc_start - s->cs_base);
         break;
 #endif
     case 0xfa: /* cli */
@@ -7200,7 +7199,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             if (b & 2) {
                 gen_helper_rdmsr(cpu_env);
             } else {
@@ -7210,7 +7209,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -7222,7 +7221,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x133: /* rdpmc */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         gen_helper_rdpmc(cpu_env);
         break;
     case 0x134: /* sysenter */
@@ -7251,8 +7250,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x105: /* syscall */
         /* XXX: is it usable in real mode ? */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
-        gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
+        gen_jmp_im(s, s->pc_start - s->cs_base);
+        gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - s->pc_start));
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
@@ -7277,7 +7276,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
     case 0x1a2: /* cpuid */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         gen_helper_cpuid(cpu_env);
         break;
     case 0xf4: /* hlt */
@@ -7285,8 +7284,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
@@ -7298,7 +7297,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 0: /* sldt */
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? s->dflag : MO_16;
@@ -7310,7 +7309,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->cpl != 0) {
                 gen_exception(s, EXCP0D_GPF);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(cpu_env, s->tmp2_i32);
@@ -7319,7 +7318,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 1: /* str */
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? s->dflag : MO_16;
@@ -7331,7 +7330,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->cpl != 0) {
                 gen_exception(s, EXCP0D_GPF);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(cpu_env, s->tmp2_i32);
@@ -7359,7 +7358,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* sgdt */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_GDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0,
                              cpu_env, offsetof(CPUX86State, gdt.limit));
@@ -7377,7 +7376,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
             gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
@@ -7389,8 +7388,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_mwait(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_mwait(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             gen_eob(s);
             break;
 
@@ -7415,7 +7414,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_MEM_OP(1): /* sidt */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
@@ -7466,9 +7465,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
-                             tcg_const_i32(s->pc - pc_start));
+                             tcg_const_i32(s->pc - s->pc_start));
             tcg_gen_exit_tb(NULL, 0);
             s->base.is_jmp = DISAS_NORETURN;
             break;
@@ -7478,7 +7477,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmmcall(cpu_env);
             break;
 
@@ -7491,7 +7490,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmload(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7504,7 +7503,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmsave(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7533,7 +7532,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_clgi(cpu_env);
             break;
 
@@ -7544,7 +7543,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_skinit(cpu_env);
             break;
 
@@ -7557,7 +7556,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_invlpga(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7566,7 +7565,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_GDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
@@ -7583,7 +7582,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
@@ -7596,7 +7595,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_OP(4): /* smsw */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_READ_CR0);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
             if (CODE64(s)) {
                 mod = (modrm >> 6) & 3;
@@ -7628,7 +7627,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_CR0);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             gen_helper_lmsw(cpu_env, s->T0);
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -7641,7 +7640,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_lea_modrm(env, s, modrm);
             gen_helper_invlpg(cpu_env, s->A0);
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -7670,7 +7669,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
@@ -7691,7 +7690,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_svm_check_intercept(s, pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
+            gen_svm_check_intercept(s, s->pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
             /* nothing to do */
         }
         break;
@@ -8038,7 +8037,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 4:
             case 8:
                 gen_update_cc_op(s);
-                gen_jmp_im(s, pc_start - s->cs_base);
+                gen_jmp_im(s, s->pc_start - s->cs_base);
                 if (b & 2) {
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_start();
@@ -8088,14 +8087,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (b & 2) {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_DR0 + reg);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_DR0 + reg);
                 gen_op_mov_v_reg(s, ot, s->T0, rm);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_set_dr(cpu_env, s->tmp2_i32, s->T0);
                 gen_jmp_im(s, s->pc - s->cs_base);
                 gen_eob(s);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 + reg);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_READ_DR0 + reg);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_get_dr(s->T0, cpu_env, s->tmp2_i32);
                 gen_op_mov_reg_v(s, ot, rm, s->T0);
@@ -8106,7 +8105,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(cpu_env);
             /* abort block because static cpu state changed */
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -8332,7 +8331,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x1aa: /* rsm */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_RSM);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_RSM);
         if (!(s->flags & HF_SMM_MASK))
             goto illegal_op;
         gen_update_cc_op(s);
-- 
2.20.1


