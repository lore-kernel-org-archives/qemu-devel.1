Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06523C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F7F20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYBghSEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F7F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoDZ-0007o7-Jw
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56687)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2v-00055V-SH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2s-0004Xc-RF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:05 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2s-0004XR-KD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:02 -0400
Received: by mail-yb1-xb42.google.com with SMTP id x4so1216828ybk.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G3OM+qLNzefR6qfzvB9q2uqTDaZ0LvxdDZW1L1Hv1gc=;
 b=aYBghSEcyc/Q6Muja8vDLtIlijrsNc1BrFA3rPsytJ8PynwkgBjAg3yqfCN3tNQIKl
 6jVgjmx7uAe3eEPWkZ0AlALmpMIsVakxPRx1ULnLvuxcK4a2HGTvzgjHQHo5lefT94J9
 DJSAghq8JcbLnIGZKK+93VluWbsYX/HhTTQbT5j+Veo9T9Rwlays0jqYW+udDfXS8ZXJ
 HHXaj8VQ0Vf8wUeTYdT//nYStnNyMrKSjXx9FAdLrt4+giSsVz2Gr6NAXON0XKEP4eg/
 IgimT3durvbLUnzMHEGkLbYkMxPsKxqkOOve61/q9Swn4xrN7CR3DRjqLM1KTgEuh/lL
 zkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G3OM+qLNzefR6qfzvB9q2uqTDaZ0LvxdDZW1L1Hv1gc=;
 b=p2ZuRYzXzEr4EuS8E18gWFL1oO2kCb1h65+4gJVto/LTzMjqKvx/xylnR4xozeG695
 rq5A5yu6eb3ri/vNzooGuyddi3fUXg0mvhWj8x2Jqok5IMXat8/uUyTwxiB0M96zB3AB
 xwBbV9moMI3v8pIS6eNHiNnSZ2ktrG67MEMkzSVoG2E59YFxOLMx5sjkzSWLSXZHpbDg
 ZOPyUAmu3H7rYSMy4MBI+e1IHe6TYhYJlscP8hGtOAUCqR5DQyParlEj3D7urlSDeq+2
 WxCvwTIgA9HKnA8rGefgwB5tamB0UZ/royomGV97lIRvhEnDVY+sUY38sfSXK6cVjp5l
 WhMA==
X-Gm-Message-State: APjAAAUjD/htDgM33SZuBD4wC89kZ1O+CmW1SZ1BUIWOXYCfzDZQVgzK
 5HclnWkiFJFe4JqMwjKp811sgDpc
X-Google-Smtp-Source: APXvYqxVSTPMWfATm+Y47rDE+aBen7C5TbJBj+P8f6Qsljm3WgiCYD0k35sN6QdcCUex5z2/H0NLCw==
X-Received: by 2002:a25:e742:: with SMTP id e63mr2803004ybh.417.1561955761493; 
 Sun, 30 Jun 2019 21:36:01 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:01 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:30 -0400
Message-Id: <20190701043536.26019-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU RFC PATCH v2 08/14] x86.risu: add SSE2
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

