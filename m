Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BABC3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1680C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQk1ikQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1680C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VEw-0002hZ-O9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URU-0001R4-G5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URS-0007nY-SR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:40 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URS-0007mv-L2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:38 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s142so1341448ybc.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J3PXpQ6i3FSUXXhz2as2ONuMwdI/5nd0+9IeX01O4wY=;
 b=AQk1ikQAXV/wYhzN1nfDrpUKTohk+KholUSnmTeIL9EPuR+7XNw9RvPOciFdBB91GC
 oJmSLf5yOCr1IS2MJEu5pfuXT2FB428zbhAWsZPxO77xK9mjJLUxWC/qM0IYMG3nVwwN
 Ne9NDHhQCuwe+QK4lQNELBnVBYAxBo3Ul6WQa9M4hDb8iozbUN8n+fRdRcRC8SuOFExV
 vmWBR17+6ruUn9h7n5CcFVyXHQcsXe1K7gj/+n1UZGOpLmIABPEP6aWOEUeyxH1Gictx
 GVsnVRfWNw2agSuxv8Ht+mH5Ldtkx0E9RGHJSPTMmm17Adm27KzOqe3YdiD1a6XyrLfz
 yuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J3PXpQ6i3FSUXXhz2as2ONuMwdI/5nd0+9IeX01O4wY=;
 b=FXDqUe3Xdx0vYkz3v6X5cg3lL0Ldx4g3ZN+Ekc90K8pKFhYkY+HkNzoGloqiP6OYb/
 VhAFQXjHe8oA3pDSLVxQCCh5wDvMDfnJ2xcYHpYLnFD+iK6W+L0Wfrqu2pbx+47sw0Gg
 dJcnjpzgeAM7AaBp12+4+mLgoSE3B9qlgFfuzZH4Uey1cH97f1FltTD9VOoWliSyrK8V
 EsS8wNc8BuP1GPLGTilp6U3CYMNlE8ePKCTSN2UA8i5xesCGuEWrDkq+WAQdWVKYqMST
 6EzKpXDZVrZTBJeqUb3brvC5chhuY4ZgGHNPwZs+U8tOPYJ/HVcbMzGAFTgKvBxZ0eRq
 YqYQ==
X-Gm-Message-State: APjAAAXcaK3sFsE9/HsYQnS9hBXxjvVdL46WyIc+nOIEA94znocv+bT3
 isL8z7GChTO22DvxpcW3yWZvgGiL
X-Google-Smtp-Source: APXvYqwl4epSS55/boztUgO7H9t9hnYoeE8q0z4PmvwkELasym/b6KZPcydqfMeCpnx1aOoRTxuzJA==
X-Received: by 2002:a25:ba91:: with SMTP id s17mr23287214ybg.460.1566408637554; 
 Wed, 21 Aug 2019 10:30:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:37 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:14 -0400
Message-Id: <20190821172951.15333-39-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 38/75] target/i386: introduce MMX vector
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

Add all MMX vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 136 +++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 04d0c49168..e570d449fc 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -42,6 +42,142 @@
 #   define OPCODE_GRP_END(grpname)
 #endif /* OPCODE_GRP_END */
 
