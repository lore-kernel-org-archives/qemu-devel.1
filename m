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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B57C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D5D20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoDrfuk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D5D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhen-0007nB-63
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdQ-0002KM-QN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0004AX-HR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:52 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:46305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0003ke-9N
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a5so3181871ybo.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FI2sCuZfDBhIzapWcE/W8gVdt/lN7+h4w7gY0VmKLgs=;
 b=DoDrfuk8DR/psiQthlj2tgKESCP6U38b3TlER/KPiPoTol1x0Dexd1O5GWdWhOnzWZ
 HXEMEX5Jw2MF6kaQDluMXxws0eTYPpVR25hOBsJW2nAlkX9rHx7hNxStNZFkGcOXLYC6
 EJhfq4i18m3nI1XukVfRO/5S2RbdWsjdbP3oQM+IKQUTQbMJ07aMFBe00I7JS+Dm4504
 2a0BQ+JXB5vW5QJZkJv5xOehpXqA1+cpXZmrQ6gncH69lzVDlLyYCuKFDzCuE0/hmuXM
 MDYHeTqw/PJFiMxoSKFSwTlsSNcFmo1m0+avBncQ2bemchQSLNhAXZLDLdd3nkUwWxF3
 2DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FI2sCuZfDBhIzapWcE/W8gVdt/lN7+h4w7gY0VmKLgs=;
 b=IdP/OUEhx4FfRmQD/3FWwIeVNl0o4ATQx7q/ZnFxtPFWjZQbYATPtsHNKB+Q3I6lZm
 PiOuQ2CPeAwR2T3FUI/VWsZo4IwLZaGCK4YTUKYwW5Dl03rUcirg/Qf//MuNsjggzWzs
 T6nR/7Q3atYtszG6GADPOgPs+jpEXqngFlTxHFJHJH+vvuC4f1kLMovwl47Xk6Rc+Rto
 lsSIPNP7WRCCSSibOyJNMiLORPFQ2i34VvZdk4oY5au5L7hPG/Tmp0g0Mb21zuuKZTjm
 cAsqkwbQBaGhtgbkC5YXMaVUliFchQUusuDeeWXLo0WvCPutJuN/2E0Ofrvx4yM5X5j1
 fbKQ==
X-Gm-Message-State: APjAAAX/owQDAIvJFRsNCdOOMK0WJHnhxelvW/hY7YN6hacJXx5ZPb/k
 tTyk6WQwQlt4brsJ4N8ycN+7TK2H
X-Google-Smtp-Source: APXvYqwP/otQcblliVclhGscU8jucYgf0U9veSTBSwzqzfco+vGHUPgkkP45N1cCzpoQGn8NPf6R8Q==
X-Received: by 2002:a25:3846:: with SMTP id f67mr4135890yba.515.1562884401918; 
 Thu, 11 Jul 2019 15:33:21 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:21 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:56 -0400
Message-Id: <20190711223300.6061-15-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU PATCH v3 14/18] x86.risu: add SSSE3 instructions
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

Add SSSE3 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/x86.risu b/x86.risu
index d40b9df..6f89a80 100644
--- a/x86.risu
+++ b/x86.risu
@@ -286,6 +286,36 @@ ADDSD SSE2 00001111 01011000 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 38 01 /r: PHADDW mm1, mm2/m64
+PHADDW_mm SSSE3 00001111 00111000 00000001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 01 /r: PHADDW xmm1, xmm2/m128
+PHADDW SSSE3 00001111 00111000 00000001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 02 /r: PHADDD mm1, mm2/m64
+PHADDD_mm SSSE3 00001111 00111000 00000010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 02 /r: PHADDD xmm1, xmm2/m128
+PHADDD SSSE3 00001111 00111000 00000010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 03 /r: PHADDSW mm1, mm2/m64
+PHADDSW_mm SSSE3 00001111 00111000 00000011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 03 /r: PHADDSW xmm1, xmm2/m128
+PHADDSW SSSE3 00001111 00111000 00000011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F2 0F 7C /r: HADDPS xmm1, xmm2/m128
 HADDPS SSE3 00001111 01111100 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -396,6 +426,36 @@ SUBSD SSE2 00001111 01011100 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 38 05 /r: PHSUBW mm1, mm2/m64
