Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DBC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C0B208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxv5q8mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C0B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5ng-0001ei-KW
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Di-0006Qu-Hw
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dg-0000Ki-S8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:30 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dg-0000KJ-N6
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:28 -0400
Received: by mail-yw1-xc43.google.com with SMTP id e65so307189ywh.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YAFcdKLU/wuX+zS9zd557KA961hwea+B01MnE+gI14k=;
 b=oxv5q8mF4ud7oXxehddLjWFtY56/DlvYUOganMaKIlsvBxP/kCPcguuuYg6M3NOebS
 dDLZOdqv04iA1Rf8lQMGYr6c6fIDVTUlyPPdnT4nzfNi3W8WQqYm5mKlLbUU/QwEP/ID
 k0wlzmjHluk9MgCHJ9SoD4cD9P7oA+1kX7Bc25mTgsaHnKPEWYZhqAzWv5yQgXEkGOuu
 q/8lDMf3wCkoiiFZQnRaMCrYcC2XWaFn2FbareHx4hAmMFo2d+gngiNq0NA7WiyurhL7
 60jzm8m7pSsMELe0c+8jFZfO8gXfxK9SpQIE87OJldxnextRByRVQPEnODv7+05+tFfc
 6Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YAFcdKLU/wuX+zS9zd557KA961hwea+B01MnE+gI14k=;
 b=LjMdnPAQ/OKLFVHvaV4XlchnMesRA9qPo7aOJqv2a9D/VkBhX4Z3CPoomm+iGUTN6+
 i4gYaL8nj6e8/EXk44YNgm6vLq5172WvxAQbISChobVBh9w0xX1HIvR6KherzCvEfHWV
 jpIoygMO75K7Wsp3MZPeBHqoRJprsb1n3OVVYiRYHyPikP6fuY9kOr97MeC1HnqjGQd+
 DXxpaaiw0p+oqeTmjBRpKwsd7c3gaJaHuRy/yFTUH78XaSUKCPuwdYHrtHjOT0QNeSjT
 7BBCBC8mBwlRSz/KsT/QHnC/ghUt/F3M4QopiaZpltqjM0G0oXL/eQxW6xLx7SzKEIhE
 OexA==
X-Gm-Message-State: APjAAAUxom1Q0QshqbxdIfuqgvtkfUdfmne0QSFQxpeVC+WjrO5tqWX9
 v1Xnb2cUHg6y24FDQsAelwVQ13vh
X-Google-Smtp-Source: APXvYqyEQjnEhumjeSZbEQqCyjdlUrG/6h9iB2xO7rM0t7wRog+kS/bTakeY/HCDg9L8liAUD+Efrw==
X-Received: by 2002:a81:8501:: with SMTP id v1mr1557260ywf.187.1565835028024; 
 Wed, 14 Aug 2019 19:10:28 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:27 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:19 -0400
Message-Id: <20190815020928.9679-38-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 37/46] target/i386: introduce MMX
 instructions to sse-opcode.inc.h
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

Add all MMX instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 131 +++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index c5e81a6a80..36963e5a7c 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -39,6 +39,137 @@
 #   define OPCODE_GRP_END(grpname)
 #endif /* OPCODE_GRP_END */
 
