Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C8C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EE521019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2T7y93U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhgD-0006Ft-Sh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdR-0002PZ-Vl
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0004AK-F6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:53 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:43673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0003mL-7F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n205so4460208ywb.10
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EDJRtTrInuk8SJPYMuGBry4P1q8G45deh+mvJtrhqc0=;
 b=n2T7y93U3DEqi+fYgNu/dKvaDcAlxNJGkcxZwUi+7RwHAmEQA+zWUzf6Rl9t0o6nqn
 E6RgzpYLPaZtJLjph/ZYgeY9h7dGmERVFupb9xhWvWQiEQ9BEJaWmimBHg/mVJ2qwZNd
 wEKVNSvKl0F76uSEfAj9LYtaQwAjkrZLEdDSv0O8pwcwPvTaSuo124GOg7+bRaVhhpPp
 cXZZB1mn9MCa+FAU9q0Fo5VniovZbw+NJ7OuKH6+/QmO8dWHg3o6o+NMhhBE0PzV2gNR
 heWbvLcUIg5tFQzQpXmCmkLXn0kHERQ1kH9SbP+43ix26x9jPGu7RX5NpOYmGWnc2Pnj
 0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EDJRtTrInuk8SJPYMuGBry4P1q8G45deh+mvJtrhqc0=;
 b=W+D0eVxt6I2Eff0uGT13rdxS7mb8odWwBnlXDD0Z9vsLwdVxHN2TMWGXGGUECZ0xQE
 +/2TK7f9G2lnqakQzI6PP8o0WZ3bUHPcgABMR0zBC0pILchV7SfNO7gV7r/agitwxVb6
 lVBs34e8RMWNIoCxixdajPbpP/3pJ7L3RPdhFbwzDf5hQcZ3IWZGjb+ORzPk4Gz2zkRk
 B6y1E/zIyKbk0806J1oqgJdMgXkOUXkaEJHxh4LX9/c/PwUWIa3T+lpXm3ldd3sWZ87m
 IWeFkrGAB18O3pspgInj3xSqoy60SbDcquhmuqHOKt/A5cw4fPKTJq8Cr5w7W494RQmj
 bPgQ==
X-Gm-Message-State: APjAAAUE0a4rZGcZlkuOI+XYPfjRf94PUXKFieimTa5N9d9fRO4klY+r
 BKFQ3JJERXS5VlSzyUpMnQLUTeI8
X-Google-Smtp-Source: APXvYqx0X8aw8T/S5Z9z3clvG222mBE3tRgon9pbFEv7Vh5mW12IOEY1dgc60LYr6DRCtQ1g5jU73Q==
X-Received: by 2002:a81:a50e:: with SMTP id u14mr3716759ywg.124.1562884402550; 
 Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:57 -0400
Message-Id: <20190711223300.6061-16-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RISU PATCH v3 15/18] x86.risu: add SSE4.1 and SSE4.2
 instructions
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

Add SSE4.1 and SSE4.2 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff --git a/x86.risu b/x86.risu
index 6f89a80..bc6636e 100644
--- a/x86.risu
+++ b/x86.risu
@@ -486,6 +486,11 @@ PMULLW SSE2 00001111 11010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 40 /r: PMULLD xmm1, xmm2/m128
+PMULLD SSE4_1 00001111 00111000 01000000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E5 /r: PMULHW mm, mm/m64
 PMULHW MMX 00001111 11100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -506,6 +511,11 @@ PMULHUW SSE2 00001111 11100100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 28 /r: PMULDQ xmm1, xmm2/m128
+PMULDQ SSE4_1 00001111 00111000 00101000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F4 /r: PMULUDQ mm1, mm2/m64
 PMULUDQ_mm SSE2 00001111 11110100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -636,6 +646,21 @@ PMINUB SSE2 00001111 11011010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 3A /r: PMINUW xmm1, xmm2/m128
+PMINUW SSE4_1 00001111 00111000 00111010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 3B /r: PMINUD xmm1, xmm2/m128
+PMINUD SSE4_1 00001111 00111000 00111011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 38 /r: PMINSB xmm1, xmm2/m128
+PMINSB SSE4_1 00001111 00111000 00111000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EA /r: PMINSW mm1, mm2/m64
 PMINSW SSE 00001111 11101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -646,6 +671,11 @@ PMINSW SSE2 00001111 11101010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 39 /r: PMINSD xmm1, xmm2/m128
+PMINSD SSE4_1 00001111 00111000 00111001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5D /r: MINPS xmm1, xmm2/m128
 MINPS SSE 00001111 01011101 \
   !constraints { modrm($_); 1 } \
@@ -666,6 +696,11 @@ MINSD SSE2 00001111 01011101 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 38 41 /r: PHMINPOSUW xmm1, xmm2/m128
+PHMINPOSUW SSE4_1 00001111 00111000 01000001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F DE /r: PMAXUB mm1, mm2/m64
 PMAXUB SSE 00001111 11011110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -676,6 +711,21 @@ PMAXUB SSE2 00001111 11011110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 3E /r: PMAXUW xmm1, xmm2/m128
