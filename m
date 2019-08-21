Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C667A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edYt+AvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C667A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VAq-0004ZX-9T
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URc-0001cC-E5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URZ-0007x9-4Z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:48 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URY-0007wn-Ud
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:45 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n126so1251411ywf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ETbzXw0KudTDOiB+1LF035zgw9Ic3L1yVdG3poi8PU=;
 b=edYt+AvG3QQbfUTqIoKVNOPF7On0H1snmrlUtSJOO6bCr5arnTygaKCAbdhjGDaNvV
 pI6DIUGbyFFd3xugk2DsMvpfm8IOEjuLiE5MOnEgmSY8DmZyfjLa3QZRhxwprPVw4eIp
 gaEG3/MRRD4I9zCg2dYn/fWwmGJtXPsN2gAiR4DtutpHZHB8LCt+Z7d53sLgj8jRJ58N
 4GPdjS9qVcV8f6b38ZK9nYORZa198CE20QLmYCtPfMDCIe8BvKFmNSibd2LwrCtJbfg9
 eL0MdSJXs4iQx0BoPE1lI9VHT9xZLj3K0G1qKf4FMwplgKFEBYaGCcom+BxoEoBG1Jk8
 z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ETbzXw0KudTDOiB+1LF035zgw9Ic3L1yVdG3poi8PU=;
 b=SVWU57FoMdKbswb45jUcy3MmhrPe74Cz0vhkqznIvfeMq6iXxzaoMWt0EcLKlvxTKl
 sUO69633jLcFxUcNCGlWo+Q9iymhldS1VG/XHx7sSWLD8Wh09PPqDyTLb8uRrSQLXrFp
 cwTzqj/4mq+j3kdcc+l/oA1OyKw8I1zWlwWS8AtPtIdW0snjvpy3Cwj1ynVT3eCt9Ppi
 1Thpa5Op8bHgibxVOb5mrZ5xe1CJ9OqRbdl2GrMXhxAuaEpASC/AoE+rBdNWVFa/9LRO
 RBPmWdzeDa0Ie5UUqNFDop19SFxYHsyMqw37+dtjIKLw786ka/BO982WbeN4zSM3P/L/
 iBIw==
X-Gm-Message-State: APjAAAXWFhRjR37CF79hrwE8KSn0qOVs61Yeg7PtXLVHEmitPMKSGGQ2
 MC6bwvrIrzhqLOnFztVg+OORFwjw
X-Google-Smtp-Source: APXvYqzg/EcCAnJ2dNEIhfawokmahD5rHUKrOnmF2yDc2mhwX/RN5kQLa2RM1xoUP8aeMghEgbaOpA==
X-Received: by 2002:a81:2e84:: with SMTP id
 u126mr24492170ywu.398.1566408643768; 
 Wed, 21 Aug 2019 10:30:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:43 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:20 -0400
Message-Id: <20190821172951.15333-45-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 44/75] target/i386: introduce SSE2
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

Add all the SSE2 vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 326 ++++++++++++++++++++++++++++++++++-
 1 file changed, 325 insertions(+), 1 deletion(-)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 92581703cd..6df5fda010 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -183,127 +183,434 @@
  * 0F 18 /2             PREFETCHT1 m8
  * 0F 18 /3             PREFETCHT2 m8
  * 0F 18 /0             PREFETCHNTA m8
