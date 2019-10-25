Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F176206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhLt131N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F176206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu0L-00072V-NK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWe-0003bw-VO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWd-0007oQ-Th
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWd-0007np-Nj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id v9so973651wrq.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U7WrzD5ojl0k5ckh0pkIszWgrZ0CrHuIRO3XAz8bE3o=;
 b=FhLt131NSYQMF2mLzA3FpVRzhCGSMmAiBlT4HZ3k4sWZiPyo1XDfzuKOCdxBLs3iqy
 Nj9toZY/xPDnY0thnxeMjnluzZDiHHPTMwzUwgY8a0YHcx/MKhBjICWSVMF24HU1GZl/
 hw0nd1pwWYU6a77GNBqPJrGT4H2fmGEhMl0g6ogTP/pUiilKtUAZx9otnbB2qvok+YmQ
 G5ca6nem70LLwKu7KrSOo+fmx5bAK/JANyacurKCse4N/OeBLRQXOQOCY8u9Cvtv0o9z
 fMtFhoyyHw3djlu+lPs/fKKsVt8i7I7xipPCMkn3N1Tfn7JTTx2ZqBfajVhQKW45kxRT
 jQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U7WrzD5ojl0k5ckh0pkIszWgrZ0CrHuIRO3XAz8bE3o=;
 b=EefMIUbcWdNWTe4AJI20vcdsdRVZrGJiFq9hSJagwPxNS9VqtpF39ka3Rl4m0TebUt
 EkHMg/DBi6VGJff9+g0Qz1u+LRCAi/cwI7E0lrMI+5dIzBoqHOJ0hArbxwDze9msLWop
 kdGC04exb55EV3I0XLqpkIjtakaa0rxsG/pNjeJNFxodGNaDjbunHFCIqZRCYUXqrDDL
 AJEWSy8oCvfh3iFXzeSgiyEavcQrSlkDi4e7Kp3IHD/faYW5XhAhdZpN0e2rLO+VyrIB
 aYUUn7abtw1wDyTFLmrBcFtoSqFdy5hCK/ubf+Lt4TrwrK9suYGadZoeD/kZYChf8HCi
 P3bA==
X-Gm-Message-State: APjAAAUixa6REZ1YO0098mXa7JDhT14sOc/6fhWQ0DjR5PLP+s5KcSo7
 lGX8pTIJG5QW5il0DDmHC/lgUBwESPU=
X-Google-Smtp-Source: APXvYqyKrq2FrDc+AryCjwZl4qeOYVVHjMcsGAbKMva1XBr7pF0GVv9yDhnuT9PF8vyfxGzwPfWXtw==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr1304422wrv.149.1571986602555; 
 Thu, 24 Oct 2019 23:56:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm1136544wmg.11.2019.10.24.23.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 491F41FFDC;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 70/73] .travis.yml: add --enable-plugins tests
Date: Fri, 25 Oct 2019 07:37:10 +0100
Message-Id: <20191025063713.23374-71-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check-tcg will automatically run the plugins against most TCG tests if
it is enabled in the build. We exclude sparc64-linux-user for now as
there are pending patches that need to be merged fixing it's fork
implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index ba3a8d4cfc9..e3f10a93683 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -339,6 +339,14 @@ matrix:
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
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
@@ -346,6 +354,13 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # Run check-tcg against softmmu targets (with plugins)
+    - env:
+        - CONFIG="--enable-plugins --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
     # This is the case when release candidate tags are created.
-- 
2.20.1


