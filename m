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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D967C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093E92084C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnNMRsiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIo1-0006e7-Dm
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkm-0005I9-D5
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkj-0004Ds-DM
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkj-0004Di-6C
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id r21so134535749otq.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B7EJT5lzpjHtBLSgeZjnrnvOhaVIfQhoZsfiVYdqw5k=;
 b=jnNMRsiS/8XdMP9cGpnato2KBes2Dq35e51AlbHHfw/6wFipWfd87RS1IsDRS8NvEp
 1OqDOL3nV7udRY5neNROImHJ1Ia3gJmfvSC0hLxT7v+u6Gz74Z78t1LCyGb9jYjWcavm
 ODWmT/Fc8YeBnHRAOUSVYoJDepSJv6J0j1r05ZZuhdI+Prky1TE3UUY+UnwFIoTYZTve
 ao5B5BDTxkyVwux5oDVaNKuONgketTRswu1S8XECnNHuOJsKm+ME8i1mAleU/Bmf/njH
 BJ/utv6nLnao6F3Gl1EiEs6uXl5uVYRg6qTqvOLAC9lLXfWXAfYqiSXFQp/r+giMeT1u
 osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B7EJT5lzpjHtBLSgeZjnrnvOhaVIfQhoZsfiVYdqw5k=;
 b=d3COlwCA+MYVZNzzyLE18c4EANX+7sHKUtlLx5C/o+uc/EMxY9B8+Jjcgy26myyPXI
 Di+/MzAb/IxLJqRAoYRPC8xC404PdYvYBzHFqEj0mkx42i5/1hFgJPSMKLtml6hS0wrC
 kYMLjFg57ulq4UmIFWUj711gFs0d8/0wu6aBtRk0Vjvrkp0ZG7qEQVHqAqGgtvIhvhg1
 VTvGinE2dlZL/qEUP0NVy/th0uaA6OveuQpQeF/n7vTqa3HTGQgzPL89cA7Db/uk4m+V
 co/3bOvnAC+l81fSvncKPnrztcz5DGaJuwruUXJEpNtdK/kwgyzEu5GTPmNGI+58wPki
 VQmQ==
X-Gm-Message-State: APjAAAWRito2fHoEMzZ7aHUzAWDl//Fwi5OZR4nq7w5v2Z1KXUXhGtQu
 SeDF6c0Ac89cNEKuJwiONsddn6wF
X-Google-Smtp-Source: APXvYqw8ZorOsDyBSffGycob+4dAVWmcnNyYvHmVnijwgbOUA8VVoAveIyMvnuR3BCIpulX6lsAy0A==
X-Received: by 2002:aca:72c7:: with SMTP id p190mr4445646oic.9.1565410391946; 
 Fri, 09 Aug 2019 21:13:11 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:11 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:20 -0400
Message-Id: <20190810041255.6820-5-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RFC PATCH v2 04/39] target/i386: use dflag from
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

There already is a variable dflag in DisasContext, so reduce the scope
of the local variable dflag to enforce use of the one in DisasContext.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 184 ++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index bda96277e4..bb13877df7 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4493,13 +4493,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     CPUX86State *env = cpu->env_ptr;
     int b, prefixes;
     int shift;