+ *
+ * SSE2 Instructions
+ * ------------------
+ * 66 0F 6E /r          MOVD xmm,r/m32
+ * 66 0F 7E /r          MOVD r/m32,xmm
+ * 66 REX.W 0F 6E /r    MOVQ xmm,r/m64
+ * 66 REX.W 0F 7E /r    MOVQ r/m64,xmm
+ * F3 0F 7E /r          MOVQ xmm1, xmm2/m64
+ * 66 0F D6 /r          MOVQ xmm2/m64, xmm1
+ * 66 0F 28 /r          MOVAPD xmm1, xmm2/m128
+ * 66 0F 29 /r          MOVAPD xmm2/m128, xmm1
+ * 66 0F 6F /r          MOVDQA xmm1, xmm2/m128
+ * 66 0F 7F /r          MOVDQA xmm2/m128, xmm1
+ * 66 0F 10 /r          MOVUPD xmm1, xmm2/m128
+ * 66 0F 11 /r          MOVUPD xmm2/m128, xmm1
+ * F3 0F 6F /r          MOVDQU xmm1,xmm2/m128
+ * F3 0F 7F /r          MOVDQU xmm2/m128,xmm1
+ * F2 0F 10 /r          MOVSD xmm1, xmm2/m64
+ * F2 0F 11 /r          MOVSD xmm1/m64, xmm2
+ * F3 0F D6 /r          MOVQ2DQ xmm, mm
+ * F2 0F D6 /r          MOVDQ2Q mm, xmm
+ * 66 0F 12 /r          MOVLPD xmm1,m64
+ * 66 0F 13 /r          MOVLPD m64,xmm1
+ * 66 0F 16 /r          MOVHPD xmm1, m64
+ * 66 0F 17 /r          MOVHPD m64, xmm1
+ * 66 0F D7 /r          PMOVMSKB r32, xmm
+ * 66 REX.W 0F D7 /r    PMOVMSKB r64, xmm
+ * 66 0F 50 /r          MOVMSKPD r32, xmm
+ * 66 REX.W 0F 50 /r    MOVMSKPD r64, xmm
+ * 66 0F FC /r          PADDB xmm1, xmm2/m128
+ * 66 0F FD /r          PADDW xmm1, xmm2/m128
+ * 66 0F FE /r          PADDD xmm1, xmm2/m128
+ * NP 0F D4 /r          PADDQ mm, mm/m64
+ * 66 0F D4 /r          PADDQ xmm1, xmm2/m128
+ * 66 0F EC /r          PADDSB xmm1, xmm2/m128
+ * 66 0F ED /r          PADDSW xmm1, xmm2/m128
+ * 66 0F DC /r          PADDUSB xmm1,xmm2/m128
+ * 66 0F DD /r          PADDUSW xmm1,xmm2/m128
+ * 66 0F 58 /r          ADDPD xmm1, xmm2/m128
+ * F2 0F 58 /r          ADDSD xmm1, xmm2/m64
+ * 66 0F F8 /r          PSUBB xmm1, xmm2/m128
+ * 66 0F F9 /r          PSUBW xmm1, xmm2/m128
+ * 66 0F FA /r          PSUBD xmm1, xmm2/m128
+ * NP 0F FB /r          PSUBQ mm1, mm2/m64
+ * 66 0F FB /r          PSUBQ xmm1, xmm2/m128
+ * 66 0F E8 /r          PSUBSB xmm1, xmm2/m128
+ * 66 0F E9 /r          PSUBSW xmm1, xmm2/m128
+ * 66 0F D8 /r          PSUBUSB xmm1, xmm2/m128
+ * 66 0F D9 /r          PSUBUSW xmm1, xmm2/m128
+ * 66 0F 5C /r          SUBPD xmm1, xmm2/m128
+ * F2 0F 5C /r          SUBSD xmm1, xmm2/m64
+ * 66 0F D5 /r          PMULLW xmm1, xmm2/m128
+ * 66 0F E5 /r          PMULHW xmm1, xmm2/m128
+ * 66 0F E4 /r          PMULHUW xmm1, xmm2/m128
+ * NP 0F F4 /r          PMULUDQ mm1, mm2/m64
+ * 66 0F F4 /r          PMULUDQ xmm1, xmm2/m128
+ * 66 0F 59 /r          MULPD xmm1, xmm2/m128
+ * F2 0F 59 /r          MULSD xmm1,xmm2/m64
+ * 66 0F F5 /r          PMADDWD xmm1, xmm2/m128
+ * 66 0F 5E /r          DIVPD xmm1, xmm2/m128
+ * F2 0F 5E /r          DIVSD xmm1, xmm2/m64
+ * 66 0F 51 /r          SQRTPD xmm1, xmm2/m128
+ * F2 0F 51 /r          SQRTSD xmm1,xmm2/m64
+ * 66 0F DA /r          PMINUB xmm1, xmm2/m128
+ * 66 0F EA /r          PMINSW xmm1, xmm2/m128
+ * 66 0F 5D /r          MINPD xmm1, xmm2/m128
+ * F2 0F 5D /r          MINSD xmm1, xmm2/m64
+ * 66 0F DE /r          PMAXUB xmm1, xmm2/m128
+ * 66 0F EE /r          PMAXSW xmm1, xmm2/m128
+ * 66 0F 5F /r          MAXPD xmm1, xmm2/m128
+ * F2 0F 5F /r          MAXSD xmm1, xmm2/m64
+ * 66 0F E0 /r          PAVGB xmm1, xmm2/m128
+ * 66 0F E3 /r          PAVGW xmm1, xmm2/m128
+ * 66 0F F6 /r          PSADBW xmm1, xmm2/m128
+ * 66 0F 74 /r          PCMPEQB xmm1,xmm2/m128
+ * 66 0F 75 /r          PCMPEQW xmm1,xmm2/m128
+ * 66 0F 76 /r          PCMPEQD xmm1,xmm2/m128
+ * 66 0F 64 /r          PCMPGTB xmm1,xmm2/m128
+ * 66 0F 65 /r          PCMPGTW xmm1,xmm2/m128
+ * 66 0F 66 /r          PCMPGTD xmm1,xmm2/m128
+ * 66 0F C2 /r ib       CMPPD xmm1, xmm2/m128, imm8
+ * F2 0F C2 /r ib       CMPSD xmm1, xmm2/m64, imm8
+ * 66 0F 2E /r          UCOMISD xmm1, xmm2/m64
+ * 66 0F 2F /r          COMISD xmm1, xmm2/m64
+ * 66 0F DB /r          PAND xmm1, xmm2/m128
+ * 66 0F 54 /r          ANDPD xmm1, xmm2/m128
+ * 66 0F DF /r          PANDN xmm1, xmm2/m128
+ * 66 0F 55 /r          ANDNPD xmm1, xmm2/m128
+ * 66 0F EB /r          POR xmm1, xmm2/m128
+ * 66 0F 56 /r          ORPD xmm1, xmm2/m128
+ * 66 0F EF /r          PXOR xmm1, xmm2/m128
+ * 66 0F 57 /r          XORPD xmm1, xmm2/m128
+ * 66 0F F1 /r          PSLLW xmm1, xmm2/m128
+ * 66 0F F2 /r          PSLLD xmm1, xmm2/m128
+ * 66 0F F3 /r          PSLLQ xmm1, xmm2/m128
+ * 66 0F D1 /r          PSRLW xmm1, xmm2/m128
+ * 66 0F D2 /r          PSRLD xmm1, xmm2/m128
+ * 66 0F D3 /r          PSRLQ xmm1, xmm2/m128
+ * 66 0F E1 /r          PSRAW xmm1,xmm2/m128
+ * 66 0F E2 /r          PSRAD xmm1,xmm2/m128
+ * 66 0F 63 /r          PACKSSWB xmm1, xmm2/m128
+ * 66 0F 6B /r          PACKSSDW xmm1, xmm2/m128
+ * 66 0F 67 /r          PACKUSWB xmm1, xmm2/m128
+ * 66 0F 68 /r          PUNPCKHBW xmm1, xmm2/m128
+ * 66 0F 69 /r          PUNPCKHWD xmm1, xmm2/m128
+ * 66 0F 6A /r          PUNPCKHDQ xmm1, xmm2/m128
+ * 66 0F 6D /r          PUNPCKHQDQ xmm1, xmm2/m128
+ * 66 0F 60 /r          PUNPCKLBW xmm1, xmm2/m128
+ * 66 0F 61 /r          PUNPCKLWD xmm1, xmm2/m128
+ * 66 0F 62 /r          PUNPCKLDQ xmm1, xmm2/m128
+ * 66 0F 6C /r          PUNPCKLQDQ xmm1, xmm2/m128
+ * 66 0F 14 /r          UNPCKLPD xmm1, xmm2/m128
+ * 66 0F 15 /r          UNPCKHPD xmm1, xmm2/m128
+ * F2 0F 70 /r ib       PSHUFLW xmm1, xmm2/m128, imm8
+ * F3 0F 70 /r ib       PSHUFHW xmm1, xmm2/m128, imm8
+ * 66 0F 70 /r ib       PSHUFD xmm1, xmm2/m128, imm8
+ * 66 0F C6 /r ib       SHUFPD xmm1, xmm2/m128, imm8
+ * 66 0F C4 /r ib       PINSRW xmm, r32/m16, imm8
+ * 66 0F C5 /r ib       PEXTRW r32, xmm, imm8
+ * 66 REX.W 0F C5 /r ib PEXTRW r64, xmm, imm8
+ * 66 0F 2A /r          CVTPI2PD xmm, mm/m64
+ * F2 0F 2A /r          CVTSI2SD xmm1,r32/m32
+ * F2 REX.W 0F 2A /r    CVTSI2SD xmm1,r/m64
+ * 66 0F 2D /r          CVTPD2PI mm, xmm/m128
+ * F2 0F 2D /r          CVTSD2SI r32,xmm1/m64
+ * F2 REX.W 0F 2D /r    CVTSD2SI r64,xmm1/m64
+ * 66 0F 2C /r          CVTTPD2PI mm, xmm/m128
+ * F2 0F 2C /r          CVTTSD2SI r32,xmm1/m64
+ * F2 REX.W 0F 2C /r    CVTTSD2SI r64,xmm1/m64
+ * F2 0F E6 /r          CVTPD2DQ xmm1, xmm2/m128
+ * 66 0F E6 /r          CVTTPD2DQ xmm1, xmm2/m128
+ * F3 0F E6 /r          CVTDQ2PD xmm1, xmm2/m64
+ * NP 0F 5A /r          CVTPS2PD xmm1, xmm2/m64
+ * 66 0F 5A /r          CVTPD2PS xmm1, xmm2/m128
+ * F3 0F 5A /r          CVTSS2SD xmm1, xmm2/m32
+ * F2 0F 5A /r          CVTSD2SS xmm1, xmm2/m64
+ * NP 0F 5B /r          CVTDQ2PS xmm1, xmm2/m128
+ * 66 0F 5B /r          CVTPS2DQ xmm1, xmm2/m128
+ * F3 0F 5B /r          CVTTPS2DQ xmm1, xmm2/m128
+ * 66 0F F7 /r          MASKMOVDQU xmm1, xmm2
+ * 66 0F 2B /r          MOVNTPD m128, xmm1
+ * NP 0F C3 /r          MOVNTI m32, r32
+ * NP REX.W + 0F C3 /r  MOVNTI m64, r64
+ * 66 0F E7 /r          MOVNTDQ m128, xmm1
+ * F3 90                PAUSE
+ * 66 0F 71 /6 ib       PSLLW xmm1, imm8
+ * 66 0F 71 /2 ib       PSRLW xmm1, imm8
+ * 66 0F 71 /4 ib       PSRAW xmm1,imm8
+ * 66 0F 72 /6 ib       PSLLD xmm1, imm8
+ * 66 0F 72 /2 ib       PSRLD xmm1, imm8
+ * 66 0F 72 /4 ib       PSRAD xmm1,imm8
+ * 66 0F 73 /6 ib       PSLLQ xmm1, imm8
+ * 66 0F 73 /7 ib       PSLLDQ xmm1, imm8
+ * 66 0F 73 /2 ib       PSRLQ xmm1, imm8
+ * 66 0F 73 /3 ib       PSRLDQ xmm1, imm8
+ * NP 0F AE /7          CLFLUSH m8
+ * NP 0F AE /5          LFENCE
+ * NP 0F AE /6          MFENCE
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
 OPCODE(movd, LEG(NP, 0F, 0, 0x7e), MMX, WR, Ed, Pq)
