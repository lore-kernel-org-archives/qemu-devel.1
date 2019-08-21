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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6666222D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRu5Gw5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6666222D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ugh-0004yE-1k
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQx-0000c7-Be
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQu-0006yE-RS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:07 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:44244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQu-0006xp-FH
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:04 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l79so1225588ywe.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VWqjFx/O0u8bCwF/JLEXfrLf2VEXAXqQnhgjFcPCqxY=;
 b=PRu5Gw5PHQp/3QARA4hpp8VmW7YaOrd2FpkBbVUo2KBfN/omkYMQ6W3hb3a0u2OJ70
 PuSAgD6ecp3WwacXq6SF+A7HMS6Is21KW9RC2/rUQWZbuGZX3E6WAK/PbmiZpx/dhjAf
 vpXrT5z4CtcRqJI8+N8eAozZvUz3/8prb07jFyU/kR+duHnlEWabN5PKAFeCHpuS+77w
 lnHMynhUS4xNWUM7wX7KHAadsYq2GGS3QmJUH5OTzlpEkVv5loYolwrAvMyUG6wsg/Pw
 IGt4FDiI2fQe450TFZ8kswaJt330d+A8HI239Kv3mkAsgy7FMbGST2BsjsRe35i9cw+Q
 w3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VWqjFx/O0u8bCwF/JLEXfrLf2VEXAXqQnhgjFcPCqxY=;
 b=S8ZUOVtQYg7wv4l4Br0oHWghJA9t2qI9OTDkaD+cmHCkfPiFkgAYecYH0hxInSQJpY
 dF2zvANE8lM+HjSrLl/yhMInNkUp1c24RhUD2OXqdExi6s5SQI/eLcfltBdOVndHc8Ij
 ZKZOQOMNsR2OL/xmER0dK8NG9ebnix2lQA/1LYOZxTrLfGBbk/JASYv8owRQFxpuJ9dM
 kJ1bWeBsN1As9CTsA9TWJqOScmmIaaoOGtkRlYXoG2tsv+61vyRD64Cv+WvA60obczEQ
 kyugNcTlVbAz8JsN82TewmIJ4I1LXSX2S7R/8w4SbLWUOSTIrbeL8scD/qY1rqS/rp4I
 ndNw==
X-Gm-Message-State: APjAAAUivnuV/n2fmZAkoBN+gL7n5rcwK27f4e8h20w5FX9eeHx21TE/
 WzIh4rBHOF1Emp09tVSwmM7aCOke
X-Google-Smtp-Source: APXvYqyfUtHwCmk3BMBrjS84QPhn+d8Nt1tJ8u3jpHk1oeMPvYTCJxHrBPiIDd4mFL0lO4n8GoWjwg==
X-Received: by 2002:a81:70c8:: with SMTP id
 l191mr25400723ywc.425.1566408602411; 
 Wed, 21 Aug 2019 10:30:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:01 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:37 -0400
Message-Id: <20190821172951.15333-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 01/75] target/i386: Push rex_r into
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

Treat this value the same as we do for rex_b and rex_x.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 85 +++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5cd74ad639..3aac84e5b0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -43,10 +43,12 @@
 #define CODE64(s) ((s)->code64)
 #define REX_X(s) ((s)->rex_x)
 #define REX_B(s) ((s)->rex_b)
+#define REX_R(s) ((s)->rex_r)
 #else
 #define CODE64(s) 0
 #define REX_X(s) 0
 #define REX_B(s) 0
+#define REX_R(s) 0
 #endif
 
 #ifdef TARGET_X86_64
@@ -98,7 +100,7 @@ typedef struct DisasContext {
 #ifdef TARGET_X86_64
     int lma;    /* long mode active */
     int code64; /* 64 bit code segment */
-    int rex_x, rex_b;
+    int rex_x, rex_b, rex_r;
 #endif
     int vex_l;  /* vex vector length */
     int vex_v;  /* vex vvvv register, without 1's complement.  */
@@ -3037,7 +3039,7 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
 };
 
 static void gen_sse(CPUX86State *env, DisasContext *s, int b,
-                    target_ulong pc_start, int rex_r)
+                    target_ulong pc_start)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
     int modrm, mod, rm, reg;
@@ -3107,8 +3109,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
     modrm = x86_ldub_code(env, s);
     reg = ((modrm >> 3) & 7);
-    if (is_xmm)
-        reg |= rex_r;
+    if (is_xmm) {
+        reg |= REX_R(s);
+    }
     mod = (modrm >> 6) & 3;
     if (sse_fn_epp == SSE_SPECIAL) {
         b |= (b1 << 8);
@@ -3642,7 +3645,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 tcg_gen_ld16u_tl(s->T0, cpu_env,
                                 offsetof(CPUX86State,fpregs[rm].mmx.MMX_W(val)));
             }
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_op_mov_reg_v(s, ot, reg, s->T0);
             break;
         case 0x1d6: /* movq ea, xmm */
@@ -3686,7 +3689,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                  offsetof(CPUX86State, fpregs[rm].mmx));
                 gen_helper_pmovmskb_mmx(s->tmp2_i32, cpu_env, s->ptr0);
             }
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             break;
 
