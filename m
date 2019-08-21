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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18E922D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw5X9cPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18E922D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UdQ-000192-Hd
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQv-0000YS-9O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQu-0006xc-34
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:05 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:34113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQt-0006xF-V4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:04 -0400
Received: by mail-yb1-xb43.google.com with SMTP id u68so1355814ybg.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XcHdhv7Tr8pKpZ8Bf3TEPpKCMu1p8Id3mWUlS1gcqrc=;
 b=Xw5X9cPx1RdPubh44uZHmPQ1stqP4lHLBum8Q76kpYIIWSf/GUnEU4NM5yDCCwlGgn
 OTJJ1jHQzA6ja4a6s6k/07DnOBqq/OD7jDz95SvfL9TBXJovizBeHH+w8A+cFexfI7fg
 K+ae/MzRZJefzDIKxS2VaONyU1uKfZlZNGsk0Zd6NxMIArwFKeGAUj69jcE7WT3gLWPh
 Ki5+s1lqQaPAs6uOjnILbwBvNo9iCp4LH5FAuHRcROCkD9S8L6hhZbM2LNvxSVBH30Zw
 WZgdehcPT6PA3pDASxx2d/YOPbsDWLN1yezNEJNcPwtqt/fUN4eWbnoO1SQSUmeMLFTM
 vwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XcHdhv7Tr8pKpZ8Bf3TEPpKCMu1p8Id3mWUlS1gcqrc=;
 b=MVL1WZ4XK6OTuBx/TpgIxAaRqC96s8scG/hgxBTJNjnc2tIi0cQT1dq1WvlJz7cpzt
 8RzfXnTYvbD6r83JXuQVm0Fl4rE0TLLnwLHo//90GXil/UHr9tj+ayY1hKQLPfjfT183
 WXmW8ahAQzeKIraNkSo4ytPJOxFXHoLC4qvTxn2QK7qwq6zw4NmFBaQhZvjTFVtI/ysx
 iwG5mibj//Bjo3lPZBbkaMHuElBv9BJpFvXxRJSailZ3T0GvUtZAb0kBENwLzRLEpHY+
 DpwF1/YjaOCK4NJPRQio6iM7pAm1apwePQr0Vq7lQ8BrQxOY66JoTfhd4thcCluHr7Rf
 X7sQ==
X-Gm-Message-State: APjAAAURe47yID9JaaP05btAu7AgIHm270VNYeazA8kGZznP9F/3pTJT
 A6YLgS33ZDJBSrNLLIsxke0COJ+f
X-Google-Smtp-Source: APXvYqwoX1TKvYpu8ENJC/RO3QJ6buzhjONJEFjE1YJX1EmfmOMJp6f+TVjwDSH/buRI0YI8+pFYEQ==
X-Received: by 2002:a5b:7d2:: with SMTP id t18mr8941048ybq.326.1566408603228; 
 Wed, 21 Aug 2019 10:30:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:02 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:38 -0400
Message-Id: <20190821172951.15333-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 02/75] target/i386: Push rex_w into
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
index 3aac84e5b0..9ec1c79371 100644
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


