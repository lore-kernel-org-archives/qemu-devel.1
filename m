Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D8C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60932084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8WL9jcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60932084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyEp-0002TO-KC
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBk-0007fj-7B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBi-0007Af-SR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyBi-00078T-LF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id b24so16301977wmj.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X0Zojohlrp9hFXtLnwWUFyqJ6AI3VRmKHspf1lmW8O0=;
 b=y8WL9jcZEL8j8g5ZUFblK07JKH9jMhPNspIfxwRpIuCiXHmFls01aQlmbA1xCu36qr
 HB1s2dgPku02tKlPJE3u7G339kgbPVeRVtIy/cafAAfQ4ENU5FTohGo7KoGPA1YAkZ9s
 1WNVvJXoMIdanFp50LiL39wLBI7imsU9pAjw/Ucj6CjuWdEvDDka2iCLo5jDPWbYrj4S
 PzmpA26rz/wklL67lGzR/p/GDFQdDDQTFbDU5Z6QOlfsTE9WH98sCKMFPJo9te18txOT
 Ol0lwstNLxqJsHJPwnQvnqd7h7u10ti3fULc8cifBQRRkcEZpsGvFc3Kj0j3Z7nzOfaJ
 FlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X0Zojohlrp9hFXtLnwWUFyqJ6AI3VRmKHspf1lmW8O0=;
 b=Hhaz9IOBJWpWV4znlWsl4jq8eQW8wjkfDSkt+2qmi2n+EpB3Wx84EU+VFAygqC0VgO
 rCm4aYYOj0a2V2myebCO46RkxNH1mT0h3iSyB7RiL6PEyzR8LigVtrw/LEIjFJcz0W4h
 n8fuqYJZdO+tlaaENQHrteONp3qO5O9+gMx8O2pNILC3y9JEJO39A3L9QH0TPfIizD4h
 LEsFhJIjyab+c579X3dHyx7Y2881EVvVf9wf6o6VJK43YZhTgb77sBcy38zicpS/2XJL
 T3PL+EWHTuwWa6SHYMdJQ7tXRjA3FPTqG6KfRPYpmKoVv6Tau8uabz9cooSFLQjSgwc5
 p9kw==
X-Gm-Message-State: APjAAAV+j76OZb/Ehz6OUpIHYplGtBNBa7uYRmLJ5LQecq7Q1N2cU7is
 hz6wysmcTGJMP+JGSL/uSwqNvw==
X-Google-Smtp-Source: APXvYqzcF6T3trT6erdzrQqgePsB3R/D2tlDtmSwAn2vFXKEEopjT9sECdwxpLzG09a17d1on+ZTiQ==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr14323942wmi.21.1571051212873; 
 Mon, 14 Oct 2019 04:06:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm22107558wrn.81.2019.10.14.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:06:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A6B6E1FFB4;
 Mon, 14 Oct 2019 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 28/55] target/hppa: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:21 +0100
Message-Id: <20191014104948.4291-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c1b2822f60..2f8d407a82 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4221,7 +4221,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+        uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-- 
2.20.1


