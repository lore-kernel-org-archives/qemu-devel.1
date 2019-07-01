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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2062C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED5820B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxIoAsAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED5820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoAX-0005Nq-Lt
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2s-0004z3-Rq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2r-0004Wn-Ak
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:02 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2r-0004WZ-58
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:01 -0400
Received: by mail-yb1-xb42.google.com with SMTP id t10so1472891ybk.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zOc+qBYBAvDXJhUjHoXcBW1/DkIntljEUehOr9ED8kY=;
 b=cxIoAsArcYsJa3VmAOrBKFKjnB7fGjyS4pef0aquzIMCPAIe4wfSDH6PA0kItWvqKn
 RuH+ynKQ1/hQtK3rN8FyO+oztw47ws9NWJ8VcXbnfu+uyr6kt84DuLV148YzJHtHGHCX
 PQEtNjsELFtxn665lxNVl2Z1YnESpi1L+LR52/+CQq3iX0DEDTgMmdVqsAJ5FXj5OoCW
 NLUHbjh2OUunvFntajEeJB9dfPU2N/B57ucun1ty/NiPTk/mh5TFjMDVMeFQjHhM3ox0
 YAQe6vX1VG7yWz9jPTc+vqgl38Dm0OX//qpRwavWTYBsdBCQbOI67nEVD3Te6fSQ13Xd
 vGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zOc+qBYBAvDXJhUjHoXcBW1/DkIntljEUehOr9ED8kY=;
 b=LDyOfo/QI8YHGHcNVPs86GHqmjizvnCATY9hfdVZdBKin7HXVDjNiM1aGlnNIVJh6c
 Jqjv6lJgVLP0sJSEB3zdIeTgldomZTkynE7Hl9CLR5hDzOIczd6pkxSgvPBwvwtH/rNz
 JROfPdshT3vsAaEs57w4XncWJU+yh/AKblC98n3/04TbO9EjgnvviQpAHKWCHk+R0uJD
 tA6c9zLnK+hUJl1BYGYdqm1ib+ivqtFMDBz9qtCUbrD80fg+p5qBdEk42HYuFOoZm5gx
 fUGfD5mtgA+7hMFvJygKPCD2WmlnZXbnhgfCHStIqST7wFbvAYXsSMImn1EQhRSONioP
 tl0w==
X-Gm-Message-State: APjAAAXAarxxyLneu0G5L+AXkATHT/Tyhu4dMkT6htY0VniARgpZTWH0
 DJ2W4N8KdmxMLomkH+0leS+FpJDh
X-Google-Smtp-Source: APXvYqzW1cKjW9oZVItnxPzAXrIqFub5vM4TWgR52mRjqjyFh94ZatFU9ZNrZUyxX5vW2dAHdeD8Rg==
X-Received: by 2002:a25:b307:: with SMTP id l7mr13456066ybj.375.1561955760536; 
 Sun, 30 Jun 2019 21:36:00 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:59 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:29 -0400
Message-Id: <20190701043536.26019-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU RFC PATCH v2 07/14] x86.risu: add SSE
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

Add SSE instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/x86.risu b/x86.risu
index f2dd9b0..c29b210 100644
--- a/x86.risu
+++ b/x86.risu
@@ -19,6 +19,18 @@ MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MO
 MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVQ_mm         MMX     00001111 011 d 1111 !emit { modrm(); mem(size => 8); }
 
+MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
+MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
+MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
+
+MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVHPS          SSE     00001111 0001011 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod => MOD_DIRECT); }
+MOVHLPS         SSE     00001111 00010010  !emit { modrm(mod => MOD_DIRECT); }
+
+PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+MOVMSKPS        SSE     00001111 01010000 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+
 # Arithmetic Instructions
 PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
 PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
@@ -29,6 +41,9 @@ PADDSW          MMX     00001111 11101101 !emit { modrm(); mem(size => 8); }
 PADDUSB         MMX     00001111 11011100 !emit { modrm(); mem(size => 8); }
 PADDUSW         MMX     00001111 11011101 !emit { modrm(); mem(size => 8); }
 
+ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
+ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
+
 PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
 PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
 PSUBD           MMX     00001111 11111010 !emit { modrm(); mem(size => 8); }
@@ -37,11 +52,47 @@ PSUBSW          MMX     00001111 11101001 !emit { modrm(); mem(size => 8); }
 PSUBUSB         MMX     00001111 11011000 !emit { modrm(); mem(size => 8); }
 PSUBUSW         MMX     00001111 11011001 !emit { modrm(); mem(size => 8); }
 
+SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
+SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
+
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
+PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
+
+MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
+MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
 
 PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
 
+DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
+DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
+
+RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
+RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
+
+SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
+SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
+
+RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
+RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
+
+PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
+PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
+
+MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
+MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
+
+PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
+PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
+
+MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
+MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
+
+PAVGB           SSE     00001111 11100000 !emit { modrm(); mem(size => 8); }
+PAVGW           SSE     00001111 11100011 !emit { modrm(); mem(size => 8); }
+
+PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
+
 # Comparison Instructions
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
 PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
@@ -50,11 +101,24 @@ PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
 PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
 PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
 
+CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
+
+UCOMISS         SSE     00001111 00101110 !emit { modrm(); mem(size => 4); }
+COMISS          SSE     00001111 00101111 !emit { modrm(); mem(size => 4); }
+
 # Logical Instructions
 PAND            MMX     00001111 11011011 !emit { modrm(); mem(size => 8); }
+ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
+
 PANDN           MMX     00001111 11011111 !emit { modrm(); mem(size => 8); }
+ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
+
 POR             MMX     00001111 11101011 !emit { modrm(); mem(size => 8); }
+ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
+
 PXOR            MMX     00001111 11101111 !emit { modrm(); mem(size => 8); }
+XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
 
 # Shift and Rotate Instructions
 PSLLW           MMX     00001111 11110001 !emit { modrm(); mem(size => 8); }
@@ -92,5 +156,41 @@ PUNPCKLBW       MMX     00001111 01100000 !emit { modrm(); mem(size => 4); }
 PUNPCKLWD       MMX     00001111 01100001 !emit { modrm(); mem(size => 4); }
 PUNPCKLDQ       MMX     00001111 01100010 !emit { modrm(); mem(size => 4); }
 
+UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
+
+PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
+SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
+PINSRW          SSE     00001111 11000100 !emit { modrm(); mem(size => 2); imm(size => 1); }
+PEXTRW_reg      SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
+
+# Conversion Instructions
+CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
+CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
+CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
+
+CVTPS2PI        SSE     00001111 00101101 !emit { modrm(); mem(size => 8); }
+CVTSS2SI        SSE     00001111 00101101 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTSS2SI_64     SSE     00001111 00101101 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+
+CVTTPS2PI       SSE     00001111 00101100 !emit { modrm(); mem(size => 8); }
+CVTTSS2SI       SSE     00001111 00101100 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTSS2SI_64    SSE     00001111 00101100 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+
+# Cacheability Control, Prefetch, and Instruction Ordering Instructions
+MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
+MOVNTPS         SSE     00001111 00101011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+
+PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
+PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
+PREFETCHT2      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 1); }
+PREFETCHNTA     SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 0); mem(size => 1); }
+SFENCE          SSE     00001111 10101110 !emit { modrm(mod => MOD_DIRECT, reg => 7); }
+
 # State Management Instructions
 EMMS            MMX     00001111 01110111 !emit { }
+
+# LDMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 4); }
+STMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 4); }
-- 
2.20.1


