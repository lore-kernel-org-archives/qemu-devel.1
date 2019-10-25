Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3811A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKem9Zhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3811A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuTW-0007Wx-8t
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNuSb-00062d-6H
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNuSa-0007ym-0D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:56:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNuSZ-0007xW-Ax
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:56:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id n7so991228wmc.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8r9gwAqZIg/CQxEo38LJIsJlTEF4FbM9PodERbeO51k=;
 b=eKem9ZhzwZ9ZyGvJROjuVbyUhzv1Yv3eayqG+ldar+nGx6V46PRzqNJATU9bcn1v73
 KLA1vFiWvk4YcTeSxfDlRB91KGyXS3nBYXGqbdhQMudYit2Av2Wrv1O3pizdCBnOgUyY
 WzFeZG97XyzeG/4DZfP+Nz6+wCtU6jLDQxXo9S3OMJU6QmV5XFi2bJA98i5x+wENbAYu
 EKaaaxziZId4EnRRUZAzG2ij6wOwomqARU98qPB53CKlZHEqQ4NBffpc2GDu05tVOgUk
 /HKqemYiUqT5oB7qnL7lMAQ27tjeZeV9mqRgAU5qh7ru9jWoP0JHh5/Q5DT9OTK+AF3w
 b11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8r9gwAqZIg/CQxEo38LJIsJlTEF4FbM9PodERbeO51k=;
 b=EUg2tfcNq5/Q2Y61BGwLLqg3xLYAIju5mUaUTbvCBa+dfpIWi8dx3ggdIkEAiuAGPd
 /Wdow3sLoz4HWNlznvjMNyRVzQ2D1ZX9ytEPTJsvekjGppwH6Ejmpx3o8OEKo25QF5YL
 AzYgplICbmvusdqwVZvGDTWX3qDjWFb4oo9qgr1TpOPkbpbMfAwih3+jz6g0IJypvpoh
 m4++ALWzX3EZHMReL3EVG8Bk4qnqwQOpz3VDZ2kFRxHFK/Dljq49F9GWznRJUIr83MHR
 nozZGal4CYPEjOIz30m+HTsoylG4uI01UicKUJ6/z9vXTuAmMDTimlzgu+O8iDrdju3N
 LTqg==
X-Gm-Message-State: APjAAAViDKvvjxcVUYSRhOmuLIPB+3kGcDsKMOo/t7k/zG6ZPbKJNhOQ
 +ZE14ynAFJz86VvdwwBR4CrrpQ==
X-Google-Smtp-Source: APXvYqxWjTiCOZrAabtnyDur5zIyAep1xjKLrPYz9KQqINa2UwJWsTKsaYUJy01sLLmfQEnFHGG1kw==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2173737wmi.49.1571990193536;
 Fri, 25 Oct 2019 00:56:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm1400839wrt.25.2019.10.25.00.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:56:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 846971FFE2;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 73/73] travis.yml: enable linux-gcc-debug-tcg cache
Date: Fri, 25 Oct 2019 07:37:13 +0100
Message-Id: <20191025063713.23374-74-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

Create a new cache for the --enable-debug-tcg builds which is separate
from the normal debug builds which generate different code. We also
enable debug-tcg for the new plugins based builds as we want to ensure
any breakage to TCG is picked up by the sanity checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index e3f10a93683..34bc8134f5b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -135,7 +135,7 @@ matrix:
     # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     - env:
@@ -336,29 +336,29 @@ matrix:
     - env:
         - CONFIG="--disable-system --enable-debug-tcg"
         - TEST_CMD="make -j3 check-tcg V=1"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
     - env:
-        - CONFIG="--disable-system --enable-plugins --target-list-exclude=sparc64-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
         - TEST_CMD="make -j3 check-tcg V=1"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets
     - env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets (with plugins)
     - env:
-        - CONFIG="--enable-plugins --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Release builds
-- 
2.20.1


