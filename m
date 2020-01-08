Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A998C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 22:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE8C2053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 22:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYDgFLID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE8C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipKAD-0003OB-Tv
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 17:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipK9N-0002eg-GA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipK9L-00067Q-JW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:50:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipK9L-00065W-BD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:50:03 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so5168776wrl.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 14:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=juWdlFfCQgG7NNhvtKKXUAUEZcw1xkA/MgzcDE7RTAk=;
 b=HYDgFLIDUDXKgOP07UDaydZIbNTBp6QgOJOSYg75Er5ZkkVO5AaRKPfSNTGVLfAGVt
 M3DTLE7OOxrjfaaXWMH/p/7Vc/bKKCBoQdi0ZzFxbFg6xtBZ4XYCmIhi97g6n0Y4fK+O
 PUrjvq165UwomTUZdf7fUax8BW9ItjaYR7ptvHld5DJ5RlmVLvCJGs6Zax0TtGm4vGst
 lRH+WkaPr4UGMVeyRAccz+xkA5In5YESyjoFCr0c4443/tepj0vZ9SNt623InEnPUST9
 KOBFS+yPqrziJOxRoDZnl07GjRQm3Ryi3rXT2FRpcWlth+30jMtuiEJ6jswpNjj/EhLn
 IPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=juWdlFfCQgG7NNhvtKKXUAUEZcw1xkA/MgzcDE7RTAk=;
 b=RhsHOPTaKs+U8MlrcsOBzywBWkCa889LCKxVWinSjfRW43YdjXy8JREoLEXSDL60jn
 eUK/v+pPCRQqQm0R1hZv7QwA7cHdpE9H1vmzzpB9ubgOTGmS/itBYVPF3iqTZ3RI6k10
 /6OHYXRjb0Qdms+Laxfw5ZVXXhWtI+Ajq/z3LFsoMzd6+F0ManPhL6Iv94No0Mc6BSO5
 yxAPTtQ+g0iDEHv0nspI6qfLA4bTH4MjUB1GWodEEEiduHrN52J2SryD7439TfHv1QTZ
 qQeCJsLAbJNBgKd0qisx5PlmrsnZRiuxSrH2y97XRQ9EIPvV9yxQ4U/apathW1WscFdN
 oePQ==
X-Gm-Message-State: APjAAAVrGuWg1zxaTHOZkk/W2w7YmPfPPPTIHmu1hkKH5QmxQA8AQCz1
 u/Q9HAGSPBDL59rTvxaqHwv6Yw==
X-Google-Smtp-Source: APXvYqzdt3NnHuoXWGxwimKwDbVTrAdM3YC/vyFyvDxCkoCY4/sjG0sajdokPlyvBbRdlrl0DGaBEw==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr7218190wrs.184.1578523801559; 
 Wed, 08 Jan 2020 14:50:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z21sm654697wml.5.2020.01.08.14.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 14:50:00 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CA3A1FF87;
 Wed,  8 Jan 2020 22:49:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] travis.yml: split into build stages
Date: Wed,  8 Jan 2020 22:49:52 +0000
Message-Id: <20200108224952.17988-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The idea of this is split the build across stages so any failure in
one stage will save time running later stages. So far I have have
arbitrarily chosen:

  canary: up-front quick to build and run
  platforms: common build configurations
  rest: everything else

The ideal should be canary and platforms catch the most common and
frequent build breakages and the "rest" aims for completeness.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1a..648c523ce59 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -17,8 +17,12 @@ cache:
   pip: true
   directories:
   - $HOME/avocado/data/cache
+stages:
+  - canary
+  - platforms
+  - rest
 
-
+  
 addons:
   apt:
     packages:
@@ -97,17 +101,20 @@ matrix:
     - env:
         - CONFIG="--disable-system --static"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: canary
 
 
     # we split the system builds as it takes a while to build them all
     - env:
         - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: canary
 
 
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: canary
 
 
     # Just build tools and run minimal unit and softfloat checks
@@ -116,28 +123,33 @@ matrix:
         - CONFIG="--disable-user --disable-system"
         - TEST_CMD="make check-unit check-softfloat -j3"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: canary
 
 
     # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - env:
         - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
+      stage: rest
 
 
     # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
+      stage: rest
 
-
+      
     - env:
         - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-libusb --disable-replication --target-list=${MAIN_SOFTMMU_TARGETS}"
+      stage: rest
 
 
     # Module builds are mostly of interest to major distros
     - env:
         - CONFIG="--enable-modules --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: rest
 
 
     # Alternate coroutines implementations are only really of interest to KVM users
@@ -145,11 +157,13 @@ matrix:
     - env:
         - CONFIG="--with-coroutine=ucontext --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
+      stage: rest
 
 
     - env:
         - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
+      stage: rest
 
 
     # Check we can build docs and tools (out of tree)
@@ -158,6 +172,7 @@ matrix:
         - BASE_CONFIG="--enable-tools --enable-docs"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      stage: rest
       addons:
         apt:
           packages:
@@ -171,11 +186,13 @@ matrix:
         - CONFIG="--disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
+      stage: platforms
 
 
     - env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
+      stage: platforms
       compiler: clang
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
@@ -185,12 +202,14 @@ matrix:
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
+      stage: platforms
       compiler: clang
 
 
     # gprof/gcov are GCC features
     - env:
         - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
+      stage: rest
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
@@ -200,6 +219,7 @@ matrix:
         - CONFIG="--without-default-devices --disable-user"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
         - TEST_CMD=""
+      stage: rest
 
 
     # Check the TCG interpreter (TCI)
@@ -207,22 +227,26 @@ matrix:
         - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
             --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
         - TEST_CMD="make check-qtest check-tcg V=1"
+      stage: rest
 
 
     # We don't need to exercise every backend with every front-end
     - env:
         - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
         - TEST_CMD=""
+      stage: rest
 
 
     - env:
         - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
         - TEST_CMD=""
+      stage: rest
 
 
     - env:
         - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
         - TEST_CMD=""
+      stage: rest
 
 
     # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
@@ -232,6 +256,7 @@ matrix:
       os: osx
       osx_image: xcode10.3
       compiler: clang
+      stage: platforms
       addons:
         homebrew:
           packages:
@@ -256,6 +281,7 @@ matrix:
       language: python
       python:
         - "3.5"
+      stage: platforms
 
 
     - env:
@@ -264,6 +290,7 @@ matrix:
       language: python
       python:
         - "3.6"
+      stage: platforms
 
 
     # Acceptance (Functional) tests
@@ -272,6 +299,7 @@ matrix:
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
+      stage: rest
       addons:
         apt:
           packages:
@@ -321,6 +349,7 @@ matrix:
             - uuid-dev
       language: generic
       compiler: none
+      stage: platforms
       env:
         - COMPILER_NAME=gcc CXX=g++-9 CC=gcc-9
         - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
@@ -343,6 +372,7 @@ matrix:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
+      stage: rest
 
 
     # Run check-tcg against softmmu targets
@@ -383,6 +413,7 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+      stage: platforms
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
@@ -412,6 +443,7 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+      stage: platforms
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
@@ -441,6 +473,7 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+      stage: platforms
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
-- 
2.20.1


