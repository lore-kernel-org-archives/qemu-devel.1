Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F3C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7302208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5LVCKz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7302208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5pe-0004Rf-Ri
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dl-0006Vm-W0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dj-0000RX-Qc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:33 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:38763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dj-0000Qg-Ky
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:31 -0400
Received: by mail-yw1-xc44.google.com with SMTP id f187so297488ywa.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y75N1nCChARzhBzkkJVMvdqN1QUUf7tayOoPoLK9798=;
 b=V5LVCKz4NNl1urQ5i7NREzF3vdSAVKIfc0XAuP0y1psfNeHN54COB9kQP7XnhitpSZ
 TZgNovMm1He9XkzTitZaubnoSr6b1zLLPZF1RywW/r3H7ybGujLrctKxuX8cw34VorSj
 1JZQuI1d2KsihWz3GNG4Glku0+COSTTuYQhL8fmlUmKZcQF3M1e2plFAr0WodWwlDPih
 V/J3N2tPo4+6ym1YsBWIyFUijAcOt3N+zDBDC4MPhrRBxv8dhgVtIIgBg29j7I6wPfLv
 b99lxdW2853uppA9SRSj0Dtm2G3ftsVEM4yept6FwisGyfCBdFOgLm5VhwX3NI/HhtSG
 pAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y75N1nCChARzhBzkkJVMvdqN1QUUf7tayOoPoLK9798=;
 b=Gj7JWWMVLa9aozrmqtlwcwjL3qjFVbkNNPToWf9DUbH/tAwaYBRcID9n0O+irY0HxY
 B+dZSHE0ZtQo/e0o24URc7yZ/sV43uoyY9wR9Hc2xQ5MqCYoVU0IjdA51i9A9O/NLLdK
 Vx2tzwnbuWQ9prrVWCBgf5B/BClHMzitXAq1MlWuRrYqOl8lx4WPQYbcbETtNu5SFSmM
 tUCGTLmiZekGOg0tuLdc5quP0BAJ82mt7tVAHa9Ut0SkkUkbskHNQNLuHhlucBjrYRl1
 C1jLOxDIUcgMqQKiJqmc7lpyVf/LHAY96lHL9DPOPPyEXU+xG1fZVWgNO6dmaw6U2img
 NFew==
X-Gm-Message-State: APjAAAUYx/wWzO9VIdWUJzsa+k40UvETAdr6+TmsNpX+uWX9y06eH7MB
 4OcPB+olIc6LmWlimi7doO50yYYN
X-Google-Smtp-Source: APXvYqycesvVjuNo+X3cp8ww56GlcqWVD0cEc8vKg5uhvMJjxLwoVwxyt88sWLZovmfV7an1WWbZvg==
X-Received: by 2002:a81:9c0f:: with SMTP id m15mr1545651ywa.495.1565835030789; 
 Wed, 14 Aug 2019 19:10:30 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:30 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:22 -0400
Message-Id: <20190815020928.9679-41-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 40/46] target/i386: introduce SSE
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

Add all the SSE instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 158 +++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 36963e5a7c..39947aeb51 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -51,6 +51,36 @@ OPCODE(movq, LEG(NP, 0F, 1, 0x7e), MMX, WR, Eq, Pq)
 OPCODE(movq, LEG(NP, 0F, 0, 0x6f), MMX, WR, Pq, Qq)
 /* NP 0F 7F /r: MOVQ mm/m64, mm */
 OPCODE(movq, LEG(NP, 0F, 0, 0x7f), MMX, WR, Qq, Pq)
