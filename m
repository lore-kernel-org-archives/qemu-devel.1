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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E83C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDD522CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfQk/qGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDD522CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Up3-0000f4-2q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQz-0000ft-05
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQv-0006yv-Pn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:08 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQv-0006yf-JN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:05 -0400
Received: by mail-yb1-xb43.google.com with SMTP id b16so1356628ybq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cFRAWFFdmyoCzE1WNd5jllqs96rRW3z2FUI/e4S8BVI=;
 b=RfQk/qGoR+eTCjUOw43Xc+TR1X/uS5P/0mA3zjrDJNYyuZr8M2ZaW0FTifwrbp3gQV
 RjxfiXhetilyr8mgiVxMvbQOCCbaYYrxEi7TKG6fawzPyih1GecaQg0A3iWkMPvjbDjS
 i/xe+sqx4NQ+eOgPzfri+xTmWQ5g+49UhuyZusIVBc3MSAH13Hf6Mj8qre9GgLSu2zp7
 p0UKoq//z37agKqrMomWRQxnWlUPRDpMBvwUd4lstOmm0ypbbkTMDV7vbf6YwFmFxeLD
 EJH0SdAz0bx+KF/8wRBX5QU/dfAR2Kcai8x7nDIl0PS0G58MR/q2VqG5vdQnqoJBSwtb
 bPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cFRAWFFdmyoCzE1WNd5jllqs96rRW3z2FUI/e4S8BVI=;
 b=fIDT8nkRDNRy7p93l17quGBivQfCwreggdMIaMO7MxHRhrf/08KAodwHe4OpAGR6r+
 LbApMB1B3YhR5/22GIYozAHPr32F2x2T8MX/1ynpdI+mZVACn5CS57qoG/jYLYtM+gFN
 SXzOM4HHmzruBC/6rUoJDm0/DI7IN7BiYWaKGzRO7AIV7YRVjVfyOPTadKUlkYl9wLT3
 8T7cc3fsBgmByDh7dck8tp7XmqypbObAPZbMi6ED1xglw4MPFL6GKmKsF5yuPsjsJrwd
 VNs8Om5lGrP5epYrOElmKsvUxqMw08iPPPQyp/MDtPETUmIM/38CWNBf1R+8bt45f6F5
 ictA==
X-Gm-Message-State: APjAAAVc5/XxIcEigklJmlWBXAqbUVK8a9DRCdm3Vj2bXtH/ixKiGnlw
 dGOwkrJI7zZSfGU7U/iPX2zg+fDP
X-Google-Smtp-Source: APXvYqwqEqRtFV/WvRIrGiZBwr7da4kZhDHCxk/Al5DduTQqQOUNFHTiugjJmW/qBDON38Umh3fiiQ==
X-Received: by 2002:a25:8001:: with SMTP id m1mr22786665ybk.66.1566408604184; 
 Wed, 21 Aug 2019 10:30:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:03 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:39 -0400
Message-Id: <20190821172951.15333-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 03/75] target/i386: use dflag from
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