+/*
+ * MMX Instructions
+ * -----------------
+ * NP 0F 6E /r          MOVD mm,r/m32
+ * NP 0F 7E /r          MOVD r/m32,mm
+ * NP REX.W + 0F 6E /r  MOVQ mm,r/m64
+ * NP REX.W + 0F 7E /r  MOVQ r/m64,mm
+ * NP 0F 6F /r          MOVQ mm, mm/m64
+ * NP 0F 7F /r          MOVQ mm/m64, mm
+ * NP 0F FC /r          PADDB mm, mm/m64
+ * NP 0F FD /r          PADDW mm, mm/m64
+ * NP 0F FE /r          PADDD mm, mm/m64
+ * NP 0F EC /r          PADDSB mm, mm/m64
+ * NP 0F ED /r          PADDSW mm, mm/m64
+ * NP 0F DC /r          PADDUSB mm,mm/m64
+ * NP 0F DD /r          PADDUSW mm,mm/m64
+ * NP 0F F8 /r          PSUBB mm, mm/m64
+ * NP 0F F9 /r          PSUBW mm, mm/m64
+ * NP 0F FA /r          PSUBD mm, mm/m64
+ * NP 0F E8 /r          PSUBSB mm, mm/m64
+ * NP 0F E9 /r          PSUBSW mm, mm/m64
+ * NP 0F D8 /r          PSUBUSB mm, mm/m64
+ * NP 0F D9 /r          PSUBUSW mm, mm/m64
+ * NP 0F D5 /r          PMULLW mm, mm/m64
+ * NP 0F E5 /r          PMULHW mm, mm/m64
+ * NP 0F F5 /r          PMADDWD mm, mm/m64
+ * NP 0F 74 /r          PCMPEQB mm,mm/m64
+ * NP 0F 75 /r          PCMPEQW mm,mm/m64
+ * NP 0F 76 /r          PCMPEQD mm,mm/m64
+ * NP 0F 64 /r          PCMPGTB mm,mm/m64
+ * NP 0F 65 /r          PCMPGTW mm,mm/m64
+ * NP 0F 66 /r          PCMPGTD mm,mm/m64
+ * NP 0F DB /r          PAND mm, mm/m64
+ * NP 0F DF /r          PANDN mm, mm/m64
+ * NP 0F EB /r          POR mm, mm/m64
+ * NP 0F EF /r          PXOR mm, mm/m64
+ * NP 0F F1 /r          PSLLW mm, mm/m64
+ * NP 0F F2 /r          PSLLD mm, mm/m64
+ * NP 0F F3 /r          PSLLQ mm, mm/m64
+ * NP 0F D1 /r          PSRLW mm, mm/m64
+ * NP 0F D2 /r          PSRLD mm, mm/m64
+ * NP 0F D3 /r          PSRLQ mm, mm/m64
+ * NP 0F E1 /r          PSRAW mm,mm/m64
+ * NP 0F E2 /r          PSRAD mm,mm/m64
+ * NP 0F 63 /r          PACKSSWB mm1, mm2/m64
+ * NP 0F 6B /r          PACKSSDW mm1, mm2/m64
+ * NP 0F 67 /r          PACKUSWB mm, mm/m64
+ * NP 0F 68 /r          PUNPCKHBW mm, mm/m64
+ * NP 0F 69 /r          PUNPCKHWD mm, mm/m64
+ * NP 0F 6A /r          PUNPCKHDQ mm, mm/m64
+ * NP 0F 60 /r          PUNPCKLBW mm, mm/m32
+ * NP 0F 61 /r          PUNPCKLWD mm, mm/m32
+ * NP 0F 62 /r          PUNPCKLDQ mm, mm/m32
+ * NP 0F 77             EMMS
+ * NP 0F 71 /6 ib       PSLLW mm1, imm8
+ * NP 0F 71 /2 ib       PSRLW mm, imm8
+ * NP 0F 71 /4 ib       PSRAW mm,imm8
+ * NP 0F 72 /6 ib       PSLLD mm, imm8
+ * NP 0F 72 /2 ib       PSRLD mm, imm8
+ * NP 0F 72 /4 ib       PSRAD mm,imm8
+ * NP 0F 73 /6 ib       PSLLQ mm, imm8
+ * NP 0F 73 /2 ib       PSRLQ mm, imm8
+ */
+
+OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
+OPCODE(movd, LEG(NP, 0F, 0, 0x7e), MMX, WR, Ed, Pq)
+OPCODE(movq, LEG(NP, 0F, 1, 0x6e), MMX, WR, Pq, Eq)
+OPCODE(movq, LEG(NP, 0F, 1, 0x7e), MMX, WR, Eq, Pq)
+OPCODE(movq, LEG(NP, 0F, 0, 0x6f), MMX, WR, Pq, Qq)
+OPCODE(movq, LEG(NP, 0F, 0, 0x7f), MMX, WR, Qq, Pq)
+OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddd, LEG(NP, 0F, 0, 0xfe), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddsb, LEG(NP, 0F, 0, 0xec), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
+OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubd, LEG(NP, 0F, 0, 0xfa), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubsb, LEG(NP, 0F, 0, 0xe8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
+OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pslld, LEG(NP, 0F, 0, 0xf2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psllq, LEG(NP, 0F, 0, 0xf3), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrlw, LEG(NP, 0F, 0, 0xd1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrld, LEG(NP, 0F, 0, 0xd2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrlq, LEG(NP, 0F, 0, 0xd3), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psraw, LEG(NP, 0F, 0, 0xe1), MMX, WRR, Pq, Pq, Qq)
+OPCODE(psrad, LEG(NP, 0F, 0, 0xe2), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packsswb, LEG(NP, 0F, 0, 0x63), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
+OPCODE(packuswb, LEG(NP, 0F, 0, 0x67), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhbw, LEG(NP, 0F, 0, 0x68), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhwd, LEG(NP, 0F, 0, 0x69), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpckhdq, LEG(NP, 0F, 0, 0x6a), MMX, WRR, Pq, Pq, Qq)
+OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
+OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
+OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
+OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
+
+OPCODE_GRP(grp12_LEG_NP, LEG(NP, 0F, 0, 0x71))
+OPCODE_GRP_BEGIN(grp12_LEG_NP)
+    OPCODE_GRPMEMB(grp12_LEG_NP, psllw, 6, MMX, WRR, Nq, Nq, Ib)
+    OPCODE_GRPMEMB(grp12_LEG_NP, psrlw, 2, MMX, WRR, Nq, Nq, Ib)
+    OPCODE_GRPMEMB(grp12_LEG_NP, psraw, 4, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp12_LEG_NP)
+
+OPCODE_GRP(grp13_LEG_NP, LEG(NP, 0F, 0, 0x72))
+OPCODE_GRP_BEGIN(grp13_LEG_NP)
+    OPCODE_GRPMEMB(grp13_LEG_NP, pslld, 6, MMX, WRR, Nq, Nq, Ib)
+    OPCODE_GRPMEMB(grp13_LEG_NP, psrld, 2, MMX, WRR, Nq, Nq, Ib)
+    OPCODE_GRPMEMB(grp13_LEG_NP, psrad, 4, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp13_LEG_NP)
+
+OPCODE_GRP(grp14_LEG_NP, LEG(NP, 0F, 0, 0x73))
+OPCODE_GRP_BEGIN(grp14_LEG_NP)
+    OPCODE_GRPMEMB(grp14_LEG_NP, psllq, 6, MMX, WRR, Nq, Nq, Ib)
+    OPCODE_GRPMEMB(grp14_LEG_NP, psrlq, 2, MMX, WRR, Nq, Nq, Ib)
+OPCODE_GRP_END(grp14_LEG_NP)
+
 #undef FMTI____
 #undef FMTI__R__
 #undef FMTI__RR__
-- 
2.20.1