+PHSUBW_mm SSSE3 00001111 00111000 00000101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 05 /r: PHSUBW xmm1, xmm2/m128
+PHSUBW SSSE3 00001111 00111000 00000101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 06 /r: PHSUBD mm1, mm2/m64
+PHSUBD_mm SSSE3 00001111 00111000 00000110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 06 /r: PHSUBD xmm1, xmm2/m128
+PHSUBD SSSE3 00001111 00111000 00000110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 07 /r: PHSUBSW mm1, mm2/m64
+PHSUBSW_mm SSSE3 00001111 00111000 00000111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 07 /r: PHSUBSW xmm1, xmm2/m128
+PHSUBSW SSSE3 00001111 00111000 00000111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F2 0F 7D /r: HSUBPS xmm1, xmm2/m128
 HSUBPS SSE3 00001111 01111101 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -456,6 +516,16 @@ PMULUDQ SSE2 00001111 11110100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# NP 0F 38 0B /r: PMULHRSW mm1, mm2/m64
+PMULHRSW_mm SSSE3 00001111 00111000 00001011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 0B /r: PMULHRSW xmm1, xmm2/m128
+PMULHRSW SSSE3 00001111 00111000 00001011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 59 /r: MULPS xmm1, xmm2/m128
 MULPS SSE 00001111 01011001 \
   !constraints { modrm($_); 1 } \
@@ -486,6 +556,16 @@ PMADDWD SSE2 00001111 11110101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# NP 0F 38 04 /r: PMADDUBSW mm1, mm2/m64
+PMADDUBSW_mm SSSE3 00001111 00111000 00000100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 04 /r: PMADDUBSW xmm1, xmm2/m128
+PMADDUBSW SSSE3 00001111 00111000 00000100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5E /r: DIVPS xmm1, xmm2/m128
 DIVPS SSE 00001111 01011110 \
   !constraints { modrm($_); 1 } \
@@ -656,6 +736,66 @@ PSADBW SSE2 00001111 11110110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# NP 0F 38 1C /r: PABSB mm1, mm2/m64
+PABSB_mm SSSE3 00001111 00111000 00011100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 1C /r: PABSB xmm1, xmm2/m128
+PABSB SSSE3 00001111 00111000 00011100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 1D /r: PABSW mm1, mm2/m64
+PABSW_mm SSSE3 00001111 00111000 00011101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 1D /r: PABSW xmm1, xmm2/m128
+PABSW SSSE3 00001111 00111000 00011101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 1E /r: PABSD mm1, mm2/m64
+PABSD_mm SSSE3 00001111 00111000 00011110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 1E /r: PABSD xmm1, xmm2/m128
+PABSD SSSE3 00001111 00111000 00011110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 08 /r: PSIGNB mm1, mm2/m64
+PSIGNB_mm SSSE3 00001111 00111000 00001000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 08 /r: PSIGNB xmm1, xmm2/m128
+PSIGNB SSSE3 00001111 00111000 00001000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 09 /r: PSIGNW mm1, mm2/m64
+PSIGNW_mm SSSE3 00001111 00111000 00001001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 09 /r: PSIGNW xmm1, xmm2/m128
+PSIGNW SSSE3 00001111 00111000 00001001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 38 0A /r: PSIGND mm1, mm2/m64
+PSIGND_mm SSSE3 00001111 00111000 00001010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 0A /r: PSIGND xmm1, xmm2/m128
+PSIGND SSSE3 00001111 00111000 00001010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Comparison Instructions
 # -----------------------
@@ -1003,6 +1143,16 @@ PSRAD_imm MMX 00001111 01110010 \
 PSRAD_imm SSE2 00001111 01110010 \
   !constraints { data16($_); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# NP 0F 3A 0F /r ib: PALIGNR mm1, mm2/m64, imm8
+PALIGNR_mm SSSE3 00001111 00111010 00001111 \
+  !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 3A 0F /r ib: PALIGNR xmm1, xmm2/m128, imm8
+PALIGNR SSSE3 00001111 00111010 00001111 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Gather Instructions
 # --------------------------------------------------------------------------------
@@ -1128,6 +1278,16 @@ UNPCKHPD SSE2 00001111 00010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# NP 0F 38 00 /r: PSHUFB mm1, mm2/m64
+PSHUFB_mm SSSE3 00001111 00111000 00000000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 38 00 /r: PSHUFB xmm1, xmm2/m128
+PSHUFB SSSE3 00001111 00111000 00000000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8
 PSHUFW SSE 00001111 01110000 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
-- 
2.20.1


