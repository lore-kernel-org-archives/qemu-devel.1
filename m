Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC3C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23FC217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUFJ5IWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23FC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36183 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3C5-0002ld-5x
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37u-0002Rd-5S
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37s-0003PI-V5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37s-0003Mk-Ow
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so24407709wrw.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8PJB/3wNiT3SG8Z/wz8oud6QTSe7SXUwd1RNLp8LyOI=;
 b=ZUFJ5IWBwpr4swokfP7og0e2ekmoZiT4tvyMFNMNT8LcKbg8CF5ZokUIXCp69Y7Z/T
 3DcENDnmbeYd49l4p6Q8ihXKtT8qIwTQWDoKRIPeCg7jJwDt67LhhivitoVAQqmJMoT+
 1ZGgQyys6n1Ogx6H2iRlJExlbCo3CY0svXwcI4lm27W8erozrj2alpus1DUEhPxaPkWs
 vZSQgcJw9e+XWDhy6bhaTxcIaZ3C6F3Uaajb2Hz1BSnyoitafnB4O4WrHluAjee3Ju70
 7NrGruE54XAcfhbWWsZqlaz3+sG9UpYISo84NxMt4DsnhFI1wKrgqKp1FKwqbuYnr7Ak
 UvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8PJB/3wNiT3SG8Z/wz8oud6QTSe7SXUwd1RNLp8LyOI=;
 b=At9S/DGxGxsSWso5LxavMsTFqUr6oFCNE+S7SJWA+qwlSwt5EqLCOzZR+hcPSLHUT8
 E3hEL1C3FDVFapqXOc10vEmW6dymhqAA/O8loRpVPEfTIAAlG6WS9N5HwZwisbHdLNha
 drzuonhSzdF8E5bfs6l2Ai9EXcfPcrF3aozUqrTqVVuT44ULh4qoJtcBrm+zUWjSrPTY
 WDncPd9qdnOTmwt5+OOpt+DCoiosIit+4qHxvWvYnie9etCR+cVVLefLnPuLUW2YcS5r
 VFc/Pzc9486qRvDl29kUJFkYi8J2eRVXf/AFegK9VsHbTN4/EyFMrwO9ivnN2sVkKnxc
 ARjw==
X-Gm-Message-State: APjAAAX06MYobug1xXBK0h3wKdUJzS5nDFDSfB/1zHKSFyQZoDP2qzd9
 ZcG9kny8n/jKTXKz0KzXxmSf7w==
X-Google-Smtp-Source: APXvYqxzGh87LgRg6vASv/z3e6MEVcTmXv/rRRK8A8TGtdoi06l4V/SSHI+Nqo+TVeOljQaSRny7Cg==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr21950701wru.99.1580841643748; 
 Tue, 04 Feb 2020 10:40:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm31284817wru.50.2020.02.04.10.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7585A1FF9C;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/16] .travis.yml: introduce TEST_BUILD_CMD and use it for
 check-tcg
Date: Tue,  4 Feb 2020 18:40:24 +0000
Message-Id: <20200204184028.13708-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

At least for check-tcg we can split the build phase from the test
phase and do the former in parallel. While we are at it drop the V=1
for the check-tcg part as it just generates a lot more noise in the
logs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-15-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index a600f508b0a..022462f6981 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -71,6 +71,7 @@ env:
     - SRC_DIR=".."
     - BUILD_DIR="build"
     - BASE_CONFIG="--disable-docs --disable-tools"
+    - TEST_BUILD_CMD=""
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
@@ -96,6 +97,12 @@ before_script:
 # Main build & test - rarely overridden - controlled by TEST_CMD
 script:
   - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
+  - |
+    if [ "$BUILD_RC" -eq 0 ] && [ -n "$TEST_BUILD_CMD" ]; then
+        ${TEST_BUILD_CMD} || BUILD_RC=$?
+    else
+        $(exit $BUILD_RC);
+    fi
   - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
@@ -368,7 +375,8 @@ matrix:
     - name: "GCC check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_CMD="make -j${JOBS} check-tcg V=1"
+        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -377,7 +385,8 @@ matrix:
     - name: "GCC plugins check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
-        - TEST_CMD="make -j${JOBS} check-tcg V=1"
+        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -385,7 +394,8 @@ matrix:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j${JOBS} check-tcg V=1"
+        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -393,7 +403,8 @@ matrix:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j${JOBS} check-tcg V=1"
+        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
     - name: "[aarch64] GCC check-tcg"
-- 
2.20.1


