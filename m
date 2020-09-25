Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D659F21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4ock7aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D659F21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq7e-0003Vd-SS
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq3-0002vI-Em
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq0-0007di-QC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id c18so4061595wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qNevELBFUrx1/zkHkvDIKUavrcR36IpGOTSGaduJWAw=;
 b=Y4ock7aVUNpat4nASkxJfdebG0EijZM32uHLiryI9VqmcnwbB/+TyDCU5iVmuEi6hR
 FD8CEBb7gjC8+bAjCfZYL3SSWM1c652H1eDr7H5lSHhwxmTDt4SYUhaERLSEt8LQYQIa
 C+Ws1d6aiLVAW9QtzfIDN1JvGZI4RX4qhKQltwCAyoFB5x4X6w7dWCVv4OJ2dwZXU3vx
 yYvkg/+7qribN7PDSouHRUqLVoR78/gjwW0PQK0fKrRkU76Och+Q9ZcW1x2BvWWZqUws
 xnMAy+osBT3qwMNpKMtMzkfmlckUlVYBdZMWM4rpcwEjzE8Hgr+goEsJBmPa6/EmCnK5
 YV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qNevELBFUrx1/zkHkvDIKUavrcR36IpGOTSGaduJWAw=;
 b=ZS9FvZbOcgyX7nCy754IQieA047XciXOYacbgbrKfdcdfnLl+c+G7BzaUWM9Q0jpBN
 Rg2now/0da6Fhp1m5fcXGyulEkCqZpA6nWtWr4x3chC6d7BRxWc3JAzFjVR0AcGicQu4
 sQVyX3gq9ymXLgxIh4QfTTofohDOPGyvyFJyzGIft4lPAeqtJXrXQvtWS6riq96st2oj
 ZSzoAZcboXbKkQQ5TnlRGTXpfxq7tdONyRW0e6NRHXiASO2jLiF6+PWBUotYj9ZzAHrz
 sbWSDLmzI2gLHwlb3DwIpq+JffDCCNq66Mav/4atph1ol3DypHOftrBa0LdDg9+wXbNZ
 GlZw==
X-Gm-Message-State: AOAM5334GCFLbH+qdp/opL/hk9NbJoC0AbkjzS/gtDvW8gebnqU7uwzG
 f40/9IgKExS0e6q1/8CGZNGdXg==
X-Google-Smtp-Source: ABdhPJwXHtx1n8nSysJ/vhAlnqXUYZ+JhShZurmCJkL+ro5UsVAZ0Dg9+vbOpM55XmWo3CFQIUaM/A==
X-Received: by 2002:adf:90a2:: with SMTP id i31mr5651404wri.276.1601048443416; 
 Fri, 25 Sep 2020 08:40:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q12sm3245681wrp.17.2020.09.25.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BDA01FF92;
 Fri, 25 Sep 2020 16:40:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/15] travis.yml: Update Travis to use Bionic and Focal
 instead of Xenial
Date: Fri, 25 Sep 2020 16:40:18 +0100
Message-Id: <20200925154027.12672-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to our support policy, we do not support Xenial anymore.
Time to switch the bigger parts of the builds to Focal instead.
Some few jobs have to be updated to Bionic instead, since they are
currently still failing on Focal otherwise. Also "--disable-pie" is
causing linker problems with newer versions of Ubuntu ... so remove
that switch from the jobs now (we still test it in a gitlab CI job,
so we don't lose much test coverage here).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200918103430.297167-6-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1fc49b07464d..80da4ebc8ea8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,7 +2,7 @@
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
 os: linux
-dist: xenial
+dist: focal
 language: c
 compiler:
   - gcc
@@ -10,7 +10,7 @@ cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
   # - OS name (currently only linux)
-  # - OS distribution (for Linux, xenial, trusty, or precise)
+  # - OS distribution (for Linux, bionic or focal)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -27,7 +27,7 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
-      - libgcc-4.8-dev
+      - libgcc-7-dev
       - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
@@ -211,8 +211,10 @@ jobs:
 
     # gprof/gcov are GCC features
     - name: "GCC gprof/gcov"
+      dist: bionic
       env:
-        - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--enable-gprof --enable-gcov --disable-libssh
+                  --target-list=${MAIN_SOFTMMU_TARGETS}"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
@@ -271,6 +273,7 @@ jobs:
 
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
+      dist: bionic
       addons:
         apt:
           update: true
@@ -286,7 +289,7 @@ jobs:
             - libattr1-dev
             - libbrlapi-dev
             - libcap-ng-dev
-            - libgnutls-dev
+            - libgnutls28-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
@@ -294,14 +297,13 @@ jobs:
             - libncurses5-dev
             - libnss3-dev
             - libpixman-1-dev
-            - libpng12-dev
+            - libpng-dev
             - librados-dev
             - libsdl2-dev
             - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-            - libssh-dev
             - liburcu-dev
             - libusb-1.0-0-dev
             - libvte-2.91-dev
@@ -311,11 +313,11 @@ jobs:
       compiler: none
       env:
         - COMPILER_NAME=gcc CXX=g++-9 CC=gcc-9
-        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
+        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread" --extra-ldflags="-fuse-ld=gold" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread" || { cat config.log && exit 1; }
 
 
     # Run check-tcg against linux-user
@@ -357,7 +359,7 @@ jobs:
 
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -390,7 +392,7 @@ jobs:
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
-- 
2.20.1


