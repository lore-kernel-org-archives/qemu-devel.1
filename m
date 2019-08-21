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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EBE233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWkpW2ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EBE233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VQN-00052H-23
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URo-0001hM-EZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URm-0008Kt-FT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:00 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URi-00089u-Ln
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 1so900811ybj.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dCAnUoqj/GPXx5JdXdQFBAGk0+RtvAipvhXnYHQQRl4=;
 b=SWkpW2icRFz7+dNEJdXFlfXKqIGZrcuzQwjkwKIa8WKbxf4XZVwab5qb1LDcKbY/Lm
 1Xm43uMtdNrlrN6pQaSvI3dZqZ+dJyYYELViinVi2TC8WRlKbec1PhO3gDaBkWDbgnuM
 kU6iucTKbcyPAHIYqNV6IYFntt2NYT/Yy4a6DqwS2ltWCXQfIyXPs+doRTA6BfEuUFqs
 J1zf1lCkOPv65ZTTs0Sch38aH2VrnCZh35X4pu2c/6v6PspD2uNvaRcNXieizZZpjBjj
 jUqaEjsAVV3hxbPVmWo+xa9BK6AosulL+4HRB/VuM0WIyoE+kEam/LqT0Fgs8aIqO0Hr
 pssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dCAnUoqj/GPXx5JdXdQFBAGk0+RtvAipvhXnYHQQRl4=;
 b=pABp/tROvSHqVblQaRAd1MbQc2+16AibMJIDgawz+C7/AbpWGnq5r9JxltLoWPZPag
 jMSUPuOfm7m+2dtZ2O1uj46X2dzkF6a5zSkCFcQlprXy59KiPpTLYYvnxzxSUxU+jjRs
 fT69Kq2S5K8ZF1GE+wdFuoI3YMvY8UU8Bwci1hYqUFwpnw1N3Ul/nSydMmiSNbcrdYfa
 epx+FTBcnTPLmriDvlIVxlgRBIvnrM/F9w7txnQ5kNb4dzxqaOIOg1XVZ/UTSRIqX9nM
 MpR+gSGC6/Zb/X8/dKZf8fG4kCeWIJDKsPHnkyjGh8GtTsJKnMvLiaFSXpxOvvzDxvGc
 ChHw==
X-Gm-Message-State: APjAAAUjHCcFyxpsCO9GScWVf8jFQdqMC+u8lnXA3HEOR9v7x5nJeAKO
 qlZ/cllr5gwzAQltl4WsqiMRFamk
X-Google-Smtp-Source: APXvYqyERs28C54jUGP5C1van7eu0zSY3AElYkO2Bo09G3rdSJFRO1+uYp4f4vjTXTij5dAm2ajaOA==
X-Received: by 2002:a25:42cb:: with SMTP id
 p194mr22462857yba.334.1566408652465; 
 Wed, 21 Aug 2019 10:30:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:51 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:31 -0400
Message-Id: <20190821172951.15333-56-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 55/75] target/i386: introduce SSE4.2
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

Add all the SSE4.2 vector instruction entries to sse-opcode.inc.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
index 9682cce7ef..f43436213e 100644
--- a/target/i386/sse-opcode.inc.h
+++ b/target/i386/sse-opcode.inc.h
@@ -441,6 +441,14 @@
  * 66 0f 38 34 /r          PMOVZXWQ xmm1, xmm2/m32
  * 66 0f 38 35 /r          PMOVZXDQ xmm1, xmm2/m64
  * 66 0F 38 2A /r          MOVNTDQA xmm1, m128
+ *
+ * SSE4.2 Instructions
+ * --------------------
+ * 66 0F 38 37 /r          PCMPGTQ xmm1,xmm2/m128
+ * 66 0F 3A 60 /r imm8     PCMPESTRM xmm1, xmm2/m128, imm8
+ * 66 0F 3A 61 /r imm8     PCMPESTRI xmm1, xmm2/m128, imm8
+ * 66 0F 3A 62 /r imm8     PCMPISTRM xmm1, xmm2/m128, imm8
+ * 66 0F 3A 63 /r imm8     PCMPISTRI xmm1, xmm2/m128, imm8
  */
 
 OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
@@ -646,6 +654,11 @@ OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtw, LEG(66, 0F, 0, 0x65), SSE2, WRR, Vdq, Vdq, Wdq)
 OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
 OPCODE(pcmpgtd, LEG(66, 0F, 0, 0x66), SSE2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pcmpgtq, LEG(66, 0F38, 0, 0x37), SSE4_2, WRR, Vdq, Vdq, Wdq)
+OPCODE(pcmpestrm, LEG(66, 0F3A, 0, 0x60), SSE4_2, RRR, Vdq, Wdq, Ib)
+OPCODE(pcmpestri, LEG(66, 0F3A, 0, 0x61), SSE4_2, RRR, Vdq, Wdq, Ib)
+OPCODE(pcmpistrm, LEG(66, 0F3A, 0, 0x62), SSE4_2, RRR, Vdq, Wdq, Ib)
+OPCODE(pcmpistri, LEG(66, 0F3A, 0, 0x63), SSE4_2, RRR, Vdq, Wdq, Ib)
 OPCODE(ptest, LEG(66, 0F38, 0, 0x17), SSE4_1, RR, Vdq, Wdq)
 OPCODE(cmpps, LEG(NP, 0F, 0, 0xc2), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
 OPCODE(cmppd, LEG(66, 0F, 0, 0xc2), SSE2, WRRR, Vdq, Vdq, Wdq, Ib)
-- 
2.20.1