+/* NP 0F 6E /r: MOVD mm,r/m32 */
+OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
+/* NP 0F 7E /r: MOVD r/m32,mm */
+OPCODE(movd, LEG(NP, 0F, 0, 0x7e), MMX, WR, Ed, Pq)
+/* NP REX.W + 0F 6E /r: MOVQ mm,r/m64 */
+OPCODE(movq, LEG(NP, 0F, 1, 0x6e), MMX, WR, Pq, Eq)
+/* NP REX.W + 0F 7E /r: MOVQ r/m64,mm */
+OPCODE(movq, LEG(NP, 0F, 1, 0x7e), MMX, WR, Eq, Pq)
+/* NP 0F 6F /r: MOVQ mm, mm/m64 */
+OPCODE(movq, LEG(NP, 0F, 0, 0x6f), MMX, WR, Pq, Qq)
+/* NP 0F 7F /r: MOVQ mm/m64, mm */
+OPCODE(movq, LEG(NP, 0F, 0, 0x7f), MMX, WR, Qq, Pq)
+/* NP 0F FC /r: PADDB mm, mm/m64 */
+OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F FD /r: PADDW mm, mm/m64 */
+OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F FE /r: PADDD mm, mm/m64 */
+OPCODE(paddd, LEG(NP, 0F, 0, 0xfe), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F EC /r: PADDSB mm, mm/m64 */
+OPCODE(paddsb, LEG(NP, 0F, 0, 0xec), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F ED /r: PADDSW mm, mm/m64 */
+OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F DC /r: PADDUSB mm,mm/m64 */
+OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F DD /r: PADDUSW mm,mm/m64 */
+OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F8 /r: PSUBB mm, mm/m64 */
+OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F9 /r: PSUBW mm, mm/m64 */
+OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F FA /r: PSUBD mm, mm/m64 */
+OPCODE(psubd, LEG(NP, 0F, 0, 0xfa), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E8 /r: PSUBSB mm, mm/m64 */
+OPCODE(psubsb, LEG(NP, 0F, 0, 0xe8), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E9 /r: PSUBSW mm, mm/m64 */
+OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D8 /r: PSUBUSB mm, mm/m64 */
+OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D9 /r: PSUBUSW mm, mm/m64 */
+OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D5 /r: PMULLW mm, mm/m64 */
+OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E5 /r: PMULHW mm, mm/m64 */
+OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F5 /r: PMADDWD mm, mm/m64 */
+OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 74 /r: PCMPEQB mm,mm/m64 */
+OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 75 /r: PCMPEQW mm,mm/m64 */
+OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 76 /r: PCMPEQD mm,mm/m64 */
+OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 64 /r: PCMPGTB mm,mm/m64 */
+OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 65 /r: PCMPGTW mm,mm/m64 */
+OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 66 /r: PCMPGTD mm,mm/m64 */
+OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F DB /r: PAND mm, mm/m64 */
+OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F DF /r: PANDN mm, mm/m64 */
+OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F EB /r: POR mm, mm/m64 */
+OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F EF /r: PXOR mm, mm/m64 */
+OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F1 /r: PSLLW mm, mm/m64 */
+OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F2 /r: PSLLD mm, mm/m64 */
+OPCODE(pslld, LEG(NP, 0F, 0, 0xf2), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F F3 /r: PSLLQ mm, mm/m64 */
+OPCODE(psllq, LEG(NP, 0F, 0, 0xf3), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D1 /r: PSRLW mm, mm/m64 */
+OPCODE(psrlw, LEG(NP, 0F, 0, 0xd1), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D2 /r: PSRLD mm, mm/m64 */
+OPCODE(psrld, LEG(NP, 0F, 0, 0xd2), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F D3 /r: PSRLQ mm, mm/m64 */
+OPCODE(psrlq, LEG(NP, 0F, 0, 0xd3), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E1 /r: PSRAW mm,mm/m64 */
+OPCODE(psraw, LEG(NP, 0F, 0, 0xe1), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E2 /r: PSRAD mm,mm/m64 */
+OPCODE(psrad, LEG(NP, 0F, 0, 0xe2), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 63 /r: PACKSSWB mm1, mm2/m64 */
+OPCODE(packsswb, LEG(NP, 0F, 0, 0x63), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 6B /r: PACKSSDW mm1, mm2/m64 */
+OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 67 /r: PACKUSWB mm, mm/m64 */
+OPCODE(packuswb, LEG(NP, 0F, 0, 0x67), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 68 /r: PUNPCKHBW mm, mm/m64 */
+OPCODE(punpckhbw, LEG(NP, 0F, 0, 0x68), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 69 /r: PUNPCKHWD mm, mm/m64 */
+OPCODE(punpckhwd, LEG(NP, 0F, 0, 0x69), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 6A /r: PUNPCKHDQ mm, mm/m64 */
+OPCODE(punpckhdq, LEG(NP, 0F, 0, 0x6a), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 60 /r: PUNPCKLBW mm, mm/m32 */
+OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
+/* NP 0F 61 /r: PUNPCKLWD mm, mm/m32 */
+OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
+/* NP 0F 62 /r: PUNPCKLDQ mm, mm/m32 */
+OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
+/* NP 0F 77: EMMS */
+OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
+
+OPCODE_GRP(grp12_LEG_NP, LEG(NP, 0F, 0, 0x71))
+OPCODE_GRP_BEGIN(grp12_LEG_NP)
+    /* NP 0F 71 /6 ib: PSLLW mm1, imm8 */
+    OPCODE_GRPMEMB(grp12_LEG_NP, psllw, 6, MMX, WRR, Nq, Nq, Ib)
+    /* NP 0F 71 /2 ib: PSRLW mm, imm8 */
+    OPCODE_GRPMEMB(grp12_LEG_NP, psrlw, 2, MMX, WRR, Nq, Nq, Ib)
+    /* NP 0F 71 /4 ib: PSRAW mm,imm8 */
+    OPCODE_GRPMEMB(grp12_LEG_NP, psraw, 4, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp12_LEG_NP)
+
+OPCODE_GRP(grp13_LEG_NP, LEG(NP, 0F, 0, 0x72))
+OPCODE_GRP_BEGIN(grp13_LEG_NP)
+    /* NP 0F 72 /6 ib: PSLLD mm, imm8 */
+    OPCODE_GRPMEMB(grp13_LEG_NP, pslld, 6, MMX, WRR, Nq, Nq, Ib)
+    /* NP 0F 72 /2 ib: PSRLD mm, imm8 */
+    OPCODE_GRPMEMB(grp13_LEG_NP, psrld, 2, MMX, WRR, Nq, Nq, Ib)
+    /* NP 0F 72 /4 ib: PSRAD mm,imm8 */
+    OPCODE_GRPMEMB(grp13_LEG_NP, psrad, 4, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp13_LEG_NP)
+
+OPCODE_GRP(grp14_LEG_NP, LEG(NP, 0F, 0, 0x73))
+OPCODE_GRP_BEGIN(grp14_LEG_NP)
+    /* NP 0F 73 /6 ib: PSLLQ mm, imm8 */
+    OPCODE_GRPMEMB(grp14_LEG_NP, psllq, 6, MMX, WRR, Nq, Nq, Ib)
+    /* NP 0F 73 /2 ib: PSRLQ mm, imm8 */
+    OPCODE_GRPMEMB(grp14_LEG_NP, psrlq, 2, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp14_LEG_NP)
+
 #undef FMTI____
 #undef FMTI__R__
 #undef FMTI__RR__
-- 
2.20.1