-    TCGMemOp ot, dflag;
+    TCGMemOp ot;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     target_ulong pc_start = s->base.pc_next;
 
     {
-    TCGMemOp aflag;
+    TCGMemOp aflag, dflag;
 
     s->pc_start = s->pc = pc_start;
     s->override = -1;
@@ -4686,7 +4686,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             op = (b >> 3) & 7;
             f = (b >> 1) & 3;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
 
             switch(f) {
             case 0: /* OP Ev, Gv */
@@ -4744,7 +4744,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             int val;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
 
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
@@ -4781,16 +4781,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5022,7 +5022,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xfe: /* GRP4 */
     case 0xff: /* GRP5 */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
 
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -5036,10 +5036,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5067,7 +5067,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
         case 2: /* call Ev */
             /* XXX: optimize if memory (no 'and' is necessary) */
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             next_eip = s->pc - s->cs_base;
@@ -5085,19 +5085,19 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -5130,7 +5130,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0x84: /* test Ev, Gv */
     case 0x85:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
 
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -5143,7 +5143,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa8: /* test eAX, Iv */
     case 0xa9:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         val = insn_get(env, s, ot);
 
         gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
@@ -5153,7 +5153,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
     case 0x98: /* CWDE/CBW */
-        switch (dflag) {
+        switch (s->dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
@@ -5176,7 +5176,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x99: /* CDQ/CWD */
-        switch (dflag) {
+        switch (s->dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
@@ -5203,7 +5203,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1af: /* imul Gv, Ev */
     case 0x69: /* imul Gv, Ev, I */
     case 0x6b:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         if (b == 0x69)
@@ -5255,7 +5255,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x1c0:
     case 0x1c1: /* xadd Ev, Gv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -5287,7 +5287,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             TCGv oldv, newv, cmpv;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
@@ -5348,7 +5348,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
-            if (dflag == MO_64) {
+            if (s->dflag == MO_64) {
                 if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
                     goto illegal_op;
                 }
@@ -5388,7 +5388,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_helper_rdrand(s->T0, cpu_env);
             rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_reg_v(s, dflag, rm, s->T0);
+            gen_op_mov_reg_v(s, s->dflag, rm, s->T0);
             set_cc_op(s, CC_OP_EFLAGS);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
@@ -5425,7 +5425,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x68: /* push Iv */
     case 0x6a:
-        ot = mo_pushpop(s, dflag);
+        ot = mo_pushpop(s, s->dflag);
         if (b == 0x68)
             val = insn_get(env, s, ot);
         else
@@ -5510,7 +5510,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /* mov */
     case 0x88:
     case 0x89: /* mov Gv, Ev */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
@@ -5519,7 +5519,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xc6:
     case 0xc7: /* mov Ev, Iv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod != 3) {
@@ -5536,7 +5536,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x8a:
     case 0x8b: /* mov Ev, Gv */
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
@@ -5568,7 +5568,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (reg >= 6)
             goto illegal_op;
         gen_op_movl_T0_seg(s, reg);
-        ot = mod == 3 ? dflag : MO_16;
+        ot = mod == 3 ? s->dflag : MO_16;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
         break;
 
@@ -5581,7 +5581,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             TCGMemOp s_ot;
 
             /* d_ot is the size of destination */
-            d_ot = dflag;
+            d_ot = s->dflag;
             /* ot is the size of source */
             ot = (b & 1) + MO_8;
             /* s_ot is the sign+size of source */
@@ -5632,7 +5632,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             TCGv ea = gen_lea_modrm_1(s, a);
             gen_lea_v_seg(s, s->aflag, ea, -1, -1);
-            gen_op_mov_reg_v(s, dflag, reg, s->A0);
+            gen_op_mov_reg_v(s, s->dflag, reg, s->A0);
         }
         break;
 
@@ -5643,7 +5643,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         {
             target_ulong offset_addr;
 
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             switch (s->aflag) {
 #ifdef TARGET_X86_64
             case MO_64:
@@ -5681,7 +5681,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xb8 ... 0xbf: /* mov R, Iv */
 #ifdef TARGET_X86_64
-        if (dflag == MO_64) {
+        if (s->dflag == MO_64) {
             uint64_t tmp;
             /* 64 bit case */
             tmp = x86_ldq_code(env, s);
@@ -5691,7 +5691,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else
 #endif
         {
-            ot = dflag;
+            ot = s->dflag;
             val = insn_get(env, s, ot);
             reg = (b & 7) | REX_B(s);
             tcg_gen_movi_tl(s->T0, val);
@@ -5701,13 +5701,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
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
@@ -5744,7 +5744,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1b5: /* lgs Gv */
         op = R_GS;
     do_lxx:
-        ot = dflag != MO_16 ? MO_32 : MO_16;
+        ot = s->dflag != MO_16 ? MO_32 : MO_16;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -5772,7 +5772,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         shift = 2;
     grp2:
         {
-            ot = mo_b_d(b, dflag);
+            ot = mo_b_d(b, s->dflag);
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             op = (modrm >> 3) & 7;
@@ -5825,7 +5825,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         op = 1;
         shift = 0;
     do_shiftd:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
@@ -5987,7 +5987,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 }
                 break;
             case 0x0c: /* fldenv mem */
-                gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x0d: /* fldcw mem */
                 tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
@@ -5995,7 +5995,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fldcw(cpu_env, s->tmp2_i32);
                 break;
             case 0x0e: /* fnstenv mem */
-                gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
+                gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(s->dflag - 1));
                 break;
             case 0x0f: /* fnstcw mem */
                 gen_helper_fnstcw(s->tmp2_i32, cpu_env);
@@ -6010,10 +6010,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6355,7 +6355,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa4: /* movsS */
     case 0xa5:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6365,7 +6365,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xaa: /* stosS */
     case 0xab:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6374,7 +6374,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xac: /* lodsS */
     case 0xad:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
@@ -6383,7 +6383,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xae: /* scasS */
     case 0xaf:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (prefixes & PREFIX_REPZ) {
@@ -6395,7 +6395,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xa6: /* cmpsS */
     case 0xa7:
-        ot = mo_b_d(b, dflag);
+        ot = mo_b_d(b, s->dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (prefixes & PREFIX_REPZ) {
@@ -6406,7 +6406,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x6c: /* insS */
     case 0x6d:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base, 
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes) | 4);
@@ -6421,7 +6421,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x6e: /* outsS */
     case 0x6f:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes) | 4);
@@ -6440,7 +6440,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     case 0xe4:
     case 0xe5:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
@@ -6459,7 +6459,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xe6:
     case 0xe7:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
@@ -6480,7 +6480,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xec:
     case 0xed:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
@@ -6498,7 +6498,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0xee:
     case 0xef:
-        ot = mo_b_d32(b, dflag);
+        ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes));
@@ -6542,21 +6542,21 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6567,17 +6567,17 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6585,14 +6585,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6609,7 +6609,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             if (CODE64(s))
                 goto illegal_op;
-            ot = dflag;
+            ot = s->dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
@@ -6618,13 +6618,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -6638,7 +6638,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             if (CODE64(s))
                 goto illegal_op;
-            ot = dflag;
+            ot = s->dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
@@ -6649,7 +6649,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xeb: /* jmp Jb */
         tval = (int8_t)insn_get(env, s, MO_8);
         tval += s->pc - s->cs_base;
-        if (dflag == MO_16) {
+        if (s->dflag == MO_16) {
             tval &= 0xffff;
         }
         gen_jmp(s, tval);
@@ -6658,7 +6658,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tval = (int8_t)insn_get(env, s, MO_8);
         goto do_jcc;
     case 0x180 ... 0x18f: /* jcc Jv */
-        if (dflag != MO_16) {
+        if (s->dflag != MO_16) {
             tval = (int32_t)insn_get(env, s, MO_32);
         } else {
             tval = (int16_t)insn_get(env, s, MO_16);
@@ -6666,7 +6666,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_jcc:
         next_eip = s->pc - s->cs_base;
         tval += next_eip;
-        if (dflag == MO_16) {
+        if (s->dflag == MO_16) {
             tval &= 0xffff;
         }
         gen_bnd_jmp(s);
@@ -6682,7 +6682,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!(s->cpuid_features & CPUID_CMOV)) {
             goto illegal_op;
         }
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_cmovcc1(env, s, ot, b, modrm, reg);
@@ -6707,7 +6707,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else {
             ot = gen_pop_T0(s);
             if (s->cpl == 0) {
-                if (dflag != MO_16) {
+                if (s->dflag != MO_16) {
                     gen_helper_write_eflags(cpu_env, s->T0,
                                             tcg_const_i32((TF_MASK | AC_MASK |
                                                            ID_MASK | NT_MASK |
@@ -6722,7 +6722,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 }
             } else {
                 if (s->cpl <= s->iopl) {
-                    if (dflag != MO_16) {
+                    if (s->dflag != MO_16) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                                 tcg_const_i32((TF_MASK |
                                                                AC_MASK |
@@ -6739,7 +6739,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                                               & 0xffff));
                     }
                 } else {
-                    if (dflag != MO_16) {
+                    if (s->dflag != MO_16) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                            tcg_const_i32((TF_MASK | AC_MASK |
                                                           ID_MASK | NT_MASK)));
@@ -6799,7 +6799,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         op = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
@@ -6832,7 +6832,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1bb: /* btc */
         op = 3;
     do_btx:
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
@@ -6937,7 +6937,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x1bc: /* bsf / tzcnt */
     case 0x1bd: /* bsr / lzcnt */
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
@@ -7111,7 +7111,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x62: /* bound */
         if (CODE64(s))
             goto illegal_op;
-        ot = dflag;
+        ot = s->dflag;
         modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
@@ -7129,7 +7129,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c8 ... 0x1cf: /* bswap reg */
         reg = (b & 7) | REX_B(s);
 #ifdef TARGET_X86_64
-        if (dflag == MO_64) {
+        if (s->dflag == MO_64) {
             gen_op_mov_v_reg(s, MO_64, s->T0, reg);
             tcg_gen_bswap64_i64(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_64, reg, s->T0);
@@ -7159,7 +7159,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             tval = (int8_t)insn_get(env, s, MO_8);
             next_eip = s->pc - s->cs_base;
             tval += next_eip;
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tval &= 0xffff;
             }
 
@@ -7243,7 +7243,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!s->pe) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            gen_helper_sysexit(cpu_env, tcg_const_i32(dflag - 1));
+            gen_helper_sysexit(cpu_env, tcg_const_i32(s->dflag - 1));
             gen_eob(s);
         }
         break;
@@ -7262,7 +7262,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!s->pe) {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
-            gen_helper_sysret(cpu_env, tcg_const_i32(dflag - 1));
+            gen_helper_sysret(cpu_env, tcg_const_i32(s->dflag - 1));
             /* condition codes are modified only in long mode */
             if (s->lma) {
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -7301,7 +7301,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, ldt.selector));
-            ot = mod == 3 ? dflag : MO_16;
+            ot = mod == 3 ? s->dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 2: /* lldt */
@@ -7322,7 +7322,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, tr.selector));
-            ot = mod == 3 ? dflag : MO_16;
+            ot = mod == 3 ? s->dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 3: /* ltr */
@@ -7366,7 +7366,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base));
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7421,7 +7421,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base));
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7571,7 +7571,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base));
@@ -7588,7 +7588,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag == MO_16) {
+            if (s->dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base));
@@ -7700,7 +7700,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s)) {
             int d_ot;
             /* d_ot is the size of destination */
-            d_ot = dflag;
+            d_ot = s->dflag;
 
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -7775,7 +7775,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             TCGv t0;
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            ot = dflag != MO_16 ? MO_32 : MO_16;
+            ot = s->dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
@@ -8117,7 +8117,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c3: /* MOVNTI reg, mem */
         if (!(s->cpuid_features & CPUID_SSE2))
             goto illegal_op;
-        ot = mo_64_32(dflag);
+        ot = mo_64_32(s->dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
@@ -8353,7 +8353,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->prefix & PREFIX_DATA) {
             ot = MO_16;
         } else {
-            ot = mo_64_32(dflag);
+            ot = mo_64_32(s->dflag);
         }
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-- 
2.20.1