+PMAXUW SSE4_1 00001111 00111000 00111110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 3F /r: PMAXUD xmm1, xmm2/m128
+PMAXUD SSE4_1 00001111 00111000 00111111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 3C /r: PMAXSB xmm1, xmm2/m128
+PMAXSB SSE4_1 00001111 00111000 00111100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EE /r: PMAXSW mm1, mm2/m64
 PMAXSW SSE 00001111 11101110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -686,6 +736,11 @@ PMAXSW SSE2 00001111 11101110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 3D /r: PMAXSD xmm1, xmm2/m128
+PMAXSD SSE4_1 00001111 00111000 00111101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5F /r: MAXPS xmm1, xmm2/m128
 MAXPS SSE 00001111 01011111 \
   !constraints { modrm($_); 1 } \
@@ -736,6 +791,11 @@ PSADBW SSE2 00001111 11110110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 3A 42 /r ib: MPSADBW xmm1, xmm2/m128, imm8
+MPSADBW SSE4_1 00001111 00111010 01000010 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 38 1C /r: PABSB mm1, mm2/m64
 PABSB_mm SSSE3 00001111 00111000 00011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -796,6 +856,36 @@ PSIGND SSSE3 00001111 00111000 00001010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 3A 40 /r ib: DPPS xmm1, xmm2/m128, imm8
+DPPS SSE4_1 00001111 00111010 01000000 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 41 /r ib: DPPD xmm1, xmm2/m128, imm8
+DPPD SSE4_1 00001111 00111010 01000001 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 08 /r ib: ROUNDPS xmm1, xmm2/m128, imm8
+ROUNDPS SSE4_1 00001111 00111010 00001000 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 09 /r ib: ROUNDPD xmm1, xmm2/m128, imm8
+ROUNDPD SSE4_1 00001111 00111010 00001001 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 0A /r ib: ROUNDSS xmm1, xmm2/m32, imm8
+ROUNDSS SSE4_1 00001111 00111010 00001010 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0F 3A 0B /r ib: ROUNDSD xmm1, xmm2/m64, imm8
+ROUNDSD SSE4_1 00001111 00111010 00001011 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 8); }
+
 #
 # Comparison Instructions
 # -----------------------
@@ -831,6 +921,11 @@ PCMPEQD SSE2 00001111 01110110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 29 /r: PCMPEQQ xmm1, xmm2/m128
+PCMPEQQ SSE4_1 00001111 00111000 00101001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 64 /r: PCMPGTB mm,mm/m64
 PCMPGTB MMX 00001111 01100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -861,6 +956,36 @@ PCMPGTD SSE2 00001111 01100110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 37 /r: PCMPGTQ xmm1,xmm2/m128
+PCMPGTQ SSE4_2 00001111 00111000 00110111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 60 /r imm8: PCMPESTRM xmm1, xmm2/m128, imm8
+PCMPESTRM SSE4_2 00001111 00111010 01100000 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
+# 66 0F 3A 61 /r imm8: PCMPESTRI xmm1, xmm2/m128, imm8
+PCMPESTRI SSE4_2 00001111 00111010 01100001 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
+
+# 66 0F 3A 62 /r imm8: PCMPISTRM xmm1, xmm2/m128, imm8
+PCMPISTRM SSE4_2 00001111 00111010 01100010 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
+# 66 0F 3A 63 /r imm8: PCMPISTRI xmm1, xmm2/m128, imm8
+PCMPISTRI SSE4_2 00001111 00111010 01100011 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
+
+# 66 0F 38 17 /r: PTEST xmm1, xmm2/m128
+PTEST SSE4_1 00001111 00111000 00010111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8
 CMPPS SSE 00001111 11000010 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
@@ -1188,6 +1313,11 @@ PACKUSWB SSE2 00001111 01100111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 38 2B /r: PACKUSDW xmm1, xmm2/m128
+PACKUSDW SSE4_1 00001111 00111000 00101011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 68 /r: PUNPCKHBW mm, mm/m64
 PUNPCKHBW MMX 00001111 01101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1318,6 +1448,46 @@ SHUFPD SSE2 00001111 11000110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 3A 0C /r ib: BLENDPS xmm1, xmm2/m128, imm8