+OPCODE(movd, LEG(66, 0F, 0, 0x6e), SSE2, WR, Vdq, Ed)
+OPCODE(movd, LEG(66, 0F, 0, 0x7e), SSE2, WR, Ed, Vdq)
 OPCODE(movq, LEG(NP, 0F, 1, 0x6e), MMX, WR, Pq, Eq)
 OPCODE(movq, LEG(NP, 0F, 1, 0x7e), MMX, WR, Eq, Pq)
+OPCODE(movq, LEG(66, 0F, 1, 0x6e), SSE2, WR, Vdq, Eq)
+OPCODE(movq, LEG(66, 0F, 1, 0x7e), SSE2, WR, Eq, Vdq)
 OPCODE(movq, LEG(NP, 0F, 0, 0x6f), MMX, WR, Pq, Qq)
 OPCODE(movq, LEG(NP, 0F, 0, 0x7f), MMX, WR, Qq, Pq)
+OPCODE(movq, LEG(F3, 0F, 0, 0x7e), SSE2, WR, Vdq, Wq)
+OPCODE(movq, LEG(66, 0F, 0, 0xd6), SSE2, WR, UdqMq, Vq)
 OPCODE(movaps, LEG(NP, 0F, 0, 0x28), SSE, WR, Vdq, Wdq)
 OPCODE(movaps, LEG(NP, 0F, 0, 0x29), SSE, WR, Wdq, Vdq)
