Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF7E20449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amIRhnI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF7E20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cm9-0006gu-LB
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3x-00010S-Ul
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3w-0003XL-FT
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3w-0003WM-6s
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id l11so211423wrx.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=flNVhetGQgd7j0XEOCGx7V7AorwZWyuhXeU2KeK5ZEg=;
 b=amIRhnI2FfpeBQ8r+Uz0vUhMYEtdn7Xsom2QPdK7CduuI1bD61ydq/8orKDC+PAHTM
 mbdetLztfpjcsU4opgBI5JYxvSXckllp0Q96568PZdKNsqpjT3+98b6Pwkm+I5t0ppDr
 RVGXygoHrxL+muXmpybNORrB6xs+F1fZDjuqBqk1QmcBYxtUPZNikNtVJWo1UVaUTDra
 b4sBVzCaV05V8OxkAwgSaRsvG3AT9Ibee4bVEiboN1rp3tm1yGBh+iDX+PoERuGvgDRB
 MhCzi/a6FMiDDToNZhvdALb7GHRhLKWoWlC9VOALNfWJpO6wHJ/CcIT5WBKoBu5nBtX1
 G0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=flNVhetGQgd7j0XEOCGx7V7AorwZWyuhXeU2KeK5ZEg=;
 b=uUUZTwk+8QO9MboWhpz2DyNgSaof/DT9kZI95oEof2sYg6tMtYW0MkTE7yg2x/WYpe
 a8qKa4z9qlgZvjAgMFvXapIqiNvHBhq/eKeblBKGXFmDp6f7ivUUjdnlZu9X1W7uEsag
 Y2Y0T3s7lpooQdHeeVlCZEh6cTAVGmAHNcWs2vbww5dhCR8fZPdAt7k8UgSKZz/Lklil
 xiVypQwhE8fk33wem6HdYdfZx8T3xQmNIYs3yCHsgD9Dtw+cD4QvlkJ8zCtHHGn/wd53
 t4eZTuSlMKmjKfSGga/5HEhqv91M1Cio2JOJ8PONO3vPtfNP7d84oTactd34hqzIhsjN
 gRoQ==
X-Gm-Message-State: APjAAAUZ1EVcS8ixNw45FzwZAY8IZYJD0pxXphz4BaFH7Ev4FPTsZyxL
 o2EpTu/S6oCqNo2ZyRy2LougeA==
X-Google-Smtp-Source: APXvYqzFhnNr4e6bdjjC3POXilBeHOOwqCWWa7aWtC6L3NYbEYjmDwfZJww20+NEQ4yJgsxbjXE3qQ==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr24116642wru.51.1567629571061; 
 Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o14sm57146701wrg.64.2019.09.04.13.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D377A1FFBE;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:09 +0100
Message-Id: <20190904203013.9028-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PATCH v1 38/42] .travis.yml: Cache Linux/GCC
 'non-debug profile' jobs together
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These jobs build different components but use the same
host features. Put them in the same cache bucket.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index ab4ee425e4f..63cbf41e573 100644
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
@@ -312,8 +322,11 @@ matrix:
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


