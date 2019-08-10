Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93573C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F70D2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtKKOw5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F70D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIlY-0007Ij-Jg
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkm-0005JD-OM
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkk-0004Ej-Ne
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:47086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkk-0004Ed-HF
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id z17so22039112otk.13
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YM6JnD5zVeDNhUIY5JwD7QUjg+Ky9R6ynEiC0EUrLPE=;
 b=XtKKOw5mfwQKFRyKK4P3Guw9P856fDN5qyajBy22VtTTGP+fVtwToRnjNAlWwrRv/k
 0U7Zq3f0ASyA6Z8jGdpdcmRpWf8bXVYCz/2MJ9EzpDGAfcTmpuwHuK26Nxzzbr+tgWJb
 NGtB1a6EX2KSA/Kp85C1pUoPmHLGNoGpTZ0jKrrfw86KEmvr1/wiyOw/PxPZEKhMK+Z8
 f7jKN0gDNIUAAvP99T/+uTsD4KSuRrK+Kl7DkvJNslCHmyUDG76Mr9A7KuGt3UA2e2Bo
 BP4PM94LE38bLWvBjlyiFLuxOI+rAyDJWaYSEW9s18BvxUqYBOgfnh5jcnknmRMMnWyl
 z46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YM6JnD5zVeDNhUIY5JwD7QUjg+Ky9R6ynEiC0EUrLPE=;
 b=tV7fd2xxpUBQ6g2L1AD4A386MeXDrd1N5zf9kJrA5BhJZn+hW2HYBXwq2kojnoyFlT
 bKSNJhOZHeEyBLiBBVg6urfoYDgPcWpPaoqxzaUipFMrFLOyLz1so0Az7A83NUh1QVD6
 yfdIxUdHNhPcbAVTNqi4/uX8mrVM/BHKdTSqo8BGEc+TvIWHwTx5lEsVNxpjHlQMtMav
 WuBtzqHPFjPN1wxZkD1K1CIc+9tzG5xjNnZWFPW0BQSejz3+j2gqL6mHhlSBphmVBEIB
 fa1hWV5uFcv8iIo4Vo6znOfpZvS8lbO7ZdibrSpJWKxg92PWU6XNp4EPT996B8H8hqyl
 eGFw==
X-Gm-Message-State: APjAAAWrRMbbvrn6OsMm8XR7cWREkjWuUTpcmcIl+MMUfZlVIeiyP3eb
 bxxVn0uJeSkrhSc4jzH+KlgqDl9v
X-Google-Smtp-Source: APXvYqwJSmZm8nGdgO9FSohANDJpWCOc/VPQqORE5WaQZzND/HF93/Q2qXLsSsTFKAjGmhHmXqDx2w==
X-Received: by 2002:a05:6830:2119:: with SMTP id
 i25mr22122748otc.282.1565410393687; 
 Fri, 09 Aug 2019 21:13:13 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:13 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:22 -0400
Message-Id: <20190810041255.6820-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 06/39] target/i386: Simplify
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
index 40a4844b64..7532d65778 100644
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
@@ -4515,7 +4514,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_l = 0;
     s->vex_v = 0;
     if (sigsetjmp(s->jmpbuf, 0) != 0) {
-        gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+        gen_exception(s, EXCP0D_GPF);
         return s->pc;
     }
 
@@ -5854,7 +5853,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
             /* if CR0.EM or CR0.TS are set, generate an FPU exception */
             /* XXX: what to do if illegal op ? */
-            gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+            gen_exception(s, EXCP07_PREX);
             break;
         }
         modrm = x86_ldub_code(env, s);
@@ -6572,7 +6571,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             set_cc_op(s, CC_OP_EFLAGS);
         } else if (s->vm86) {
             if (s->iopl != 3) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -6694,7 +6693,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9c: /* pushf */
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_PUSHF);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_helper_read_eflags(s->T0, cpu_env);
@@ -6704,7 +6703,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9d: /* popf */
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_POPF);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             ot = gen_pop_T0(s);
             if (s->cpl == 0) {
@@ -7021,7 +7020,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         val = x86_ldub_code(env, s);
         if (val == 0) {
-            gen_exception(s, EXCP00_DIVZ, pc_start - s->cs_base);
+            gen_exception(s, EXCP00_DIVZ);
         } else {
             gen_helper_aam(cpu_env, tcg_const_i32(val));
             set_cc_op(s, CC_OP_LOGICB);
@@ -7055,7 +7054,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x9b: /* fwait */
         if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) ==
             (HF_MP_MASK | HF_TS_MASK)) {
-            gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+            gen_exception(s, EXCP07_PREX);
         } else {
             gen_helper_fwait(cpu_env);
         }
@@ -7066,7 +7065,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xcd: /* int N */
         val = x86_ldub_code(env, s);
         if (s->vm86 && s->iopl != 3) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_interrupt(s, val, pc_start - s->cs_base, s->pc - s->cs_base);
         }
@@ -7089,13 +7088,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -7106,7 +7105,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob_inhibit_irq(s, true);
         } else {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         }
         break;
     case 0x62: /* bound */
@@ -7198,7 +7197,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x130: /* wrmsr */
     case 0x132: /* rdmsr */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
@@ -7231,7 +7230,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
             goto illegal_op;
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysenter(cpu_env);
             gen_eob(s);
@@ -7242,7 +7241,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
             goto illegal_op;
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysexit(cpu_env, tcg_const_i32(s->dflag - 1));
             gen_eob(s);
@@ -7261,7 +7260,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_helper_sysret(cpu_env, tcg_const_i32(s->dflag - 1));
             /* condition codes are modified only in long mode */
@@ -7283,7 +7282,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xf4: /* hlt */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
@@ -7309,7 +7308,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!s->pe || s->vm86)
                 goto illegal_op;
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -7330,7 +7329,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!s->pe || s->vm86)
                 goto illegal_op;
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -7446,7 +7445,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -7463,7 +7462,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7488,7 +7487,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7501,7 +7500,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7516,7 +7515,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7530,7 +7529,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7554,7 +7553,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7564,7 +7563,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(2): /* lgdt */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
@@ -7581,7 +7580,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(3): /* lidt */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
@@ -7626,7 +7625,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
         CASE_MODRM_OP(6): /* lmsw */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
@@ -7638,7 +7637,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
         CASE_MODRM_MEM_OP(7): /* invlpg */
             if (s->cpl != 0) {
-                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                gen_exception(s, EXCP0D_GPF);
                 break;
             }
             gen_update_cc_op(s);
@@ -7653,7 +7652,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #ifdef TARGET_X86_64
             if (CODE64(s)) {
                 if (s->cpl != 0) {
-                    gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+                    gen_exception(s, EXCP0D_GPF);
                 } else {
                     tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
                     tcg_gen_ld_tl(cpu_seg_base[R_GS], cpu_env,
@@ -7690,7 +7689,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x108: /* invd */
     case 0x109: /* wbinvd */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_svm_check_intercept(s, pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
             /* nothing to do */
@@ -8014,7 +8013,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x120: /* mov reg, crN */
     case 0x122: /* mov crN, reg */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
@@ -8071,7 +8070,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x121: /* mov reg, drN */
     case 0x123: /* mov drN, reg */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
@@ -8105,7 +8104,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x106: /* clts */
         if (s->cpl != 0) {
-            gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+            gen_exception(s, EXCP0D_GPF);
         } else {
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(cpu_env);
@@ -8136,7 +8135,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8149,7 +8148,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8161,7 +8160,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8174,7 +8173,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
+                gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
@@ -8377,7 +8376,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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


