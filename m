Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87104C3524E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DF72070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTPYY2jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DF72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXrt-0004FS-D1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXju-000768-Ax
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjt-0001IJ-1Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjs-0001FW-Qs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so16826504wrl.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ffTzUEg2gfAFZMr201nr055ZrQ7kseNndMOMdQkKexc=;
 b=fTPYY2jYvWybu0oBI+2wp06FHGLM036Hhzf1H67lbzCKvRPg0XJ8LIFX9XHpyXP8m6
 abB4+y4vXXyY9iLDH3pQ/dy9aDl7FOgyrXjfUUxLUC4cYfEsfQYF4R039p8Wcd0NKCMd
 nKsGC6Ud7FosuwSTJzyIzSAl8dipi+ofvFWDnusEexWhIbPme1/w5d6YrQ2v3nMoPyKH
 Y6w3Sn9fVrD24BA5NQ9bw/ZMLpHhnc6bqzSNWxRuKrnnU/mxcjx/5kKVyPzjmYcvUtsf
 UZggkmw8SNvqMqhnFQiZ3sSsKQDNCsMHJyZElhSHE9sYzas9QEBNQR4sEaCyu+IRaxuW
 EwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffTzUEg2gfAFZMr201nr055ZrQ7kseNndMOMdQkKexc=;
 b=negMwah7RTrsFcsFv7/fUYDDEiAx/NuvZ/OJ4aawqgpfF9tmU8Ir+vhqk0fi3wY1F1
 mLk01apalLDcFjXgVkxulCtf+TbMJUvG8vslwzSRHzNP8AKr0xclFRgM5szMGwhsQ6kI
 rNj1riSDByA8+VYH0YM4sYJOWUuE/FAJaJzfMvE1iFAnbls1ain28E1T1BEg0nm/pZzl
 5iYSFH8ouinx9rt/G7INm5v10tG+REfQ3BUxOdFZvaculWnMv3Oh86hRE5KVDkQhI8sf
 f3EmJDIAAJwsflp1uj4Ph+0X9QTP1bUTkYnj91Xhra2DjUiK9Y0Wwh/a4OUOmliGFyZ4
 ST4w==
X-Gm-Message-State: APjAAAUmFdH7vshNo2GxlbKWj3+jm8L8OZgypaauc5DZgfuGA/TTIMiy
 iOwviFSLsYQHfuYpCsevf4LEPg==
X-Google-Smtp-Source: APXvYqyigEzgjajbsrLCdNdk9/2mAXn2JPr/CrgIjnKdfgzMmljjyaSX1+5xo9dX+6+059Gv8F6WIQ==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr12145393wro.423.1580720991794; 
 Mon, 03 Feb 2020 01:09:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm23216542wmj.23.2020.02.03.01.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 50F1F1FF9B;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/17] .travis.yml: probe for number of available processors
Date: Mon,  3 Feb 2020 09:09:26 +0000
Message-Id: <20200203090932.19147-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The arm64 hardware was especially hit by only building on 3 of the 32
available cores. Introduce a JOBS environment variable which we use
for all parallel builds. We still run the main checks single threaded
though so to make it easier to spot hangs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1b92f40eab2..a600f508b0a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -85,6 +85,8 @@ git:
 # Common first phase for all steps
 before_install:
   - if command -v ccache ; then ccache --zero-stats ; fi
+  - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
+  - echo "=== Using ${JOBS} simultaneous jobs ==="
 
 # Configure step - may be overridden
 before_script:
@@ -93,7 +95,7 @@ before_script:
 
 # Main build & test - rarely overridden - controlled by TEST_CMD
 script:
-  - BUILD_RC=0 && make -j3 || BUILD_RC=$?
+  - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
   - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
@@ -125,7 +127,7 @@ matrix:
       env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
-        - TEST_CMD="make check-unit check-softfloat -j3"
+        - TEST_CMD="make check-unit check-softfloat -j${JOBS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
@@ -160,13 +162,13 @@ matrix:
     - name: "check-unit coroutine=ucontext"
       env:
         - CONFIG="--with-coroutine=ucontext --disable-tcg"
-        - TEST_CMD="make check-unit -j3 V=1"
+        - TEST_CMD="make check-unit -j${JOBS} V=1"
 
 
     - name: "check-unit coroutine=sigaltstack"
       env:
         - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
-        - TEST_CMD="make check-unit -j3 V=1"
+        - TEST_CMD="make check-unit -j${JOBS} V=1"
 
 
     # Check we can build docs and tools (out of tree)
@@ -366,7 +368,7 @@ matrix:
     - name: "GCC check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -375,7 +377,7 @@ matrix:
     - name: "GCC plugins check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -383,7 +385,7 @@ matrix:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -391,7 +393,7 @@ matrix:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
     - name: "[aarch64] GCC check-tcg"
@@ -500,7 +502,7 @@ matrix:
         - BUILD_DIR="release/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--prefix=$PWD/dist"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-softmmu,armeb-linux-user,ppc-linux-user"
-        - TEST_CMD="make install -j3"
+        - TEST_CMD="make install -j${JOBS}"
         - QEMU_VERSION="${TRAVIS_TAG:1}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       script:
-- 
2.20.1


