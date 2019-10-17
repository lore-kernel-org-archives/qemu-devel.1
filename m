Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA32ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E6420820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2XK7l+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E6420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7IC-0002bS-Sy
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FW-0004eM-0e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FV-0004Ek-4p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL6FU-0004DO-TL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id j11so2495942wrp.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xLFSa4w57TB2L7dDfU1OySLvcjk7v8MeCLcxQIOKNAo=;
 b=R2XK7l+mPtMzL95A2TVWSs1cW4l2QzKCHOwOxCebxn4hjLFEdrPlry1ckhfJSolyYm
 l1f5OnIRSANA2KmKZJcV7GPGXwuK4G2awQYLRul3wVpDUYQlNXxIIUzpg/aramXpSb/I
 4m400j0TZHyLZ7n2RDMLoklGs6WdZiZS091wnBMoRFn0Rxy3K1Q1YDyuOS/YQCMz3gDb
 dZ6k/HGkbb+mDnK7TeptVRnxH9Q5SyvQBcxUgb0oujNaxXKbv2mgHvBCnqaud4RwWeDK
 1ftuAV+RmD5KSfCWO0Py7MCsXp6IDJD1guIS91HvLyYCAPfV3rxJIUwkDMMebJfhOB+x
 XeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xLFSa4w57TB2L7dDfU1OySLvcjk7v8MeCLcxQIOKNAo=;
 b=d+w+lSwr3b/Y/MBzP1vG48WqsswTX/7b4nuIZrl0oKkvDVO7HjHKBBwAYKaX0RJOty
 rJGrls82SoUUngRsG3UXXIVzhyV0g1VSgB5WuqQEYoh4cIBiTMY0RvLOc0+6ZVzlJKZ/
 t5OcozLqMMraA1exbCSBgKUTXLC+lhRm5QnNxWZOsF8SUsjYPTh1CuWwoOHhNJR//qXx
 oUBJ9UC58htXoP4c22cNiSwzslp3h3L+HTai67xCktSkz1pea8uwUIgAqulfDi+aLH95
 k6/cUZDGLbhqsTkGmyyaqmbeqE4zntGwbbeKwSR+xFxw5kWM/SS8k5qlaId8Qjh25m4Y
 uhMg==
X-Gm-Message-State: APjAAAVS0a6aBjbCGxGk6kVpLn2jgE/bWmtxHq5QqSgd3PIuLJkWDXDq
 t4Ol28H3eicDLIvxwJ4RqCHkLg==
X-Google-Smtp-Source: APXvYqwQRkEc3ODAynNl2lmWHeWt/Fqqyra/UTG2LUgi7b6DmAwRPDcAFztghKLtCfRs8/uNCOjx0Q==
X-Received: by 2002:adf:f805:: with SMTP id s5mr1541773wrp.329.1571320522323; 
 Thu, 17 Oct 2019 06:55:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm2362922wru.90.2019.10.17.06.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:55:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8868A1FFB1;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 28/54] target/m68k: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:49 +0100
Message-Id: <20191017131615.19660-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