Add SSE2 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/x86.risu b/x86.risu
index c29b210..9b63d6b 100644
--- a/x86.risu
+++ b/x86.risu
@@ -15,179 +15,332 @@
 # Data Transfer Instructions
 MOVD            MMX     00001111 011 d 1110 !emit { modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
 MOVD_mem        MMX     00001111 011 d 1110 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
+MOVD            SSE2    00001111 011 d 1110 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+MOVD_mem        SSE2    00001111 011 d 1110 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
 MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVQ            SSE2    00001111 011 d 1110 !emit { data16(); rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+MOVQ_mem        SSE2    00001111 011 d 1110 !emit { data16(); rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVQ_mm         MMX     00001111 011 d 1111 !emit { modrm(); mem(size => 8); }
+MOVQ_xmm1       SSE2    00001111 01111110 !emit { rep(); modrm(); mem(size => 8); }
+MOVQ_xmm2       SSE2    00001111 11010110 !emit { data16(); modrm(); mem(size => 8); }
 
 MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
+MOVAPD          SSE2    00001111 0010100 d !emit { data16(); modrm(); mem(size => 16, align => 16); }
+MOVDQA          SSE2    00001111 011 d 1111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
+MOVUPD          SSE2    00001111 0001000 d !emit { data16(); modrm(); mem(size => 16); }
+MOVDQU          SSE2    00001111 011 d 1111 !emit { rep(); modrm(); mem(size => 16); }
 MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
+MOVSD           SSE2    00001111 0001000 d !emit { repne(); modrm(); mem(size => 8); }
+
+MOVQ2DQ         SSE2    00001111 11010110 !emit { rep(); modrm(mod => MOD_DIRECT); }
+MOVDQ2Q         SSE2    00001111 11010110 !emit { repne(); modrm(mod => MOD_DIRECT); }
 
 MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVLPD          SSE2    00001111 0001001 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVHPS          SSE     00001111 0001011 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVHPD          SSE2    00001111 0001011 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod => MOD_DIRECT); }
 MOVHLPS         SSE     00001111 00010010  !emit { modrm(mod => MOD_DIRECT); }
 
 PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+PMOVMSKB        SSE2    00001111 11010111 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMSKPS        SSE     00001111 01010000 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+MOVMKSPD        SSE2    00001111 01010000 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 
 # Arithmetic Instructions
 PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
+PADDB           SSE2    00001111 11111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
+PADDW           SSE2    00001111 11111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size => 8); }
+PADDD           SSE2    00001111 11111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size => 8); }
+PADDQ           SSE2    00001111 11010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDSB          MMX     00001111 11101100 !emit { modrm(); mem(size => 8); }
+PADDSB          SSE2    00001111 11101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDSW          MMX     00001111 11101101 !emit { modrm(); mem(size => 8); }
+PADDSW          SSE2    00001111 11101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDUSB         MMX     00001111 11011100 !emit { modrm(); mem(size => 8); }
+PADDUSB         SSE2    00001111 11011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PADDUSW         MMX     00001111 11011101 !emit { modrm(); mem(size => 8); }
+PADDUSW         SSE2    00001111 11011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
+ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size => 16, align => 16) }
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
+ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 8); }
 
 PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
+PSUBB           SSE2    00001111 11111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
+PSUBW           SSE2    00001111 11111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBD           MMX     00001111 11111010 !emit { modrm(); mem(size => 8); }
+PSUBD           SSE2    00001111 11111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBQ_64        SSE2    00001111 11111011 !emit { modrm(); mem(size => 8); }
+PSUBQ           SSE2    00001111 11111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBSB          MMX     00001111 11101000 !emit { modrm(); mem(size => 8); }
+PSUBSB          SSE2    00001111 11101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBSW          MMX     00001111 11101001 !emit { modrm(); mem(size => 8); }
+PSUBSW          SSE2    00001111 11101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBUSB         MMX     00001111 11011000 !emit { modrm(); mem(size => 8); }
+PSUBUSB         SSE2    00001111 11011000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBUSW         MMX     00001111 11011001 !emit { modrm(); mem(size => 8); }
+PSUBUSW         SSE2    00001111 11011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
+SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
+SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 8); }
 
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
+PMULLW          SSE2    00001111 11010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
+PMULHW          SSE2    00001111 11100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
+PMULHUW         SSE2    00001111 11100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
+PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
+MULPD           SSE2    00001111 01011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
+MULSD           SSE2    00001111 01011001 !emit { repne(); modrm(); mem(size => 8); }
 
 PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
+PMADDWD         SSE2    00001111 11110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
+DIVPD           SSE2    00001111 01011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
+DIVSD           SSE2    00001111 01011110 !emit { repne(); modrm(); mem(size => 8); }
 
 RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
 RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
 
 SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
+SQRTPD          SSE2    00001111 01010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
+SQRTSD          SSE2    00001111 01010001 !emit { repne(); modrm(); mem(size => 8); }
 
 RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
 RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
 
 PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
+PMINUB          SSE2    00001111 11011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
+PMINSW          SSE2    00001111 11101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
+MINPD           SSE2    00001111 01011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
+MINSD           SSE2    00001111 01011101 !emit { repne(); modrm(); mem(size => 8); }
 
 PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
+PMAXUB          SSE2    00001111 11011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
+PMAXSW          SSE2    00001111 11101110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
+MAXPD           SSE2    00001111 01011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
+MAXSD           SSE2    00001111 01011111 !emit { repne(); modrm(); mem(size => 8); }
 
 PAVGB           SSE     00001111 11100000 !emit { modrm(); mem(size => 8); }
