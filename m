Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323EAC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D19217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8CqZX5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D19217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwJ1N-0007u1-1G
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlI-000706-Dr
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlG-0004m7-Kz
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlG-0004jw-Fw
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so63826242otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qd9Vak9zDrp9Soub8eUxv/gAK9kgKTJPLZEknV6Ahqs=;
 b=J8CqZX5wLKL543QDg/uE2qDl2h3yDJvxO/FGC4XisrABg8CaWHaCJDUYQJt01/OfOo
 Oc7cqCX2wbOP1kEf6YLmqBIOjl8UlLFBqIy2SIFWz8xeCjq1WioTjECo6hFStMUk4qmA
 R1Z71cRU6l/aPjCrweO1SqhpdUL5Ed2q4FdFnRcNXuc3uA/D9fmkciWuDDiihPi/PXth
 +TR9yceYEgPvllzcR1+bYzMOvTbggqMRkaU7jpdVyynusm53yIAO/HcsNXSuKAXFTdqU
 4WBK8urDDnMHkRp2QJMNatiERWbudQ9K21Z4bmHz879ptntPLc5dRdWsBkulKnDzSrdq
 yJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qd9Vak9zDrp9Soub8eUxv/gAK9kgKTJPLZEknV6Ahqs=;
 b=ZKPVYzrTJ0uT0hwa6ll1a2tf2PNj3IXVL/d4aahm/38+GOlwSxbWi5L5lqpibAUbNC
 gjI2BET1oxuSPGqwrmHVvvavc+I8q+NyfBa6RHk98vLUY1B6vcmde39y55KW6f4zJXso
 BvdrR92d3UaSEr80Ri80Py593fvkAKl9J82pKx0ZLYbg40b9rlaiQOXkPacLeRbK4moA
 k4rXXEDu+XwKTIcZmr1SWYGtHzhs0sqhr/hb7DBrEZKS8MeJ0HvaIyG16ga0NRI/eOlc
 JPx8LGRqhqUXxk5DhASdBMm7D5KrRkujALR3fQq4WDVLmeySokFuJ21dDX3IWNE5v6/U
 xRAg==
X-Gm-Message-State: APjAAAWTbpf8nlx++8Tif6ycRk8hQ/3xxUOh1C8UICoVZZmtT1fLo7Mb
 NtKe8llfNPQWfAfT6eQQEiduV8uq
X-Google-Smtp-Source: APXvYqxg3/PUaNL08CDBV3arjkvr2BniPe9XYEKVP61qujh2BFp8ZQl1l2auivWJRkqH4QwQIxMfsQ==
X-Received: by 2002:a05:6830:2119:: with SMTP id
 i25mr22124032otc.282.1565410425544; 
 Fri, 09 Aug 2019 21:13:45 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:45 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:54 -0400
Message-Id: <20190810041255.6820-39-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 38/39] target/i386: introduce SSE
 instructions to insn.h
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

Add all the SSE instruction entries to insn.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/insn.h | 158 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/target/i386/insn.h b/target/i386/insn.h
index 6506ff3137..6e0c75b9f7 100644
--- a/target/i386/insn.h
+++ b/target/i386/insn.h
@@ -78,6 +78,36 @@ INSN_WR(movq, LEG(NP, 0F, 1), 0x7e, MMX, Eq, Pq)
 INSN_WR(movq, LEG(NP, 0F, 0), 0x6f, MMX, Pq, Qq)
 /* NP 0F 7F /r: MOVQ mm/m64, mm */
 INSN_WR(movq, LEG(NP, 0F, 0), 0x7f, MMX, Qq, Pq)