@@ -3698,7 +3701,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             }
             modrm = x86_ldub_code(env, s);
             rm = modrm & 7;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             if (b1 >= 2) {
                 goto unknown_op;
@@ -3774,7 +3777,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             /* Various integer extensions at 0f 38 f[0-f].  */
             b = modrm | (b1 << 8);
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
 
             switch (b) {
             case 0x3f0: /* crc32 Gd,Eb */
@@ -4128,7 +4131,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             b = modrm;
             modrm = x86_ldub_code(env, s);
             rm = modrm & 7;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             if (b1 >= 2) {
                 goto unknown_op;
@@ -4148,7 +4151,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3)
                     gen_lea_modrm(env, s, modrm);
-                reg = ((modrm >> 3) & 7) | rex_r;
+                reg = ((modrm >> 3) & 7) | REX_R(s);
                 val = x86_ldub_code(env, s);
                 switch (b) {
                 case 0x14: /* pextrb */
@@ -4317,7 +4320,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             /* Various integer extensions at 0f 3a f[0-f].  */
             b = modrm | (b1 << 8);
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
 
             switch (b) {
             case 0x3f0: /* rorx Gy,Ey, Ib */
@@ -4491,14 +4494,15 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     TCGMemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
-    int rex_w, rex_r;
     target_ulong pc_start = s->base.pc_next;
+    int rex_w;
 
     s->pc_start = s->pc = pc_start;
     s->override = -1;
 #ifdef TARGET_X86_64
     s->rex_x = 0;
     s->rex_b = 0;
+    s->rex_r = 0;
     s->x86_64_hregs = false;
 #endif
     s->rip_offset = 0; /* for relative ip address */
@@ -4511,7 +4515,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
     prefixes = 0;
     rex_w = -1;
-    rex_r = 0;
 
  next_byte:
     b = x86_ldub_code(env, s);
@@ -4555,9 +4558,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s)) {
             /* REX prefix */
             rex_w = (b >> 3) & 1;
-            rex_r = (b & 0x4) << 1;
+            s->rex_r = (b & 0x4) << 1;
             s->rex_x = (b & 0x2) << 2;
-            REX_B(s) = (b & 0x1) << 3;
+            s->rex_b = (b & 0x1) << 3;
             /* select uniform byte register addressing */
             s->x86_64_hregs = true;
             goto next_byte;
@@ -4590,8 +4593,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->x86_64_hregs) {
                 goto illegal_op;
             }
+            s->rex_r = (~vex2 >> 4) & 8;
 #endif
-            rex_r = (~vex2 >> 4) & 8;
             if (b == 0xc5) {
                 /* 2-byte VEX prefix: RVVVVlpp, implied 0f leading opcode byte */
                 vex3 = vex2;
@@ -4681,7 +4684,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             switch(f) {
             case 0: /* OP Ev, Gv */
                 modrm = x86_ldub_code(env, s);
-                reg = ((modrm >> 3) & 7) | rex_r;
+                reg = ((modrm >> 3) & 7) | REX_R(s);
                 mod = (modrm >> 6) & 3;
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3) {
@@ -4703,7 +4706,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 1: /* OP Gv, Ev */
                 modrm = x86_ldub_code(env, s);
                 mod = (modrm >> 6) & 3;
-                reg = ((modrm >> 3) & 7) | rex_r;
+                reg = ((modrm >> 3) & 7) | REX_R(s);
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3) {
                     gen_lea_modrm(env, s, modrm);
@@ -5123,7 +5126,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d(b, dflag);
 
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_v_reg(s, ot, s->T1, reg);
@@ -5195,7 +5198,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x6b:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         if (b == 0x69)
             s->rip_offset = insn_const_size(ot);
         else if (b == 0x6b)
@@ -5247,7 +5250,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c1: /* xadd Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         gen_op_mov_v_reg(s, ot, s->T0, reg);
         if (mod == 3) {
@@ -5279,7 +5282,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
             ot = mo_b_d(b, dflag);
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             oldv = tcg_temp_new();
             newv = tcg_temp_new();
@@ -5501,7 +5504,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x89: /* mov Gv, Ev */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
@@ -5527,7 +5530,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x8b: /* mov Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_reg_v(s, ot, reg, s->T0);
@@ -5577,7 +5580,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             s_ot = b & 8 ? MO_SIGN | ot : ot;
 
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
@@ -5616,7 +5619,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         {
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             TCGv ea = gen_lea_modrm_1(s, a);
@@ -5698,7 +5701,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x87: /* xchg Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3) {
             rm = (modrm & 7) | REX_B(s);
@@ -5735,7 +5738,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_lxx:
         ot = dflag != MO_16 ? MO_32 : MO_16;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
@@ -5818,7 +5821,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         if (mod != 3) {
             gen_lea_modrm(env, s, modrm);
             opreg = OR_TMP0;
@@ -6669,7 +6672,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_cmovcc1(env, s, ot, b, modrm, reg);
         break;
 
@@ -6819,7 +6822,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_btx:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
@@ -6924,7 +6927,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1bd: /* bsr / lzcnt */
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
 
@@ -7686,7 +7689,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             d_ot = dflag;
 
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
@@ -7760,7 +7763,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             t0 = tcg_temp_local_new();
             gen_update_cc_op(s);
@@ -7801,7 +7804,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
@@ -7891,7 +7894,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
@@ -8005,7 +8008,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
              * are assumed to be 1's, regardless of actual values.
              */
             rm = (modrm & 7) | REX_B(s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (CODE64(s))
                 ot = MO_64;
             else
@@ -8059,7 +8062,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
              * are assumed to be 1's, regardless of actual values.
              */
             rm = (modrm & 7) | REX_B(s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (CODE64(s))
                 ot = MO_64;
             else
@@ -8102,7 +8105,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
         break;
@@ -8328,7 +8331,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
 
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         if (s->prefix & PREFIX_DATA) {
             ot = MO_16;
@@ -8356,7 +8359,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-        gen_sse(env, s, b, pc_start, rex_r);
+        gen_sse(env, s, b, pc_start);
         break;
     default:
         goto unknown_op;
-- 
2.20.1


