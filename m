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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E375C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFAD22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seZkKlmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFAD22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VEZ-0001ZT-R3
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0001fE-PL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00089b-N0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:54 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:44247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URe-00085B-Mq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:52 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l79so1226392ywe.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UzwOWGnlxNuJcAEM/mDIC5BJDuCr0O/luDbpoecD9KU=;
 b=seZkKlmWa2gvgg3JYOy6ShYBq16OOrxkpBcL9pKv0MyLs5z/rT1kBPrG6+oTQIgpEK
 bG4khtlZUZQqxYrVYAb2x2RWP58X7sUD+ElFOhE89JfhCT5dKt7Z7uaRvwAolPZL1jmX
 AXuFZ/5TrFmQimg+Hzc8FvjaSKvh/9saOW9JHSTel5ruX+cTFvWT4LYCLmtWyV1zeTTh
 8I8yBa3PJMx+ICP6UJcqrYD+YIAB0dbhb2tV9XrZzuu5TTe44gzmhKbKyl2B7MCLXyXF
 eoCqMvVJg1t4OzMje/RavkPwOwC5BGJoGc985gN1kL5edbZgXCsR0WrSqYqxOi6zJNrC
 2F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UzwOWGnlxNuJcAEM/mDIC5BJDuCr0O/luDbpoecD9KU=;
 b=GciWvR/sEeeP1IOeifnRAZSbPBUG/gEDHQ4PcIOs7eruP7hvZEOzgrPfnA0jCKxUPB
 XlSGidXoqKMlyxaVFiyXpU8Zj8HzGKKwRj+gKbY29JoJ9cQHLeIoJptaACRjjaSjmHDy
 7kjpSe8VizBIgylCoHG3yokpLBK86Aqa3ebzBGTISJ94URDkM71GGNI9bJ0zVgiUT332
 ZGftLUMZG95dzTGoEwBbuTtLCX2/fWUkXaUjkAxUA7VIn0uKYX+6DOpd/M3fiNZX9hS4
 Ycdri60MmD7RzJDG7sC3DS6mRjpWbwWzH6Zfb5/V/i7p0PQ1FbdbtxUpOrsxjk7BRuWx
 udUw==
X-Gm-Message-State: APjAAAX9jnhkZ++8gMm+W9gHK8OA6uD5x3xeeM5YqlWTxgDaxS0ecdkt
 Q1guL3x5iIZlGQewOtndOiLXAAs8
X-Google-Smtp-Source: APXvYqy+F1OGDGXVO7nSIWGl6AnFeMHnM8o86FbdenPuTze3qaM/xuFd4M1aOhy8BdOglsw9W3rPgA==
X-Received: by 2002:a81:5ec2:: with SMTP id s185mr24952283ywb.35.1566408648314; 
 Wed, 21 Aug 2019 10:30:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:47 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:26 -0400
Message-Id: <20190821172951.15333-51-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 50/75] target/i386: introduce SSSE3
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

Add all the SSSE3 vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 84785a4e04..d8ea71aa6c 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -354,6 +354,41 @@
  * 66 0F 7D /r          HSUBPD xmm1, xmm2/m128
  * F2 0F D0 /r          ADDSUBPS xmm1, xmm2/m128
  * 66 0F D0 /r          ADDSUBPD xmm1, xmm2/m128
