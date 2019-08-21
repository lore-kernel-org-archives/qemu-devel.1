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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910AAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id5TFTc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V7w-0000NH-Sf
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URY-0001W1-3B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URV-0007ro-UH
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:43 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URV-0007qn-Os
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:41 -0400
Received: by mail-yb1-xb43.google.com with SMTP id j199so1342833ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsb+ZcxAmfMO59dSw7a4dzp3XF7GxsSOH97ehlPsfvg=;
 b=id5TFTc+gfjwEBmcLWpFTxKteMstfJBBK0oKgqZ1xl4lfDA5+fjRcijxb1Qp3J1F8w
 j0fynG5kRA100b/3M4+uC4gemW4O2zQMKJFSTlBtu62+LgmRi4RlcvJKkVM1fPlaDUBr
 qzAzlYsui1l1tkPQh2UTuKjV5IKQJUuA/KbmqMHfTgSvQbZDioYHzA2qIg1CJ7ww9aO5
 EfXznVLKqxyJ4Qp28Ivkd8w8p/s1aYp1tWeTkQjBvV9yORlwifig9BOkxBlh48A9ng5l
 o9TUGFVeYWSPjJWdbiw+dbv52WmqjJp6OoEgZoO5N1AhRM0m+zs6lcPpvhgNV4bQpUje
 /Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsb+ZcxAmfMO59dSw7a4dzp3XF7GxsSOH97ehlPsfvg=;
 b=t5aWqeEvY6FeoN10D2mzEyunTmstF56ujj8gNy5i1IdQhDe9Ek+ffFRdRL6MrJwyxI
 XwHbfj9S1UMbd9kBaQ3eUimHDyYaYErlphHbHrKpxFNp15TonUNSCZKaxlNPBdetYvgu
 qNB0OXis5KhAathlf7K1VUh+1ZqJRP0xny5FiutivHN/vG1TIVPEdtThMlc7Na51Cr+W
 wn8bTexnD3za7T82n2I36lB4kr9wbjV09/hcH4hw8Qq4PE2FKtiEIw5LQPa5MtcpfvJk
 /0TACi4fOx8Y2jcjfbnjUTMZbOkGOWW142gxtbMNK6d8VSkYZ/eWmkpudm7gorOh7lwE
 BpUQ==
X-Gm-Message-State: APjAAAXoCgtY3uNi/SsUXPx2CVr/VVKrQ6XR6J3Qgb6UrQh9nMZIwEfu
 +5Pv1vRNakOYQIoF2MLlqeTDyXiM
X-Google-Smtp-Source: APXvYqw+UFpO8/WM1vxAL37VHAqykbEkFlN/UYIEW0VWXNCd87LynOJjKMu79NTrAm65UfApUGbAJw==
X-Received: by 2002:a25:2bc8:: with SMTP id
 r191mr24058302ybr.327.1566408640909; 
 Wed, 21 Aug 2019 10:30:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:40 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:17 -0400
Message-Id: <20190821172951.15333-42-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 41/75] target/i386: introduce SSE vector
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

Add all the SSE vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 161 +++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index e570d449fc..92581703cd 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -104,6 +104,85 @@
  * NP 0F 72 /4 ib       PSRAD mm,imm8
  * NP 0F 73 /6 ib       PSLLQ mm, imm8
  * NP 0F 73 /2 ib       PSRLQ mm, imm8