+/* NP 0F 28 /r: MOVAPS xmm1, xmm2/m128 */
+OPCODE(movaps, LEG(NP, 0F, 0, 0x28), SSE, WR, Vdq, Wdq)
+/* NP 0F 29 /r: MOVAPS xmm2/m128, xmm1 */
+OPCODE(movaps, LEG(NP, 0F, 0, 0x29), SSE, WR, Wdq, Vdq)
+/* NP 0F 10 /r: MOVUPS xmm1, xmm2/m128 */
+OPCODE(movups, LEG(NP, 0F, 0, 0x10), SSE, WR, Vdq, Wdq)
+/* NP 0F 11 /r: MOVUPS xmm2/m128, xmm1 */
+OPCODE(movups, LEG(NP, 0F, 0, 0x11), SSE, WR, Wdq, Vdq)
+/* F3 0F 10 /r: MOVSS xmm1, xmm2/m32 */
+OPCODE(movss, LEG(F3, 0F, 0, 0x10), SSE, WRRR, Vdq, Vdq, Wd, modrm_mod)
+/* F3 0F 11 /r: MOVSS xmm2/m32, xmm1 */
+OPCODE(movss, LEG(F3, 0F, 0, 0x11), SSE, WR, Wd, Vd)
+/* NP 0F 12 /r: MOVHLPS xmm1, xmm2 */
+/* NP 0F 12 /r: MOVLPS xmm1, m64 */
+OPCODE(movhlps, LEG(NP, 0F, 0, 0x12), SSE, WR, Vq, UdqMhq)
+/* 0F 13 /r: MOVLPS m64, xmm1 */
+OPCODE(movlps, LEG(NP, 0F, 0, 0x13), SSE, WR, Mq, Vq)
+/* NP 0F 16 /r: MOVLHPS xmm1, xmm2 */
+/* NP 0F 16 /r: MOVHPS xmm1, m64 */
+OPCODE(movlhps, LEG(NP, 0F, 0, 0x16), SSE, WRR, Vdq, Vq, Wq)
+/* NP 0F 17 /r: MOVHPS m64, xmm1 */
+OPCODE(movhps, LEG(NP, 0F, 0, 0x17), SSE, WR, Mq, Vdq)
+/* NP 0F D7 /r: PMOVMSKB r32, mm */
+OPCODE(pmovmskb, LEG(NP, 0F, 0, 0xd7), SSE, WR, Gd, Nq)
+/* NP REX.W 0F D7 /r: PMOVMSKB r64, mm */
+OPCODE(pmovmskb, LEG(NP, 0F, 1, 0xd7), SSE, WR, Gq, Nq)
+/* NP 0F 50 /r: MOVMSKPS r32, xmm */
+OPCODE(movmskps, LEG(NP, 0F, 0, 0x50), SSE, WR, Gd, Udq)
+/* NP REX.W 0F 50 /r: MOVMSKPS r64, xmm */
+OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
 /* NP 0F FC /r: PADDB mm, mm/m64 */
 OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F FD /r: PADDW mm, mm/m64 */
@@ -65,6 +95,10 @@ OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F DD /r: PADDUSW mm,mm/m64 */
 OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 58 /r: ADDPS xmm1, xmm2/m128 */
+OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 58 /r: ADDSS xmm1, xmm2/m32 */
+OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
 /* NP 0F F8 /r: PSUBB mm, mm/m64 */
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F F9 /r: PSUBW mm, mm/m64 */
@@ -79,12 +113,60 @@ OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F D9 /r: PSUBUSW mm, mm/m64 */
 OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 5C /r: SUBPS xmm1, xmm2/m128 */
+OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 5C /r: SUBSS xmm1, xmm2/m32 */
+OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
 /* NP 0F D5 /r: PMULLW mm, mm/m64 */
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F E5 /r: PMULHW mm, mm/m64 */
 OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F E4 /r: PMULHUW mm1, mm2/m64 */
+OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F 59 /r: MULPS xmm1, xmm2/m128 */
+OPCODE(mulps, LEG(NP, 0F, 0, 0x59), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 59 /r: MULSS xmm1,xmm2/m32 */
+OPCODE(mulss, LEG(F3, 0F, 0, 0x59), SSE, WRR, Vd, Vd, Wd)
 /* NP 0F F5 /r: PMADDWD mm, mm/m64 */
 OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 5E /r: DIVPS xmm1, xmm2/m128 */
+OPCODE(divps, LEG(NP, 0F, 0, 0x5e), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 5E /r: DIVSS xmm1, xmm2/m32 */
+OPCODE(divss, LEG(F3, 0F, 0, 0x5e), SSE, WRR, Vd, Vd, Wd)
+/* NP 0F 53 /r: RCPPS xmm1, xmm2/m128 */
+OPCODE(rcpps, LEG(NP, 0F, 0, 0x53), SSE, WR, Vdq, Wdq)
+/* F3 0F 53 /r: RCPSS xmm1, xmm2/m32 */
+OPCODE(rcpss, LEG(F3, 0F, 0, 0x53), SSE, WR, Vd, Wd)
+/* NP 0F 51 /r: SQRTPS xmm1, xmm2/m128 */
+OPCODE(sqrtps, LEG(NP, 0F, 0, 0x51), SSE, WR, Vdq, Wdq)
+/* F3 0F 51 /r: SQRTSS xmm1, xmm2/m32 */
+OPCODE(sqrtss, LEG(F3, 0F, 0, 0x51), SSE, WR, Vd, Wd)
+/* NP 0F 52 /r: RSQRTPS xmm1, xmm2/m128 */
+OPCODE(rsqrtps, LEG(NP, 0F, 0, 0x52), SSE, WR, Vdq, Wdq)
+/* F3 0F 52 /r: RSQRTSS xmm1, xmm2/m32 */
+OPCODE(rsqrtss, LEG(F3, 0F, 0, 0x52), SSE, WR, Vd, Wd)
+/* NP 0F DA /r: PMINUB mm1, mm2/m64 */
+OPCODE(pminub, LEG(NP, 0F, 0, 0xda), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F EA /r: PMINSW mm1, mm2/m64 */
+OPCODE(pminsw, LEG(NP, 0F, 0, 0xea), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F 5D /r: MINPS xmm1, xmm2/m128 */
+OPCODE(minps, LEG(NP, 0F, 0, 0x5d), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 5D /r: MINSS xmm1,xmm2/m32 */
+OPCODE(minss, LEG(F3, 0F, 0, 0x5d), SSE, WRR, Vd, Vd, Wd)
+/* NP 0F DE /r: PMAXUB mm1, mm2/m64 */
+OPCODE(pmaxub, LEG(NP, 0F, 0, 0xde), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F EE /r: PMAXSW mm1, mm2/m64 */
+OPCODE(pmaxsw, LEG(NP, 0F, 0, 0xee), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F 5F /r: MAXPS xmm1, xmm2/m128 */
+OPCODE(maxps, LEG(NP, 0F, 0, 0x5f), SSE, WRR, Vdq, Vdq, Wdq)
+/* F3 0F 5F /r: MAXSS xmm1, xmm2/m32 */
+OPCODE(maxss, LEG(F3, 0F, 0, 0x5f), SSE, WRR, Vd, Vd, Wd)
+/* NP 0F E0 /r: PAVGB mm1, mm2/m64 */
+OPCODE(pavgb, LEG(NP, 0F, 0, 0xe0), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F E3 /r: PAVGW mm1, mm2/m64 */
+OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
+/* NP 0F F6 /r: PSADBW mm1, mm2/m64 */
+OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
 /* NP 0F 74 /r: PCMPEQB mm,mm/m64 */
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F 75 /r: PCMPEQW mm,mm/m64 */
@@ -97,14 +179,30 @@ OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F 66 /r: PCMPGTD mm,mm/m64 */
 OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8 */
+OPCODE(cmpps, LEG(NP, 0F, 0, 0xc2), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+/* F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8 */
+OPCODE(cmpss, LEG(F3, 0F, 0, 0xc2), SSE, WRRR, Vd, Vd, Wd, Ib)
+/* NP 0F 2E /r: UCOMISS xmm1, xmm2/m32 */
+OPCODE(ucomiss, LEG(NP, 0F, 0, 0x2e), SSE, RR, Vd, Wd)
+/* NP 0F 2F /r: COMISS xmm1, xmm2/m32 */
+OPCODE(comiss, LEG(NP, 0F, 0, 0x2f), SSE, RR, Vd, Wd)
 /* NP 0F DB /r: PAND mm, mm/m64 */
 OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 54 /r: ANDPS xmm1, xmm2/m128 */
+OPCODE(andps, LEG(NP, 0F, 0, 0x54), SSE, WRR, Vdq, Vdq, Wdq)
 /* NP 0F DF /r: PANDN mm, mm/m64 */
 OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 55 /r: ANDNPS xmm1, xmm2/m128 */
+OPCODE(andnps, LEG(NP, 0F, 0, 0x55), SSE, WRR, Vdq, Vdq, Wdq)
 /* NP 0F EB /r: POR mm, mm/m64 */
 OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 56 /r: ORPS xmm1, xmm2/m128 */
+OPCODE(orps, LEG(NP, 0F, 0, 0x56), SSE, WRR, Vdq, Vdq, Wdq)
 /* NP 0F EF /r: PXOR mm, mm/m64 */
 OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
+/* NP 0F 57 /r: XORPS xmm1, xmm2/m128 */
+OPCODE(xorps, LEG(NP, 0F, 0, 0x57), SSE, WRR, Vdq, Vdq, Wdq)
 /* NP 0F F1 /r: PSLLW mm, mm/m64 */
 OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
 /* NP 0F F2 /r: PSLLD mm, mm/m64 */
@@ -139,6 +237,44 @@ OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
 OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
 /* NP 0F 62 /r: PUNPCKLDQ mm, mm/m32 */
 OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
+/* NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128 */
+OPCODE(unpcklps, LEG(NP, 0F, 0, 0x14), SSE, WRR, Vdq, Vdq, Wdq)
+/* NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128 */
+OPCODE(unpckhps, LEG(NP, 0F, 0, 0x15), SSE, WRR, Vdq, Vdq, Wdq)
+/* NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8 */
+OPCODE(pshufw, LEG(NP, 0F, 0, 0x70), SSE, WRR, Pq, Qq, Ib)
+/* NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8 */
+OPCODE(shufps, LEG(NP, 0F, 0, 0xc6), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
+/* NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8 */
+OPCODE(pinsrw, LEG(NP, 0F, 0, 0xc4), SSE, WRRR, Pq, Pq, RdMw, Ib)
+/* NP 0F C5 /r ib: PEXTRW r32, mm, imm8 */
+OPCODE(pextrw, LEG(NP, 0F, 0, 0xc5), SSE, WRR, Gd, Nq, Ib)
+/* NP REX.W 0F C5 /r ib: PEXTRW r64, mm, imm8 */
+OPCODE(pextrw, LEG(NP, 0F, 1, 0xc5), SSE, WRR, Gq, Nq, Ib)
+/* NP 0F 2A /r: CVTPI2PS xmm, mm/m64 */
+OPCODE(cvtpi2ps, LEG(NP, 0F, 0, 0x2a), SSE, WR, Vdq, Qq)
+/* F3 0F 2A /r: CVTSI2SS xmm1,r/m32 */
+OPCODE(cvtsi2ss, LEG(F3, 0F, 0, 0x2a), SSE, WR, Vd, Ed)
+/* F3 REX.W 0F 2A /r: CVTSI2SS xmm1,r/m64 */
+OPCODE(cvtsi2ss, LEG(F3, 0F, 1, 0x2a), SSE, WR, Vd, Eq)
+/* NP 0F 2D /r: CVTPS2PI mm, xmm/m64 */
+OPCODE(cvtps2pi, LEG(NP, 0F, 0, 0x2d), SSE, WR, Pq, Wq)
+/* F3 0F 2D /r: CVTSS2SI r32,xmm1/m32 */
+OPCODE(cvtss2si, LEG(F3, 0F, 0, 0x2d), SSE, WR, Gd, Wd)
+/* F3 REX.W 0F 2D /r: CVTSS2SI r64,xmm1/m32 */
+OPCODE(cvtss2si, LEG(F3, 0F, 1, 0x2d), SSE, WR, Gq, Wd)
+/* NP 0F 2C /r: CVTTPS2PI mm, xmm/m64 */
+OPCODE(cvttps2pi, LEG(NP, 0F, 0, 0x2c), SSE, WR, Pq, Wq)
+/* F3 0F 2C /r: CVTTSS2SI r32,xmm1/m32 */
+OPCODE(cvttss2si, LEG(F3, 0F, 0, 0x2c), SSE, WR, Gd, Wd)
+/* F3 REX.W 0F 2C /r: CVTTSS2SI r64,xmm1/m32 */
+OPCODE(cvttss2si, LEG(F3, 0F, 1, 0x2c), SSE, WR, Gq, Wd)
+/* NP 0F F7 /r: MASKMOVQ mm1, mm2 */
+OPCODE(maskmovq, LEG(NP, 0F, 0, 0xf7), SSE, RR, Pq, Nq)
+/* NP 0F 2B /r: MOVNTPS m128, xmm1 */
+OPCODE(movntps, LEG(NP, 0F, 0, 0x2b), SSE, WR, Mdq, Vdq)
+/* NP 0F E7 /r: MOVNTQ m64, mm */
+OPCODE(movntq, LEG(NP, 0F, 0, 0xe7), SSE, WR, Mq, Pq)
 /* NP 0F 77: EMMS */
 OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
 
@@ -170,6 +306,28 @@ OPCODE_GRP_BEGIN(grp14_LEG_NP)
     OPCODE_GRPMEMB(grp14_LEG_NP, psrlq, 2, MMX, WRR, Nq, Nq, Ib)
 OPCODE_GRP_END(grp14_LEG_NP)
 
+OPCODE_GRP(grp15_LEG_NP, LEG(NP, 0F, 0, 0xae))
+OPCODE_GRP_BEGIN(grp15_LEG_NP)
+    /* NP 0F AE /7: SFENCE */
+    OPCODE_GRPMEMB(grp15_LEG_NP, sfence, 7, SSE, )
+    /* NP 0F AE /2: LDMXCSR m32 */
+    OPCODE_GRPMEMB(grp15_LEG_NP, ldmxcsr, 2, SSE, R, Md)
+    /* NP 0F AE /3: STMXCSR m32 */
+    OPCODE_GRPMEMB(grp15_LEG_NP, stmxcsr, 3, SSE, W, Md)
+OPCODE_GRP_END(grp15_LEG_NP)
+
+OPCODE_GRP(grp16_LEG_NP, LEG(NP, 0F, 0, 0x18))
+OPCODE_GRP_BEGIN(grp16_LEG_NP)
+    /* 0F 18 /1: PREFETCHT0 m8 */
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht0, 1, SSE, R, Mb)
+    /* 0F 18 /2: PREFETCHT1 m8 */
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht1, 2, SSE, R, Mb)
+    /* 0F 18 /3: PREFETCHT2 m8 */
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetcht2, 3, SSE, R, Mb)
+    /* 0F 18 /0: PREFETCHNTA m8 */
+    OPCODE_GRPMEMB(grp16_LEG_NP, prefetchnta, 0, SSE, R, Mb)
+OPCODE_GRP_END(grp16_LEG_NP)
+
 #undef FMTI____
 #undef FMTI__R__
 #undef FMTI__RR__
-- 
2.20.1


