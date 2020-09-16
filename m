Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFA2C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B390F2224B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ii2MiOQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B390F2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWcm-00023c-Hb
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWh-0002cl-HN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWb-00059y-Ul
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id w5so6697571wrp.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YcCcU9F2In+Ku3PtGwzsyh5JOTdQ6yu4YMUVutwWuck=;
 b=ii2MiOQUlGFLxyKKUOw3tsZocoUJLENNLohooeoFExeENzA0nw5L7y77aa4i5pIiHJ
 SKUhlNFeTY6+u7Yqdgn2L9mwvUg0DvGaGlmht+0dwQNAnTLZO9FXSpFUF1ljcL2UPrET
 PwjLg4L3oxU1Ij0rARPCdqGNdPE7BZBOvhpYNgw7DASqpRf2C4AJeQ8LbDR6uBvFWVFw
 rokfyhbcLyUDGwop1yl2fyz4x6O7ZQlMPFlMw5srPqYG8myWp9lzFkxydBKpWWrhzU0I
 Ux6bQfeeqenzHRiZQ0uiHkBGxDZEOum4MrA6ZRlVxvs4IDxxbCLfquGKR2hcG3Bv6HGb
 bWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YcCcU9F2In+Ku3PtGwzsyh5JOTdQ6yu4YMUVutwWuck=;
 b=kV8UldBBWmXEqE1AYutLymek6Xq+j6TPnw20g81TrNlfsKoPQO7ZdtbAtHZ/2jeCKA
 6BLmzZ3IcDeO1lArg3uUKRkiv4PmTbz/TC7eCAdNYnVhgdMhJhXaNpJ/i9vYV4he5Pd9
 qChtVWIbtu6JrCH9Rim17FL4xsuzlvAFalqpEHvPDTTJjStrLGKl+3VUbWY77MS4bqif
 NtSlqMbNb+uqQ/RK6xDIaWRliqIvlRbiwzcBl9QXHUOrls26bDYDRoaxp9A9LM6+RePB
 utVpXFRofOnGldsEwb3fP4dJNK+ld2VOAhHqGmZpS52zhQ1woAXqXbUcnjaK/I38PQcV
 93Cw==
X-Gm-Message-State: AOAM531id2f76/ZXpdgs1Wj2C2Q750zeHGtGJX5stkX6Mdm3iEZHmFNg
 MY/RwsjrT5qk3tCE94KsWEX6ag==
X-Google-Smtp-Source: ABdhPJxRCqw2W1AB2w0CyHv9x14MFwk0P/5BVq/QkqCyXCBD1nhgVu7Pfi5yVcx9XJxyNqdif5r0rg==
X-Received: by 2002:a5d:4450:: with SMTP id x16mr25494168wrr.28.1600259220531; 
 Wed, 16 Sep 2020 05:27:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k5sm3434672wmb.19.2020.09.16.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BBCF1FF93;
 Wed, 16 Sep 2020 13:26:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/8] gitlab: create a build-deprecated target
Date: Wed, 16 Sep 2020 13:26:47 +0100
Message-Id: <20200916122648.17468-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These targets might be deprecated but we should keep them building
before the final axe comes down. Lets keep them all in one place and
don't hold up the CI if they do fail. They are either poorly tested or
already flaky anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200915134317.11110-8-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72e8604579ee..f027b55aef15 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -254,6 +254,16 @@ build-clang:
       ppc-softmmu s390x-softmmu arm-linux-user
     MAKE_CHECK_ARGS: check
 
+# These targets are on the way out
+build-deprecated:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
+    MAKE_CHECK_ARGS: check-tcg
+    TARGETS: ppc64abi32-linux-user tilegx-linux-user
+  allow_failure: true
+
 build-oss-fuzz:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index 65341634d02a..c75221dca3e7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -344,10 +344,9 @@ jobs:
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
     # we skip cris-linux-user as it doesn't use the common run loop
-    # we skip ppc64abi32-linux-user as it seems to have a broken libc
     - name: "GCC plugins check-tcg (user)"
       env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user,ppc64abi32-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
         - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-- 
2.20.1


