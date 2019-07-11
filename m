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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C347C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5A120872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u46z3Wnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5A120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhgT-00074W-5H
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-00029H-9D
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdH-00046J-TF
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d]:40846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdE-0003jO-IA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:42 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id i14so3194084ybp.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kohGEyqxlhg37a0/+jnHKVGWWtcSTpxMhkb6u6b8YkI=;
 b=u46z3WnjzPEp6zccy3inDA+t6BJFbrIpVoNH+3+ckwoxeytxWbv06vnSxGI+lROCDz
 kiiKtYvuiY8zkHbqC9kYGDunWG4svdRjI8p6wIPgjYiyNHkXsnQwmqSK1WCSHMuanSrX
 AvBiHr0nXFUJlXYR82HHUBlOOLLNNfSXZ+dbq1gZX1Ume2SlS/P+NfGXMqJWKrSuht0z
 1zgjpRcQ1HkP4CsHyGYG45oBOdV4eb0CdtnVZRSUfpzUOy7zHjw/jj71zAhubKPnJH6b
 Dx/6NQpdSfGVzT/d4xVZ19rsH5VzeOFvBeAe0fO23Ib+tjP8x6GNGA9Yu82h4Yu2hUtZ
 p4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kohGEyqxlhg37a0/+jnHKVGWWtcSTpxMhkb6u6b8YkI=;
 b=SJphccW6Xyxq1l0IL08vJWp6dvbK6Di9bA6aJSJZXXTgt1GbmhiRky1+pOqIoQOAzp
 y+RklaKteObdkhZMhkR/YEeH/G9sXnifCw/cz+9Ao+3tGjuhkTXHGZQg3cReoUw+n3tG
 ksf1up0rrO/xAYcJAgTHNO/yNr+cYefTfFToFgMmaEdbJu9vTO4v8HwYAZJrmnayLM+J
 Ugel2w99+GBwo3BZyUbOobsMCgpTLyEjj3iuY4BbGCjp4MbXl+MZCUw4ZrZyCl3E1/Tk
 n6QKBtgoGvd0r7FMEnIxuIUPgj64JuGFDgsgCzrQ8+zBBdnuTBm6qoAyGvZFByhBqz/s
 nEEQ==
X-Gm-Message-State: APjAAAXMmDNWk0bOxgAJzdC9TkU4H1CXOE4oKpEQ0rpU2egrrtuJitFY
 02oP/SBsjU6CXxKaLe1TNTr1SXdZ
X-Google-Smtp-Source: APXvYqzIaW/EsSETa6WI7wt+pFIiomhqMwQ0GV+PhVEXWBOODf1f66h4zynJW+tuZKcajjYv+p7WsA==
X-Received: by 2002:a25:21c2:: with SMTP id h185mr4227595ybh.125.1562884400650; 
 Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:54 -0400
Message-Id: <20190711223300.6061-13-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2d
Subject: [Qemu-devel] [RISU PATCH v3 12/18] x86.risu: add SSE2 instructions
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

Add SSE2 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 734 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 734 insertions(+)

diff --git a/x86.risu b/x86.risu
index 2d963fc..b9d424e 100644
--- a/x86.risu
+++ b/x86.risu
@@ -23,48 +23,120 @@ MOVD MMX 00001111 011 d 1110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { $d ? store(size => 4) : load(size => 4); }
 