+ *
+ * SSE Instructions
+ * -----------------
+ * NP 0F 28 /r          MOVAPS xmm1, xmm2/m128
+ * NP 0F 29 /r          MOVAPS xmm2/m128, xmm1
+ * NP 0F 10 /r          MOVUPS xmm1, xmm2/m128
+ * NP 0F 11 /r          MOVUPS xmm2/m128, xmm1
+ * F3 0F 10 /r          MOVSS xmm1, xmm2/m32
+ * F3 0F 11 /r          MOVSS xmm2/m32, xmm1
+ * NP 0F 12 /r          MOVHLPS xmm1, xmm2
+ * NP 0F 12 /r          MOVLPS xmm1, m64
+ * 0F 13 /r             MOVLPS m64, xmm1
+ * NP 0F 16 /r          MOVLHPS xmm1, xmm2
+ * NP 0F 16 /r          MOVHPS xmm1, m64
+ * NP 0F 17 /r          MOVHPS m64, xmm1
+ * NP 0F D7 /r          PMOVMSKB r32, mm
+ * NP REX.W 0F D7 /r    PMOVMSKB r64, mm
+ * NP 0F 50 /r          MOVMSKPS r32, xmm
+ * NP REX.W 0F 50 /r    MOVMSKPS r64, xmm
+ * NP 0F 58 /r          ADDPS xmm1, xmm2/m128
+ * F3 0F 58 /r          ADDSS xmm1, xmm2/m32
+ * NP 0F 5C /r          SUBPS xmm1, xmm2/m128
+ * F3 0F 5C /r          SUBSS xmm1, xmm2/m32
+ * NP 0F E4 /r          PMULHUW mm1, mm2/m64
+ * NP 0F 59 /r          MULPS xmm1, xmm2/m128
+ * F3 0F 59 /r          MULSS xmm1,xmm2/m32
+ * NP 0F 5E /r          DIVPS xmm1, xmm2/m128
+ * F3 0F 5E /r          DIVSS xmm1, xmm2/m32
+ * NP 0F 53 /r          RCPPS xmm1, xmm2/m128
+ * F3 0F 53 /r          RCPSS xmm1, xmm2/m32
+ * NP 0F 51 /r          SQRTPS xmm1, xmm2/m128
+ * F3 0F 51 /r          SQRTSS xmm1, xmm2/m32
+ * NP 0F 52 /r          RSQRTPS xmm1, xmm2/m128
+ * F3 0F 52 /r          RSQRTSS xmm1, xmm2/m32
+ * NP 0F DA /r          PMINUB mm1, mm2/m64
+ * NP 0F EA /r          PMINSW mm1, mm2/m64
+ * NP 0F 5D /r          MINPS xmm1, xmm2/m128
+ * F3 0F 5D /r          MINSS xmm1,xmm2/m32
+ * NP 0F DE /r          PMAXUB mm1, mm2/m64
+ * NP 0F EE /r          PMAXSW mm1, mm2/m64
+ * NP 0F 5F /r          MAXPS xmm1, xmm2/m128
+ * F3 0F 5F /r          MAXSS xmm1, xmm2/m32
+ * NP 0F E0 /r          PAVGB mm1, mm2/m64
+ * NP 0F E3 /r          PAVGW mm1, mm2/m64
+ * NP 0F F6 /r          PSADBW mm1, mm2/m64
+ * NP 0F C2 /r ib       CMPPS xmm1, xmm2/m128, imm8
+ * F3 0F C2 /r ib       CMPSS xmm1, xmm2/m32, imm8
+ * NP 0F 2E /r          UCOMISS xmm1, xmm2/m32
+ * NP 0F 2F /r          COMISS xmm1, xmm2/m32
+ * NP 0F 54 /r          ANDPS xmm1, xmm2/m128
+ * NP 0F 55 /r          ANDNPS xmm1, xmm2/m128
+ * NP 0F 56 /r          ORPS xmm1, xmm2/m128
+ * NP 0F 57 /r          XORPS xmm1, xmm2/m128
+ * NP 0F 14 /r          UNPCKLPS xmm1, xmm2/m128
+ * NP 0F 15 /r          UNPCKHPS xmm1, xmm2/m128
+ * NP 0F 70 /r ib       PSHUFW mm1, mm2/m64, imm8
+ * NP 0F C6 /r ib       SHUFPS xmm1, xmm3/m128, imm8
+ * NP 0F C4 /r ib       PINSRW mm, r32/m16, imm8
+ * NP 0F C5 /r ib       PEXTRW r32, mm, imm8
+ * NP REX.W 0F C5 /r ib PEXTRW r64, mm, imm8
+ * NP 0F 2A /r          CVTPI2PS xmm, mm/m64
+ * F3 0F 2A /r          CVTSI2SS xmm1,r/m32
+ * F3 REX.W 0F 2A /r    CVTSI2SS xmm1,r/m64
+ * NP 0F 2D /r          CVTPS2PI mm, xmm/m64
+ * F3 0F 2D /r          CVTSS2SI r32,xmm1/m32
+ * F3 REX.W 0F 2D /r    CVTSS2SI r64,xmm1/m32
+ * NP 0F 2C /r          CVTTPS2PI mm, xmm/m64
+ * F3 0F 2C /r          CVTTSS2SI r32,xmm1/m32
+ * F3 REX.W 0F 2C /r    CVTTSS2SI r64,xmm1/m32
+ * NP 0F F7 /r          MASKMOVQ mm1, mm2
+ * NP 0F 2B /r          MOVNTPS m128, xmm1
+ * NP 0F E7 /r          MOVNTQ m64, mm
+ * NP 0F AE /7          SFENCE
+ * NP 0F AE /2          LDMXCSR m32
+ * NP 0F AE /3          STMXCSR m32
+ * 0F 18 /1             PREFETCHT0 m8
+ * 0F 18 /2             PREFETCHT1 m8
+ * 0F 18 /3             PREFETCHT2 m8
+ * 0F 18 /0             PREFETCHNTA m8
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -112,6 +191,20 @@ OPCODE(movq, LEG(NP, 0F, 1, 0x6e), MMX, WR, Pq, Eq)
 OPCODE(movq, LEG(NP, 0F, 1, 0x7e), MMX, WR, Eq, Pq)
 OPCODE(movq, LEG(NP, 0F, 0, 0x6f), MMX, WR, Pq, Qq)
 OPCODE(movq, LEG(NP, 0F, 0, 0x7f), MMX, WR, Qq, Pq)