+/* NP 0F 28 /r: MOVAPS xmm1, xmm2/m128 */
+INSN_WR(movaps, LEG(NP, 0F, 0), 0x28, SSE, Vdq, Wdq)
+/* NP 0F 29 /r: MOVAPS xmm2/m128, xmm1 */
+INSN_WR(movaps, LEG(NP, 0F, 0), 0x29, SSE, Wdq, Vdq)
+/* NP 0F 10 /r: MOVUPS xmm1, xmm2/m128 */
+INSN_WR(movups, LEG(NP, 0F, 0), 0x10, SSE, Vdq, Wdq)
+/* NP 0F 11 /r: MOVUPS xmm2/m128, xmm1 */
+INSN_WR(movups, LEG(NP, 0F, 0), 0x11, SSE, Wdq, Vdq)
+/* F3 0F 10 /r: MOVSS xmm1, xmm2/m32 */
+INSN_WRR(movss, LEG(F3, 0F, 0), 0x10, SSE, Vdq, Vdq, UdMd)
+/* F3 0F 11 /r: MOVSS xmm2/m32, xmm1 */
+INSN_WR(movss, LEG(F3, 0F, 0), 0x11, SSE, Wd, Vd)
+/* NP 0F 12 /r: MOVHLPS xmm1, xmm2 */
+/* NP 0F 12 /r: MOVLPS xmm1, m64 */
+INSN_WR(movhlps, LEG(NP, 0F, 0), 0x12, SSE, Vq, UdqMq)
+/* 0F 13 /r: MOVLPS m64, xmm1 */
+INSN_WR(movlps, LEG(NP, 0F, 0), 0x13, SSE, Mq, Vq)
+/* NP 0F 16 /r: MOVLHPS xmm1, xmm2 */
+/* NP 0F 16 /r: MOVHPS xmm1, m64 */
+INSN_WRR(movlhps, LEG(NP, 0F, 0), 0x16, SSE, Vdq, Vq, UqMq)
+/* NP 0F 17 /r: MOVHPS m64, xmm1 */
+INSN_WR(movhps, LEG(NP, 0F, 0), 0x17, SSE, Mq, Vdq)
+/* NP 0F D7 /r: PMOVMSKB r32, mm */
+INSN_WR(pmovmskb, LEG(NP, 0F, 0), 0xd7, SSE, Gd, Nq)
+/* NP REX.W 0F D7 /r: PMOVMSKB r64, mm */
+INSN_WR(pmovmskb, LEG(NP, 0F, 1), 0xd7, SSE, Gq, Nq)
+/* NP 0F 50 /r: MOVMSKPS r32, xmm */
+INSN_WR(movmskps, LEG(NP, 0F, 0), 0x50, SSE, Gd, Udq)
+/* NP REX.W 0F 50 /r: MOVMSKPS r64, xmm */
+INSN_WR(movmskps, LEG(NP, 0F, 1), 0x50, SSE, Gq, Udq)
 /* NP 0F FC /r: PADDB mm, mm/m64 */
 INSN_WRR(paddb, LEG(NP, 0F, 0), 0xfc, MMX, Pq, Pq, Qq)
 /* NP 0F FD /r: PADDW mm, mm/m64 */
@@ -92,6 +122,10 @@ INSN_WRR(paddsw, LEG(NP, 0F, 0), 0xed, MMX, Pq, Pq, Qq)
 INSN_WRR(paddusb, LEG(NP, 0F, 0), 0xdc, MMX, Pq, Pq, Qq)
 /* NP 0F DD /r: PADDUSW mm,mm/m64 */
 INSN_WRR(paddusw, LEG(NP, 0F, 0), 0xdd, MMX, Pq, Pq, Qq)
