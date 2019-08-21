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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A4CC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEF1214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilfPe8Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEF1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VVe-00046O-0h
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0001iD-Dc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0008Sa-9b
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:34428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URm-0008Fl-EH
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:00 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n126so1251616ywf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mtpv7TUPO152TH+n/5BNHJ1qaIvUaGy6XgtApaMVtnM=;
 b=ilfPe8YpyZ+B8nRL37pxj2aSNOh9sb45BFaR3UBHkCtq8w7CHVXRsDetA3HAUjgLLl
 zCnZ8ZjzjlftubnCFG7OiZhiQEuj20rk8eDI3NMFc1r6rXC/Z+Xey7HZ+IYQcGL+nsA5
 tlPzz8JT1XxxkSHrxwttyULSt1G31siIiTARUG9fYhfIb/cQMbBNB98KdaNW6MkQAQhB
 NrXLp3ak6y2qq+k7g9qWCx+Y8MHC8rCLArjzy7HTAmhI4+rmYFF6c5G4gRjtoKk8asuy
 HvACbRftVx0avhZ2nkmsnAIpWy2WjQS5Eyn5JFo/x7OUdai2Rc77xpBz1dn8kW/1bNf+
 Gw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mtpv7TUPO152TH+n/5BNHJ1qaIvUaGy6XgtApaMVtnM=;
 b=OeiPjOsWbzSgUrw6KMab0cLv+YXutakX3tDPWyn1AT0y7iTeiZnD/w30OsrQg6BT8C
 T40fP7tfgVDaiD+H8ky4k8MyFVTjY0vonHbeiomJyDnOlsHkpM26uPLiwiXcFW0dfCN7
 1bA6j33WRYWRDioVT7OkGOV6ozNODxB30OBCjDEpCQ8nm/qzqIl7pXw+BhJs8Cd1YYY2
 2v2+1EQL/Cg7fIiz5dDZSBo83D3FdSjyqR3zWeKWOO8Zn6r81v3nJviTRQNOOkgdXnMg
 +TVQjxwa6lE/4EVJHlOTzqhqcK1xBClvahsb0MI8RiMa7RYDpSXoZEeeHzrJEdGMzIlR
 0zLg==
X-Gm-Message-State: APjAAAXtQ58tXjmLNZ/W0oPP3ld9zENyPIEX+juaNKU0Sl5oIPCL/e2B
 qxlcISOY11CeXtSYNr1Ra2APEDsm
X-Google-Smtp-Source: APXvYqyCDglQlUmedOo1m5TRIe3meIgOW3c58Ubo0jTVKaRiWBzfXvnUh/SHtP0OVUyFJvLaQA6adQ==
X-Received: by 2002:a81:2903:: with SMTP id p3mr23551543ywp.355.1566408655145; 
 Wed, 21 Aug 2019 10:30:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:54 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:34 -0400
Message-Id: <20190821172951.15333-59-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 58/75] target/i386: introduce AES and
 PCLMULQDQ vector instructions to sse-opcode.inc.h
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

Add all the AES and PCLMULQDQ vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index f43436213e..1359508424 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -449,6 +449,26 @@
  * 66 0F 3A 61 /r imm8     PCMPESTRI xmm1, xmm2/m128, imm8
  * 66 0F 3A 62 /r imm8     PCMPISTRM xmm1, xmm2/m128, imm8
  * 66 0F 3A 63 /r imm8     PCMPISTRI xmm1, xmm2/m128, imm8