+# 66 0F 6E /r: MOVD xmm,r/m32
+# 66 0F 7E /r: MOVD r/m32,xmm
+MOVD SSE2 00001111 011 d 1110 \
+  !constraints { data16($_); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 4) : load(size => 4); }
+
 # NP REX.W + 0F 6E /r: MOVQ mm,r/m64
 # NP REX.W + 0F 7E /r: MOVQ r/m64,mm
 MOVQ MMX 00001111 011 d 1110 \
   !constraints { rex($_, w => 1); modrm($_); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# 66 REX.W 0F 6E /r: MOVQ xmm,r/m64
+# 66 REX.W 0F 7E /r: MOVQ r/m64,xmm
+MOVQ SSE2 00001111 011 d 1110 \
+  !constraints { data16($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 6F /r: MOVQ mm, mm/m64
 # NP 0F 7F /r: MOVQ mm/m64, mm
 MOVQ_mm MMX 00001111 011 d 1111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# F3 0F 7E /r: MOVQ xmm1, xmm2/m64
+MOVQ_xmm1 SSE2 00001111 01111110 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F D6 /r: MOVQ xmm2/m64, xmm1
+MOVQ_xmm2 SSE2 00001111 11010110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { store(size => 8); }
+
 # NP 0F 28 /r: MOVAPS xmm1, xmm2/m128
 # NP 0F 29 /r: MOVAPS xmm2/m128, xmm1
 MOVAPS SSE 00001111 0010100 d \
   !constraints { modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# 66 0F 28 /r: MOVAPD xmm1, xmm2/m128
+# 66 0F 29 /r: MOVAPD xmm2/m128, xmm1
+MOVAPD SSE2 00001111 0010100 d \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
+# 66 0F 6F /r: MOVDQA xmm1, xmm2/m128
+# 66 0F 7F /r: MOVDQA xmm2/m128, xmm1
+MOVDQA SSE2 00001111 011 d 1111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
 # NP 0F 10 /r: MOVUPS xmm1, xmm2/m128
 # NP 0F 11 /r: MOVUPS xmm2/m128, xmm1
 MOVUPS SSE 00001111 0001000 d \
   !constraints { modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# 66 0F 10 /r: MOVUPD xmm1, xmm2/m128
+# 66 0F 11 /r: MOVUPD xmm2/m128, xmm1
+MOVUPD SSE2 00001111 0001000 d \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
+# F3 0F 6F /r: MOVDQU xmm1,xmm2/m128
+# F3 0F 7F /r: MOVDQU xmm2/m128,xmm1
+MOVDQU SSE2 00001111 011 d 1111 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
 # F3 0F 10 /r: MOVSS xmm1, xmm2/m32
 # F3 0F 11 /r: MOVSS xmm2/m32, xmm1
 MOVSS SSE 00001111 0001000 d \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { $d ? store(size => 4) : load(size => 4); }
 
+# F2 0F 10 /r: MOVSD xmm1, xmm2/m64
+# F2 0F 11 /r: MOVSD xmm1/m64, xmm2
+MOVSD SSE2 00001111 0001000 d \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 8): load(size => 8); }
+
+# F3 0F D6 /r: MOVQ2DQ xmm, mm
+MOVQ2DQ SSE2 00001111 11010110 \
+  !constraints { rep($_); modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# F2 0F D6 /r: MOVDQ2Q mm, xmm
+MOVDQ2Q SSE2 00001111 11010110 \
+  !constraints { repne($_); modrm($_); $_->{modrm}{reg} &= 0b111; defined $_->{modrm}{reg2} }
+
 # NP 0F 12 /r: MOVLPS xmm1, m64
 # 0F 13 /r: MOVLPS m64, xmm1
 MOVLPS SSE 00001111 0001001 d \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# 66 0F 12 /r: MOVLPD xmm1,m64
+# 66 0F 13 /r: MOVLPD m64,xmm1
+MOVLPD SSE2 00001111 0001001 d \
+  !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 16 /r: MOVHPS xmm1, m64
 # NP 0F 17 /r: MOVHPS m64, xmm1
 MOVHPS SSE 00001111 0001011 d \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# 66 0F 16 /r: MOVHPD xmm1, m64
+# 66 0F 17 /r: MOVHPD m64, xmm1
+MOVHPD SSE2 00001111 0001011 d \
+  !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 16 /r: MOVLHPS xmm1, xmm2
 MOVLHPS SSE 00001111 00010110 \
   !constraints { modrm($_); defined $_->{modrm}{reg2} }
@@ -77,10 +149,18 @@ MOVHLPS SSE 00001111 00010010 \
 PMOVMSKB SSE 00001111 11010111 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# 66 0F D7 /r: PMOVMSKB reg, xmm
+PMOVMSKB SSE2 00001111 11010111 \
+  !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # NP 0F 50 /r: MOVMSKPS reg, xmm
 MOVMSKPS SSE 00001111 01010000 \
   !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# 66 0F 50 /r: MOVMSKPD reg, xmm
+MOVMSKPD SSE2 00001111 01010000 \
+  !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 #
 # Arithmetic Instructions
 # -----------------------
@@ -91,131 +171,291 @@ PADDB MMX 00001111 11111100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F FC /r: PADDB xmm1, xmm2/m128
+PADDB SSE2 00001111 11111100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F FD /r: PADDW mm, mm/m64
 PADDW MMX 00001111 11111101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F FD /r: PADDW xmm1, xmm2/m128
+PADDW SSE2 00001111 11111101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F FE /r: PADDD mm, mm/m64
 PADDD MMX 00001111 11111110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F FE /r: PADDD xmm1, xmm2/m128
+PADDD SSE2 00001111 11111110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F D4 /r: PADDQ mm, mm/m64
+PADDQ_mm SSE2 00001111 11010100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F D4 /r: PADDQ xmm1, xmm2/m128
+PADDQ SSE2 00001111 11010100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EC /r: PADDSB mm, mm/m64
 PADDSB MMX 00001111 11101100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F EC /r: PADDSB xmm1, xmm2/m128
+PADDSB SSE2 00001111 11101100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F ED /r: PADDSW mm, mm/m64
 PADDSW MMX 00001111 11101101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F ED /r: PADDSW xmm1, xmm2/m128
+PADDSW SSE2 00001111 11101101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F DC /r: PADDUSB mm,mm/m64
 PADDUSB MMX 00001111 11011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DC /r: PADDUSB xmm1,xmm2/m128
+PADDUSB SSE2 00001111 11011100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F DD /r: PADDUSW mm,mm/m64
 PADDUSW MMX 00001111 11011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DD /r: PADDUSW xmm1,xmm2/m128
+PADDUSW SSE2 00001111 11011101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 58 /r: ADDPS xmm1, xmm2/m128
 ADDPS SSE 00001111 01011000 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 58 /r: ADDPD xmm1, xmm2/m128
+ADDPD SSE2 00001111 01011000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 58 /r: ADDSS xmm1, xmm2/m32
 ADDSS SSE 00001111 01011000 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 58 /r: ADDSD xmm1, xmm2/m64
+ADDSD SSE2 00001111 01011000 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F F8 /r: PSUBB mm, mm/m64
 PSUBB MMX 00001111 11111000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F8 /r: PSUBB xmm1, xmm2/m128
+PSUBB SSE2 00001111 11111000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F9 /r: PSUBW mm, mm/m64
 PSUBW MMX 00001111 11111001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F9 /r: PSUBW xmm1, xmm2/m128
+PSUBW SSE2 00001111 11111001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F FA /r: PSUBD mm, mm/m64
 PSUBD MMX 00001111 11111010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F FA /r: PSUBD xmm1, xmm2/m128
+PSUBD SSE2 00001111 11111010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F FB /r: PSUBQ mm1, mm2/m64
+PSUBQ_mm SSE2 00001111 11111011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F FB /r: PSUBQ xmm1, xmm2/m128
+PSUBQ SSE2 00001111 11111011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E8 /r: PSUBSB mm, mm/m64
 PSUBSB MMX 00001111 11101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E8 /r: PSUBSB xmm1, xmm2/m128
+PSUBSB SSE2 00001111 11101000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E9 /r: PSUBSW mm, mm/m64
 PSUBSW MMX 00001111 11101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E9 /r: PSUBSW xmm1, xmm2/m128
+PSUBSW SSE2 00001111 11101001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F D8 /r: PSUBUSB mm, mm/m64
 PSUBUSB MMX 00001111 11011000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D8 /r: PSUBUSB xmm1, xmm2/m128
+PSUBUSB SSE2 00001111 11011000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F D9 /r: PSUBUSW mm, mm/m64
 PSUBUSW MMX 00001111 11011001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D9 /r: PSUBUSW xmm1, xmm2/m128
+PSUBUSW SSE2 00001111 11011001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5C /r: SUBPS xmm1, xmm2/m128
 SUBPS SSE 00001111 01011100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 5C /r: SUBPD xmm1, xmm2/m128
+SUBPD SSE2 00001111 01011100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 5C /r: SUBSS xmm1, xmm2/m32
 SUBSS SSE 00001111 01011100 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 5C /r: SUBSD xmm1, xmm2/m64
+SUBSD SSE2 00001111 01011100 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F D5 /r: PMULLW mm, mm/m64
 PMULLW MMX 00001111 11010101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D5 /r: PMULLW xmm1, xmm2/m128
+PMULLW SSE2 00001111 11010101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E5 /r: PMULHW mm, mm/m64
 PMULHW MMX 00001111 11100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E5 /r: PMULHW xmm1, xmm2/m128
+PMULHW SSE2 00001111 11100101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E4 /r: PMULHUW mm1, mm2/m64
 PMULHUW SSE 00001111 11100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E4 /r: PMULHUW xmm1, xmm2/m128
+PMULHUW SSE2 00001111 11100100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F F4 /r: PMULUDQ mm1, mm2/m64
+PMULUDQ_mm SSE2 00001111 11110100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F F4 /r: PMULUDQ xmm1, xmm2/m128
+PMULUDQ SSE2 00001111 11110100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 59 /r: MULPS xmm1, xmm2/m128
 MULPS SSE 00001111 01011001 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 59 /r: MULPD xmm1, xmm2/m128
+MULPD SSE2 00001111 01011001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 59 /r: MULSS xmm1,xmm2/m32
 MULSS SSE 00001111 01011001 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 59 /r: MULSD xmm1,xmm2/m64
+MULSD SSE2 00001111 01011001 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F F5 /r: PMADDWD mm, mm/m64
 PMADDWD MMX 00001111 11110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F5 /r: PMADDWD xmm1, xmm2/m128
+PMADDWD SSE2 00001111 11110101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5E /r: DIVPS xmm1, xmm2/m128
 DIVPS SSE 00001111 01011110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 5E /r: DIVPD xmm1, xmm2/m128
+DIVPD SSE2 00001111 01011110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 5E /r: DIVSS xmm1, xmm2/m32
 DIVSS SSE 00001111 01011110 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 5E /r: DIVSD xmm1, xmm2/m64
+DIVSD SSE2 00001111 01011110 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 53 /r: RCPPS xmm1, xmm2/m128
 RCPPS SSE 00001111 01010011 \
   !constraints { modrm($_); 1 } \
@@ -231,11 +471,21 @@ SQRTPS SSE 00001111 01010001 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 51 /r: SQRTPD xmm1, xmm2/m128
+SQRTPD SSE2 00001111 01010001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 51 /r: SQRTSS xmm1, xmm2/m32
 SQRTSS SSE 00001111 01010001 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 51 /r: SQRTSD xmm1,xmm2/m64
+SQRTSD SSE2 00001111 01010001 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 52 /r: RSQRTPS xmm1, xmm2/m128
 RSQRTPS SSE 00001111 01010010 \
   !constraints { modrm($_); 1 } \
@@ -251,56 +501,111 @@ PMINUB SSE 00001111 11011010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DA /r: PMINUB xmm1, xmm2/m128
+PMINUB SSE2 00001111 11011010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EA /r: PMINSW mm1, mm2/m64
 PMINSW SSE 00001111 11101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F EA /r: PMINSW xmm1, xmm2/m128
+PMINSW SSE2 00001111 11101010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5D /r: MINPS xmm1, xmm2/m128
 MINPS SSE 00001111 01011101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 5D /r: MINPD xmm1, xmm2/m128
+MINPD SSE2 00001111 01011101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 5D /r: MINSS xmm1,xmm2/m32
 MINSS SSE 00001111 01011101 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 5D /r: MINSD xmm1, xmm2/m64
+MINSD SSE2 00001111 01011101 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F DE /r: PMAXUB mm1, mm2/m64
 PMAXUB SSE 00001111 11011110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DE /r: PMAXUB xmm1, xmm2/m128
+PMAXUB SSE2 00001111 11011110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EE /r: PMAXSW mm1, mm2/m64
 PMAXSW SSE 00001111 11101110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F EE /r: PMAXSW xmm1, xmm2/m128
+PMAXSW SSE2 00001111 11101110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 5F /r: MAXPS xmm1, xmm2/m128
 MAXPS SSE 00001111 01011111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 5F /r: MAXPD xmm1, xmm2/m128
+MAXPD SSE2 00001111 01011111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F 5F /r: MAXSS xmm1, xmm2/m32
 MAXSS SSE 00001111 01011111 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F 5F /r: MAXSD xmm1, xmm2/m64
+MAXSD SSE2 00001111 01011111 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F E0 /r: PAVGB mm1, mm2/m64
 PAVGB SSE 00001111 11100000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E0 /r: PAVGB xmm1, xmm2/m128
+PAVGB SSE2 00001111 11100000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E3 /r: PAVGW mm1, mm2/m64
 PAVGW SSE 00001111 11100011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E3 /r: PAVGW xmm1, xmm2/m128
+PAVGW SSE2 00001111 11100011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F6 /r: PSADBW mm1, mm2/m64
 PSADBW SSE 00001111 11110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F6 /r: PSADBW xmm1, xmm2/m128
+PSADBW SSE2 00001111 11110110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Comparison Instructions
 # -----------------------
@@ -311,51 +616,101 @@ PCMPEQB MMX 00001111 01110100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 74 /r: PCMPEQB xmm1,xmm2/m128
+PCMPEQB SSE2 00001111 01110100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 75 /r: PCMPEQW mm,mm/m64
 PCMPEQW MMX 00001111 01110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 75 /r: PCMPEQW xmm1,xmm2/m128
+PCMPEQW SSE2 00001111 01110101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 76 /r: PCMPEQD mm,mm/m64
 PCMPEQD MMX 00001111 01110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 76 /r: PCMPEQD xmm1,xmm2/m128
+PCMPEQD SSE2 00001111 01110110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 64 /r: PCMPGTB mm,mm/m64
 PCMPGTB MMX 00001111 01100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 64 /r: PCMPGTB xmm1,xmm2/m128
+PCMPGTB SSE2 00001111 01100100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 65 /r: PCMPGTW mm,mm/m64
 PCMPGTW MMX 00001111 01100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 65 /r: PCMPGTW xmm1,xmm2/m128
+PCMPGTW SSE2 00001111 01100101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 66 /r: PCMPGTD mm,mm/m64
 PCMPGTD MMX 00001111 01100110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 66 /r: PCMPGTD xmm1,xmm2/m128
+PCMPGTD SSE2 00001111 01100110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8
 CMPPS SSE 00001111 11000010 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F C2 /r ib: CMPPD xmm1, xmm2/m128, imm8
+CMPPD SSE2 00001111 11000010 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8
 CMPSS SSE 00001111 11000010 \
   !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 4); }
 
+# F2 0F C2 /r ib: CMPSD xmm1, xmm2/m64, imm8
+CMPSD SSE2 00001111 11000010 \
+  !constraints { repne($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2E /r: UCOMISS xmm1, xmm2/m32
 UCOMISS SSE 00001111 00101110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# 66 0F 2E /r: UCOMISD xmm1, xmm2/m64
+UCOMISD SSE2 00001111 00101110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2F /r: COMISS xmm1, xmm2/m32
 COMISS SSE 00001111 00101111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# 66 0F 2F /r: COMISD xmm1, xmm2/m64
+COMISD SSE2 00001111 00101111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 #
 # Logical Instructions
 # --------------------
@@ -366,41 +721,81 @@ PAND MMX 00001111 11011011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DB /r: PAND xmm1, xmm2/m128
+PAND SSE2 00001111 11011011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 54 /r: ANDPS xmm1, xmm2/m128
 ANDPS SSE 00001111 01010100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 54 /r: ANDPD xmm1, xmm2/m128
+ANDPD SSE2 00001111 01010100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F DF /r: PANDN mm, mm/m64
 PANDN MMX 00001111 11011111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F DF /r: PANDN xmm1, xmm2/m128
+PANDN SSE2 00001111 11011111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 55 /r: ANDNPS xmm1, xmm2/m128
 ANDNPS SSE 00001111 01010101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 55 /r: ANDNPD xmm1, xmm2/m128
+ANDNPD SSE2 00001111 01010101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EB /r: POR mm, mm/m64
 POR MMX 00001111 11101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F EB /r: POR xmm1, xmm2/m128
+POR SSE2 00001111 11101011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 56 /r: ORPS xmm1, xmm2/m128
 ORPS SSE 00001111 01010110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 56 /r: ORPD xmm1, xmm2/m128
+ORPD SSE2 00001111 01010110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EF /r: PXOR mm, mm/m64
 PXOR MMX 00001111 11101111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F EF /r: PXOR xmm1, xmm2/m128
+PXOR SSE2 00001111 11101111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 57 /r: XORPS xmm1, xmm2/m128
 XORPS SSE 00001111 01010111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 57 /r: XORPD xmm1, xmm2/m128
+XORPD SSE2 00001111 01010111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Shift and Rotate Instructions
 # -----------------------------
@@ -411,73 +806,153 @@ PSLLW MMX 00001111 11110001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F1 /r: PSLLW xmm1, xmm2/m128
+PSLLW SSE2 00001111 11110001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F2 /r: PSLLD mm, mm/m64
 PSLLD MMX 00001111 11110010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F2 /r: PSLLD xmm1, xmm2/m128
+PSLLD SSE2 00001111 11110010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F3 /r: PSLLQ mm, mm/m64
 PSLLQ MMX 00001111 11110011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F F3 /r: PSLLQ xmm1, xmm2/m128
+PSLLQ SSE2 00001111 11110011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 71 /6 ib: PSLLW mm1, imm8
 PSLLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 71 /6 ib: PSLLW xmm1, imm8
+PSLLW_imm SSE2 00001111 01110001 \
+  !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /6 ib: PSLLD mm, imm8
 PSLLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 72 /6 ib: PSLLD xmm1, imm8
+PSLLD_imm SSE2 00001111 01110010 \
+  !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /6 ib: PSLLQ mm, imm8
 PSLLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 73 /6 ib: PSLLQ xmm1, imm8
+PSLLQ_imm SSE2 00001111 01110011 \
+  !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
+# 66 0F 73 /7 ib: PSLLDQ xmm1, imm8
+PSLLDQ_imm SSE2 00001111 01110011 \
+  !constraints { data16($_); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F D1 /r: PSRLW mm, mm/m64
 PSRLW MMX 00001111 11010001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D1 /r: PSRLW xmm1, xmm2/m128
+PSRLW SSE2 00001111 11010001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F D2 /r: PSRLD mm, mm/m64
 PSRLD MMX 00001111 11010010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D2 /r: PSRLD xmm1, xmm2/m128
+PSRLD SSE2 00001111 11010010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F D3 /r: PSRLQ mm, mm/m64
 PSRLQ MMX 00001111 11010011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F D3 /r: PSRLQ xmm1, xmm2/m128
+PSRLQ SSE2 00001111 11010011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 71 /2 ib: PSRLW mm, imm8
 PSRLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 71 /2 ib: PSRLW xmm1, imm8
+PSRLW_imm SSE2 00001111 01110001 \
+  !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /2 ib: PSRLD mm, imm8
 PSRLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 72 /2 ib: PSRLD xmm1, imm8
+PSRLD_imm SSE2 00001111 01110010 \
+  !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /2 ib: PSRLQ mm, imm8
 PSRLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 73 /2 ib: PSRLQ xmm1, imm8
+PSRLQ_imm SSE2 00001111 01110011 \
+  !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
+# 66 0F 73 /3 ib: PSRLDQ xmm1, imm8
+PSRLDQ_imm SSE2 00001111 01110011 \
+  !constraints { data16($_); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F E1 /r: PSRAW mm,mm/m64
 PSRAW MMX 00001111 11100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E1 /r: PSRAW xmm1,xmm2/m128
+PSRAW SSE2 00001111 11100001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F E2 /r: PSRAD mm,mm/m64
 PSRAD MMX 00001111 11100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F E2 /r: PSRAD xmm1,xmm2/m128
+PSRAD SSE2 00001111 11100010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 71 /4 ib: PSRAW mm,imm8
 PSRAW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 71 /4 ib: PSRAW xmm1,imm8
+PSRAW_imm SSE2 00001111 01110001 \
+  !constraints { data16($_); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /4 ib: PSRAD mm,imm8
 PSRAD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
 
+# 66 0F 72 /4 ib: PSRAD xmm1,imm8
+PSRAD_imm SSE2 00001111 01110010 \
+  !constraints { data16($_); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 #
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Gather Instructions
 # --------------------------------------------------------------------------------
@@ -488,75 +963,169 @@ PACKSSWB MMX 00001111 01100011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 63 /r: PACKSSWB xmm1, xmm2/m128
+PACKSSWB SSE2 00001111 01100011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 6B /r: PACKSSDW mm1, mm2/m64
 PACKSSDW MMX 00001111 01101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 6B /r: PACKSSDW xmm1, xmm2/m128
+PACKSSDW SSE2 00001111 01101011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 67 /r: PACKUSWB mm, mm/m64
 PACKUSWB MMX 00001111 01100111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 67 /r: PACKUSWB xmm1, xmm2/m128
+PACKUSWB SSE2 00001111 01100111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 68 /r: PUNPCKHBW mm, mm/m64
 PUNPCKHBW MMX 00001111 01101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8, align => 8); }
 
+# 66 0F 68 /r: PUNPCKHBW xmm1, xmm2/m128
+PUNPCKHBW SSE2 00001111 01101000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 69 /r: PUNPCKHWD mm, mm/m64
 PUNPCKHWD MMX 00001111 01101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 69 /r: PUNPCKHWD xmm1, xmm2/m128
+PUNPCKHWD SSE2 00001111 01101001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 6A /r: PUNPCKHDQ mm, mm/m64
 PUNPCKHDQ MMX 00001111 01101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# 66 0F 6A /r: PUNPCKHDQ xmm1, xmm2/m128
+PUNPCKHDQ SSE2 00001111 01101010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 6D /r: PUNPCKHQDQ xmm1, xmm2/m128
+PUNPCKHQDQ SSE2 00001111 01101101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 60 /r: PUNPCKLBW mm, mm/m32
 PUNPCKLBW MMX 00001111 01100000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 4); }
 
+# 66 0F 60 /r: PUNPCKLBW xmm1, xmm2/m128
+PUNPCKLBW SSE2 00001111 01100000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 61 /r: PUNPCKLWD mm, mm/m32
 PUNPCKLWD MMX 00001111 01100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 4); }
 
+# 66 0F 61 /r: PUNPCKLWD xmm1, xmm2/m128
+PUNPCKLWD SSE2 00001111 01100001 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 62 /r: PUNPCKLDQ mm, mm/m32
 PUNPCKLDQ MMX 00001111 01100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 4); }
 
