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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4CBC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1A9233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWYh9eNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1A9233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Usy-0004Sz-WB
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-0000ik-4Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQy-000711-HB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:12 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQy-00070b-B9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:08 -0400
Received: by mail-yb1-xb42.google.com with SMTP id j199so1342130ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrwJcSab9woLJp3CeeA/fK1v8L09Nrf6lrmn7x9jQd0=;
 b=DWYh9eNzBaeOZvi8VI2nm+7dBC6jRu8zDJpJs1So5qvq+OfeRm2QgdVXFVKQkhDxaJ
 fgXB9b1i4obU8cT84ZD6QWuyN8gPhr5yZgOYo4adtdSo95I9iSIJsvPM19uEsKu4krPy
 dsYYGeLZfcVRM07gWEkzcQUkBSqEUPCKGZ3D58nAnFZJFPa1Ho6mNDGbDK7Swkg6RTnd
 VTwY9SHkdFEfJQjqfi64gvSfMJ3rzpMd0T/HgQA9IprTD/HtzwlqFi7uPcYQBJ111gAr
 y6snF+OOo3ZuvtyDqCvqKrXuw2MSlEduWjnupItnmLOsH0uTlRiKoIxvNZdeRmWQlix6
 Z6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrwJcSab9woLJp3CeeA/fK1v8L09Nrf6lrmn7x9jQd0=;
 b=hypIww71OPoIjsAuDT35Bw4sP3J5i7KQAGBPurV4vnyhKlnOZNtJby8VLALtesiwvB
 ujytYSbpkTqhHHtrfGWOOPMpDzvhCz3yGD8DlqOL/qQcG2QMZh05nT3DF3ZD5NlHfhiJ
 EXrmTUyVvYwta0TzdSdRpbJnhi7U+vqOvgr4tAEaRpGKpQzw+9sxELKUzmiDZmZW+2A3
 UUSkJYIwLqGLFkS69I66fx+pt0S72WDPxfW6Q1GYp+zFEGi/H7YGw2282nYu2cWXL88f
 Xy4HqsqWLJo1x34Jgu8XZpXocEbrhG1/7ilb1c2nezOBF8E2l7zthhLZfbEDS8My6a9C
 5yvg==
X-Gm-Message-State: APjAAAVpU3W/UNcITcr2n7sfAKT+qspnce6jlI8UP/0O+qB4REx250w7
 mjyU+0L+0rR7g8Lpb4T3P+Dyx2eY
X-Google-Smtp-Source: APXvYqxzXHEhbVcQHmQobc3i6Ikg+Vqu2eEUXI5DsKuEYPcI8rhJWnjyBitmAzZl44bjlAD9yymEhQ==
X-Received: by 2002:a25:2bc8:: with SMTP id
 r191mr24056147ybr.327.1566408607478; 
 Wed, 21 Aug 2019 10:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:42 -0400
Message-Id: <20190821172951.15333-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 06/75] target/i386: Simplify
 gen_exception arguments
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

We can compute cur_eip from values present within DisasContext.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 89 ++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 410aa89c75..b067323962 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1272,10 +1272,10 @@ static void gen_helper_fp_arith_STN_ST0(int op, int opreg)
     }
 }
 
-static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
+static void gen_exception(DisasContext *s, int trapno)
 {
     gen_update_cc_op(s);
-    gen_jmp_im(s, cur_eip);
+    gen_jmp_im(s, s->pc_start - s->cs_base);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1284,7 +1284,7 @@ static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
    the instruction is known, but it isn't allowed in the current cpu mode.  */
 static void gen_illegal_opcode(DisasContext *s)
 {
-    gen_exception(s, EXCP06_ILLOP, s->pc_start - s->cs_base);
+    gen_exception(s, EXCP06_ILLOP);
 }
 
 /* if d == OR_TMP0, it means memory operand (address in A0) */
@@ -3040,8 +3040,7 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
     [0xdf] = AESNI_OP(aeskeygenassist),
 };
 
-static void gen_sse(CPUX86State *env, DisasContext *s, int b,
-                    target_ulong pc_start)
+static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
     int modrm, mod, rm, reg;
