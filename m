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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE55FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84812084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCI/xOyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84812084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5HR-000310-6p
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DM-00063g-5T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DK-0008KH-Sl
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:08 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:38761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DK-0008K1-Ns
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:06 -0400
Received: by mail-yw1-xc44.google.com with SMTP id f187so297256ywa.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8aF01SLckOj3fHneThtSLSdq9Zx3ryEqfOh/qRUz9m0=;
 b=pCI/xOyBw0y12tr9rayCmTWHyfGtVlLnSTrbXRfUugmFqPDIqCF+5FYmuQNJ3uQFIh
 KarA4XYljcOKXs0wLhuqC4N4CKM119r797NG6T3vYxHu9TnRqjLqduD1EvUx9syNp9Wv
 gxa7RrrxA6V1UdI3hq+NtvoP01+3xjpzdleqVhHcS02Dh2dRE78AAELAMkWgode4+lAm
 /b/7+mplKA7X2bD2vRLdtH9aLMbQYKL3SZY+lUaWYrGzl+KUv77sHfZSxjTAbpzLLjxI
 K9DNDvpqW8iudhv6TrCYk3GWGQYmuXwodYOryN8hqbPtnuOUS0Y2dh/4AjT+3YasSKv8
 2jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8aF01SLckOj3fHneThtSLSdq9Zx3ryEqfOh/qRUz9m0=;
 b=jh2JhPLmqQaikY+ORUR++eXWES/TbcuPfwkRVhGM0HUL4/XggQRf3mJ8Ft2328YV2x
 P+tB8pXQnjqY0SfKFffpbkn46KH+Wf1Upc8FXJUnGqUpJMnjpDZQr7MaPX2fD24T8d7H
 LyIx8yQrsheqdUUBTWSfrnO69GYMpnfYPrfDd2ElmvWjsbEupOb+1SvtWaDCbVf3fzxy
 9ONRrl8W1rO5Ufp7cyFNL7JVeSseqyiahs1SJUrXVHEJvT+CU+ah8/ufshw4CTBSiIPG
 6lZfQdJemLcAqGPvCXrFByD1xHAYpsURmZrqQtRlwnObDU3UqubkNxfmK733cEpAnzjp
 eKxQ==
X-Gm-Message-State: APjAAAXd1kpAke85vcBEpvgSOPxulnLsqb1m989etsAnbx7b7pAxvB9F
 QfS3+QB9eWjM9J2DSV1UlIODtF1X
X-Google-Smtp-Source: APXvYqw/iPIWFdaClbSyGhf2E0JAvbexZE/yH2JcEONGUKWPKQuRZN/d+Ay52BQG3xDa/f/xGg5CFw==
X-Received: by 2002:a0d:c044:: with SMTP id b65mr1559992ywd.273.1565835006114; 
 Wed, 14 Aug 2019 19:10:06 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:05 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:55 -0400
Message-Id: <20190815020928.9679-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 13/46] target/i386: disable unused
 function warning temporarily
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

Some functions added later are generated by preprocessor macros and
end up being unused (e.g. not all operands can serve as a destination
operand). Disable unused function warnings for the new code until I
figure out how I want to solve this particular issue.

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index fdc7cb0054..e9741cd7f7 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4489,6 +4489,10 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+/* XXX TODO get rid of this eventually */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-function"
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
@@ -4515,6 +4519,7 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 
     g_assert_not_reached();
 }
+#pragma GCC diagnostic pop
 
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
-- 
2.20.1


