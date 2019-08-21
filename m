Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D03C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9495221655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdWPU2L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9495221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VH8-0007C4-Kp
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URm-0001gt-Gr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0008EL-M8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:58 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:42662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00088d-NN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:54 -0400
Received: by mail-yw1-xc44.google.com with SMTP id z63so1230594ywz.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o7fOGW+Cc55NYFbvUmZ6fMX/JBD2BN8yXcVO5+NI94E=;
 b=PdWPU2L9E7OaEJmp72M5OsZfdqCyF4mWin21qcWlPayrA/oMPRyyOUWI/Jh2cPE62k
 K0brP6papVg2w9CY0gX4YkzTEbEbm0hQDyekEEDu72OeUyZQbFckic9e+9rqnxXfC7MR
 YHESZjHNQGEO5Sx0iQRQJlX773LxRSk9BzzTXOsL5CDXn8Qln89aHwov4WgoEjsXDoCW
 ZJtGrBJmSL4v2D8rcHc1EiYIXDL1/yq/mWC+/opkn1Xlgkngj0kOsdDXqYadbSEUNtCC
 lIVSH3xfuhj5vMzYYQLdxpBpd0fr4RiM0jBR4BePZ8XxlCOp3vp3kUWshTSuzAiJr7Rd
 jYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o7fOGW+Cc55NYFbvUmZ6fMX/JBD2BN8yXcVO5+NI94E=;
 b=KE9Pr4rcK/E0CJe+oYsU+dEeYq0uBXo93UOqLSZx/SFWTFYeeOcieiXxygW5XaQ5qP
 EBqQ0A7nSSLgJ2YMsEEiRiSL20m3053kdBMgpFxUeyKtW8bHejpO2lkhmFjaqSWtfkTe
 8xtuMjF1r3l5bEIIwVhzodXeKKX1NGNEjVh1Oa7iCG8MGiZeJqoSWP0/hQcAPntZvJRm
 dWAc/jy6nCDwhk/Xbd3jaQ/rbh7AVQEI8pOMMKPlwUFXpTOYikA/GMcLZr6zR1E4GHNp
 mjlOS2TlvOgjHmVx4y/khKByz9PrS8WQHw9tKTfZnnpz7/AaBnuxTZttip5tX/ZgdP6t
 Cr9w==
X-Gm-Message-State: APjAAAWmPRLBdsbDSoEdx7nyEUD7Bjp5YBTe9S9X6rB5jihVGD4gUm1e
 KJnR02DICSHe3ttdUBjWX0UKHmqz
X-Google-Smtp-Source: APXvYqyR68239eN/8fMmsOT6tiDgBPegwz6Vab3+Qvg8CRy0sX8PX0BDjJFFMwWpzsz3Jv2Icgs2RA==
X-Received: by 2002:a81:5793:: with SMTP id
 l141mr23225148ywb.175.1566408650787; 
 Wed, 21 Aug 2019 10:30:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:50 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:29 -0400
Message-Id: <20190821172951.15333-54-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 53/75] target/i386: introduce SSE4.1
 vector instructions to sse-opcode.inc.h
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

Add all the SSE4.1 vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index d8ea71aa6c..9682cce7ef 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -389,6 +389,58 @@
  * 66 0F 3A 0F /r ib       PALIGNR xmm1, xmm2/m128, imm8
  * NP 0F 38 00 /r          PSHUFB mm1, mm2/m64
  * 66 0F 38 00 /r          PSHUFB xmm1, xmm2/m128