+ *
+ * SSSE3 Instructions
+ * -------------------
+ * NP 0F 38 01 /r          PHADDW mm1, mm2/m64
+ * 66 0F 38 01 /r          PHADDW xmm1, xmm2/m128
+ * NP 0F 38 02 /r          PHADDD mm1, mm2/m64
+ * 66 0F 38 02 /r          PHADDD xmm1, xmm2/m128
+ * NP 0F 38 03 /r          PHADDSW mm1, mm2/m64
+ * 66 0F 38 03 /r          PHADDSW xmm1, xmm2/m128
+ * NP 0F 38 05 /r          PHSUBW mm1, mm2/m64
+ * 66 0F 38 05 /r          PHSUBW xmm1, xmm2/m128
+ * NP 0F 38 06 /r          PHSUBD mm1, mm2/m64
+ * 66 0F 38 06 /r          PHSUBD xmm1, xmm2/m128
+ * NP 0F 38 07 /r          PHSUBSW mm1, mm2/m64
+ * 66 0F 38 07 /r          PHSUBSW xmm1, xmm2/m128
+ * NP 0F 38 0B /r          PMULHRSW mm1, mm2/m64
+ * 66 0F 38 0B /r          PMULHRSW xmm1, xmm2/m128
+ * NP 0F 38 04 /r          PMADDUBSW mm1, mm2/m64
+ * 66 0F 38 04 /r          PMADDUBSW xmm1, xmm2/m128
+ * NP 0F 38 1C /r          PABSB mm1, mm2/m64
+ * 66 0F 38 1C /r          PABSB xmm1, xmm2/m128
+ * NP 0F 38 1D /r          PABSW mm1, mm2/m64
+ * 66 0F 38 1D /r          PABSW xmm1, xmm2/m128
+ * NP 0F 38 1E /r          PABSD mm1, mm2/m64
+ * 66 0F 38 1E /r          PABSD xmm1, xmm2/m128
+ * NP 0F 38 08 /r          PSIGNB mm1, mm2/m64
+ * 66 0F 38 08 /r          PSIGNB xmm1, xmm2/m128
+ * NP 0F 38 09 /r          PSIGNW mm1, mm2/m64
+ * 66 0F 38 09 /r          PSIGNW xmm1, xmm2/m128
+ * NP 0F 38 0A /r          PSIGND mm1, mm2/m64
+ * 66 0F 38 0A /r          PSIGND xmm1, xmm2/m128
+ * NP 0F 3A 0F /r ib       PALIGNR mm1, mm2/m64, imm8
+ * 66 0F 3A 0F /r ib       PALIGNR xmm1, xmm2/m128, imm8
+ * NP 0F 38 00 /r          PSHUFB mm1, mm2/m64
+ * 66 0F 38 00 /r          PSHUFB xmm1, xmm2/m128
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -426,6 +461,12 @@ OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(addpd, LEG(66, 0F, 0, 0x58), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
 OPCODE(addsd, LEG(F2, 0F, 0, 0x58), SSE2, WRR, Vq, Vq, Wq)
+OPCODE(phaddw, LEG(NP, 0F38, 0, 0x01), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phaddw, LEG(66, 0F38, 0, 0x01), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(phaddd, LEG(NP, 0F38, 0, 0x02), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phaddd, LEG(66, 0F38, 0, 0x02), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(phaddsw, LEG(NP, 0F38, 0, 0x03), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phaddsw, LEG(66, 0F38, 0, 0x03), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(haddps, LEG(F2, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(haddpd, LEG(66, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
@@ -448,6 +489,12 @@ OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(subpd, LEG(66, 0F, 0, 0x5c), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
 OPCODE(subsd, LEG(F2, 0F, 0, 0x5c), SSE2, WRR, Vq, Vq, Wq)
+OPCODE(phsubw, LEG(NP, 0F38, 0, 0x05), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phsubw, LEG(66, 0F38, 0, 0x05), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(phsubd, LEG(NP, 0F38, 0, 0x06), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phsubd, LEG(66, 0F38, 0, 0x06), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(phsubsw, LEG(NP, 0F38, 0, 0x07), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(phsubsw, LEG(66, 0F38, 0, 0x07), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(hsubps, LEG(F2, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(hsubpd, LEG(66, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(addsubps, LEG(F2, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
@@ -460,12 +507,16 @@ OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pmulhuw, LEG(66, 0F, 0, 0xe4), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmuludq, LEG(NP, 0F, 0, 0xf4), SSE2, WRR, Pq, Pq, Qq)
 OPCODE(pmuludq, LEG(66, 0F, 0, 0xf4), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmulhrsw, LEG(NP, 0F38, 0, 0x0b), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(pmulhrsw, LEG(66, 0F38, 0, 0x0b), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(mulps, LEG(NP, 0F, 0, 0x59), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(mulpd, LEG(66, 0F, 0, 0x59), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(mulss, LEG(F3, 0F, 0, 0x59), SSE, WRR, Vd, Vd, Wd)
 OPCODE(mulsd, LEG(F2, 0F, 0, 0x59), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pmaddwd, LEG(66, 0F, 0, 0xf5), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmaddubsw, LEG(NP, 0F38, 0, 0x04), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(pmaddubsw, LEG(66, 0F38, 0, 0x04), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(divps, LEG(NP, 0F, 0, 0x5e), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(divpd, LEG(66, 0F, 0, 0x5e), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(divss, LEG(F3, 0F, 0, 0x5e), SSE, WRR, Vd, Vd, Wd)
@@ -500,6 +551,18 @@ OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pavgw, LEG(66, 0F, 0, 0xe3), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
 OPCODE(psadbw, LEG(66, 0F, 0, 0xf6), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pabsb, LEG(NP, 0F38, 0, 0x1c), SSSE3, WR, Pq, Qq)
+OPCODE(pabsb, LEG(66, 0F38, 0, 0x1c), SSSE3, WR, Vdq, Wdq)
+OPCODE(pabsw, LEG(NP, 0F38, 0, 0x1d), SSSE3, WR, Pq, Qq)
+OPCODE(pabsw, LEG(66, 0F38, 0, 0x1d), SSSE3, WR, Vdq, Wdq)
+OPCODE(pabsd, LEG(NP, 0F38, 0, 0x1e), SSSE3, WR, Pq, Qq)
+OPCODE(pabsd, LEG(66, 0F38, 0, 0x1e), SSSE3, WR, Vdq, Wdq)
+OPCODE(psignb, LEG(NP, 0F38, 0, 0x08), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(psignb, LEG(66, 0F38, 0, 0x08), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(psignw, LEG(NP, 0F38, 0, 0x09), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(psignw, LEG(66, 0F38, 0, 0x09), SSSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(psignd, LEG(NP, 0F38, 0, 0x0a), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(psignd, LEG(66, 0F38, 0, 0x0a), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
@@ -552,6 +615,8 @@ OPCODE(psraw, LEG(NP, 0F, 0, 0xe1), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psraw, LEG(66, 0F, 0, 0xe1), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psrad, LEG(NP, 0F, 0, 0xe2), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psrad, LEG(66, 0F, 0, 0xe2), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(palignr, LEG(NP, 0F3A, 0, 0x0f), SSSE3, WRRR, Pq, Pq, Qq, Ib)
+OPCODE(palignr, LEG(66, 0F3A, 0, 0x0f), SSSE3, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(packsswb, LEG(NP, 0F, 0, 0x63), MMX, WRR, Pq, Pq, Qq)
 OPCODE(packsswb, LEG(66, 0F, 0, 0x63), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
@@ -576,6 +641,8 @@ OPCODE(unpcklps, LEG(NP, 0F, 0, 0x14), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(unpcklpd, LEG(66, 0F, 0, 0x14), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(unpckhps, LEG(NP, 0F, 0, 0x15), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(unpckhpd, LEG(66, 0F, 0, 0x15), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pshufb, LEG(NP, 0F38, 0, 0x00), SSSE3, WRR, Pq, Pq, Qq)
+OPCODE(pshufb, LEG(66, 0F38, 0, 0x00), SSSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(pshufw, LEG(NP, 0F, 0, 0x70), SSE, WRR, Pq, Qq, Ib)
 OPCODE(pshuflw, LEG(F2, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
 OPCODE(pshufhw, LEG(F3, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
-- 
2.20.1


