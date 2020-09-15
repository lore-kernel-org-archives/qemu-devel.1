Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F38C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D280B21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYt1K7yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D280B21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBKG-0007eB-UH
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF6-0000t5-Rh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF5-0004A8-5P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so50862wmh.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RIQ55TyLOp5zbXj8SHskFG2Y72E7vX075sBNHlYczZY=;
 b=iYt1K7yqkTMoQz9QUHbiUm0U/TXHf3FU9EPs+eJr6kl8Reeh7Y5bSBnhkosw/XbvHd
 EPZxkj4jfMxrAzda7AQx0Q36C6G5q6soh4p/mv5DxvmTSYMQJ9KheUbjlBHihDVAJR4i
 4N2+J/QQHMwFyvtw6WUUozo2EZ8xlXlA7fou2uBp80lzIaVZSd+xK6DWyEC71zepzcKj
 gw5mPfzAhbrvRtUENVEclQvRE3q8r/DGzOCEaoUkmCVy21a+B98BAwCk2A8x/DBlVEhE
 R7F34JVa5wAXkZej/BXURcHmvIHVmjFPhrsOeKEwqk+eXzpYlj78Utk+rr9+D9OiSkrJ
 vMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RIQ55TyLOp5zbXj8SHskFG2Y72E7vX075sBNHlYczZY=;
 b=fkHUm9/tnre1kC0BV2Bl6bq7pB+rq5WAYEgzND74v/hQsVS2vCKUG4YUQWFIRQIgIt
 asgXjXFpFnGKnKIPk10xSuAaXx6pev6FVq9vCPnlnXIu9U/o7uDN2NmXPduKlt94vTvz
 aWrY8X95tEV2i5XudwVAPCY2xeQw2V6auGlEROxm8K09+oVcfuzFLwp1UubY4bJQvZe0
 y/MuoGke2/GdsQq7A0wYs2cuK6zHAPsWlkd8hkQ9oXrQJ8Vde5bRvNeYvrpkitD5WNp2
 JWk1D1ndbvbDCxzGcyPt/15+VIkZeDX2ILUVFsYBGdsH8tZHfpxX9+hABblBNX+Ad+ld
 CTZQ==
X-Gm-Message-State: AOAM532SfcaE7++YqRL/DnEseJa/NUPMQb6M1ln6CHfA00+r2kO1T3L8
 io8BBZYoGq4zMSzjrBwTgXFVqA==
X-Google-Smtp-Source: ABdhPJzfOlP9ygGXhSRGnlNE/8cy07WN774qVw0uH0oSIwMFHx704zJaQugEZipgk4G79lOX/EQMMQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr4660852wma.87.1600177409722;
 Tue, 15 Sep 2020 06:43:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h184sm25747972wmh.41.2020.09.15.06.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C145B1FF93;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 7/8] gitlab: create a build-deprecated target
Date: Tue, 15 Sep 2020 14:43:16 +0100
Message-Id: <20200915134317.11110-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
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
---
 .gitlab-ci.yml | 10 ++++++++++
 .travis.yml    |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

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


