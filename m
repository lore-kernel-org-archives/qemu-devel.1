Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F50C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B2120721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zj7MLoFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXpR-0000Iv-9m
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjv-00078g-7j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXju-0001Iw-3A
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjt-0001IY-SR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so16880423wrx.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6SLyQx9usOP5EhubjT0CndDwEL+rYnuFBfAW77fKcPw=;
 b=Zj7MLoFqx+A7KSmxiSvQZ8RnGS+vgzBLEHv70ZpoxxjtWMVUfaAgZChu5B2X2H+Z6H
 tpVXcbwOMQ+CKCBUjwoxvw/1QAAci6c6/cI/zt0LNsorAFDhlTEdpLFtr+HW8khRke89
 mkmoTlG6aGSKvmOP4Nce8NfjWabMY2AkQ1LDxz8V7dgdIcdyKqJ+vxn3Q25pu2yaPJ/S
 gHLhXeegteOK7pHbx7CJ1pTvvJbusUpoBQA6SVxz29bQueLk3ubVYUWyhYLYLsC4FJj+
 9rDWpCsnvl2XnNnXxFsDkQWfMEXaZ/SgQZxJl8rxZCosNqf6Bun4sCznx4mwfaSlg1XN
 Gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6SLyQx9usOP5EhubjT0CndDwEL+rYnuFBfAW77fKcPw=;
 b=GlEyYETF+jK/rGQEWxfgtHgM0F+MRY21B08sZscBfvw39Jf6nxWz2pvDG5TcW9f3by
 KAOQ4sIrZjftMMy+5xP+d8D89983zBqxdFz25Wt29JQd7Uz0XP3ahbAogp2j9eBZ1vv7
 lypCFd9qms9B0sKXHSrwAC2dYtC4CuMrvYJqEmmzOps8esiC/gpA6pe57t3N40Kbe8lv
 XMPH02ltnryGruwQDvmCKL/7PdvmhvrMGtLgsrFSuQKzoz0Ph2Ih9vLzy4qbWL3+SY1o
 qpQxgjLnF3CM3/tyf7SnAlXCagpf8FQ6UoLwWiBREKxDPwz1pMWbZOYg7KtMVpyn6VN2
 nkuw==
X-Gm-Message-State: APjAAAWJ4TrpilEezpIlUlLqrS8SVTsMc5pDT1sp3vDe1auFotCBrn5Y
 wxF1gEI+NXlHbUrxWaG2uRA21A==
X-Google-Smtp-Source: APXvYqwVqvlfc51v2g4rkHZHqsTw7mqwsaBb+eeznzJpCxqP9LBEumpZR7gwmDrZdyUuut5ejGboVg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr13893855wrv.79.1580720992972; 
 Mon, 03 Feb 2020 01:09:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v17sm24054500wrt.91.2020.02.03.01.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:48 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 95DFA1FF9E;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/17] .travis.yml: introduce TEST_BUILD_CMD and use it for
 check-tcg
Date: Mon,  3 Feb 2020 09:09:29 +0000
Message-Id: <20200203090932.19147-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least for check-tcg we can split the build phase from the test
phase and do the former in parallel. While we are at it drop the V=1
for the check-tcg part as it just generates a lot more noise in the
logs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

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


