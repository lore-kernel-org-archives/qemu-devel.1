Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A044ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EDC206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dck61wv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EDC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyii-0005dY-5E
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyCA-00083v-5h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC9-0007gu-3P
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyC8-0007f9-TE
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id m18so16323032wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cgnURW7On79/62ZfWFlo3wt05KKxTsvmAfQT2MMGb8A=;
 b=Dck61wv71VwOMiZLUxd0YHY7tTYvalyf3JAyksmOOjIUgLRsClbtcGX342W/8PDYV7
 OsoBHzJwDnw8cpuYgukbVUiOQPXquqo38Z63FnbcZI/+Z3MkCnQM1cIwOxUbKO/lNuqs
 x1VJt9HUJvV6Ytnd8OwibfOx91IQFTlgtSzgO1UCoIE+s8uqxYd5UB2zOSwzJEpYDC8q
 srmk3pH9Q0lyAGugQITSRLpQiUITSbs+6zSNfqjLwVh7IbMhCt6cvST6csFIkUBcZ/cq
 Njg6aZFt7W2hHY0GajCsY10EQW2hFzhPZy1236vfXA8G90v9+zyCY5H0de3zlJj3nXx+
 7wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cgnURW7On79/62ZfWFlo3wt05KKxTsvmAfQT2MMGb8A=;
 b=IXxhpwh1kWVrKINg3iq2lwvMy/0gFuWhHHIC0k0PK27bwHDoWt+6c1gk/xshXysFnq
 ksMRr/H0avzY5wksjSN9YjEEy9UD1XVojB+SC6HdOwLCcaZUsBn8pBM4vO32DhMkHhre
 OmcgfMRoXUTgy4cxbz3zp12k6O8tfBcGI/aVFye2hoCB3yn0ihJ9CRzwORx0CCYmQKi3
 JIMHmsNsLSFrZhwCZz+HxvkJx1nCNZhSDGwuojobIyagyTFLtGxgCnUFr+XOxaF74pEO
 pM68Pe4sqc07zcNnz9EN6WKy+Hyfxu2+I2CSpkPibXFc971iXdelklS+D0w8TJLGYXy4
 Sp6A==
X-Gm-Message-State: APjAAAU5vDlXI65W0IJwhSryw0AUs8Cce6jGwpZOm9Zgyc6sX0fwm2yK
 DY9Mcg/iiuyE6+jKWV2/d/KISw==
X-Google-Smtp-Source: APXvYqwW7lP66UHLDfLRxC1gwO9lwr6zPy/wvo9x/FjTrR6uzbbpFaWGT7NDYA3DLg/4QXLhR5No/A==
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr15120161wmj.154.1571051239230; 
 Mon, 14 Oct 2019 04:07:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm36321550wra.89.2019.10.14.04.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 816461FFDE;
 Mon, 14 Oct 2019 11:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 55/55] .travis.yml: add --enable-plugins tests
Date: Mon, 14 Oct 2019 11:49:48 +0100
Message-Id: <20191014104948.4291-56-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check-tcg will automatically run the plugins against most TCG tests if
it is enabled in the build. We exclude sparc64-linux-user for now as
there are pending patches that need to be merged fixing it's fork
implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 .travis.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..37bca1ca1c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -334,8 +334,23 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # Run check-tcg against linux-user (with plugins)
+    # we skip sparc64-linux-user until it has been fixed somewhat
+    - env:
+        - CONFIG="--disable-system --enable-plugins --target-list-exclude=sparc64-linux-user"
+        - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
     # Run check-tcg against softmmu targets
     - env:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Run check-tcg against softmmu targets (with plugins)
+    - env:
+        - CONFIG="--enable-plugins --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-- 
2.20.1


