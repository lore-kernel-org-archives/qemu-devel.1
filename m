Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D748C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB6A206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax9awmYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB6A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJTp-0004WG-1A
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNG-0006ti-EN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007bv-8G
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id o5so1423756wrn.13
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WQ/czQxQGLcgdCZRtqh/qd37OiFdMr4lYxa9jTrDLXM=;
 b=Ax9awmYza45IcjCecOQZFeZDTtozRWbmzHVCloPKqfExgjPQ86XKcUAF2YVuQ8Ddy0
 t7/mP2nr+9Cr0plRyPvTCe+euwNZWOLJjmT40QaCK36FIEezkDvSg2X0r3wYjsciDVNp
 n8B2W9ERun05VH78gMFy2Qg0QjJA6xxmdcH0oSzSKqC+qBaCdBoI2gmBqeGq8CQ4gdgR
 qowou4FCEhKHm7kVfe6cONhxuBy2TWqO4Tc0AHMPrDjvIwBxd2f+orHufrm3JMxFqSVm
 qXg1vc4zkFF1YlahQLm4js5XXjR5sE1zDZvWPBs8HiBbJpyWV365WWeLBQpTdMCkbRA7
 5+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WQ/czQxQGLcgdCZRtqh/qd37OiFdMr4lYxa9jTrDLXM=;
 b=eUcjrQPeH9AH5oR7POGwQhf4nQnBG3FSmcZ+XVRzTOvlv21dSaaWJUdCc7soNN/rMz
 zowVKA/hHyO/V0Zdr1or2pKKCZ9zUWJCgmHP5knDusIl4qcUo3zPUxIdQLZ5ltfx1MYB
 xK77LQ1OB7QUXxxzI0l9HOxW6fRDGrGhy2qwy68Y8ZgAl0vdeZ+5up2u+0pVNGw8qtBZ
 /KPi3lSk6hHGeibeawVMd5et63OrkKOZsubEaQJnQLvIuuiNQL0gYfeifIRQVZrcgdyb
 i3vrN5eZs/5B5B4pFKcCYuKmYPF/QMxcK/nahpIZ4SNoK/CBP2O3a5Nkrg1bzmPBNPSw
 /gyw==
X-Gm-Message-State: AOAM531ywo+yofjYcClobSy/FoIwMwPjy3rWh+BOuPjj8k4HcPgWK90H
 at+getmfggxUPdpbrnV+66lF2g==
X-Google-Smtp-Source: ABdhPJzRPX98rxSrVAjWff11i/wB+FrE1tdpVuoHYdgT+GVG8vMQ1r8pppK1A3XLmt0i/wuduJOv1A==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr2462024wru.243.1601638612881; 
 Fri, 02 Oct 2020 04:36:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c4sm1418184wme.27.2020.10.02.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 36BC11FF8F;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/14] travis.yml: Update Travis to use Bionic and Focal
 instead of Xenial
Date: Fri,  2 Oct 2020 12:36:34 +0100
Message-Id: <20201002113645.17693-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200918103430.297167-6-thuth@redhat.com>
Message-Id: <20200925154027.12672-7-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index b2d492f8c6..65b825ff64 100644
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
@@ -210,8 +210,10 @@ jobs:
 
     # gprof/gcov are GCC features
     - name: "GCC gprof/gcov"
+      dist: bionic
       env:
-        - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--enable-gprof --enable-gcov --disable-libssh
+                  --target-list=${MAIN_SOFTMMU_TARGETS}"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
@@ -270,6 +272,7 @@ jobs:
 
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
+      dist: bionic
       addons:
         apt:
           update: true
@@ -285,7 +288,7 @@ jobs:
             - libattr1-dev
             - libbrlapi-dev
             - libcap-ng-dev
-            - libgnutls-dev
+            - libgnutls28-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
@@ -293,14 +296,13 @@ jobs:
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
@@ -310,11 +312,11 @@ jobs:
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
@@ -356,7 +358,7 @@ jobs:
 
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -389,7 +391,7 @@ jobs:
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
-- 
2.20.1