+OPCODE(movapd, LEG(66, 0F, 0, 0x28), SSE2, WR, Vdq, Wdq)
+OPCODE(movapd, LEG(66, 0F, 0, 0x29), SSE2, WR, Wdq, Vdq)
+OPCODE(movdqa, LEG(66, 0F, 0, 0x6f), SSE2, WR, Vdq, Wdq)
+OPCODE(movdqa, LEG(66, 0F, 0, 0x7f), SSE2, WR, Wdq, Vdq)
 OPCODE(movups, LEG(NP, 0F, 0, 0x10), SSE, WR, Vdq, Wdq)
 OPCODE(movups, LEG(NP, 0F, 0, 0x11), SSE, WR, Wdq, Vdq)
+OPCODE(movupd, LEG(66, 0F, 0, 0x10), SSE2, WR, Vdq, Wdq)
+OPCODE(movupd, LEG(66, 0F, 0, 0x11), SSE2, WR, Wdq, Vdq)
+OPCODE(movdqu, LEG(F3, 0F, 0, 0x6f), SSE2, WR, Vdq, Wdq)
+OPCODE(movdqu, LEG(F3, 0F, 0, 0x7f), SSE2, WR, Wdq, Vdq)
 OPCODE(movss, LEG(F3, 0F, 0, 0x10), SSE, WRRR, Vdq, Vdq, Wd, modrm_mod)
 OPCODE(movss, LEG(F3, 0F, 0, 0x11), SSE, WR, Wd, Vd)
+OPCODE(movsd, LEG(F2, 0F, 0, 0x10), SSE2, WRRR, Vdq, Vdq, Wq, modrm_mod)
+OPCODE(movsd, LEG(F2, 0F, 0, 0x11), SSE2, WR, Wq, Vq)
+OPCODE(movq2dq, LEG(F3, 0F, 0, 0xd6), SSE2, WR, Vdq, Nq)
+OPCODE(movdq2q, LEG(F2, 0F, 0, 0xd6), SSE2, WR, Pq, Uq)
 OPCODE(movhlps, LEG(NP, 0F, 0, 0x12), SSE, WRR, Vdq, Vdq, UdqMhq)
 OPCODE(movlps, LEG(NP, 0F, 0, 0x13), SSE, WR, Mq, Vq)
+OPCODE(movlpd, LEG(66, 0F, 0, 0x12), SSE2, WRR, Vdq, Vdq, Mq)
+OPCODE(movlpd, LEG(66, 0F, 0, 0x13), SSE2, WR, Mq, Vq)
 OPCODE(movlhps, LEG(NP, 0F, 0, 0x16), SSE, WRR, Vdq, Vq, Wq)
 OPCODE(movhps, LEG(NP, 0F, 0, 0x17), SSE, WR, Mq, Vdq)
+OPCODE(movhpd, LEG(66, 0F, 0, 0x16), SSE2, WRR, Vdq, Vq, Mq)
+OPCODE(movhpd, LEG(66, 0F, 0, 0x17), SSE2, WR, Mq, Vdq)
 OPCODE(pmovmskb, LEG(NP, 0F, 0, 0xd7), SSE, WR, Gd, Nq)
 OPCODE(pmovmskb, LEG(NP, 0F, 1, 0xd7), SSE, WR, Gq, Nq)