@@ -3076,7 +3075,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
     }
     /* simple MMX/SSE operation */
     if (s->flags & HF_TS_MASK) {
-        gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+        gen_exception(s, EXCP07_PREX);
         return;
     }
     if (s->flags & HF_EM_MASK) {
@@ -4669,7 +4668,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     s->pc_start = s->pc = pc_start;
     if (sigsetjmp(s->jmpbuf, 0) != 0) {
-        gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+        gen_exception(s, EXCP0D_GPF);
         return s->pc;
     }
 
@@ -5868,7 +5867,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
             /* if CR0.EM or CR0.TS are set, generate an FPU exception */
             /* XXX: what to do if illegal op ? */
-            gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+            gen_exception(s, EXCP07_PREX);
             break;
         }
         modrm = x86_ldub_code(env, s);
@@ -6582,7 +6581,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             set_cc_op(s, CC_OP_EFLAGS);
         } else if (s->vm86) {
             if (s->iopl != 3) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -6704,7 +6703,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9c: /* pushf */
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_PUSHF);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_helper_read_eflags(s->T0, cpu_env);
@@ -6714,7 +6713,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9d: /* popf */
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_POPF);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             ot = gen_pop_T0(s);
             if (s->cpl == 0) {
@@ -7031,7 +7030,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         val = x86_ldub_code(env, s);
         if (val == 0) {
-            gen_exception(s, EXCP00_DIVZ, pc_start - s->cs_base);
+            gen_exception(s, EXCP00_DIVZ);
         } else {
             gen_helper_aam(cpu_env, tcg_const_i32(val));
             set_cc_op(s, CC_OP_LOGICB);
@@ -7065,7 +7064,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9b: /* fwait */
         if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) ==
             (HF_MP_MASK | HF_TS_MASK)) {
-            gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+            gen_exception(s, EXCP07_PREX);
         } else {
             gen_helper_fwait(cpu_env);
         }
@@ -7076,7 +7075,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xcd: /* int N */
         val = x86_ldub_code(env, s);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_interrupt(s, val, pc_start - s->cs_base, s->pc - s->cs_base);
         }
@@ -7099,13 +7098,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->cpl <= s->iopl) {
                 gen_helper_cli(cpu_env);
             } else {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             }
         } else {
             if (s->iopl == 3) {
                 gen_helper_cli(cpu_env);
             } else {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             }
         }
         break;
@@ -7116,7 +7115,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob_inhibit_irq(s, true);
         } else {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         }
         break;
     case 0x62: /* bound */
@@ -7208,7 +7207,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x130: /* wrmsr */
     case 0x132: /* rdmsr */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
@@ -7240,7 +7239,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
             goto illegal_op;
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysenter(cpu_env);
             gen_eob(s);
@@ -7251,7 +7250,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
             goto illegal_op;
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysexit(cpu_env, tcg_const_i32(s->dflag - 1));
             gen_eob(s);
@@ -7270,7 +7269,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysret(cpu_env, tcg_const_i32(s->dflag - 1));
             /* condition codes are modified only in long mode */
@@ -7292,7 +7291,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xf4: /* hlt */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
@@ -7318,7 +7317,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!s->pe || s->vm86)
                 goto illegal_op;
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -7339,7 +7338,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!s->pe || s->vm86)
                 goto illegal_op;
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -7455,7 +7454,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -7472,7 +7471,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7497,7 +7496,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7510,7 +7509,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7525,7 +7524,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7539,7 +7538,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7563,7 +7562,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7573,7 +7572,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(2): /* lgdt */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
@@ -7590,7 +7589,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(3): /* lidt */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
@@ -7635,7 +7634,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
         CASE_MODRM_OP(6): /* lmsw */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
@@ -7647,7 +7646,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(7): /* invlpg */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7662,7 +7661,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #ifdef TARGET_X86_64
             if (CODE64(s)) {
                 if (s->cpl != 0) {
-                    gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                    gen_exception(s, EXCP0D_GPF);
                 } else {
                     tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
                     tcg_gen_ld_tl(cpu_seg_base[R_GS], cpu_env,
@@ -7698,7 +7697,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x108: /* invd */
     case 0x109: /* wbinvd */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_svm_check_intercept(s, pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
             /* nothing to do */
@@ -8022,7 +8021,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x120: /* mov reg, crN */
     case 0x122: /* mov crN, reg */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
@@ -8076,7 +8075,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x121: /* mov reg, drN */
     case 0x123: /* mov drN, reg */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
@@ -8110,7 +8109,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x106: /* clts */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(cpu_env);
@@ -8141,7 +8140,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8154,7 +8153,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8166,7 +8165,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8179,7 +8178,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8382,7 +8381,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-        gen_sse(env, s, b, pc_start);
+        gen_sse(env, s, b);
         break;
     default:
         goto unknown_op;
-- 
2.20.1