+# 66 0F 62 /r: PUNPCKLDQ xmm1, xmm2/m128
+PUNPCKLDQ SSE2 00001111 01100010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 6C /r: PUNPCKLQDQ xmm1, xmm2/m128
+PUNPCKLQDQ SSE2 00001111 01101100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128
 UNPCKLPS SSE 00001111 00010100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 14 /r: UNPCKLPD xmm1, xmm2/m128
+UNPCKLPD SSE2 00001111 00010100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128
 UNPCKHPS SSE 00001111 00010101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F 15 /r: UNPCKHPD xmm1, xmm2/m128
+UNPCKHPD SSE2 00001111 00010101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8
 PSHUFW SSE 00001111 01110000 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# F2 0F 70 /r ib: PSHUFLW xmm1, xmm2/m128, imm8
+PSHUFLW SSE2 00001111 01110000 \
+  !constraints { repne($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 70 /r ib: PSHUFHW xmm1, xmm2/m128, imm8
+PSHUFHW SSE2 00001111 01110000 \
+  !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 70 /r ib: PSHUFD xmm1, xmm2/m128, imm8
+PSHUFD SSE2 00001111 01110000 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8
 SHUFPS SSE 00001111 11000110 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# 66 0F C6 /r ib: SHUFPD xmm1, xmm2/m128, imm8
+SHUFPD SSE2 00001111 11000110 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8
 PINSRW SSE 00001111 11000100 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 2); }
 