+OPCODE(movaps, LEG(NP, 0F, 0, 0x28), SSE, WR, Vdq, Wdq)
+OPCODE(movaps, LEG(NP, 0F, 0, 0x29), SSE, WR, Wdq, Vdq)
+OPCODE(movups, LEG(NP, 0F, 0, 0x10), SSE, WR, Vdq, Wdq)
+OPCODE(movups, LEG(NP, 0F, 0, 0x11), SSE, WR, Wdq, Vdq)
+OPCODE(movss, LEG(F3, 0F, 0, 0x10), SSE, WRRR, Vdq, Vdq, Wd, modrm_mod)
+OPCODE(movss, LEG(F3, 0F, 0, 0x11), SSE, WR, Wd, Vd)
+OPCODE(movhlps, LEG(NP, 0F, 0, 0x12), SSE, WRR, Vdq, Vdq, UdqMhq)
+OPCODE(movlps, LEG(NP, 0F, 0, 0x13), SSE, WR, Mq, Vq)
+OPCODE(movlhps, LEG(NP, 0F, 0, 0x16), SSE, WRR, Vdq, Vq, Wq)
+OPCODE(movhps, LEG(NP, 0F, 0, 0x17), SSE, WR, Mq, Vdq)
+OPCODE(pmovmskb, LEG(NP, 0F, 0, 0xd7), SSE, WR, Gd, Nq)
+OPCODE(pmovmskb, LEG(NP, 0F, 1, 0xd7), SSE, WR, Gq, Nq)
+OPCODE(movmskps, LEG(NP, 0F, 0, 0x50), SSE, WR, Gd, Udq)
+OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
 OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddd, LEG(NP, 0F, 0, 0xfe), MMX, WRR, Pq, Pq, Qq)