+OPCODE(pmovmskb, LEG(66, 0F, 0, 0xd7), SSE2, WR, Gd, Udq)
+OPCODE(pmovmskb, LEG(66, 0F, 1, 0xd7), SSE2, WR, Gq, Udq)
 OPCODE(movmskps, LEG(NP, 0F, 0, 0x50), SSE, WR, Gd, Udq)
 OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
+OPCODE(movmskpd, LEG(66, 0F, 0, 0x50), SSE2, WR, Gd, Udq)
+OPCODE(movmskpd, LEG(66, 0F, 1, 0x50), SSE2, WR, Gq, Udq)
 OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddb, LEG(66, 0F, 0, 0xfc), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddw, LEG(66, 0F, 0, 0xfd), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddd, LEG(NP, 0F, 0, 0xfe), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddd, LEG(66, 0F, 0, 0xfe), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(paddq, LEG(NP, 0F, 0, 0xd4), SSE2, WRR, Pq, Pq, Qq)
+OPCODE(paddq, LEG(66, 0F, 0, 0xd4), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddsb, LEG(NP, 0F, 0, 0xec), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddsb, LEG(66, 0F, 0, 0xec), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddsw, LEG(66, 0F, 0, 0xed), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddusb, LEG(66, 0F, 0, 0xdc), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddusw, LEG(66, 0F, 0, 0xdd), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(addpd, LEG(66, 0F, 0, 0x58), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
+OPCODE(addsd, LEG(F2, 0F, 0, 0x58), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubb, LEG(66, 0F, 0, 0xf8), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubw, LEG(66, 0F, 0, 0xf9), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubd, LEG(NP, 0F, 0, 0xfa), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubd, LEG(66, 0F, 0, 0xfa), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(psubq, LEG(NP, 0F, 0, 0xfb), SSE2, WRR, Pq, Pq, Qq)
+OPCODE(psubq, LEG(66, 0F, 0, 0xfb), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubsb, LEG(NP, 0F, 0, 0xe8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubsb, LEG(66, 0F, 0, 0xe8), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubsw, LEG(66, 0F, 0, 0xe9), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubusb, LEG(66, 0F, 0, 0xd8), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubusw, LEG(66, 0F, 0, 0xd9), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(subpd, LEG(66, 0F, 0, 0x5c), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
+OPCODE(subsd, LEG(F2, 0F, 0, 0x5c), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmullw, LEG(66, 0F, 0, 0xd5), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmulhw, LEG(66, 0F, 0, 0xe5), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pmulhuw, LEG(66, 0F, 0, 0xe4), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pmuludq, LEG(NP, 0F, 0, 0xf4), SSE2, WRR, Pq, Pq, Qq)
+OPCODE(pmuludq, LEG(66, 0F, 0, 0xf4), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(mulps, LEG(NP, 0F, 0, 0x59), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(mulpd, LEG(66, 0F, 0, 0x59), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(mulss, LEG(F3, 0F, 0, 0x59), SSE, WRR, Vd, Vd, Wd)
+OPCODE(mulsd, LEG(F2, 0F, 0, 0x59), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmaddwd, LEG(66, 0F, 0, 0xf5), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(divps, LEG(NP, 0F, 0, 0x5e), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(divpd, LEG(66, 0F, 0, 0x5e), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(divss, LEG(F3, 0F, 0, 0x5e), SSE, WRR, Vd, Vd, Wd)
+OPCODE(divsd, LEG(F2, 0F, 0, 0x5e), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(rcpps, LEG(NP, 0F, 0, 0x53), SSE, WR, Vdq, Wdq)
 OPCODE(rcpss, LEG(F3, 0F, 0, 0x53), SSE, WR, Vd, Wd)
 OPCODE(sqrtps, LEG(NP, 0F, 0, 0x51), SSE, WR, Vdq, Wdq)
+OPCODE(sqrtpd, LEG(66, 0F, 0, 0x51), SSE2, WR, Vdq, Wdq)
 OPCODE(sqrtss, LEG(F3, 0F, 0, 0x51), SSE, WR, Vd, Wd)
+OPCODE(sqrtsd, LEG(F2, 0F, 0, 0x51), SSE2, WR, Vq, Wq)
 OPCODE(rsqrtps, LEG(NP, 0F, 0, 0x52), SSE, WR, Vdq, Wdq)
 OPCODE(rsqrtss, LEG(F3, 0F, 0, 0x52), SSE, WR, Vd, Wd)
 OPCODE(pminub, LEG(NP, 0F, 0, 0xda), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pminub, LEG(66, 0F, 0, 0xda), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pminsw, LEG(NP, 0F, 0, 0xea), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pminsw, LEG(66, 0F, 0, 0xea), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(minps, LEG(NP, 0F, 0, 0x5d), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(minpd, LEG(66, 0F, 0, 0x5d), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(minss, LEG(F3, 0F, 0, 0x5d), SSE, WRR, Vd, Vd, Wd)
+OPCODE(minsd, LEG(F2, 0F, 0, 0x5d), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(pmaxub, LEG(NP, 0F, 0, 0xde), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pmaxub, LEG(66, 0F, 0, 0xde), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmaxsw, LEG(NP, 0F, 0, 0xee), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pmaxsw, LEG(66, 0F, 0, 0xee), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(maxps, LEG(NP, 0F, 0, 0x5f), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(maxpd, LEG(66, 0F, 0, 0x5f), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(maxss, LEG(F3, 0F, 0, 0x5f), SSE, WRR, Vd, Vd, Wd)
+OPCODE(maxsd, LEG(F2, 0F, 0, 0x5f), SSE2, WRR, Vq, Vq, Wq)
 OPCODE(pavgb, LEG(NP, 0F, 0, 0xe0), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pavgb, LEG(66, 0F, 0, 0xe0), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pavgw, LEG(66, 0F, 0, 0xe3), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
+OPCODE(psadbw, LEG(66, 0F, 0, 0xf6), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqw, LEG(66, 0F, 0, 0x75), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqd, LEG(66, 0F, 0, 0x76), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtb, LEG(66, 0F, 0, 0x64), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtw, LEG(66, 0F, 0, 0x65), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtd, LEG(66, 0F, 0, 0x66), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(cmpps, LEG(NP, 0F, 0, 0xc2), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(cmppd, LEG(66, 0F, 0, 0xc2), SSE2, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(cmpss, LEG(F3, 0F, 0, 0xc2), SSE, WRRR, Vd, Vd, Wd, Ib)
+OPCODE(cmpsd, LEG(F2, 0F, 0, 0xc2), SSE2, WRRR, Vq, Vq, Wq, Ib)
 OPCODE(ucomiss, LEG(NP, 0F, 0, 0x2e), SSE, RR, Vd, Wd)
+OPCODE(ucomisd, LEG(66, 0F, 0, 0x2e), SSE2, RR, Vq, Wq)
 OPCODE(comiss, LEG(NP, 0F, 0, 0x2f), SSE, RR, Vd, Wd)
+OPCODE(comisd, LEG(66, 0F, 0, 0x2f), SSE2, RR, Vq, Wq)
 OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pand, LEG(66, 0F, 0, 0xdb), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(andps, LEG(NP, 0F, 0, 0x54), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(andpd, LEG(66, 0F, 0, 0x54), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pandn, LEG(66, 0F, 0, 0xdf), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(andnps, LEG(NP, 0F, 0, 0x55), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(andnpd, LEG(66, 0F, 0, 0x55), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(por, LEG(66, 0F, 0, 0xeb), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(orps, LEG(NP, 0F, 0, 0x56), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(orpd, LEG(66, 0F, 0, 0x56), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pxor, LEG(66, 0F, 0, 0xef), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(xorps, LEG(NP, 0F, 0, 0x57), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(xorpd, LEG(66, 0F, 0, 0x57), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psllw, LEG(66, 0F, 0, 0xf1), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pslld, LEG(NP, 0F, 0, 0xf2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pslld, LEG(66, 0F, 0, 0xf2), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psllq, LEG(NP, 0F, 0, 0xf3), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psllq, LEG(66, 0F, 0, 0xf3), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psrlw, LEG(NP, 0F, 0, 0xd1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrlw, LEG(66, 0F, 0, 0xd1), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psrld, LEG(NP, 0F, 0, 0xd2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrld, LEG(66, 0F, 0, 0xd2), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psrlq, LEG(NP, 0F, 0, 0xd3), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrlq, LEG(66, 0F, 0, 0xd3), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psraw, LEG(NP, 0F, 0, 0xe1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psraw, LEG(66, 0F, 0, 0xe1), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psrad, LEG(NP, 0F, 0, 0xe2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrad, LEG(66, 0F, 0, 0xe2), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(packsswb, LEG(NP, 0F, 0, 0x63), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packsswb, LEG(66, 0F, 0, 0x63), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packssdw, LEG(66, 0F, 0, 0x6b), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(packuswb, LEG(NP, 0F, 0, 0x67), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packuswb, LEG(66, 0F, 0, 0x67), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckhbw, LEG(NP, 0F, 0, 0x68), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhbw, LEG(66, 0F, 0, 0x68), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckhwd, LEG(NP, 0F, 0, 0x69), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhwd, LEG(66, 0F, 0, 0x69), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckhdq, LEG(NP, 0F, 0, 0x6a), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhdq, LEG(66, 0F, 0, 0x6a), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(punpckhqdq, LEG(66, 0F, 0, 0x6d), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
+OPCODE(punpcklbw, LEG(66, 0F, 0, 0x60), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
+OPCODE(punpcklwd, LEG(66, 0F, 0, 0x61), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
+OPCODE(punpckldq, LEG(66, 0F, 0, 0x62), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(punpcklqdq, LEG(66, 0F, 0, 0x6c), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(unpcklps, LEG(NP, 0F, 0, 0x14), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(unpcklpd, LEG(66, 0F, 0, 0x14), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(unpckhps, LEG(NP, 0F, 0, 0x15), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(unpckhpd, LEG(66, 0F, 0, 0x15), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pshufw, LEG(NP, 0F, 0, 0x70), SSE, WRR, Pq, Qq, Ib)
+OPCODE(pshuflw, LEG(F2, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
+OPCODE(pshufhw, LEG(F3, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
+OPCODE(pshufd, LEG(66, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
 OPCODE(shufps, LEG(NP, 0F, 0, 0xc6), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(shufpd, LEG(66, 0F, 0, 0xc6), SSE2, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(pinsrw, LEG(NP, 0F, 0, 0xc4), SSE, WRRR, Pq, Pq, RdMw, Ib)
+OPCODE(pinsrw, LEG(66, 0F, 0, 0xc4), SSE2, WRRR, Vdq, Vdq, RdMw, Ib)
 OPCODE(pextrw, LEG(NP, 0F, 0, 0xc5), SSE, WRR, Gd, Nq, Ib)
 OPCODE(pextrw, LEG(NP, 0F, 1, 0xc5), SSE, WRR, Gq, Nq, Ib)
+OPCODE(pextrw, LEG(66, 0F, 0, 0xc5), SSE2, WRR, Gd, Udq, Ib)
+OPCODE(pextrw, LEG(66, 0F, 1, 0xc5), SSE2, WRR, Gq, Udq, Ib)
 OPCODE(cvtpi2ps, LEG(NP, 0F, 0, 0x2a), SSE, WR, Vdq, Qq)
 OPCODE(cvtsi2ss, LEG(F3, 0F, 0, 0x2a), SSE, WR, Vd, Ed)
 OPCODE(cvtsi2ss, LEG(F3, 0F, 1, 0x2a), SSE, WR, Vd, Eq)
+OPCODE(cvtpi2pd, LEG(66, 0F, 0, 0x2a), SSE2, WR, Vdq, Qq)
+OPCODE(cvtsi2sd, LEG(F2, 0F, 0, 0x2a), SSE2, WR, Vq, Ed)
+OPCODE(cvtsi2sd, LEG(F2, 0F, 1, 0x2a), SSE2, WR, Vq, Eq)
 OPCODE(cvtps2pi, LEG(NP, 0F, 0, 0x2d), SSE, WR, Pq, Wq)
 OPCODE(cvtss2si, LEG(F3, 0F, 0, 0x2d), SSE, WR, Gd, Wd)
 OPCODE(cvtss2si, LEG(F3, 0F, 1, 0x2d), SSE, WR, Gq, Wd)
+OPCODE(cvtpd2pi, LEG(66, 0F, 0, 0x2d), SSE2, WR, Pq, Wdq)
+OPCODE(cvtsd2si, LEG(F2, 0F, 0, 0x2d), SSE2, WR, Gd, Wq)
+OPCODE(cvtsd2si, LEG(F2, 0F, 1, 0x2d), SSE2, WR, Gq, Wq)
 OPCODE(cvttps2pi, LEG(NP, 0F, 0, 0x2c), SSE, WR, Pq, Wq)
 OPCODE(cvttss2si, LEG(F3, 0F, 0, 0x2c), SSE, WR, Gd, Wd)
 OPCODE(cvttss2si, LEG(F3, 0F, 1, 0x2c), SSE, WR, Gq, Wd)
+OPCODE(cvttpd2pi, LEG(66, 0F, 0, 0x2c), SSE2, WR, Pq, Wdq)
+OPCODE(cvttsd2si, LEG(F2, 0F, 0, 0x2c), SSE2, WR, Gd, Wq)
+OPCODE(cvttsd2si, LEG(F2, 0F, 1, 0x2c), SSE2, WR, Gq, Wq)
+OPCODE(cvtpd2dq, LEG(F2, 0F, 0, 0xe6), SSE2, WR, Vdq, Wdq)
+OPCODE(cvttpd2dq, LEG(66, 0F, 0, 0xe6), SSE2, WR, Vdq, Wdq)
+OPCODE(cvtdq2pd, LEG(F3, 0F, 0, 0xe6), SSE2, WR, Vdq, Wq)
+OPCODE(cvtps2pd, LEG(NP, 0F, 0, 0x5a), SSE2, WR, Vdq, Wq)
+OPCODE(cvtpd2ps, LEG(66, 0F, 0, 0x5a), SSE2, WR, Vdq, Wdq)
+OPCODE(cvtss2sd, LEG(F3, 0F, 0, 0x5a), SSE2, WR, Vq, Wd)
+OPCODE(cvtsd2ss, LEG(F2, 0F, 0, 0x5a), SSE2, WR, Vd, Wq)
+OPCODE(cvtdq2ps, LEG(NP, 0F, 0, 0x5b), SSE2, WR, Vdq, Wdq)
+OPCODE(cvtps2dq, LEG(66, 0F, 0, 0x5b), SSE2, WR, Vdq, Wdq)
+OPCODE(cvttps2dq, LEG(F3, 0F, 0, 0x5b), SSE2, WR, Vdq, Wdq)
 OPCODE(maskmovq, LEG(NP, 0F, 0, 0xf7), SSE, RR, Pq, Nq)
+OPCODE(maskmovdqu, LEG(66, 0F, 0, 0xf7), SSE2, RR, Vdq, Udq)
 OPCODE(movntps, LEG(NP, 0F, 0, 0x2b), SSE, WR, Mdq, Vdq)
+OPCODE(movntpd, LEG(66, 0F, 0, 0x2b), SSE2, WR, Mdq, Vdq)
+OPCODE(movnti, LEG(NP, 0F, 0, 0xc3), SSE2, WR, Md, Gd)
+OPCODE(movnti, LEG(NP, 0F, 1, 0xc3), SSE2, WR, Mq, Gq)
 OPCODE(movntq, LEG(NP, 0F, 0, 0xe7), SSE, WR, Mq, Pq)
+OPCODE(movntdq, LEG(66, 0F, 0, 0xe7), SSE2, WR, Mdq, Vdq)
+OPCODE(pause, LEG(F3, NA, 0, 0x90), SSE2, )
 OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
 
+OPCODE_GRP(grp12_LEG_66, LEG(66, 0F, 0, 0x71))
+OPCODE_GRP_BEGIN(grp12_LEG_66)
+    OPCODE_GRPMEMB(grp12_LEG_66, psllw, 6, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp12_LEG_66, psrlw, 2, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp12_LEG_66, psraw, 4, SSE2, WRR, Udq, Udq, Ib)
+OPCODE_GRP_END(grp12_LEG_66)
+
 OPCODE_GRP(grp12_LEG_NP, LEG(NP, 0F, 0, 0x71))
 OPCODE_GRP_BEGIN(grp12_LEG_NP)
     OPCODE_GRPMEMB(grp12_LEG_NP, psllw, 6, MMX, WRR, Nq, Nq, Ib)
@@ -311,6 +618,13 @@ OPCODE_GRP_BEGIN(grp12_LEG_NP)
     OPCODE_GRPMEMB(grp12_LEG_NP, psraw, 4, MMX, WRR, Nq, Nq, Ib)
 OPCODE_GRP_END(grp12_LEG_NP)
 
+OPCODE_GRP(grp13_LEG_66, LEG(66, 0F, 0, 0x72))
+OPCODE_GRP_BEGIN(grp13_LEG_66)
+    OPCODE_GRPMEMB(grp13_LEG_66, pslld, 6, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp13_LEG_66, psrld, 2, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp13_LEG_66, psrad, 4, SSE2, WRR, Udq, Udq, Ib)
+OPCODE_GRP_END(grp13_LEG_66)
+
 OPCODE_GRP(grp13_LEG_NP, LEG(NP, 0F, 0, 0x72))
 OPCODE_GRP_BEGIN(grp13_LEG_NP)
     OPCODE_GRPMEMB(grp13_LEG_NP, pslld, 6, MMX, WRR, Nq, Nq, Ib)
@@ -318,6 +632,14 @@ OPCODE_GRP_BEGIN(grp13_LEG_NP)
     OPCODE_GRPMEMB(grp13_LEG_NP, psrad, 4, MMX, WRR, Nq, Nq, Ib)
 OPCODE_GRP_END(grp13_LEG_NP)
 
+OPCODE_GRP(grp14_LEG_66, LEG(66, 0F, 0, 0x73))
+OPCODE_GRP_BEGIN(grp14_LEG_66)
+    OPCODE_GRPMEMB(grp14_LEG_66, psllq, 6, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp14_LEG_66, pslldq, 7, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp14_LEG_66, psrlq, 2, SSE2, WRR, Udq, Udq, Ib)
+    OPCODE_GRPMEMB(grp14_LEG_66, psrldq, 3, SSE2, WRR, Udq, Udq, Ib)
+OPCODE_GRP_END(grp14_LEG_66)
+
 OPCODE_GRP(grp14_LEG_NP, LEG(NP, 0F, 0, 0x73))
 OPCODE_GRP_BEGIN(grp14_LEG_NP)
     OPCODE_GRPMEMB(grp14_LEG_NP, psllq, 6, MMX, WRR, Nq, Nq, Ib)
@@ -326,7 +648,9 @@ OPCODE_GRP_END(grp14_LEG_NP)
 
 OPCODE_GRP(grp15_LEG_NP, LEG(NP, 0F, 0, 0xae))
 OPCODE_GRP_BEGIN(grp15_LEG_NP)
-    OPCODE_GRPMEMB(grp15_LEG_NP, sfence, 7, SSE, )
+    OPCODE_GRPMEMB(grp15_LEG_NP, sfence_clflush, 7, SSE, RR, modrm_mod, modrm)
+    OPCODE_GRPMEMB(grp15_LEG_NP, lfence, 5, SSE2, )
+    OPCODE_GRPMEMB(grp15_LEG_NP, mfence, 6, SSE2, )
     OPCODE_GRPMEMB(grp15_LEG_NP, ldmxcsr, 2, SSE, R, Md)
     OPCODE_GRPMEMB(grp15_LEG_NP, stmxcsr, 3, SSE, W, Md)
 OPCODE_GRP_END(grp15_LEG_NP)
-- 
2.20.1


