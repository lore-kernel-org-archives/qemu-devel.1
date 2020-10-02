Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD9120719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrYtfUb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD9120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJUT-0005G1-C5
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNI-0006vA-Cj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007dT-BM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id s12so1431354wrw.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V8w5gFyqs3rkDT9U+8pSjZ6LqA4RWs5w6dFBc0m5Qgc=;
 b=QrYtfUb6qXRSi/bmvk0rEdi5naBRbgytq6PBeXPPoQ3sZoC3m/jDV6h0f5XZl1Mu+I
 poqfxJnCyTNKEf47sP8sqb4+hrrAinEronKY903SijNYElQ4fMWSOe82KokrSdgIdXW+
 uIs2ldIUYGqnvfaBywLX3VvkMoQaHnaQ1rlA5cnNiTNdWtxfFkGmOweJ7ZkqvGDwEa58
 Q2WFcioA58CCw3fBsVORXRnBwBDCmHf4BivPAi675Ssy+gBQHhvWrgLuLZuJ71St4hk2
 Pt2fpYYFgoLRPHrYG3FxNdMS1rWfiXfi2/IgUj9fgIM5Uklwk9eph5uMqkzFboARELRq
 ccSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V8w5gFyqs3rkDT9U+8pSjZ6LqA4RWs5w6dFBc0m5Qgc=;
 b=qWDw/+YIf6MpzYyWk1ur90w6T46aP6BqMa3hzMjjxP7sBOkotu6CAlhCqtjIo43gNK
 X7nKjgnrgL+F+9nasqM9wCmW9HqJYcaq+fDw6uYVdVCinPqX28HavJ05UXQ5rVCbnix2
 x2eo2hiLE/kP9K0kgN2npNHsdJD3Wo8ELpQN83+JiIzTusyeNDtx+rpu/4yZcFaLwOYq
 UhLJJxLnNA378awzO0lAVO+kPZMkPLwI7SyamEgmuoiwxtyXgWa5BheRx6Hz74gn1m4n
 2WhiSfOILkZeXTV/bC1Jk8+pNcjwnZ4bTVvsc6bWewHcxAp/+/LbFM4FZA7bgc+LveNY
 CtkQ==
X-Gm-Message-State: AOAM533sHUhiB7yOEYn7ECF9wY9Bga3mG6TojsyY0Fq+s3CS/0C8a3+k
 q2Z05eowmM4DkJAJySShE855aw==
X-Google-Smtp-Source: ABdhPJw4Ia+EleDNsDf5XyotuTl77+zNmyy1QzQulCOPQX5TUyOrxnQdXnoFoozSBZN8RPbghu6ofA==
X-Received: by 2002:adf:a34b:: with SMTP id d11mr2553815wrb.7.1601638629024;
 Fri, 02 Oct 2020 04:37:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm1591402wrv.72.2020.10.02.04.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29DA41FF9C;
 Fri,  2 Oct 2020 12:36:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/14] gitlab: move linux-user plugins test across to gitlab
Date: Fri,  2 Oct 2020 12:36:44 +0100
Message-Id: <20201002113645.17693-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Even with the recent split moving beefier plugins into contrib and
dropping them from the check-tcg tests we are still hitting time
limits. This possibly points to a slow down of --debug-tcg but seeing
as we are migrating stuff to gitlab we might as well move there and
bump the timeout.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201002103223.24022-1-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c265e7f8ab..346f23acf7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -244,6 +244,17 @@ build-user:
     CONFIGURE_ARGS: --disable-tools --disable-system
     MAKE_CHECK_ARGS: check-tcg
 
+# Run check-tcg against linux-user (with plugins)
+# we skip sparc64-linux-user until it has been fixed somewhat
+# we skip cris-linux-user as it doesn't use the common run loop
+build-user-plugins:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user
+    MAKE_CHECK_ARGS: check-tcg
+  timeout: 1h 30m
+
 build-clang:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index c255c331a7..519e62432d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -311,17 +311,6 @@ jobs:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
-    # Run check-tcg against linux-user (with plugins)
-    # we skip sparc64-linux-user until it has been fixed somewhat
-    # we skip cris-linux-user as it doesn't use the common run loop
-    - name: "GCC plugins check-tcg (user)"
-      env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
-        - TEST_BUILD_CMD="make build-tcg"
-        - TEST_CMD="make check-tcg"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-
-
     # Run check-tcg against softmmu targets
     - name: "GCC check-tcg (some-softmmu)"
       env:
-- 
2.20.1