@@ -119,6 +212,8 @@ OPCODE(paddsb, LEG(NP, 0F, 0, 0xec), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
+OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubd, LEG(NP, 0F, 0, 0xfa), MMX, WRR, Pq, Pq, Qq)
@@ -126,19 +221,51 @@ OPCODE(psubsb, LEG(NP, 0F, 0, 0xe8), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
+OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
+OPCODE(mulps, LEG(NP, 0F, 0, 0x59), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(mulss, LEG(F3, 0F, 0, 0x59), SSE, WRR, Vd, Vd, Wd)
 OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
+OPCODE(divps, LEG(NP, 0F, 0, 0x5e), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(divss, LEG(F3, 0F, 0, 0x5e), SSE, WRR, Vd, Vd, Wd)
+OPCODE(rcpps, LEG(NP, 0F, 0, 0x53), SSE, WR, Vdq, Wdq)
+OPCODE(rcpss, LEG(F3, 0F, 0, 0x53), SSE, WR, Vd, Wd)
+OPCODE(sqrtps, LEG(NP, 0F, 0, 0x51), SSE, WR, Vdq, Wdq)
+OPCODE(sqrtss, LEG(F3, 0F, 0, 0x51), SSE, WR, Vd, Wd)
+OPCODE(rsqrtps, LEG(NP, 0F, 0, 0x52), SSE, WR, Vdq, Wdq)
+OPCODE(rsqrtss, LEG(F3, 0F, 0, 0x52), SSE, WR, Vd, Wd)
+OPCODE(pminub, LEG(NP, 0F, 0, 0xda), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pminsw, LEG(NP, 0F, 0, 0xea), SSE, WRR, Pq, Pq, Qq)
+OPCODE(minps, LEG(NP, 0F, 0, 0x5d), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(minss, LEG(F3, 0F, 0, 0x5d), SSE, WRR, Vd, Vd, Wd)
+OPCODE(pmaxub, LEG(NP, 0F, 0, 0xde), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pmaxsw, LEG(NP, 0F, 0, 0xee), SSE, WRR, Pq, Pq, Qq)
+OPCODE(maxps, LEG(NP, 0F, 0, 0x5f), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(maxss, LEG(F3, 0F, 0, 0x5f), SSE, WRR, Vd, Vd, Wd)
+OPCODE(pavgb, LEG(NP, 0F, 0, 0xe0), SSE, WRR, Pq, Pq, Qq)
+OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
+OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
+OPCODE(cmpps, LEG(NP, 0F, 0, 0xc2), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(cmpss, LEG(F3, 0F, 0, 0xc2), SSE, WRRR, Vd, Vd, Wd, Ib)
+OPCODE(ucomiss, LEG(NP, 0F, 0, 0x2e), SSE, RR, Vd, Wd)
+OPCODE(comiss, LEG(NP, 0F, 0, 0x2f), SSE, RR, Vd, Wd)
 OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(andps, LEG(NP, 0F, 0, 0x54), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
+OPCODE(andnps, LEG(NP, 0F, 0, 0x55), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
+OPCODE(orps, LEG(NP, 0F, 0, 0x56), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
+OPCODE(xorps, LEG(NP, 0F, 0, 0x57), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pslld, LEG(NP, 0F, 0, 0xf2), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psllq, LEG(NP, 0F, 0, 0xf3), MMX, WRR, Pq, Pq, Qq)
@@ -156,6 +283,25 @@ OPCODE(punpckhdq, LEG(NP, 0F, 0, 0x6a), MMX, WRR, Pq, Pq, Qq)
 OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
 OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
 OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
+OPCODE(unpcklps, LEG(NP, 0F, 0, 0x14), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(unpckhps, LEG(NP, 0F, 0, 0x15), SSE, WRR, Vdq, Vdq, Wdq)
+OPCODE(pshufw, LEG(NP, 0F, 0, 0x70), SSE, WRR, Pq, Qq, Ib)
+OPCODE(shufps, LEG(NP, 0F, 0, 0xc6), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(pinsrw, LEG(NP, 0F, 0, 0xc4), SSE, WRRR, Pq, Pq, RdMw, Ib)
+OPCODE(pextrw, LEG(NP, 0F, 0, 0xc5), SSE, WRR, Gd, Nq, Ib)
+OPCODE(pextrw, LEG(NP, 0F, 1, 0xc5), SSE, WRR, Gq, Nq, Ib)
+OPCODE(cvtpi2ps, LEG(NP, 0F, 0, 0x2a), SSE, WR, Vdq, Qq)
+OPCODE(cvtsi2ss, LEG(F3, 0F, 0, 0x2a), SSE, WR, Vd, Ed)
+OPCODE(cvtsi2ss, LEG(F3, 0F, 1, 0x2a), SSE, WR, Vd, Eq)
+OPCODE(cvtps2pi, LEG(NP, 0F, 0, 0x2d), SSE, WR, Pq, Wq)
+OPCODE(cvtss2si, LEG(F3, 0F, 0, 0x2d), SSE, WR, Gd, Wd)
+OPCODE(cvtss2si, LEG(F3, 0F, 1, 0x2d), SSE, WR, Gq, Wd)
+OPCODE(cvttps2pi, LEG(NP, 0F, 0, 0x2c), SSE, WR, Pq, Wq)
+OPCODE(cvttss2si, LEG(F3, 0F, 0, 0x2c), SSE, WR, Gd, Wd)
+OPCODE(cvttss2si, LEG(F3, 0F, 1, 0x2c), SSE, WR, Gq, Wd)
+OPCODE(maskmovq, LEG(NP, 0F, 0, 0xf7), SSE, RR, Pq, Nq)
+OPCODE(movntps, LEG(NP, 0F, 0, 0x2b), SSE, WR, Mdq, Vdq)
+OPCODE(movntq, LEG(NP, 0F, 0, 0xe7), SSE, WR, Mq, Pq)
 OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
 
 OPCODE_GRP(grp12_LEG_NP, LEG(NP, 0F, 0, 0x71))
@@ -178,6 +324,21 @@ OPCODE_GRP_BEGIN(grp14_LEG_NP)
     OPCODE_GRPMEMB(grp14_LEG_NP, psrlq, 2, MMX, WRR, Nq, Nq, Ib)
 OPCODE_GRP_END(grp14_LEG_NP)
 
+OPCODE_GRP(grp15_LEG_NP, LEG(NP, 0F, 0, 0xae))
+OPCODE_GRP_BEGIN(grp15_LEG_NP)
+    OPCODE_GRPMEMB(grp15_LEG_NP, sfence, 7, SSE, )
+    OPCODE_GRPMEMB(grp15_LEG_NP, ldmxcsr, 2, SSE, R, Md)
+    OPCODE_GRPMEMB(grp15_LEG_NP, stmxcsr, 3, SSE, W, Md)
+OPCODE_GRP_END(grp15_LEG_NP)
+
+OPCODE_GRP(grp16_LEG_NP, LEG(NP, 0F, 0, 0x18))
+OPCODE_GRP_BEGIN(grp16_LEG_NP)
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht0, 1, SSE, R, Mb)
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht1, 2, SSE, R, Mb)
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht2, 3, SSE, R, Mb)
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetchnta, 0, SSE, R, Mb)
+OPCODE_GRP_END(grp16_LEG_NP)
+
 #undef FMTI____
 #undef FMTI__R__
 #undef FMTI__RR__
-- 
2.20.1