There already is a variable dflag in DisasContext, so use that one
rather than the identically-named local helper variable.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 180 ++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 90 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9ec1c79371..7226c67d2e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4682,7 +4682,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             op = (b >> 3) & 7;
             f = (b >> 1) & 3;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
 
             switch(f) {
             case 0: /* OP Ev, Gv */
@@ -4740,7 +4740,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             int val;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
 
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
@@ -4777,16 +4777,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /**************************/
         /* inc, dec, and other misc arith */
     case 0x40 ... 0x47: /* inc Gv */
-        ot = dflag;
+        ot = s->dflag;
         gen_inc(s, ot, OR_EAX + (b & 7), 1);
         break;
     case 0x48 ... 0x4f: /* dec Gv */
-        ot = dflag;
+        ot = s->dflag;
         gen_inc(s, ot, OR_EAX + (b & 7), -1);
         break;
     case 0xf6: /* GRP3 */
     case 0xf7:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
 
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -5018,7 +5018,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xfe: /* GRP4 */
     case 0xff: /* GRP5 */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
 
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -5032,10 +5032,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* operand size for jumps is 64 bit */
                 ot = MO_64;
             } else if (op == 3 || op == 5) {
-                ot = dflag != MO_16 ? MO_32 + (REX_W(s) == 1) : MO_16;
+                ot = s->dflag != MO_16 ? MO_32 + (REX_W(s) == 1) : MO_16;
             } else if (op == 6) {
                 /* default push size is 64 bit */
-                ot = mo_pushpop(s, dflag);
+                ot = mo_pushpop(s, s->dflag);
             }
         }
         if (mod != 3) {
@@ -5063,7 +5063,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
         case 2: /* call Ev */
             /* XXX: optimize if memory (no 'and' is necessary) */
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             next_eip = s->pc - s->cs_base;
@@ -5081,19 +5081,19 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->pe && !s->vm86) {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lcall_protected(cpu_env, s->tmp2_i32, s->T1,
-                                           tcg_const_i32(dflag - 1),
+                                           tcg_const_i32(s->dflag - 1),
                                            tcg_const_tl(s->pc - s->cs_base));
             } else {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lcall_real(cpu_env, s->tmp2_i32, s->T1,
-                                      tcg_const_i32(dflag - 1),
+                                      tcg_const_i32(s->dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
             tcg_gen_ld_tl(s->tmp4, cpu_env, offsetof(CPUX86State, eip));
             gen_jr(s, s->tmp4);
             break;
         case 4: /* jmp Ev */
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             gen_op_jmp_v(s->T0);
@@ -5126,7 +5126,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0x84: /* test Ev, Gv */
     case 0x85:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
 
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -5139,7 +5139,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa8: /* test eAX, Iv */
     case 0xa9:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         val = insn_get(env, s, ot);
 
         gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
@@ -5149,7 +5149,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x98: /* CWDE/CBW */
-        switch (dflag) {
+        switch (s->dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
@@ -5172,7 +5172,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x99: /* CDQ/CWD */
-        switch (dflag) {
+        switch (s->dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
@@ -5199,7 +5199,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1af: /* imul Gv, Ev */
     case 0x69: /* imul Gv, Ev, I */
     case 0x6b:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         if (b == 0x69)
@@ -5251,7 +5251,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x1c0:
     case 0x1c1: /* xadd Ev, Gv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -5283,7 +5283,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             TCGv oldv, newv, cmpv;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
@@ -5344,7 +5344,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
-            if (dflag == MO_64) {
+            if (s->dflag == MO_64) {
                 if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
                     goto illegal_op;
                 }
@@ -5384,7 +5384,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_helper_rdrand(s->T0, cpu_env);
             rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_reg_v(s, dflag, rm, s->T0);
+            gen_op_mov_reg_v(s, s->dflag, rm, s->T0);
             set_cc_op(s, CC_OP_EFLAGS);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
@@ -5420,7 +5420,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x68: /* push Iv */
     case 0x6a:
-        ot = mo_pushpop(s, dflag);
+        ot = mo_pushpop(s, s->dflag);
         if (b == 0x68)
             val = insn_get(env, s, ot);
         else
@@ -5505,7 +5505,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /* mov */
     case 0x88:
     case 0x89: /* mov Gv, Ev */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
@@ -5514,7 +5514,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xc6:
     case 0xc7: /* mov Ev, Iv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod != 3) {
@@ -5531,7 +5531,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x8a:
     case 0x8b: /* mov Ev, Gv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
@@ -5563,7 +5563,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (reg >= 6)
             goto illegal_op;
         gen_op_movl_T0_seg(s, reg);
-        ot = mod == 3 ? dflag : MO_16;
+        ot = mod == 3 ? s->dflag : MO_16;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
         break;
 
@@ -5576,7 +5576,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             TCGMemOp s_ot;
 
             /* d_ot is the size of destination */
-            d_ot = dflag;
+            d_ot = s->dflag;
             /* ot is the size of source */
             ot = (b & 1) + MO_8;
             /* s_ot is the sign+size of source */
@@ -5627,7 +5627,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             TCGv ea = gen_lea_modrm_1(s, a);
             gen_lea_v_seg(s, s->aflag, ea, -1, -1);
-            gen_op_mov_reg_v(s, dflag, reg, s->A0);
+            gen_op_mov_reg_v(s, s->dflag, reg, s->A0);
         }
         break;
 
@@ -5638,7 +5638,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             target_ulong offset_addr;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             switch (s->aflag) {
 #ifdef TARGET_X86_64
             case MO_64:
@@ -5676,7 +5676,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xb8 ... 0xbf: /* mov R, Iv */
 #ifdef TARGET_X86_64
-        if (dflag == MO_64) {
+        if (s->dflag == MO_64) {
             uint64_t tmp;
             /* 64 bit case */
             tmp = x86_ldq_code(env, s);
@@ -5686,7 +5686,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else
 #endif
         {
-            ot = dflag;
+            ot = s->dflag;
             val = insn_get(env, s, ot);
             reg = (b & 7) | REX_B(s);
             tcg_gen_movi_tl(s->T0, val);
@@ -5696,13 +5696,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0x91 ... 0x97: /* xchg R, EAX */
     do_xchg_reg_eax:
-        ot = dflag;
+        ot = s->dflag;
         reg = (b & 7) | REX_B(s);
         rm = R_EAX;
         goto do_xchg_reg;
     case 0x86:
     case 0x87: /* xchg Ev, Gv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -5739,7 +5739,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1b5: /* lgs Gv */
         op = R_GS;
     do_lxx:
-        ot = dflag != MO_16 ? MO_32 : MO_16;
+        ot = s->dflag != MO_16 ? MO_32 : MO_16;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -5767,7 +5767,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         shift = 2;
     grp2:
         {
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             op = (modrm >> 3) & 7;
@@ -5820,7 +5820,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         op = 1;
         shift = 0;
     do_shiftd:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
@@ -5982,7 +5982,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 }
                 break;
             case 0x0c: /* fldenv mem */
-                gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x0d: /* fldcw mem */
                 tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
@@ -5990,7 +5990,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fldcw(cpu_env, s->tmp2_i32);
                 break;
             case 0x0e: /* fnstenv mem */
-                gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x0f: /* fnstcw mem */
                 gen_helper_fnstcw(s->tmp2_i32, cpu_env);
@@ -6005,10 +6005,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fpop(cpu_env);
                 break;
             case 0x2c: /* frstor mem */
-                gen_helper_frstor(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_frstor(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x2e: /* fnsave mem */
-                gen_helper_fsave(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_fsave(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x2f: /* fnstsw mem */
                 gen_helper_fnstsw(s->tmp2_i32, cpu_env);
@@ -6350,7 +6350,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa4: /* movsS */
     case 0xa5:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6360,7 +6360,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xaa: /* stosS */
     case 0xab:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6369,7 +6369,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xac: /* lodsS */
     case 0xad:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6378,7 +6378,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xae: /* scasS */
     case 0xaf:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (prefixes & PREFIX_REPZ) {
@@ -6390,7 +6390,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa6: /* cmpsS */
     case 0xa7:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (prefixes & PREFIX_REPZ) {
@@ -6401,7 +6401,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x6c: /* insS */
     case 0x6d:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base, 
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes) | 4);
@@ -6416,7 +6416,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x6e: /* outsS */
     case 0x6f:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes) | 4);
@@ -6435,7 +6435,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xe4:
     case 0xe5:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
@@ -6453,7 +6453,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xe6:
     case 0xe7:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
@@ -6473,7 +6473,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xec:
     case 0xed:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
@@ -6490,7 +6490,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xee:
     case 0xef:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes));
@@ -6533,21 +6533,21 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->pe && !s->vm86) {
             gen_update_cc_op(s);
             gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_lret_protected(cpu_env, tcg_const_i32(dflag - 1),
+            gen_helper_lret_protected(cpu_env, tcg_const_i32(s->dflag - 1),
                                       tcg_const_i32(val));
         } else {
             gen_stack_A0(s);
             /* pop offset */
-            gen_op_ld_v(s, dflag, s->T0, s->A0);
+            gen_op_ld_v(s, s->dflag, s->T0, s->A0);
             /* NOTE: keeping EIP updated is not a problem in case of
                exception */
             gen_op_jmp_v(s->T0);
             /* pop selector */
-            gen_add_A0_im(s, 1 << dflag);
-            gen_op_ld_v(s, dflag, s->T0, s->A0);
+            gen_add_A0_im(s, 1 << s->dflag);
+            gen_op_ld_v(s, s->dflag, s->T0, s->A0);
             gen_op_movl_seg_T0_vm(s, R_CS);
             /* add stack offset */
-            gen_stack_update(s, val + (2 << dflag));
+            gen_stack_update(s, val + (2 << s->dflag));
         }
         gen_eob(s);
         break;
@@ -6558,17 +6558,17 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_IRET);
         if (!s->pe) {
             /* real mode */
-            gen_helper_iret_real(cpu_env, tcg_const_i32(dflag - 1));
+            gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
             set_cc_op(s, CC_OP_EFLAGS);
         } else if (s->vm86) {
             if (s->iopl != 3) {
                 gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
             } else {
-                gen_helper_iret_real(cpu_env, tcg_const_i32(dflag - 1));
+                gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
                 set_cc_op(s, CC_OP_EFLAGS);
             }
         } else {
-            gen_helper_iret_protected(cpu_env, tcg_const_i32(dflag - 1),
+            gen_helper_iret_protected(cpu_env, tcg_const_i32(s->dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             set_cc_op(s, CC_OP_EFLAGS);
         }
@@ -6576,14 +6576,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xe8: /* call im */
         {
-            if (dflag != MO_16) {
+            if (s->dflag != MO_16) {
                 tval = (int32_t)insn_get(env, s, MO_32);
             } else {
                 tval = (int16_t)insn_get(env, s, MO_16);
             }
             next_eip = s->pc - s->cs_base;
             tval += next_eip;
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tval &= 0xffff;
             } else if (!CODE64(s)) {
                 tval &= 0xffffffff;
@@ -6600,7 +6600,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             if (CODE64(s))
                 goto illegal_op;
-            ot = dflag;
+            ot = s->dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
@@ -6609,13 +6609,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         goto do_lcall;
     case 0xe9: /* jmp im */
-        if (dflag != MO_16) {
+        if (s->dflag != MO_16) {
             tval = (int32_t)insn_get(env, s, MO_32);
         } else {
             tval = (int16_t)insn_get(env, s, MO_16);
         }
         tval += s->pc - s->cs_base;
-        if (dflag == MO_16) {
+        if (s->dflag == MO_16) {
             tval &= 0xffff;
         } else if (!CODE64(s)) {
             tval &= 0xffffffff;
@@ -6629,7 +6629,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             if (CODE64(s))
                 goto illegal_op;
-            ot = dflag;
+            ot = s->dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
@@ -6640,7 +6640,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xeb: /* jmp Jb */
         tval = (int8_t)insn_get(env, s, MO_8);
         tval += s->pc - s->cs_base;
-        if (dflag == MO_16) {
+        if (s->dflag == MO_16) {
             tval &= 0xffff;
         }
         gen_jmp(s, tval);
@@ -6649,7 +6649,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tval = (int8_t)insn_get(env, s, MO_8);
         goto do_jcc;
     case 0x180 ... 0x18f: /* jcc Jv */
-        if (dflag != MO_16) {
+        if (s->dflag != MO_16) {
             tval = (int32_t)insn_get(env, s, MO_32);
         } else {
             tval = (int16_t)insn_get(env, s, MO_16);
@@ -6657,7 +6657,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_jcc:
         next_eip = s->pc - s->cs_base;
         tval += next_eip;
-        if (dflag == MO_16) {
+        if (s->dflag == MO_16) {
             tval &= 0xffff;
         }
         gen_bnd_jmp(s);
@@ -6673,7 +6673,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!(s->cpuid_features & CPUID_CMOV)) {
             goto illegal_op;
         }
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_cmovcc1(env, s, ot, b, modrm, reg);
@@ -6698,7 +6698,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else {
             ot = gen_pop_T0(s);
             if (s->cpl == 0) {
-                if (dflag != MO_16) {
+                if (s->dflag != MO_16) {
                     gen_helper_write_eflags(cpu_env, s->T0,
                                             tcg_const_i32((TF_MASK | AC_MASK |
                                                            ID_MASK | NT_MASK |
@@ -6713,7 +6713,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 }
             } else {
                 if (s->cpl <= s->iopl) {
-                    if (dflag != MO_16) {
+                    if (s->dflag != MO_16) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                                 tcg_const_i32((TF_MASK |
                                                                AC_MASK |
@@ -6730,7 +6730,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                                               & 0xffff));
                     }
                 } else {
-                    if (dflag != MO_16) {
+                    if (s->dflag != MO_16) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                            tcg_const_i32((TF_MASK | AC_MASK |
                                                           ID_MASK | NT_MASK)));
@@ -6790,7 +6790,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         op = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
@@ -6823,7 +6823,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1bb: /* btc */
         op = 3;
     do_btx:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -6928,7 +6928,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x1bc: /* bsf / tzcnt */
     case 0x1bd: /* bsr / lzcnt */
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
@@ -7102,7 +7102,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x62: /* bound */
         if (CODE64(s))
             goto illegal_op;
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
@@ -7120,7 +7120,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c8 ... 0x1cf: /* bswap reg */
         reg = (b & 7) | REX_B(s);
 #ifdef TARGET_X86_64
-        if (dflag == MO_64) {
+        if (s->dflag == MO_64) {
             gen_op_mov_v_reg(s, MO_64, s->T0, reg);
             tcg_gen_bswap64_i64(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_64, reg, s->T0);
@@ -7150,7 +7150,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             tval = (int8_t)insn_get(env, s, MO_8);
             next_eip = s->pc - s->cs_base;
             tval += next_eip;
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tval &= 0xffff;
             }
 
@@ -7233,7 +7233,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!s->pe) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            gen_helper_sysexit(cpu_env, tcg_const_i32(dflag - 1));
+            gen_helper_sysexit(cpu_env, tcg_const_i32(s->dflag - 1));
             gen_eob(s);
         }
         break;
@@ -7252,7 +7252,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!s->pe) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            gen_helper_sysret(cpu_env, tcg_const_i32(dflag - 1));
+            gen_helper_sysret(cpu_env, tcg_const_i32(s->dflag - 1));
             /* condition codes are modified only in long mode */
             if (s->lma) {
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -7291,7 +7291,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, ldt.selector));
-            ot = mod == 3 ? dflag : MO_16;
+            ot = mod == 3 ? s->dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 2: /* lldt */
@@ -7312,7 +7312,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, tr.selector));
-            ot = mod == 3 ? dflag : MO_16;
+            ot = mod == 3 ? s->dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 3: /* ltr */
@@ -7356,7 +7356,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base));
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7411,7 +7411,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base));
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7561,7 +7561,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base));
@@ -7578,7 +7578,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base));
@@ -7689,7 +7689,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s)) {
             int d_ot;
             /* d_ot is the size of destination */
-            d_ot = dflag;
+            d_ot = s->dflag;
 
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -7764,7 +7764,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             TCGv t0;
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            ot = dflag != MO_16 ? MO_32 : MO_16;
+            ot = s->dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -8103,7 +8103,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c3: /* MOVNTI reg, mem */
         if (!(s->cpuid_features & CPUID_SSE2))
             goto illegal_op;
-        ot = mo_64_32(dflag);
+        ot = mo_64_32(s->dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
@@ -8339,7 +8339,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->prefix & PREFIX_DATA) {
             ot = MO_16;
         } else {
-            ot = mo_64_32(dflag);
+            ot = mo_64_32(s->dflag);
         }
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-- 
2.20.1


