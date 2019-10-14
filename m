Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E795EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16EA20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CT8C5r72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyVo-0006DM-FA
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2D-0006mC-RX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2C-0005EP-Sq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy2B-0005B8-CX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so19149137wrl.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xLFSa4w57TB2L7dDfU1OySLvcjk7v8MeCLcxQIOKNAo=;
 b=CT8C5r725CT2KWfWLaMhgBz3CglamerMDXY79bsg6Cl9r2GSY6iJiXwQRlj1miX/Hb
 xlyqa32VoQpWwuROZaAe0pRmKoXiq6oeZPMlw1qM48IHXG/sN4KmOhwpGanhXRaWzfl1
 Fq71inf8SqRXuhhCtFSKcvZNa9boXW7rvqGRIxn2G/jSe2qaPuvWmrVGSk7pvXMWqGhs
 gpB28C3q8vvcn5R+7cA5QNblv3ZMTkaF1gPQSRZeQQHZuAGc/olijzrtno3dm3TW8ocr
 +CmdfTrib0j4/k+6nudQIzGJnPcQbIE3WdMmjnru6wCCHNXlFw8kTPO8olvbXr+v6zu+
 s/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xLFSa4w57TB2L7dDfU1OySLvcjk7v8MeCLcxQIOKNAo=;
 b=O2A4pzj+7Cq/DsuFsAAbaejEbOb+VOkQGeQtOQCTBpT9oiWZFQ6rBW3xs5qBbdBLhj
 Eye/MNSiO0R0bADYSoy5bGOTWExPSr2F052YJsO1pk8roViI6MT0P1OYvIfabBJ3C/Qp
 WKwlXEQgF3TpfG+qMcxuxAFO+td+XxqGyamHmfUHbG58Sy5U4S3RGNo/lhfrnQ9k+v5W
 gDjaDZWvR16jilTdNR+PhQkzheMAPyG/1/zR6TGyn9NR7V+Lp2wwCuzy4zgPPltuhw4W
 zO+ugoK9ZXonIZaVdMSN8rYPbnhbpYWneHVaE+OiHqxeksl0WxFQ3h7IvMemUGZz2LP/
 Y3vw==
X-Gm-Message-State: APjAAAVZOCr8unCaj34JbKIL6Gewfqth9qChY0NC7hhmM9421ihcHtdw
 QajU22BtH1+DKJ8uosOs1Jdtmg==
X-Google-Smtp-Source: APXvYqwlAyitJ9BYZYJiUDa5S0TXk2mfhEnGPe1Tvbkfs9ubAQB1LFlCYVnzTrHz/7q2Lwo27fmGUQ==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr11123783wru.379.1571050621388; 
 Mon, 14 Oct 2019 03:57:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r20sm22819850wrg.61.2019.10.14.03.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D86D31FFB5;
 Mon, 14 Oct 2019 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 29/55] target/m68k: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:22 +0100
Message-Id: <20191014104948.4291-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 24c1dd3408..fcdb7bc8e4 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -384,7 +384,7 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
     uint16_t im;
-    im = cpu_lduw_code(env, s->pc);
+    im = translator_lduw(env, s->pc);
     s->pc += 2;
     return im;
 }
-- 
2.20.1