+ *
+ * SSE4.1 Instructions
+ * --------------------
+ * 66 0F 38 40 /r          PMULLD xmm1, xmm2/m128
+ * 66 0F 38 28 /r          PMULDQ xmm1, xmm2/m128
+ * 66 0F 38 3A /r          PMINUW xmm1, xmm2/m128
+ * 66 0F 38 3B /r          PMINUD xmm1, xmm2/m128
+ * 66 0F 38 38 /r          PMINSB xmm1, xmm2/m128
+ * 66 0F 38 39 /r          PMINSD xmm1, xmm2/m128
+ * 66 0F 38 41 /r          PHMINPOSUW xmm1, xmm2/m128
+ * 66 0F 38 3E /r          PMAXUW xmm1, xmm2/m128
+ * 66 0F 38 3F /r          PMAXUD xmm1, xmm2/m128
+ * 66 0F 38 3C /r          PMAXSB xmm1, xmm2/m128
+ * 66 0F 38 3D /r          PMAXSD xmm1, xmm2/m128
+ * 66 0F 3A 42 /r ib       MPSADBW xmm1, xmm2/m128, imm8
+ * 66 0F 3A 40 /r ib       DPPS xmm1, xmm2/m128, imm8
+ * 66 0F 3A 41 /r ib       DPPD xmm1, xmm2/m128, imm8
+ * 66 0F 3A 08 /r ib       ROUNDPS xmm1, xmm2/m128, imm8
+ * 66 0F 3A 09 /r ib       ROUNDPD xmm1, xmm2/m128, imm8
+ * 66 0F 3A 0A /r ib       ROUNDSS xmm1, xmm2/m32, imm8
+ * 66 0F 3A 0B /r ib       ROUNDSD xmm1, xmm2/m64, imm8
+ * 66 0F 38 29 /r          PCMPEQQ xmm1, xmm2/m128
+ * 66 0F 38 17 /r          PTEST xmm1, xmm2/m128
+ * 66 0F 38 2B /r          PACKUSDW xmm1, xmm2/m128
+ * 66 0F 3A 0C /r ib       BLENDPS xmm1, xmm2/m128, imm8
+ * 66 0F 3A 0D /r ib       BLENDPD xmm1, xmm2/m128, imm8
+ * 66 0F 38 14 /r          BLENDVPS xmm1, xmm2/m128, <XMM0>
+ * 66 0F 38 15 /r          BLENDVPD xmm1, xmm2/m128 , <XMM0>
+ * 66 0F 38 10 /r          PBLENDVB xmm1, xmm2/m128, <XMM0>
+ * 66 0F 3A 0E /r ib       PBLENDW xmm1, xmm2/m128, imm8
+ * 66 0F 3A 21 /r ib       INSERTPS xmm1, xmm2/m32, imm8
+ * 66 0F 3A 20 /r ib       PINSRB xmm1,r32/m8,imm8
+ * 66 0F 3A 22 /r ib       PINSRD xmm1,r/m32,imm8
+ * 66 REX.W 0F 3A 22 /r ib PINSRQ xmm1,r/m64,imm8
+ * 66 0F 3A 17 /r ib       EXTRACTPS reg/m32, xmm1, imm8
+ * 66 0F 3A 14 /r ib       PEXTRB r32/m8,xmm2,imm8
+ * 66 0F 3A 15 /r ib       PEXTRW r32/m16, xmm, imm8
+ * 66 0F 3A 16 /r ib       PEXTRD r/m32,xmm2,imm8
+ * 66 REX.W 0F 3A 16 /r ib PEXTRQ r/m64,xmm2,imm8
+ * 66 0f 38 20 /r          PMOVSXBW xmm1, xmm2/m64
+ * 66 0f 38 21 /r          PMOVSXBD xmm1, xmm2/m32
+ * 66 0f 38 22 /r          PMOVSXBQ xmm1, xmm2/m16
+ * 66 0f 38 23 /r          PMOVSXWD xmm1, xmm2/m64
+ * 66 0f 38 24 /r          PMOVSXWQ xmm1, xmm2/m32
+ * 66 0f 38 25 /r          PMOVSXDQ xmm1, xmm2/m64
+ * 66 0f 38 30 /r          PMOVZXBW xmm1, xmm2/m64
+ * 66 0f 38 31 /r          PMOVZXBD xmm1, xmm2/m32
+ * 66 0f 38 32 /r          PMOVZXBQ xmm1, xmm2/m16
+ * 66 0f 38 33 /r          PMOVZXWD xmm1, xmm2/m64
+ * 66 0f 38 34 /r          PMOVZXWQ xmm1, xmm2/m32
+ * 66 0f 38 35 /r          PMOVZXDQ xmm1, xmm2/m64
+ * 66 0F 38 2A /r          MOVNTDQA xmm1, m128
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -501,10 +553,12 @@ OPCODE(addsubps, LEG(F2, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(addsubpd, LEG(66, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pmullw, LEG(66, 0F, 0, 0xd5), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmulld, LEG(66, 0F38, 0, 0x40), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pmulhw, LEG(66, 0F, 0, 0xe5), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pmulhuw, LEG(66, 0F, 0, 0xe4), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmuldq, LEG(66, 0F38, 0, 0x28), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmuludq, LEG(NP, 0F, 0, 0xf4), SSE2, WRR, Pq, Pq, Qq)
 OPCODE(pmuludq, LEG(66, 0F, 0, 0xf4), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhrsw, LEG(NP, 0F38, 0, 0x0b), SSSE3, WRR, Pq, Pq, Qq)
@@ -531,16 +585,25 @@ OPCODE(rsqrtps, LEG(NP, 0F, 0, 0x52), SSE, WR, Vdq, Wdq)
 OPCODE(rsqrtss, LEG(F3, 0F, 0, 0x52), SSE, WR, Vd, Wd)
 OPCODE(pminub, LEG(NP, 0F, 0, 0xda), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pminub, LEG(66, 0F, 0, 0xda), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pminuw, LEG(66, 0F38, 0, 0x3a), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pminud, LEG(66, 0F38, 0, 0x3b), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pminsb, LEG(66, 0F38, 0, 0x38), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(pminsw, LEG(NP, 0F, 0, 0xea), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pminsw, LEG(66, 0F, 0, 0xea), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pminsd, LEG(66, 0F38, 0, 0x39), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(minps, LEG(NP, 0F, 0, 0x5d), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(minpd, LEG(66, 0F, 0, 0x5d), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(minss, LEG(F3, 0F, 0, 0x5d), SSE, WRR, Vd, Vd, Wd)
 OPCODE(minsd, LEG(F2, 0F, 0, 0x5d), SSE2, WRR, Vq, Vq, Wq)
+OPCODE(phminposuw, LEG(66, 0F38, 0, 0x41), SSE4_1, WR, Vdq, Wdq)
 OPCODE(pmaxub, LEG(NP, 0F, 0, 0xde), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pmaxub, LEG(66, 0F, 0, 0xde), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmaxuw, LEG(66, 0F38, 0, 0x3e), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmaxud, LEG(66, 0F38, 0, 0x3f), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmaxsb, LEG(66, 0F38, 0, 0x3c), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmaxsw, LEG(NP, 0F, 0, 0xee), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pmaxsw, LEG(66, 0F, 0, 0xee), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmaxsd, LEG(66, 0F38, 0, 0x3d), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(maxps, LEG(NP, 0F, 0, 0x5f), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(maxpd, LEG(66, 0F, 0, 0x5f), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(maxss, LEG(F3, 0F, 0, 0x5f), SSE, WRR, Vd, Vd, Wd)
@@ -551,6 +614,7 @@ OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pavgw, LEG(66, 0F, 0, 0xe3), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
 OPCODE(psadbw, LEG(66, 0F, 0, 0xf6), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(mpsadbw, LEG(66, 0F3A, 0, 0x42), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(pabsb, LEG(NP, 0F38, 0, 0x1c), SSSE3, WR, Pq, Qq)
 OPCODE(pabsb, LEG(66, 0F38, 0, 0x1c), SSSE3, WR, Vdq, Wdq)
 OPCODE(pabsw, LEG(NP, 0F38, 0, 0x1d), SSSE3, WR, Pq, Qq)
@@ -563,18 +627,26 @@ OPCODE(psignw, LEG(NP, 0F38, 0, 0x09), SSSE3, WRR, Pq, Pq, Qq)
 OPCODE(psignw, LEG(66, 0F38, 0, 0x09), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(psignd, LEG(NP, 0F38, 0, 0x0a), SSSE3, WRR, Pq, Pq, Qq)
 OPCODE(psignd, LEG(66, 0F38, 0, 0x0a), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(dpps, LEG(66, 0F3A, 0, 0x40), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(dppd, LEG(66, 0F3A, 0, 0x41), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(roundps, LEG(66, 0F3A, 0, 0x08), SSE4_1, WRR, Vdq, Wdq, Ib)
+OPCODE(roundpd, LEG(66, 0F3A, 0, 0x09), SSE4_1, WRR, Vdq, Wdq, Ib)
+OPCODE(roundss, LEG(66, 0F3A, 0, 0x0a), SSE4_1, WRR, Vd, Wd, Ib)
+OPCODE(roundsd, LEG(66, 0F3A, 0, 0x0b), SSE4_1, WRR, Vq, Wq, Ib)
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqw, LEG(66, 0F, 0, 0x75), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqd, LEG(66, 0F, 0, 0x76), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pcmpeqq, LEG(66, 0F38, 0, 0x29), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtb, LEG(66, 0F, 0, 0x64), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtw, LEG(66, 0F, 0, 0x65), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtd, LEG(66, 0F, 0, 0x66), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(ptest, LEG(66, 0F38, 0, 0x17), SSE4_1, RR, Vdq, Wdq)
 OPCODE(cmpps, LEG(NP, 0F, 0, 0xc2), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(cmppd, LEG(66, 0F, 0, 0xc2), SSE2, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(cmpss, LEG(F3, 0F, 0, 0xc2), SSE, WRRR, Vd, Vd, Wd, Ib)
@@ -623,6 +695,7 @@ OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
 OPCODE(packssdw, LEG(66, 0F, 0, 0x6b), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(packuswb, LEG(NP, 0F, 0, 0x67), MMX, WRR, Pq, Pq, Qq)
 OPCODE(packuswb, LEG(66, 0F, 0, 0x67), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(packusdw, LEG(66, 0F38, 0, 0x2b), SSE4_1, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckhbw, LEG(NP, 0F, 0, 0x68), MMX, WRR, Pq, Pq, Qq)
 OPCODE(punpckhbw, LEG(66, 0F, 0, 0x68), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckhwd, LEG(NP, 0F, 0, 0x69), MMX, WRR, Pq, Pq, Qq)
@@ -649,12 +722,39 @@ OPCODE(pshufhw, LEG(F3, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
 OPCODE(pshufd, LEG(66, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
 OPCODE(shufps, LEG(NP, 0F, 0, 0xc6), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(shufpd, LEG(66, 0F, 0, 0xc6), SSE2, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(blendps, LEG(66, 0F3A, 0, 0x0c), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(blendpd, LEG(66, 0F3A, 0, 0x0d), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(blendvps, LEG(66, 0F38, 0, 0x14), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(blendvpd, LEG(66, 0F38, 0, 0x15), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pblendvb, LEG(66, 0F38, 0, 0x10), SSE4_1, WRR, Vdq, Vdq, Wdq)
+OPCODE(pblendw, LEG(66, 0F3A, 0, 0x0e), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(insertps, LEG(66, 0F3A, 0, 0x21), SSE4_1, WRRR, Vdq, Vdq, Wd, Ib)
+OPCODE(pinsrb, LEG(66, 0F3A, 0, 0x20), SSE4_1, WRRR, Vdq, Vdq, RdMb, Ib)
 OPCODE(pinsrw, LEG(NP, 0F, 0, 0xc4), SSE, WRRR, Pq, Pq, RdMw, Ib)
 OPCODE(pinsrw, LEG(66, 0F, 0, 0xc4), SSE2, WRRR, Vdq, Vdq, RdMw, Ib)
+OPCODE(pinsrd, LEG(66, 0F3A, 0, 0x22), SSE4_1, WRRR, Vdq, Vdq, Ed, Ib)
+OPCODE(pinsrq, LEG(66, 0F3A, 1, 0x22), SSE4_1, WRRR, Vdq, Vdq, Eq, Ib)
+OPCODE(extractps, LEG(66, 0F3A, 0, 0x17), SSE4_1, WRR, Ed, Vdq, Ib)
+OPCODE(pextrb, LEG(66, 0F3A, 0, 0x14), SSE4_1, WRR, RdMb, Vdq, Ib)
+OPCODE(pextrw, LEG(66, 0F3A, 0, 0x15), SSE4_1, WRR, RdMw, Vdq, Ib)
+OPCODE(pextrd, LEG(66, 0F3A, 0, 0x16), SSE4_1, WRR, Ed, Vdq, Ib)
+OPCODE(pextrq, LEG(66, 0F3A, 1, 0x16), SSE4_1, WRR, Eq, Vdq, Ib)
 OPCODE(pextrw, LEG(NP, 0F, 0, 0xc5), SSE, WRR, Gd, Nq, Ib)
 OPCODE(pextrw, LEG(NP, 0F, 1, 0xc5), SSE, WRR, Gq, Nq, Ib)
 OPCODE(pextrw, LEG(66, 0F, 0, 0xc5), SSE2, WRR, Gd, Udq, Ib)
 OPCODE(pextrw, LEG(66, 0F, 1, 0xc5), SSE2, WRR, Gq, Udq, Ib)
+OPCODE(pmovsxbw, LEG(66, 0F38, 0, 0x20), SSE4_1, WR, Vdq, Wq)
+OPCODE(pmovsxbd, LEG(66, 0F38, 0, 0x21), SSE4_1, WR, Vdq, Wd)
+OPCODE(pmovsxbq, LEG(66, 0F38, 0, 0x22), SSE4_1, WR, Vdq, Ww)
+OPCODE(pmovsxwd, LEG(66, 0F38, 0, 0x23), SSE4_1, WR, Vdq, Wq)
+OPCODE(pmovsxwq, LEG(66, 0F38, 0, 0x24), SSE4_1, WR, Vdq, Wd)
+OPCODE(pmovsxdq, LEG(66, 0F38, 0, 0x25), SSE4_1, WR, Vdq, Wq)
+OPCODE(pmovzxbw, LEG(66, 0F38, 0, 0x30), SSE4_1, WR, Vdq, Wq)
+OPCODE(pmovzxbd, LEG(66, 0F38, 0, 0x31), SSE4_1, WR, Vdq, Wd)
+OPCODE(pmovzxbq, LEG(66, 0F38, 0, 0x32), SSE4_1, WR, Vdq, Ww)
+OPCODE(pmovzxwd, LEG(66, 0F38, 0, 0x33), SSE4_1, WR, Vdq, Wq)
+OPCODE(pmovzxwq, LEG(66, 0F38, 0, 0x34), SSE4_1, WR, Vdq, Wd)
+OPCODE(pmovzxdq, LEG(66, 0F38, 0, 0x35), SSE4_1, WR, Vdq, Wq)
 OPCODE(cvtpi2ps, LEG(NP, 0F, 0, 0x2a), SSE, WR, Vdq, Qq)
 OPCODE(cvtsi2ss, LEG(F3, 0F, 0, 0x2a), SSE, WR, Vd, Ed)
 OPCODE(cvtsi2ss, LEG(F3, 0F, 1, 0x2a), SSE, WR, Vd, Eq)
@@ -691,6 +791,7 @@ OPCODE(movnti, LEG(NP, 0F, 0, 0xc3), SSE2, WR, Md, Gd)
 OPCODE(movnti, LEG(NP, 0F, 1, 0xc3), SSE2, WR, Mq, Gq)
 OPCODE(movntq, LEG(NP, 0F, 0, 0xe7), SSE, WR, Mq, Pq)
 OPCODE(movntdq, LEG(66, 0F, 0, 0xe7), SSE2, WR, Mdq, Vdq)
+OPCODE(movntdqa, LEG(66, 0F38, 0, 0x2a), SSE4_1, WR, Vdq, Mdq)
 OPCODE(pause, LEG(F3, NA, 0, 0x90), SSE2, )
 OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
 
-- 
2.20.1