+PAVGB           SSE2    00001111 11100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PAVGW           SSE     00001111 11100011 !emit { modrm(); mem(size => 8); }
+PAVGW           SSE2    00001111 11100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
+PSADBW          SSE2    00001111 11110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 # Comparison Instructions
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
+PCMPEQB         SSE2    00001111 01110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
+PCMPEQW         SSE2    00001111 01110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPEQD         MMX     00001111 01110110 !emit { modrm(); mem(size => 8); }
+PCMPEQD         SSE2    00001111 01110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
+PCMPGTB         SSE2    00001111 01100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
+PCMPGTW         SSE2    00001111 01100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
+PCMPGTD         SSE2    00001111 01100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+CMPPD           SSE2    00001111 11000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
+CMPSD           SSE2    00001111 11000010 !emit { repne(); modrm(); mem(size => 8); imm(size => 1); }
 
 UCOMISS         SSE     00001111 00101110 !emit { modrm(); mem(size => 4); }
+UCOMISD         SSE2    00001111 00101110 !emit { data16(); modrm(); mem(size => 8); }
+
 COMISS          SSE     00001111 00101111 !emit { modrm(); mem(size => 4); }
+COMISD          SSE2    00001111 00101111 !emit { data16(); modrm(); mem(size => 8); }
 
 # Logical Instructions
 PAND            MMX     00001111 11011011 !emit { modrm(); mem(size => 8); }
+PAND            SSE2    00001111 11011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
+ANDPD           SSE2    00001111 01010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PANDN           MMX     00001111 11011111 !emit { modrm(); mem(size => 8); }
+PANDN           SSE2    00001111 11011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
+ANDNPD          SSE2    00001111 01010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 POR             MMX     00001111 11101011 !emit { modrm(); mem(size => 8); }
+POR             SSE2    00001111 11101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
+ORPD            SSE2    00001111 01010110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PXOR            MMX     00001111 11101111 !emit { modrm(); mem(size => 8); }
+PXOR            SSE2    00001111 11101111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
+XORPD           SSE2    00001111 01010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 # Shift and Rotate Instructions
 PSLLW           MMX     00001111 11110001 !emit { modrm(); mem(size => 8); }
+PSLLW           SSE2    00001111 11110001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSLLD           MMX     00001111 11110010 !emit { modrm(); mem(size => 8); }
+PSLLD           SSE2    00001111 11110010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSLLQ           MMX     00001111 11110011 !emit { modrm(); mem(size => 8); }
+PSLLQ           SSE2    00001111 11110011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSLLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
 
 PSLLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 
 PSRLW           MMX     00001111 11010001 !emit { modrm(); mem(size => 8); }
+PSRLW           SSE2    00001111 11010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSRLD           MMX     00001111 11010010 !emit { modrm(); mem(size => 8); }
+PSRLD           SSE2    00001111 11010010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSRLQ           MMX     00001111 11010011 !emit { modrm(); mem(size => 8); }
+PSRLQ           SSE2    00001111 11010011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
 
 PSRLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 
 PSRAW           MMX     00001111 11100001 !emit { modrm(); mem(size => 8); }
+PSRAW           SSE2    00001111 11100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSRAD           MMX     00001111 11100010 !emit { modrm(); mem(size => 8); }
+PSRAD           SSE2    00001111 11100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PSRAW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+PSRAW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+PSRAD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Scatter Instructions
 PACKSSWB        MMX     00001111 01100011 !emit { modrm(); mem(size => 8); }