+# 66 0F C4 /r ib: PINSRW xmm, r32/m16, imm8
+PINSRW SSE2 00001111 11000100 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 2); }
+
 # NP 0F C5 /r ib: PEXTRW reg, mm, imm8
 PEXTRW_reg SSE 00001111 11000101 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# 66 0F C5 /r ib: PEXTRW reg, xmm, imm8
+PEXTRW_reg SSE2 00001111 11000101 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 #
 # Conversion Instructions
 # -----------------------
@@ -567,16 +1136,141 @@ CVTPI2PS SSE 00001111 00101010 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# F3 0F 2A /r: CVTSI2SS xmm1,r/m32
+CVTSI2SS SSE2 00001111 00101010 \
+  !constraints { rep($_); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
+# F3 REX.W 0F 2A /r: CVTSI2SS xmm1,r/m64
+CVTSI2SS_64 SSE2 00001111 00101010 \
+  !constraints { rep($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
+# 66 0F 2A /r: CVTPI2PD xmm, mm/m64
+CVTPI2PD SSE2 00001111 00101010 \
+  !constraints { data16($_); modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# F2 0F 2A /r: CVTSI2SD xmm1,r32/m32
+CVTSI2SD SSE2 00001111 00101010 \
+  !constraints { repne($_); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
+# F2 REX.W 0F 2A /r: CVTSI2SD xmm1,r/m64
+CVTSI2SD_64 SSE2 00001111 00101010 \
+  !constraints { repne($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
 # NP 0F 2D /r: CVTPS2PI mm, xmm/m64
 CVTPS2PI SSE 00001111 00101101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
   !memory { load(size => 8); }
 
+# F3 0F 2D /r: CVTSS2SI r32,xmm1/m32
+CVTSS2SI SSE2 00001111 00101101 \
+  !constraints { rep($_); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# F3 REX.W 0F 2D /r: CVTSS2SI r64,xmm1/m32
+CVTSS2SI_64 SSE2 00001111 00101101 \
+  !constraints { rep($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# 66 0F 2D /r: CVTPD2PI mm, xmm/m128
+CVTPD2PI SSE2 00001111 00101101 \
+  !constraints { data16($_); modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F2 0F 2D /r: CVTSD2SI r32,xmm1/m64
+CVTSD2SI SSE2 00001111 00101101 \
+  !constraints { repne($_); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# F2 REX.W 0F 2D /r: CVTSD2SI r64,xmm1/m64
+CVTSD2SI_64 SSE2 00001111 00101101 \
+  !constraints { repne($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
 # NP 0F 2C /r: CVTTPS2PI mm, xmm/m64
 CVTTPS2PI SSE 00001111 00101100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
   !memory { load(size => 8); }
 
+# F3 0F 2C /r: CVTTSS2SI r32,xmm1/m32
+CVTTSS2SI SSE2 00001111 00101100 \
+  !constraints { rep($_); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# F3 REX.W 0F 2C /r: CVTTSS2SI r64,xmm1/m32
+CVTTSS2SI_64 SSE2 00001111 00101100 \
+  !constraints { rep($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# 66 0F 2C /r: CVTTPD2PI mm, xmm/m128
+CVTTPD2PI SSE2 00001111 00101100 \
+  !constraints { data16($_); modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F2 0F 2C /r: CVTTSD2SI r32,xmm1/m64
+CVTTSD2SI SSE2 00001111 00101100 \
+  !constraints { repne($_); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# F2 REX.W 0F 2C /r: CVTTSD2SI r64,xmm1/m64
+CVTTSD2SI_64 SSE2 00001111 00101100 \
+  !constraints { repne($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# F2 0F E6 /r: CVTPD2DQ xmm1, xmm2/m128
+CVTPD2DQ SSE2 00001111 11100110 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F E6 /r: CVTTPD2DQ xmm1, xmm2/m128
+CVTTPD2DQ SSE2 00001111 11100110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F E6 /r: CVTDQ2PD xmm1, xmm2/m64
+CVTDQ2PD SSE2 00001111 11100110 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 5A /r: CVTPS2PD xmm1, xmm2/m64
+CVTPS2PD SSE2 00001111 01011010 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# 66 0F 5A /r: CVTPD2PS xmm1, xmm2/m128
+CVTPD2PS SSE2 00001111 01011010 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5A /r: CVTSS2SD xmm1, xmm2/m32
+CVTSS2SD SSE2 00001111 01011010 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# F2 0F 5A /r: CVTSD2SS xmm1, xmm2/m64
+CVTSD2SS SSE2 00001111 01011010 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 5B /r: CVTDQ2PS xmm1, xmm2/m128
+CVTDQ2PS SSE2 00001111 01011011 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 5B /r: CVTPS2DQ xmm1, xmm2/m128
+CVTPS2DQ SSE2 00001111 01011011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5B /r: CVTTPS2DQ xmm1, xmm2/m128
+CVTTPS2DQ SSE2 00001111 01011011 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 # ---------------------------------------------------------------------
@@ -587,16 +1281,41 @@ MASKMOVQ SSE 00001111 11110111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} } \
   !memory { load(size => 8, base => REG_RDI, rollback => 1); }
 
+# 66 0F F7 /r: MASKMOVDQU xmm1, xmm2
+MASKMOVDQU SSE2 00001111 11110111 \
+  !constraints { data16($_); modrm($_); defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16, base => REG_RDI, rollback => 1); }
+
 # NP 0F 2B /r: MOVNTPS m128, xmm1
 MOVNTPS SSE 00001111 00101011 \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# 66 0F 2B /r: MOVNTPD m128, xmm1
+MOVNTPD SSE2 00001111 00101011 \
+  !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
+# NP 0F C3 /r: MOVNTI m32, r32
+MOVNTI SSE2 00001111 11000011 \
+  !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg} } \
+  !memory { store(size => 4); }
+
+# NP REX.W + 0F C3 /r: MOVNTI m64, r64
+MOVNTI_64 SSE2 00001111 11000011 \
+  !constraints { rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg} } \
+  !memory { store(size => 8); }
+
 # NP 0F E7 /r: MOVNTQ m64, mm
 MOVNTQ SSE 00001111 11100111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; !defined $_->{modrm}{reg2} } \
   !memory { store(size => 8); }
 
+# 66 0F E7 /r: MOVNTDQ m128, xmm1
+MOVNTDQ SSE2 00001111 11100111 \
+  !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
 # 0F 18 /1: PREFETCHT0 m8
 PREFETCHT0 SSE 00001111 00011000 \
   !constraints { modrm($_, reg => 1); !defined $_->{modrm}{reg2} } \
@@ -617,9 +1336,24 @@ PREFETCHNTA SSE 00001111 00011000 \
   !constraints { modrm($_, reg => 0); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 1); }
 
+# NP 0F AE /7: CLFLUSH m8
+CLFLUSH SSE2 00001111 10101110 \
+  !constraints { modrm($_, reg => 7); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 1); }
+
 # NP 0F AE F8: SFENCE
 SFENCE SSE 00001111 10101110 11111000
 
+# NP 0F AE E8: LFENCE
+LFENCE SSE2 00001111 10101110 11101000
+
+# NP 0F AE F0: MFENCE
+MFENCE SSE2 00001111 10101110 11110000
+
+# F3 90: PAUSE
+PAUSE SSE2 10010000 \
+  !constraints { rep($_); 1 }
+
 #
 # State Management Instructions
 # -----------------------------
-- 
2.20.1