+ *
+ * AES Instructions
+ * -----------------
+ * 66 0F 38 DE /r                  AESDEC xmm1, xmm2/m128
+ * VEX.128.66.0F38.WIG DE /r       VAESDEC xmm1, xmm2, xmm3/m128
+ * 66 0F 38 DF /r                  AESDECLAST xmm1, xmm2/m128
+ * VEX.128.66.0F38.WIG DF /r       VAESDECLAST xmm1, xmm2, xmm3/m128
+ * 66 0F 38 DC /r                  AESENC xmm1, xmm2/m128
+ * VEX.128.66.0F38.WIG DC /r       VAESENC xmm1, xmm2, xmm3/m128
+ * 66 0F 38 DD /r                  AESENCLAST xmm1, xmm2/m128
+ * VEX.128.66.0F38.WIG DD /r       VAESENCLAST xmm1, xmm2, xmm3/m128
+ * 66 0F 38 DB /r                  AESIMC xmm1, xmm2/m128
+ * VEX.128.66.0F38.WIG DB /r       VAESIMC xmm1, xmm2/m128
+ * 66 0F 3A DF /r ib               AESKEYGENASSIST xmm1, xmm2/m128, imm8
+ * VEX.128.66.0F3A.WIG DF /r ib    VAESKEYGENASSIST xmm1, xmm2/m128, imm8
+ *
+ * PCLMULQDQ Instructions
+ * -----------------------
+ * 66 0F 3A 44 /r ib               PCLMULQDQ xmm1, xmm2/m128, imm8
+ * VEX.128.66.0F3A.WIG 44 /r ib    VPCLMULQDQ xmm1, xmm2, xmm3/m128, imm8
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -641,6 +661,20 @@ OPCODE(roundps, LEG(66, 0F3A, 0, 0x08), SSE4_1, WRR, Vdq, Wdq, Ib)
 OPCODE(roundpd, LEG(66, 0F3A, 0, 0x09), SSE4_1, WRR, Vdq, Wdq, Ib)
 OPCODE(roundss, LEG(66, 0F3A, 0, 0x0a), SSE4_1, WRR, Vd, Wd, Ib)
 OPCODE(roundsd, LEG(66, 0F3A, 0, 0x0b), SSE4_1, WRR, Vq, Wq, Ib)
+OPCODE(aesdec, LEG(66, 0F38, 0, 0xde), AES, WRR, Vdq, Vdq, Wdq)
+OPCODE(vaesdec, VEX(128, 66, 0F38, IG, 0xde), AES_AVX, WRR, Vdq, Hdq, Wdq)
+OPCODE(aesdeclast, LEG(66, 0F38, 0, 0xdf), AES, WRR, Vdq, Vdq, Wdq)
+OPCODE(vaesdeclast, VEX(128, 66, 0F38, IG, 0xdf), AES_AVX, WRR, Vdq, Hdq, Wdq)
+OPCODE(aesenc, LEG(66, 0F38, 0, 0xdc), AES, WRR, Vdq, Vdq, Wdq)
+OPCODE(vaesenc, VEX(128, 66, 0F38, IG, 0xdc), AES_AVX, WRR, Vdq, Hdq, Wdq)
+OPCODE(aesenclast, LEG(66, 0F38, 0, 0xdd), AES, WRR, Vdq, Vdq, Wdq)
+OPCODE(vaesenclast, VEX(128, 66, 0F38, IG, 0xdd), AES_AVX, WRR, Vdq, Hdq, Wdq)
+OPCODE(aesimc, LEG(66, 0F38, 0, 0xdb), AES, WR, Vdq, Wdq)
+OPCODE(vaesimc, VEX(128, 66, 0F38, IG, 0xdb), AES_AVX, WR, Vdq, Wdq)
+OPCODE(aeskeygenassist, LEG(66, 0F3A, 0, 0xdf), AES, WRR, Vdq, Wdq, Ib)
+OPCODE(vaeskeygenassist, VEX(128, 66, 0F3A, IG, 0xdf), AES_AVX, WRR, Vdq, Wdq, Ib)
+OPCODE(pclmulqdq, LEG(66, 0F3A, 0, 0x44), PCLMULQDQ, WRRR, Vdq, Vdq, Wdq, Ib)
+OPCODE(vpclmulqdq, VEX(128, 66, 0F3A, IG, 0x44), PCLMULQDQ_AVX, WRRR, Vdq, Hdq, Wdq, Ib)
 OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
-- 
2.20.1


