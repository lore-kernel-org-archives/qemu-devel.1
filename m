Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A907C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E542076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B68PIvhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E542076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfPZ-0000Cz-Hf
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIn-0001O4-Sa
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIn-0005dU-47
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIm-0005bm-M2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id e26so7201991wmk.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dbl7vz/2JDzRYFnfm6XKsckDvoap7FMNqmtKMQ9jX5c=;
 b=B68PIvhBuzDpuVi5b+BMq2qJcbrpy6e4xqEXDQJaax7k7sNBDQsfGbcdSpOmEAgao/
 AMfOdaRFRyXmB0ox7BC/CCA1irRIhWFdCoUdBosO8jp2dA7XQPq5kFvWc8SlkBThwwsf
 +Ar1AlSmciDlTjPM3Dpyl6UOnYmV8b+QlyDVWOB4Sq/BjPcN5PGW4T8iGEkG5DwGYADQ
 CwLHb/IdS370Iou3j/WIIFPO3d96z9FyFR6obnRu7QUrq118SONEqqDUiVE886743TON
 DF6wSlDjhdb90BpLJhXo+SysiJGi3izd4qtW2ig83synYoofSNMjNWkX+3pzmsmugsP8
 bseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dbl7vz/2JDzRYFnfm6XKsckDvoap7FMNqmtKMQ9jX5c=;
 b=LrkR0PtBVWC45eotHrej/rvGVmTK3pvpWcdIZBx3zTDx6SwYncRR05ZFtK6eKqW9h9
 f7j9KU+u5wedgKpwIuaP1br/C4x0R/aygRIT2piy4lKY3TpE0NdYg8kdDJkkzak0EHRF
 EqQxrig3ngWagpwIK70eDR2FwI2W3smfLsrjKZgK14UJ3r1XdH3icwSI1dBWkxaE4jXv
 eSqXT1WjnjPY9qMy3tVL/0aRUAvLsApqy2ODS2yJKsUmuQbphUlaavRht89KHt8JOTji
 Qdoxoq5RwO1qWFJsr6BREjRyUYmfaCdXUIZ9dUen3MgCJuLIJwyMoX2N7U56SNJ9Vzlo
 tFBw==
X-Gm-Message-State: AGi0PuZYThDRYy5ZdoThMYGVCn7ebTA3ErkUDdYylzfR5wJ3j4q85B2s
 d2N7Md1r1bsFN97xUQiKGlsXHA==
X-Google-Smtp-Source: APiQypLLEwf8gv4qKB0E9rmKIHX6F44e+69r0xk3AfuM6oPKgHC1K1eChDUfDwkqc6iTrrAlbcgieA==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr5238332wme.20.1587661574908; 
 Thu, 23 Apr 2020 10:06:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a67sm4735296wmc.30.2020.04.23.10.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 911391FF9D;
 Thu, 23 Apr 2020 18:05:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 14/14] .travis.yml: drop MacOSX
Date: Thu, 23 Apr 2020 18:05:57 +0100
Message-Id: <20200423170557.31106-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::336
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

This keeps breaking on Travis so lets just fall back to the Cirrus CI
builds which seem to be better maintained. Fix up the comments while
we are doing this as we never had a windows build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a4c3c6c805..49267b73b3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,9 +9,8 @@ compiler:
 cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
-  # - OS name (currently, linux, osx, or windows)
+  # - OS name (currently only linux)
   # - OS distribution (for Linux, xenial, trusty, or precise)
-  # - macOS image name (e.g., xcode7.2)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -271,31 +270,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
-
-    - name: "OSX Xcode 10.3"
-      env:
-        - BASE_CONFIG="--disable-docs --enable-tools"
-        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
-      os: osx
-      osx_image: xcode10.3
-      compiler: clang
-      addons:
-        homebrew:
-          packages:
-            - ccache
-            - glib
-            - pixman
-            - gnu-sed
-            - python
-          update: true
-      before_script:
-        - brew link --overwrite python
-        - export PATH="/usr/local/opt/ccache/libexec:$PATH"
-        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
-
-
     # Python builds
     - name: "GCC Python 3.5 (x86_64-softmmu)"
       env:
-- 
2.20.1