+/* NP 0F 58 /r: ADDPS xmm1, xmm2/m128 */
+INSN_WRR(addps, LEG(NP, 0F, 0), 0x58, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 58 /r: ADDSS xmm1, xmm2/m32 */
+INSN_WRR(addss, LEG(F3, 0F, 0), 0x58, SSE, Vd, Vd, Wd)
 /* NP 0F F8 /r: PSUBB mm, mm/m64 */
 INSN_WRR(psubb, LEG(NP, 0F, 0), 0xf8, MMX, Pq, Pq, Qq)
 /* NP 0F F9 /r: PSUBW mm, mm/m64 */
@@ -106,12 +140,60 @@ INSN_WRR(psubsw, LEG(NP, 0F, 0), 0xe9, MMX, Pq, Pq, Qq)
 INSN_WRR(psubusb, LEG(NP, 0F, 0), 0xd8, MMX, Pq, Pq, Qq)
 /* NP 0F D9 /r: PSUBUSW mm, mm/m64 */
 INSN_WRR(psubusw, LEG(NP, 0F, 0), 0xd9, MMX, Pq, Pq, Qq)
+/* NP 0F 5C /r: SUBPS xmm1, xmm2/m128 */
+INSN_WRR(subps, LEG(NP, 0F, 0), 0x5c, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 5C /r: SUBSS xmm1, xmm2/m32 */
+INSN_WRR(subss, LEG(F3, 0F, 0), 0x5c, SSE, Vd, Vd, Wd)
 /* NP 0F D5 /r: PMULLW mm, mm/m64 */
 INSN_WRR(pmullw, LEG(NP, 0F, 0), 0xd5, MMX, Pq, Pq, Qq)
 /* NP 0F E5 /r: PMULHW mm, mm/m64 */
 INSN_WRR(pmulhw, LEG(NP, 0F, 0), 0xe5, MMX, Pq, Pq, Qq)
+/* NP 0F E4 /r: PMULHUW mm1, mm2/m64 */
+INSN_WRR(pmulhuw, LEG(NP, 0F, 0), 0xe4, SSE, Pq, Pq, Qq)
+/* NP 0F 59 /r: MULPS xmm1, xmm2/m128 */
+INSN_WRR(mulps, LEG(NP, 0F, 0), 0x59, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 59 /r: MULSS xmm1,xmm2/m32 */
+INSN_WRR(mulss, LEG(F3, 0F, 0), 0x59, SSE, Vd, Vd, Wd)
 /* NP 0F F5 /r: PMADDWD mm, mm/m64 */
 INSN_WRR(pmaddwd, LEG(NP, 0F, 0), 0xf5, MMX, Pq, Pq, Qq)
+/* NP 0F 5E /r: DIVPS xmm1, xmm2/m128 */
+INSN_WRR(divps, LEG(NP, 0F, 0), 0x5e, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 5E /r: DIVSS xmm1, xmm2/m32 */
+INSN_WRR(divss, LEG(F3, 0F, 0), 0x5e, SSE, Vd, Vd, Wd)
+/* NP 0F 53 /r: RCPPS xmm1, xmm2/m128 */
+INSN_WR(rcpps, LEG(NP, 0F, 0), 0x53, SSE, Vdq, Wdq)
+/* F3 0F 53 /r: RCPSS xmm1, xmm2/m32 */
+INSN_WR(rcpss, LEG(F3, 0F, 0), 0x53, SSE, Vd, Wd)
+/* NP 0F 51 /r: SQRTPS xmm1, xmm2/m128 */
+INSN_WR(sqrtps, LEG(NP, 0F, 0), 0x51, SSE, Vdq, Wdq)
+/* F3 0F 51 /r: SQRTSS xmm1, xmm2/m32 */
+INSN_WR(sqrtss, LEG(F3, 0F, 0), 0x51, SSE, Vd, Wd)
+/* NP 0F 52 /r: RSQRTPS xmm1, xmm2/m128 */
+INSN_WR(rsqrtps, LEG(NP, 0F, 0), 0x52, SSE, Vdq, Wdq)
+/* F3 0F 52 /r: RSQRTSS xmm1, xmm2/m32 */
+INSN_WR(rsqrtss, LEG(F3, 0F, 0), 0x52, SSE, Vd, Wd)
+/* NP 0F DA /r: PMINUB mm1, mm2/m64 */
+INSN_WRR(pminub, LEG(NP, 0F, 0), 0xda, SSE, Pq, Pq, Qq)
+/* NP 0F EA /r: PMINSW mm1, mm2/m64 */
+INSN_WRR(pminsw, LEG(NP, 0F, 0), 0xea, SSE, Pq, Pq, Qq)
+/* NP 0F 5D /r: MINPS xmm1, xmm2/m128 */
+INSN_WRR(minps, LEG(NP, 0F, 0), 0x5d, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 5D /r: MINSS xmm1,xmm2/m32 */
+INSN_WRR(minss, LEG(F3, 0F, 0), 0x5d, SSE, Vd, Vd, Wd)
+/* NP 0F DE /r: PMAXUB mm1, mm2/m64 */
+INSN_WRR(pmaxub, LEG(NP, 0F, 0), 0xde, SSE, Pq, Pq, Qq)
+/* NP 0F EE /r: PMAXSW mm1, mm2/m64 */
+INSN_WRR(pmaxsw, LEG(NP, 0F, 0), 0xee, SSE, Pq, Pq, Qq)
+/* NP 0F 5F /r: MAXPS xmm1, xmm2/m128 */
+INSN_WRR(maxps, LEG(NP, 0F, 0), 0x5f, SSE, Vdq, Vdq, Wdq)
+/* F3 0F 5F /r: MAXSS xmm1, xmm2/m32 */
+INSN_WRR(maxss, LEG(F3, 0F, 0), 0x5f, SSE, Vd, Vd, Wd)
+/* NP 0F E0 /r: PAVGB mm1, mm2/m64 */
+INSN_WRR(pavgb, LEG(NP, 0F, 0), 0xe0, SSE, Pq, Pq, Qq)
+/* NP 0F E3 /r: PAVGW mm1, mm2/m64 */
+INSN_WRR(pavgw, LEG(NP, 0F, 0), 0xe3, SSE, Pq, Pq, Qq)
+/* NP 0F F6 /r: PSADBW mm1, mm2/m64 */
+INSN_WRR(psadbw, LEG(NP, 0F, 0), 0xf6, SSE, Pq, Pq, Qq)
 /* NP 0F 74 /r: PCMPEQB mm,mm/m64 */
 INSN_WRR(pcmpeqb, LEG(NP, 0F, 0), 0x74, MMX, Pq, Pq, Qq)
 /* NP 0F 75 /r: PCMPEQW mm,mm/m64 */
@@ -124,14 +206,30 @@ INSN_WRR(pcmpgtb, LEG(NP, 0F, 0), 0x64, MMX, Pq, Pq, Qq)
 INSN_WRR(pcmpgtw, LEG(NP, 0F, 0), 0x65, MMX, Pq, Pq, Qq)
 /* NP 0F 66 /r: PCMPGTD mm,mm/m64 */
 INSN_WRR(pcmpgtd, LEG(NP, 0F, 0), 0x66, MMX, Pq, Pq, Qq)
+/* NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8 */
+INSN_WRRR(cmpps, LEG(NP, 0F, 0), 0xc2, SSE, Vdq, Vdq, Wdq, Ib)
+/* F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8 */
+INSN_WRRR(cmpss, LEG(F3, 0F, 0), 0xc2, SSE, Vd, Vd, Wd, Ib)
+/* NP 0F 2E /r: UCOMISS xmm1, xmm2/m32 */
+INSN_RR(ucomiss, LEG(NP, 0F, 0), 0x2e, SSE, Vd, Wd)
+/* NP 0F 2F /r: COMISS xmm1, xmm2/m32 */
+INSN_RR(comiss, LEG(NP, 0F, 0), 0x2f, SSE, Vd, Wd)
 /* NP 0F DB /r: PAND mm, mm/m64 */
 INSN_WRR(pand, LEG(NP, 0F, 0), 0xdb, MMX, Pq, Pq, Qq)
+/* NP 0F 54 /r: ANDPS xmm1, xmm2/m128 */
+INSN_WRR(andps, LEG(NP, 0F, 0), 0x54, SSE, Vdq, Vdq, Wdq)
 /* NP 0F DF /r: PANDN mm, mm/m64 */
 INSN_WRR(pandn, LEG(NP, 0F, 0), 0xdf, MMX, Pq, Pq, Qq)
+/* NP 0F 55 /r: ANDNPS xmm1, xmm2/m128 */
+INSN_WRR(andnps, LEG(NP, 0F, 0), 0x55, SSE, Vdq, Vdq, Wdq)
 /* NP 0F EB /r: POR mm, mm/m64 */
 INSN_WRR(por, LEG(NP, 0F, 0), 0xeb, MMX, Pq, Pq, Qq)
+/* NP 0F 56 /r: ORPS xmm1, xmm2/m128 */
+INSN_WRR(orps, LEG(NP, 0F, 0), 0x56, SSE, Vdq, Vdq, Wdq)
 /* NP 0F EF /r: PXOR mm, mm/m64 */
 INSN_WRR(pxor, LEG(NP, 0F, 0), 0xef, MMX, Pq, Pq, Qq)
+/* NP 0F 57 /r: XORPS xmm1, xmm2/m128 */
+INSN_WRR(xorps, LEG(NP, 0F, 0), 0x57, SSE, Vdq, Vdq, Wdq)
 /* NP 0F F1 /r: PSLLW mm, mm/m64 */
 INSN_WRR(psllw, LEG(NP, 0F, 0), 0xf1, MMX, Pq, Pq, Qq)
 /* NP 0F F2 /r: PSLLD mm, mm/m64 */
@@ -166,6 +264,44 @@ INSN_WRR(punpcklbw, LEG(NP, 0F, 0), 0x60, MMX, Pq, Pq, Qd)
 INSN_WRR(punpcklwd, LEG(NP, 0F, 0), 0x61, MMX, Pq, Pq, Qd)
 /* NP 0F 62 /r: PUNPCKLDQ mm, mm/m32 */
 INSN_WRR(punpckldq, LEG(NP, 0F, 0), 0x62, MMX, Pq, Pq, Qd)
+/* NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128 */
+INSN_WRR(unpcklps, LEG(NP, 0F, 0), 0x14, SSE, Vdq, Vdq, Wdq)
+/* NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128 */
+INSN_WRR(unpckhps, LEG(NP, 0F, 0), 0x15, SSE, Vdq, Vdq, Wdq)
+/* NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8 */
+INSN_WRR(pshufw, LEG(NP, 0F, 0), 0x70, SSE, Pq, Qq, Ib)
+/* NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8 */
+INSN_WRRR(shufps, LEG(NP, 0F, 0), 0xc6, SSE, Vdq, Vdq, Wdq, Ib)
+/* NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8 */
+INSN_WRRR(pinsrw, LEG(NP, 0F, 0), 0xc4, SSE, Pq, Pq, RdMw, Ib)
+/* NP 0F C5 /r ib: PEXTRW r32, mm, imm8 */
+INSN_WRR(pextrw, LEG(NP, 0F, 0), 0xc5, SSE, Gd, Nq, Ib)
+/* NP REX.W 0F C5 /r ib: PEXTRW r64, mm, imm8 */
+INSN_WRR(pextrw, LEG(NP, 0F, 1), 0xc5, SSE, Gq, Nq, Ib)
+/* NP 0F 2A /r: CVTPI2PS xmm, mm/m64 */
+INSN_WR(cvtpi2ps, LEG(NP, 0F, 0), 0x2a, SSE, Vdq, Qq)
+/* F3 0F 2A /r: CVTSI2SS xmm1,r/m32 */
+INSN_WR(cvtsi2ss, LEG(F3, 0F, 0), 0x2a, SSE, Vd, Ed)
+/* F3 REX.W 0F 2A /r: CVTSI2SS xmm1,r/m64 */
+INSN_WR(cvtsi2ss, LEG(F3, 0F, 1), 0x2a, SSE, Vd, Eq)
+/* NP 0F 2D /r: CVTPS2PI mm, xmm/m64 */
+INSN_WR(cvtps2pi, LEG(NP, 0F, 0), 0x2d, SSE, Pq, Wq)
+/* F3 0F 2D /r: CVTSS2SI r32,xmm1/m32 */
+INSN_WR(cvtss2si, LEG(F3, 0F, 0), 0x2d, SSE, Gd, Wd)
+/* F3 REX.W 0F 2D /r: CVTSS2SI r64,xmm1/m32 */
+INSN_WR(cvtss2si, LEG(F3, 0F, 1), 0x2d, SSE, Gq, Wd)
+/* NP 0F 2C /r: CVTTPS2PI mm, xmm/m64 */
+INSN_WR(cvttps2pi, LEG(NP, 0F, 0), 0x2c, SSE, Pq, Wq)
+/* F3 0F 2C /r: CVTTSS2SI r32,xmm1/m32 */
+INSN_WR(cvttss2si, LEG(F3, 0F, 0), 0x2c, SSE, Gd, Wd)
+/* F3 REX.W 0F 2C /r: CVTTSS2SI r64,xmm1/m32 */
+INSN_WR(cvttss2si, LEG(F3, 0F, 1), 0x2c, SSE, Gq, Wd)
+/* NP 0F F7 /r: MASKMOVQ mm1, mm2 */
+INSN_RR(maskmovq, LEG(NP, 0F, 0), 0xf7, SSE, Pq, Nq)
+/* NP 0F 2B /r: MOVNTPS m128, xmm1 */
+INSN_WR(movntps, LEG(NP, 0F, 0), 0x2b, SSE, Mdq, Vdq)
+/* NP 0F E7 /r: MOVNTQ m64, mm */
+INSN_WR(movntq, LEG(NP, 0F, 0), 0xe7, SSE, Mq, Pq)
 /* NP 0F 77: EMMS */
 INSN(emms, LEG(NP, 0F, 0), 0x77, MMX)
 
@@ -197,6 +333,28 @@ INSN_GRP_BEGIN(grp14_LEG_NP)
     INSN_GRPMEMB_WRR(grp14_LEG_NP, psrlq, 2, MMX, Nq, Nq, Ib)
 INSN_GRP_END(grp14_LEG_NP)
 
+INSN_GRP(grp15_LEG_NP, LEG(NP, 0F, 0), 0xae)
+INSN_GRP_BEGIN(grp15_LEG_NP)
+    /* NP 0F AE /7: SFENCE */
+    INSN_GRPMEMB(grp15_LEG_NP, sfence, 7, SSE)
+    /* NP 0F AE /2: LDMXCSR m32 */
+    INSN_GRPMEMB_R(grp15_LEG_NP, ldmxcsr, 2, SSE, Md)
+    /* NP 0F AE /3: STMXCSR m32 */
+    INSN_GRPMEMB_W(grp15_LEG_NP, stmxcsr, 3, SSE, Md)
+INSN_GRP_END(grp15_LEG_NP)
+
+INSN_GRP(grp16_LEG_NP, LEG(NP, 0F, 0), 0x18)
+INSN_GRP_BEGIN(grp16_LEG_NP)
+    /* 0F 18 /1: PREFETCHT0 m8 */
+    INSN_GRPMEMB_R(grp16_LEG_NP, prefetcht0, 1, SSE, Mb)
+    /* 0F 18 /2: PREFETCHT1 m8 */
+    INSN_GRPMEMB_R(grp16_LEG_NP, prefetcht1, 2, SSE, Mb)
+    /* 0F 18 /3: PREFETCHT2 m8 */
+    INSN_GRPMEMB_R(grp16_LEG_NP, prefetcht2, 3, SSE, Mb)
+    /* 0F 18 /0: PREFETCHNTA m8 */
+    INSN_GRPMEMB_R(grp16_LEG_NP, prefetchnta, 0, SSE, Mb)
+INSN_GRP_END(grp16_LEG_NP)
+
 #undef LEG
 #undef VEX
 #undef INSN
-- 
2.20.1


