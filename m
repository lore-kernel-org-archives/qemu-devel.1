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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808BA2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdUOrrl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808BA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssrz-0003dk-MZ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 13:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr9-00022K-1g
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssr7-0002dL-Rw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:42 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssr7-0002d2-Nx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:41 -0400
Received: by mail-yb1-xb42.google.com with SMTP id x188so2574367yba.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6nDSi2OJfOTaQ/1QMGaIy9TKp9JFtHSdU8wWAA7Z90w=;
 b=mdUOrrl1HL+Kd6MeulItl68Ug4AOPPWVcXTgja1E8WavCsOofTOyZK0rnCCgI95Ru5
 1JLQTAJ5vmwkp0FYoczMttRRRR69TPSM0y+fyT6mv2WFrYV2gZ7EKb4zA9PJBoKT7c5h
 tP0mMsoS/43SvwwR7byHvPrepRhq+sdkQXxVwpQrbjPM4kA4oeUvUF34cyXgn6A6R1BW
 upwPNBjr7hvcG8s0mtOLGRyYPz4FkqGNSW/JicjHm6VK1dGY+xg9a9rQNHw/9s3LM4ai
 UPsADyw/aWFFaaXMWJF4hW79J6CE83IXAi0Y2Z0PyXwpsNYP68fzJeJYWg+yUzCZlGME
 imkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6nDSi2OJfOTaQ/1QMGaIy9TKp9JFtHSdU8wWAA7Z90w=;
 b=UfYtaaBdGAFJkzdDGF+GZ40Crj1H/UYlCjBrr8UHkpXcEukiDAxx0K7FZcwL48kWs4
 96WbPu4zoSk6sMcxnzkQ4joGBjv47h/CaGxIc/RwiAuaqTKBWbNcGt5wox1l4dAcE0m1
 ksfj9+D9PcK2Gjfph++d03nM34mQhmRqmxKmlQp3jS8/BbANkl5On0OnN37Pbwe2aE+J
 0RnL9jHLs7FFUkIU03GL+dp2JQ1a7Ts/Q9irRu8qw+JGNeAk+NLHiTrlgCtzcilIU7SM
 0I7+hj/cih7je514pLxxRsFKF/Jn2I6WgvPYP5UH5MLLrYMKjyOHGcgaTxABhxi+YSxy
 /gfw==
X-Gm-Message-State: APjAAAViUyROkJLgyDQGLJeDZTSoxVqrgyPuAuAGWn+4pd/W65meowIM
 6DUfpd+o2rkMlXguIUTMbeF+S3xj
X-Google-Smtp-Source: APXvYqxc5et63cLzMtE7pl/UdjOci25zqw8KCshWmy4PjGaG+NxDcKe5FExpj3Z8ZIQCfk9iEIJb2w==
X-Received: by 2002:a25:908d:: with SMTP id t13mr75323398ybl.411.1564595860845; 
 Wed, 31 Jul 2019 10:57:40 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:40 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:42 -0400
Message-Id: <20190731175702.4916-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v1 02/22] target/i386: Push rex_w into
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

Treat this the same as we already do for other rex bits.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d74dbfd585..c0866c2797 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -44,11 +44,13 @@
 #define REX_X(s) ((s)->rex_x)
 #define REX_B(s) ((s)->rex_b)
 #define REX_R(s) ((s)->rex_r)
+#define REX_W(s) ((s)->rex_w)
 #else
 #define CODE64(s) 0
 #define REX_X(s) 0
 #define REX_B(s) 0
 #define REX_R(s) 0
+#define REX_W(s) -1
 #endif
 
 #ifdef TARGET_X86_64
@@ -100,7 +102,7 @@ typedef struct DisasContext {
 #ifdef TARGET_X86_64
     int lma;    /* long mode active */
     int code64; /* 64 bit code segment */
-    int rex_x, rex_b, rex_r;
+    int rex_x, rex_b, rex_r, rex_w;
 #endif
     int vex_l;  /* vex vector length */
     int vex_v;  /* vex vvvv register, without 1's complement.  */
@@ -4495,7 +4497,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     target_ulong pc_start = s->base.pc_next;
-    int rex_w;
 
     s->pc_start = s->pc = pc_start;
     s->override = -1;
@@ -4503,6 +4504,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->rex_x = 0;
     s->rex_b = 0;
     s->rex_r = 0;
+    s->rex_w = -1;
     s->x86_64_hregs = false;
 #endif
     s->rip_offset = 0; /* for relative ip address */
@@ -4514,7 +4516,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     prefixes = 0;
-    rex_w = -1;
 
  next_byte:
     b = x86_ldub_code(env, s);
@@ -4557,7 +4558,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x40 ... 0x4f:
         if (CODE64(s)) {
             /* REX prefix */
-            rex_w = (b >> 3) & 1;
+            s->rex_w = (b >> 3) & 1;
             s->rex_r = (b & 0x4) << 1;
             s->rex_x = (b & 0x2) << 2;
             s->rex_b = (b & 0x1) << 3;
@@ -4606,7 +4607,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 s->rex_b = (~vex2 >> 2) & 8;
 #endif
                 vex3 = x86_ldub_code(env, s);
-                rex_w = (vex3 >> 7) & 1;
+#ifdef TARGET_X86_64
+                s->rex_w = (vex3 >> 7) & 1;
+#endif
                 switch (vex2 & 0x1f) {
                 case 0x01: /* Implied 0f leading opcode bytes.  */
                     b = x86_ldub_code(env, s) | 0x100;
@@ -4631,9 +4634,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     /* Post-process prefixes.  */
     if (CODE64(s)) {
         /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
-           data with rex_w, and 16-bit data with 0x66; rex_w takes precedence
+           data with REX_W, and 16-bit data with 0x66; REX_W takes precedence
            over 0x66 if both are present.  */
-        dflag = (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16 : MO_32);
+        dflag = (REX_W(s) > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16 : MO_32);
         /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
         aflag = (prefixes & PREFIX_ADR ? MO_32 : MO_64);
     } else {
@@ -5029,7 +5032,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* operand size for jumps is 64 bit */
                 ot = MO_64;
             } else if (op == 3 || op == 5) {
-                ot = dflag != MO_16 ? MO_32 + (rex_w == 1) : MO_16;
+                ot = dflag != MO_16 ? MO_32 + (REX_W(s) == 1) : MO_16;
             } else if (op == 6) {
                 /* default push size is 64 bit */
                 ot = mo_pushpop(s, dflag);
-- 
2.20.1