+PACKSSWB        SSE2    00001111 01100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PACKSSDW        MMX     00001111 01101011 !emit { modrm(); mem(size => 8); }
+PACKSSDW        SSE2    00001111 01101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PACKUSWB        MMX     00001111 01100111 !emit { modrm(); mem(size => 8); }
+PACKUSWB        SSE2    00001111 01100111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PUNPCKHBW       MMX     00001111 01101000 !emit { modrm(); mem(size => 8); }
+PUNPCKHBW       SSE2    00001111 01101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PUNPCKHWD       MMX     00001111 01101001 !emit { modrm(); mem(size => 8); }
+PUNPCKHWD       SSE2    00001111 01101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PUNPCKHDQ       MMX     00001111 01101010 !emit { modrm(); mem(size => 8); }
+PUNPCKHDQ       SSE2    00001111 01101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKHQDQ      SSE2    00001111 01101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PUNPCKLBW       MMX     00001111 01100000 !emit { modrm(); mem(size => 4); }
+PUNPCKLBW       SSE2    00001111 01100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PUNPCKLWD       MMX     00001111 01100001 !emit { modrm(); mem(size => 4); }
+PUNPCKLWD       SSE2    00001111 01100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PUNPCKLDQ       MMX     00001111 01100010 !emit { modrm(); mem(size => 4); }
+PUNPCKLDQ       SSE2    00001111 01100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKLQDQ      SSE2    00001111 01101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKLPD        SSE2    00001111 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKHPD        SSE2    00001111 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
+PSHUFLW         SSE2    00001111 01110000 !emit { repne(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+PSHUFHW         SSE2    00001111 01110000 !emit { rep(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+PSHUFD          SSE2    00001111 01110000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
 SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+SHUFPD          SSE2    00001111 11000110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 
 PINSRW          SSE     00001111 11000100 !emit { modrm(); mem(size => 2); imm(size => 1); }
+PINSRW          SSE2    00001111 11000100 !emit { data16(); modrm(); mem(size => 2); imm(size => 1); }
+
 PEXTRW_reg      SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
+PEXTRW_reg      SSE2    00001111 11000101 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 
 # Conversion Instructions
 CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
 CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
 CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
+CVTPI2PD        SSE2    00001111 00101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTSI2SD        SSE2    00001111 00101010 !emit { repne(); modrm(); mem(size => 4); }
+CVTSI2SD_64     SSE2    00001111 00101010 !emit { repne(); rex(w => 1); modrm(); mem(size => 8); }
 
 CVTPS2PI        SSE     00001111 00101101 !emit { modrm(); mem(size => 8); }
 CVTSS2SI        SSE     00001111 00101101 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTSS2SI_64     SSE     00001111 00101101 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTPD2PI        SSE2    00001111 00101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTSD2SI        SSE2    00001111 00101101 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
+CVTSD2SI_64     SSE2    00001111 00101101 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
 
 CVTTPS2PI       SSE     00001111 00101100 !emit { modrm(); mem(size => 8); }
 CVTTSS2SI       SSE     00001111 00101100 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTTSS2SI_64    SSE     00001111 00101100 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTPD2PI       SSE2    00001111 00101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTTSD2SI       SSE2    00001111 00101100 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
+CVTTSD2SI_64    SSE2    00001111 00101100 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
+
+CVTPD2DQ        SSE2    00001111 11100110 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+CVTTPD2DQ       SSE2    00001111 11100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTDQ2PD        SSE2    00001111 11100110 !emit { rep(); modrm(); mem(size => 8); }
+
+CVTPS2PD        SSE2    00001111 01011010 !emit { modrm(); mem(size => 8); }
+CVTPD2PS        SSE2    00001111 01011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTSS2SD        SSE2    00001111 01011010 !emit { rep(); modrm(); mem(size => 4); }
+CVTSD2SS        SSE2    00001111 01011010 !emit { repne(); modrm(); mem(size => 8); }
+
+CVTDQ2PS        SSE2    00001111 01011011 !emit { modrm(); mem(size => 16, align => 16); }
+CVTPS2DQ        SSE2    00001111 01011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTTPS2DQ       SSE2    00001111 01011011 !emit { rep(); modrm(); mem(size => 16, align => 16); }
 
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
+MASKMOVDQU      SSE2    00001111 11110111 !emit { data16(); modrm(mod => MOD_DIRECT); mem(size => 16, base => REG_EDI); }
+
 MOVNTPS         SSE     00001111 00101011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+MOVNTPD         SSE2    00001111 00101011 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+
+MOVNTI          SSE2    00001111 11000011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
+MOVNTI_64       SSE2    00001111 11000011 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVNTDQ         SSE2    00001111 11100111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 
 PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
 PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
 PREFETCHT2      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 1); }
 PREFETCHNTA     SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 0); mem(size => 1); }
+CFLUSH          SSE2    00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 7); mem(size => 1); }
 SFENCE          SSE     00001111 10101110 !emit { modrm(mod => MOD_DIRECT, reg => 7); }
+LFENCE          SSE2    00001111 10101110 !emit { modrm(mod => 0b11, reg => 0b101); }
+MFENCE          SSE2    00001111 10101110 !emit { modrm(mod => 0b11, reg => 0b111); }
+PAUSE           SSE2    10010000          !emit { rep(); }
 
 # State Management Instructions
 EMMS            MMX     00001111 01110111 !emit { }
-- 
2.20.1


