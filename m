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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE7C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCA4206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtqpCfpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCA4206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5TG-0000dr-8i
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DH-0005wo-I3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DF-0008G7-Ep
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:03 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:43832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DF-0008Fw-9E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:01 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n205so286757ywb.10
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YM6JnD5zVeDNhUIY5JwD7QUjg+Ky9R6ynEiC0EUrLPE=;
 b=qtqpCfpLtKYusVBIzAecZO0eg7fO81vq4IRGj5MsIBsCRreWpK77qv0UYXX24gM455
 HArffliqTQcqd00jcYL8yohZViInkaaRB59/UwyJdQz8acjAvHLb6I58UG/n88vVpqh4
 kqRxN+VN2YQgYcOEpE8HY9GktH1Svqabro4AwfFueaMKu8W1vtICDInwcOBcXCiJNKbT
 Ghzcomc0v1nkD4BxFbeSI1CnMOu8AiC/uPjxFC4+tVRBdvXX6SaZIBAJvBmwe6wqLZI1
 bXTvNcwHirn0LFMA2YdCplYhri7GYiYVTc7cim9fslYX4c4qtmix/qQfxan+o0sneHFd
 tjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YM6JnD5zVeDNhUIY5JwD7QUjg+Ky9R6ynEiC0EUrLPE=;
 b=c4YKFf6TJcrWMnLO+LP5X5ztDXPkmTdYfDfsmLVXyHiL+e0z/VEcvXwvhTSUFTxn/O
 rwtLbIM/gpu9h6oNwxe/R57MpB0VS8iBn7D3vQdurffP5cakYTdx+uk3oNQo+KHiKnMR
 61TUmWBUFdTzrd9v0TYJx9qiBHXMWSJp7fdoYOnPAuhhptmcQUV841ctH43nuWHXN9Uo
 iO4YXwSKgVBjpyM5OEnoU6BNKtMbVBPVrBgX4WMiMVRwyyZ8MPPjrGpgcsa0WSOOZ8IQ
 shU4SIYTGRzXgVESFcya5wE3cl2fEunmeD8ZQAdn4DY41s1UX+JGzXQxueQqTpcmJ+oe
 cuTQ==
X-Gm-Message-State: APjAAAWw9jhRO4CFy55JEvYcJjmx0KPyUj3lKjOnhsRjZi5g/506RYF+
 714aBvY5Rn276WsmoT3Z3o6gOtnP
X-Google-Smtp-Source: APXvYqx5Q9wh/2rdgpmVh77Hg7IF7z1Bs/7OGCdc4Wxita0EmN8Xbl7YLm3xAZK9yBQkToL1Q8RIcw==
X-Received: by 2002:a81:9c0f:: with SMTP id m15mr1544818ywa.495.1565835000468; 
 Wed, 14 Aug 2019 19:10:00 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:00 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:48 -0400
Message-Id: <20190815020928.9679-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v3 06/46] target/i386: Simplify
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


