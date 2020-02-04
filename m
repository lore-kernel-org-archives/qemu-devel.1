Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF096C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8605A2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5GD4P0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8605A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3E9-0006ie-Mo
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37x-0002bL-1h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37w-0003cx-1e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37v-0003Yh-Qa
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:47 -0500
Received: by mail-wr1-x435.google.com with SMTP id z3so24457865wru.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/TV/N7OzCTJ9WVazwWcBCI64243f6rpQOW3yZSm6a4c=;
 b=r5GD4P0DimIAbKmKtJHnjxWYHjc3/0pdCnHHcYW38Ivre1MRjEn0u33XOgvQkZrXMI
 8WxWAQh9MmYolKLW4149IXnjeguwYgLmi9iEdRem86fjV9a8sJB0hZU4LsmNo+P96j+J
 BmkvIiPrH6Z1iug68xICqfAuPYdJxgOGrX6iomOAzU+X8OsE188gTSKIl2C+agJJxAtQ
 7H7HnAlbCfitOxhf+33YiF8Pa0BRBxs0/v4/7ki6Vub8DxW4hPtfjIZQ4PkkCbo213TO
 Pik2/qRe+ELftjqDKwOYhALlvGWTp+zlf2xaNQNGSP7Rhia5WO5uycrmqftF4h1zYh35
 MCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/TV/N7OzCTJ9WVazwWcBCI64243f6rpQOW3yZSm6a4c=;
 b=tW2wBeeqB8fwn4SHEpuGumjhC5ltaQP/VqXX/7g18LmMkQthmOtf9kjy1GgS+cYrKx
 1EFzLKNtA2rX/r5fLPGdotyQIMHVo+WPrmB3zppw4K4alcyl1c1XvBMtOIueIiCmlyZz
 ifI4lbcyA6gOUwnTy3xfbBwZDJdYJxajkVoRsTpjXRCFPJhbpkO0W3AEBx7cxonk0ySi
 +QkYIu73ghoJCJIdgq8p5RNpL3SB+4Rkc7fi5DJlsc0hyQ0WHerplmLTd9QbGyeZllvC
 gTXzLW/OIGCBAb9t7WaR1EXh9kBFbaB8hzZiElHC9ltbwDGvr4PXfSQW5BES+Db4GoGx
 ntRA==
X-Gm-Message-State: APjAAAVaN8X8/ZLC4igCkSE16mHnR9yoQzH+ctJOpQsbGcYjMndjhsJF
 Wd3fGdxfE3slFRX8r+5QB2hulg==
X-Google-Smtp-Source: APXvYqwQvbDu3sBB6UDDiGh9g8TYm/FC8A1rJvFGgej7QShw+pgeVugMAj3TVf0YDtoCmWjtA9Mgpg==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr25096356wrr.204.1580841646771; 
 Tue, 04 Feb 2020 10:40:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k13sm30410947wrx.59.2020.02.04.10.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A04BA1FF9E;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/16] .travis.yml: drop cris-linux-user from the plugins test
Date: Tue,  4 Feb 2020 18:40:26 +0000
Message-Id: <20200204184028.13708-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it shouldn't cause problems we will never get useful information
from cris as it has yet to be converted to the common translator loop.
It also causes the Travis CI to fail for weird reasons which I have so
far been unable to replicate on a normal Xenial system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200203090932.19147-17-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 875671325c8..c1c6df475a8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -387,9 +387,10 @@ matrix:
 
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
+    # we skip cris-linux-user as it doesn't use the common run loop
     - name: "GCC plugins check-tcg (user)"
       env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
         - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-- 
2.20.1


