Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93CC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0912067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnuBeBCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0912067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsstG-0006tO-4m
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 13:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr9-00022L-8V
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr7-0002ca-BQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:43 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:39728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssr7-0002bW-63
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:41 -0400
Received: by mail-yw1-xc42.google.com with SMTP id x74so7287207ywx.6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XvCHdm9nHE9smMApxfPJipkd9WnhL73swaE5KE6lGAQ=;
 b=dnuBeBCEpiywgd6LIj8NfS5VB0b++TU+SJCYHxR5J2w71bauHOBjmkuFDwGn69VDs+
 K9E3RE5pkjDfOlxYpIB4lTTeE7KWebbgidPdgkrofdJV+OXB/oIJHf1oVDaF742WH3Ca
 OS6qr2GbN1cj1tUa7KpcAZbGLKlAAzFJmlPbWEjicGTChqu8DlIhUuPIErDzY/eLLSkX
 MdUXM9HkR2a7C41gDSMpA6mF8XBejQkukayo7hYqqGKXPBphTSpkCQvHe4U1Ck3TUylu
 X+Tvi6MYzgDlujqwVP0ActiPHoIWoM44uewQ01j19kyNwKqBeKcZFU0+p7G52OitaP/Z
 pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XvCHdm9nHE9smMApxfPJipkd9WnhL73swaE5KE6lGAQ=;
 b=scux+xzvM6la8zUP5Fs2sNBabD+RsqDMrzdnacojb7jL0en+trzcO1FLUHGpZ1k6XU
 kaWj5E/+ez+BsqrlqeBPwCJ/rgdQ7dB0l/aa2f9+g7+lOuZFGvkwVXPcSrOhdXojJZgB
 eU0yzpqXgmRdyD/dHYrMbrgyYQ/zIp+GfY4vjSpGGeYWrWLYdXDSsPfmca2TyzVByU+G
 moQxB9NlZCv0Sp3udDEidnHovzGgJY8SR6+LxlxBTTzO0OFJqNbbdPtTMjNURkGGZVRB
 DZgTo4eZoVjDQrMr/25xtLqrbUuZDpSSB7GWnmSt0P3KmOhVw8VNsNUhozF/JmzyaElI
 cBCw==
X-Gm-Message-State: APjAAAXoAD2YBnnVwrA1/nbRJKCegrf/LgLiWP2/6dFqQPP4GAx3NPyZ
 kVzMEN82RMKgsZl4gIzV5shRgQAb
X-Google-Smtp-Source: APXvYqzlUdQNwr/wLXB2mId+ypa1aYfWx52gffUjKDhuAxUTff2qGnVv5klWDYb5QoM2i3tuhx41fA==
X-Received: by 2002:a81:a1cb:: with SMTP id
 y194mr79264705ywg.104.1564595860253; 
 Wed, 31 Jul 2019 10:57:40 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:39 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:41 -0400
Message-Id: <20190731175702.4916-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v1 01/22] target/i386: Push rex_r into
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
index 03150a86e2..d74dbfd585 100644
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
@@ -5502,7 +5505,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x89: /* mov Gv, Ev */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
@@ -5528,7 +5531,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x8b: /* mov Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_reg_v(s, ot, reg, s->T0);
@@ -5578,7 +5581,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             s_ot = b & 8 ? MO_SIGN | ot : ot;
 
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
@@ -5617,7 +5620,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         {
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             TCGv ea = gen_lea_modrm_1(s, a);
@@ -5699,7 +5702,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x87: /* xchg Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3) {
             rm = (modrm & 7) | REX_B(s);
@@ -5736,7 +5739,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_lxx:
         ot = dflag != MO_16 ? MO_32 : MO_16;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
@@ -5819,7 +5822,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         if (mod != 3) {
             gen_lea_modrm(env, s, modrm);
             opreg = OR_TMP0;
@@ -6674,7 +6677,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_cmovcc1(env, s, ot, b, modrm, reg);
         break;
 
@@ -6824,7 +6827,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_btx:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
@@ -6929,7 +6932,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1bd: /* bsr / lzcnt */
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
 
@@ -7693,7 +7696,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             d_ot = dflag;
 
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
@@ -7767,7 +7770,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             t0 = tcg_temp_local_new();
             gen_update_cc_op(s);
@@ -7808,7 +7811,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
@@ -7898,7 +7901,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
@@ -8012,7 +8015,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
              * are assumed to be 1's, regardless of actual values.
              */
             rm = (modrm & 7) | REX_B(s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (CODE64(s))
                 ot = MO_64;
             else
@@ -8069,7 +8072,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
              * are assumed to be 1's, regardless of actual values.
              */
             rm = (modrm & 7) | REX_B(s);
-            reg = ((modrm >> 3) & 7) | rex_r;
+            reg = ((modrm >> 3) & 7) | REX_R(s);
             if (CODE64(s))
                 ot = MO_64;
             else
@@ -8112,7 +8115,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
         break;
@@ -8338,7 +8341,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
 
         modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | rex_r;
+        reg = ((modrm >> 3) & 7) | REX_R(s);
 
         if (s->prefix & PREFIX_DATA) {
             ot = MO_16;
@@ -8366,7 +8369,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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


