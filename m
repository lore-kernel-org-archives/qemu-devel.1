Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D617C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A145208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnPmBxMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A145208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cBt-0000cv-MP
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqp-0000et-M2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqo-0000YQ-Fw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqo-0000Xi-9I
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id k6so6264231wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GNd2ZKncMfCUSVKpijAHXvsP8/P4bKfNh6VELcXjcfM=;
 b=rnPmBxMp0EDP43bQOIjGDCrXLzosyMdd0JG3AHGpRwvOAaZwN+j3C4uzXl4pnPFhh0
 EQ70dGdnhQaIpp7I6DHmQ5MN7B64IIsPwg/ta/NJN3RzHLfCIJ77u/lZe1dJps1d8QYB
 PLqBXcvpcXqpCYAlPBnOirShYRUm8cw0SpbLagW+4JZmsUPSo+rhTWDdfiizWiGeN/e5
 xARnI2WtjTnz8o64RBAWQuvJCUfZrX6WBnrWZLESS8DIM5EyOlos8t6UUGbKlOLncQqr
 KLPPvT5KW/4hmlVch/UCeqt5/82GOz1Ylj7XGDal7wyEHUoPksXacqke0r8Qe7n2hFBq
 z+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNd2ZKncMfCUSVKpijAHXvsP8/P4bKfNh6VELcXjcfM=;
 b=JIMPb7KhSOgGRl9Hk0wpSoK/OgwYb6js2UBTKSbq4xfUbsa/EVBoz/isTmig7CQPMy
 IqLYoOHeckKx0i/ChUBsvsY2QJEYiL+4tJnCn0Dy0b/4fvq2S+QoqQjgULp6hZF1yEiI
 uiiHCFfTGv+PUvbGxtjfZsBMbWdDfvKpeMliG6n5zycoluublhxSyXSq3boOaLFNO0Lo
 ztjDf9rI+nuOG1qQDKhM+fo10AErO5obT6/rHA24iz5j9uHsXlI/Q99kqUX6Vh1L/1uK
 BitcaLzbOvy104Lh0/o458fyS6nMGcvNdAMw7WYHxQGufErInWrW2qPlt+WzzxJ1jftE
 TqJQ==
X-Gm-Message-State: APjAAAXHsFjFjGrIf7JFYefGV8e7MLQTYl6KMxXNkRS1ivJNoCdzOmQN
 NkmUwSPb8eTSdgZLCEFBYbJQbA==
X-Google-Smtp-Source: APXvYqwYWYh+biRhi/FAYsizPEJqonP9oJMsjtEh8QIb9zXEZzQEj47rkML5tPqIjwSEJ5jlA1WOoA==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr24669749wrw.104.1568105413205; 
 Tue, 10 Sep 2019 01:50:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm36461356wrc.77.2019.09.10.01.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6BDBA1FFC1;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:46 +0100
Message-Id: <20190910084349.28817-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 42/45] .travis.yml: Cache Linux/GCC 'non-debug
 profile' jobs together
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These jobs build different components but use the same
host features. Put them in the same cache bucket.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index d2da12580f3..74f10d352fe 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -101,15 +101,18 @@ matrix:
   include:
     - env:
         - CONFIG="--disable-system --static"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # we split the system builds as it takes a while to build them all
     - env:
         - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Just build tools and run minimal unit and softfloat checks
@@ -117,6 +120,8 @@ matrix:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
         - TEST_CMD="make check-unit check-softfloat -j3"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
 
     - env:
         - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
@@ -136,6 +141,7 @@ matrix:
     # Module builds are mostly of interest to major distros
     - env:
         - CONFIG="--enable-modules --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Alternate coroutines implementations are only really of interest to KVM users
@@ -155,6 +161,7 @@ matrix:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       addons:
         apt:
           packages:
@@ -196,6 +203,7 @@ matrix:
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG="--without-default-devices --disable-user"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
         - TEST_CMD=""
 
 
@@ -239,6 +247,7 @@ matrix:
     # Python builds
     - env:
         - CONFIG="--target-list=x86_64-softmmu"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
       python:
         - "3.4"
@@ -246,6 +255,7 @@ matrix:
 
     - env:
         - CONFIG="--target-list=x86_64-softmmu"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
       python:
         - "3.6"
@@ -317,8 +327,11 @@ matrix:
     - env:
         - CONFIG="--disable-system"
         - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
 
     # Run check-tcg against softmmu targets
     - env:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-- 
2.20.1


