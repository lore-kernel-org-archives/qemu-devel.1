Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F2C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB79206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJBUBkol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB79206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5TH-0000gq-Ox
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dp-0006bh-Q4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Do-0000a2-Js
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:37 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Do-0000Za-Fd
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:36 -0400
Received: by mail-yb1-xb42.google.com with SMTP id m9so407196ybm.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gKZDBNbs0Rv4p03odiZWPA215sxOPuT/ZV9NL1iqxbM=;
 b=nJBUBkolxuvyTsrjC0TjPZ1Bu1lObbPiC+rYzufGIxXui2HG2haMglAFbRX78fOF3U
 X5mfS1lf6Xs3pZ4cdgJhZnmfUEZabkwj3+90mEOILkHJ6IR6+dFGCYh7ZhXxUdssqu8d
 OYyyObHEElUVSn3E8aGzbqFuweb65+KjGbWlTBNn7bwAtYMX8TseQIkuwsnga+ax2C1p
 ZE5/xUb0/L4tr3ZO7m93mQqqa5kchCMvPe111MrPxfrU/zX9lYKMO1ooi2jeNw2/J1nl
 YHtivYcgPsokDhzhBJPR1qhYGlYLNVYJ5JqnqI7O99B+wTZGm6DkpwNNW0TgM+znHVrL
 ZX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gKZDBNbs0Rv4p03odiZWPA215sxOPuT/ZV9NL1iqxbM=;
 b=FEZgNczgVEOvejpv/eqzVf8/mLZt/1ESR/DIUBWjm3z75OHGgE5MFD/1zVDkpF46hh
 E52ylGO2M7mX+ekE/OA8Yi7qNdzOUf6Nuu7Yk4xFk9eWb5BvF5tf+5Wh9/Y0kH+TpVbB
 ALGmrQQoovn5sbqiRz0riOpd+oJjjK8S/wzESWTniqgd19RtDf61G54GPEPVKv3WL7Uc
 Bcpo0nLpOsIiAT17RDrb7rWCwkyvigj+sO/Xk79TRtAwtvTRlnWySFc+rowPREvlTkan
 RFsQpZVbn19cHzUuUg4pwr4yKgJhdM5SEbTqlx6RhMQb2omYbtsFejlvv4dNbJU9+3Cy
 TCyg==
X-Gm-Message-State: APjAAAU5wvx6eWz7zxst/B5MK6Mn9luuzEh9PjGLyMvjsQKNi/THJJzH
 +bTq5MCIU1+7Kqcffn+iuvMZ0+ne
X-Google-Smtp-Source: APXvYqxVMjkdKoKZdrUpal11xyw7QN2lUAfxC1hAMZHpVm/onk5XhLGyO02/f6vQj4dc6kSlR8gmjw==
X-Received: by 2002:a25:d7d0:: with SMTP id o199mr1961431ybg.162.1565835035878; 
 Wed, 14 Aug 2019 19:10:35 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:35 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:28 -0400
Message-Id: <20190815020928.9679-47-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 46/46] target/i386: introduce SSE3
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

Add all the SSE3 instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index efa67b7ce2..0cfe6fbe31 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -133,6 +133,14 @@ OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
 OPCODE(movmskpd, LEG(66, 0F, 0, 0x50), SSE2, WR, Gd, Udq)
 /* 66 REX.W 0F 50 /r: MOVMSKPD r64, xmm */
 OPCODE(movmskpd, LEG(66, 0F, 1, 0x50), SSE2, WR, Gq, Udq)
+/* F2 0F F0 /r: LDDQU xmm1, m128 */
+OPCODE(lddqu, LEG(F2, 0F, 0, 0xf0), SSE3, WR, Vdq, Mdq)
+/* F3 0F 16 /r: MOVSHDUP xmm1, xmm2/m128 */
+OPCODE(movshdup, LEG(F3, 0F, 0, 0x16), SSE3, WR, Vdq, Wdq)
+/* F3 0F 12 /r: MOVSLDUP xmm1, xmm2/m128 */
+OPCODE(movsldup, LEG(F3, 0F, 0, 0x12), SSE3, WR, Vdq, Wdq)
+/* F2 0F 12 /r: MOVDDUP xmm1, xmm2/m64 */
+OPCODE(movddup, LEG(F2, 0F, 0, 0x12), SSE3, WR, Vdq, Wq)
 /* NP 0F FC /r: PADDB mm, mm/m64 */
 OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
 /* 66 0F FC /r: PADDB xmm1, xmm2/m128 */
@@ -173,6 +181,10 @@ OPCODE(addpd, LEG(66, 0F, 0, 0x58), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
 /* F2 0F 58 /r: ADDSD xmm1, xmm2/m64 */
 OPCODE(addsd, LEG(F2, 0F, 0, 0x58), SSE2, WRR, Vq, Vq, Wq)
+/* F2 0F 7C /r: HADDPS xmm1, xmm2/m128 */
+OPCODE(haddps, LEG(F2, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
+/* 66 0F 7C /r: HADDPD xmm1, xmm2/m128 */
+OPCODE(haddpd, LEG(66, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
 /* NP 0F F8 /r: PSUBB mm, mm/m64 */
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
 /* 66 0F F8 /r: PSUBB xmm1, xmm2/m128 */
@@ -213,6 +225,14 @@ OPCODE(subpd, LEG(66, 0F, 0, 0x5c), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
 /* F2 0F 5C /r: SUBSD xmm1, xmm2/m64 */
 OPCODE(subsd, LEG(F2, 0F, 0, 0x5c), SSE2, WRR, Vq, Vq, Wq)
+/* F2 0F 7D /r: HSUBPS xmm1, xmm2/m128 */
+OPCODE(hsubps, LEG(F2, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
+/* 66 0F 7D /r: HSUBPD xmm1, xmm2/m128 */
+OPCODE(hsubpd, LEG(66, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
+/* F2 0F D0 /r: ADDSUBPS xmm1, xmm2/m128 */
+OPCODE(addsubps, LEG(F2, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
+/* 66 0F D0 /r: ADDSUBPD xmm1, xmm2/m128 */
+OPCODE(addsubpd, LEG(66, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
 /* NP 0F D5 /r: PMULLW mm, mm/m64 */
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
 /* 66 0F D5 /r: PMULLW xmm1, xmm2/m128 */
-- 
2.20.1


