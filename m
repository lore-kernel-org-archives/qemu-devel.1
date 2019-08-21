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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FB621655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdwdTcR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FB621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VIX-0000dJ-Eb
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0001hj-Cf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URo-0008Px-Kg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:02 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:39262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URm-000810-De
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:00 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s142so1341607ybc.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wDlBybYVRe7OaKyJaw8OMfE6wxYZwPdGtL10eKPQHAU=;
 b=vdwdTcR1egGCVoxAv/PU0tpGyOZ8kbPe/mdfZV6HuZBQkhC34hHWHdUUpV6ijzgY1H
 7/pwNK/4moFIxRxtSdEoLs9NMYMqgYV5AkYl2EcptAkGkRqlEj3GA6HQtUUxcb4aX6Gn
 tmoXRBQFyie5dBKwJerSj72+wLldCEyUh45fc+Dzag9V5zRkihZN2qz8llqxl7dj8zvc
 g9VxgOSYosDZpYNki90X+5acViEP2gTvhgX37/IPtwU+0XHnKd4SUgbQwOLM6AdEl8YN
 jg9l2TXMKiznpsnkQaiOSghyzgIqVqQPSb5AkhM9KQ+1bFwOnn2cROOpQ2MHFAG0d667
 Uviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wDlBybYVRe7OaKyJaw8OMfE6wxYZwPdGtL10eKPQHAU=;
 b=XRfHG/lWWjWfq32uRqdY7KnCtPOfv3XREZmn1/Kwg7O0oh/HwrEy+d+ZjTCY1LcRea
 bkYs6uco7h+7qg567E3Y0h7AxuML8K2SPHADLoJBHUHFtq6m56/q8jC5C1Kstytckrfd
 l2+Pc54lYL7VbSlri1qjvoLPxXY63vaAVmXcBxNQ2ppyn2ufe0q7pGTYAP1runyLrcao
 78/foPdDdXoSmRkeaVLP8Ht1kXXJoWNpQ0KgypkwjFLY4wp4mXwSMfECWrHq+vvPOAmM
 6kGG/D/nJ6NEZjfirgKVXjliws709bXTLa36Mk2uGOD4EdUevwcCWY+kR91z1WfaofpG
 mcCg==
X-Gm-Message-State: APjAAAWoY7n6VmEp5SZrxrqOhYIG0c5fAJi9aE4Fq0WCzbvFTOdPs5WO
 sqPfiHhgcj4QeSbBWXlc363JRM30
X-Google-Smtp-Source: APXvYqyLTRxeCpoha3rLETX5YIVAydNDb+q2UbnZWYYwOscNgmhisnn4GyANrDatr3zTlroUhuZ+XQ==
X-Received: by 2002:a25:db05:: with SMTP id g5mr25606493ybf.397.1566408646058; 
 Wed, 21 Aug 2019 10:30:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:45 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:23 -0400
Message-Id: <20190821172951.15333-48-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 47/75] target/i386: introduce SSE3
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

Add all the SSE3 vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 6df5fda010..84785a4e04 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -341,6 +341,19 @@
  * NP 0F AE /7          CLFLUSH m8
  * NP 0F AE /5          LFENCE
  * NP 0F AE /6          MFENCE
+ *
+ * SSE3 Instructions
+ * ------------------
+ * F2 0F F0 /r          LDDQU xmm1, m128
+ * F3 0F 16 /r          MOVSHDUP xmm1, xmm2/m128
+ * F3 0F 12 /r          MOVSLDUP xmm1, xmm2/m128
+ * F2 0F 12 /r          MOVDDUP xmm1, xmm2/m64
+ * F2 0F 7C /r          HADDPS xmm1, xmm2/m128
+ * 66 0F 7C /r          HADDPD xmm1, xmm2/m128
+ * F2 0F 7D /r          HSUBPS xmm1, xmm2/m128
+ * 66 0F 7D /r          HSUBPD xmm1, xmm2/m128
+ * F2 0F D0 /r          ADDSUBPS xmm1, xmm2/m128
+ * 66 0F D0 /r          ADDSUBPD xmm1, xmm2/m128
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -389,6 +402,10 @@ OPCODE(movmskps, LEG(NP, 0F, 0, 0x50), SSE, WR, Gd, Udq)
 OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
 OPCODE(movmskpd, LEG(66, 0F, 0, 0x50), SSE2, WR, Gd, Udq)
 OPCODE(movmskpd, LEG(66, 0F, 1, 0x50), SSE2, WR, Gq, Udq)
+OPCODE(lddqu, LEG(F2, 0F, 0, 0xf0), SSE3, WR, Vdq, Mdq)
+OPCODE(movshdup, LEG(F3, 0F, 0, 0x16), SSE3, WR, Vdq, Wdq)
+OPCODE(movsldup, LEG(F3, 0F, 0, 0x12), SSE3, WR, Vdq, Wdq)
+OPCODE(movddup, LEG(F2, 0F, 0, 0x12), SSE3, WR, Vdq, Wq)
 OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
 OPCODE(paddb, LEG(66, 0F, 0, 0xfc), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
@@ -409,6 +426,8 @@ OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(addpd, LEG(66, 0F, 0, 0x58), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(addss, LEG(F3, 0F, 0, 0x58), SSE, WRR, Vd, Vd, Wd)
 OPCODE(addsd, LEG(F2, 0F, 0, 0x58), SSE2, WRR, Vq, Vq, Wq)
+OPCODE(haddps, LEG(F2, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(haddpd, LEG(66, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
 OPCODE(psubb, LEG(66, 0F, 0, 0xf8), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
@@ -429,6 +448,10 @@ OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
 OPCODE(subpd, LEG(66, 0F, 0, 0x5c), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(subss, LEG(F3, 0F, 0, 0x5c), SSE, WRR, Vd, Vd, Wd)
 OPCODE(subsd, LEG(F2, 0F, 0, 0x5c), SSE2, WRR, Vq, Vq, Wq)
+OPCODE(hsubps, LEG(F2, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(hsubpd, LEG(66, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(addsubps, LEG(F2, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
+OPCODE(addsubpd, LEG(66, 0F, 0, 0xd0), SSE3, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pmullw, LEG(66, 0F, 0, 0xd5), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
-- 
2.20.1