+BLENDPS SSE4_1 00001111 00111010 00001100 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 0D /r ib: BLENDPD xmm1, xmm2/m128, imm8
+BLENDPD SSE4_1 00001111 00111010 00001101 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 14 /r: BLENDVPS xmm1, xmm2/m128, <XMM0>
+BLENDVPS SSE4_1 00001111 00111000 00010100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 15 /r: BLENDVPD xmm1, xmm2/m128 , <XMM0>
+BLENDVPD SSE4_1 00001111 00111000 00010101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 10 /r: PBLENDVB xmm1, xmm2/m128, <XMM0>
+PBLENDVB SSE4_1 00001111 00111000 00010000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 0E /r ib: PBLENDW xmm1, xmm2/m128, imm8
+PBLENDW SSE4_1 00001111 00111010 00001110 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A 21 /r ib: INSERTPS xmm1, xmm2/m32, imm8
+INSERTPS SSE4_1 00001111 00111010 00100001 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0F 3A 20 /r ib: PINSRB xmm1,r32/m8,imm8
+PINSRB SSE4_1 00001111 00111010 00100000 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 1); }
+
 # NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8
 PINSRW SSE 00001111 11000100 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
@@ -1328,6 +1498,41 @@ PINSRW SSE2 00001111 11000100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 2); }
 
+# 66 0F 3A 22 /r ib: PINSRD xmm1,r/m32,imm8
+PINSRD SSE4_1 00001111 00111010 00100010 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
+# 66 REX.W 0F 3A 22 /r ib: PINSRQ xmm1,r/m64,imm8
+PINSRQ SSE4_1 00001111 00111010 00100010 \
+  !constraints { data16($_); rex($_, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
+# 66 0F 3A 17 /r ib: EXTRACTPS reg/m32, xmm1, imm8
+EXTRACTPS SSE4_1 00001111 00111010 00010111 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 4); }
+
+# 66 0F 3A 14 /r ib: PEXTRB reg/m8,xmm2,imm8
+PEXTRB SSE4_1 00001111 00111010 00010100 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 1); }
+
+# 66 0F 3A 15 /r ib: PEXTRW reg/m16, xmm, imm8
+PEXTRW SSE4_1 00001111 00111010 00010101 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 2); }
+
+# 66 0F 3A 16 /r ib: PEXTRD r/m32,xmm2,imm8
+PEXTRD SSE4_1 00001111 00111010 00010110 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 4); }
+
+# 66 REX.W 0F 3A 16 /r ib: PEXTRQ r/m64,xmm2,imm8
+PEXTRQ SSE4_1 00001111 00111010 00010110 \
+  !constraints { data16($_); rex($_, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 8); }
+
 # NP 0F C5 /r ib: PEXTRW reg, mm, imm8
 PEXTRW_reg SSE 00001111 11000101 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
@@ -1341,6 +1546,66 @@ PEXTRW_reg SSE2 00001111 11000101 \
 # -----------------------
 #
 
+# 66 0f 38 20 /r: PMOVSXBW xmm1, xmm2/m64
+PMOVSXBW SSE4_1 00001111 00111000 00100000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0f 38 21 /r: PMOVSXBD xmm1, xmm2/m32
+PMOVSXBD SSE4_1 00001111 00111000 00100001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0f 38 22 /r: PMOVSXBQ xmm1, xmm2/m16
+PMOVSXBQ SSE4_1 00001111 00111000 00100010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
+# 66 0f 38 23 /r: PMOVSXWD xmm1, xmm2/m64
+PMOVSXWD SSE4_1 00001111 00111000 00100011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0f 38 24 /r: PMOVSXWQ xmm1, xmm2/m32
+PMOVSXWQ SSE4_1 00001111 00111000 00100100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0f 38 25 /r: PMOVSXDQ xmm1, xmm2/m64
+PMOVSXDQ SSE4_1 00001111 00111000 00100101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0f 38 30 /r: PMOVZXBW xmm1, xmm2/m64
+PMOVZXBW SSE4_1 00001111 00111000 00110000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0f 38 31 /r: PMOVZXBD xmm1, xmm2/m32
+PMOVZXBD SSE4_1 00001111 00111000 00110001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0f 38 32 /r: PMOVZXBQ xmm1, xmm2/m16
+PMOVZXBQ SSE4_1 00001111 00111000 00110010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
+# 66 0f 38 33 /r: PMOVZXWD xmm1, xmm2/m64
+PMOVZXWD SSE4_1 00001111 00111000 00110011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0f 38 34 /r: PMOVZXWQ xmm1, xmm2/m32
+PMOVZXWQ SSE4_1 00001111 00111000 00110100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# 66 0f 38 35 /r: PMOVZXDQ xmm1, xmm2/m64
+PMOVZXDQ SSE4_1 00001111 00111000 00110101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2A /r: CVTPI2PS xmm, mm/m64
 CVTPI2PS SSE 00001111 00101010 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1526,6 +1791,11 @@ MOVNTDQ SSE2 00001111 11100111 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# 66 0F 38 2A /r: MOVNTDQA xmm1, m128
+MOVNTDQA SSE4_1 00001111 00111000 00101010 \
+  !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16, align => 16); }
+
 # 0F 18 /1: PREFETCHT0 m8
 PREFETCHT0 SSE 00001111 00011000 \
   !constraints { modrm($_, reg => 1); !defined $_->{modrm}{reg2} } \
-- 
2.20.1


