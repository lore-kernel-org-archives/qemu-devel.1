Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DBC2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVvQBoX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DBC2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfhx-0006EB-Im
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNfdA-00069S-RR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNfd9-0002Yl-Bo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:06:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNfd9-0002YP-4k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:06:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id q13so21750759wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMlvgodQ6Jkp63ZYQQNtCc0oq2SvqraFWnbtUZjuzhc=;
 b=VVvQBoX2WKhAyHjdKpTclcdH4PVICQHTDrqq+87XTVh1V1W9NtbtKlph3omACrs/rg
 lnTZZyPPbsWicZ6GiXXhwAaJ8EFNBb6jkkrJqPkgRu5ubuyyPi7qkY6n2wdKVS9Aotri
 RyzYgMRZohxjM89th+UjrtRggAVkWvVCybk1G6az35ZH/SIB7FENj3ToJlYl2zdhDLjB
 JW0eXY39XVVperxWsgQhMhEQT8kPLhdcKpYQL8eVNE3QB225c9AhxkCxPaGitDn8x2ub
 ztBOFs7+2l9DgxC0ZGCavGZcdfDypwyaJWeNV9YhpaaFRyG5+TKi+1nu2DtbWPElpzX3
 TrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMlvgodQ6Jkp63ZYQQNtCc0oq2SvqraFWnbtUZjuzhc=;
 b=hJF99ngHtiFIXPtO13xl8sf5g/qTzhguLO8uJPH/BL7JTgjMk99Il8DBnFE4qwn0hl
 fUNSo0AflrVTDwOc9kUDqDosYi/kiHe0z/2ogAvqYvPJbSALuLnM5vPdzzKVZsk0OkN/
 saNQnwK0craieq90MX2PZh8befc8Ns9tavYk3I6sEVmENere73XsqYawgEseyuzSyvb3
 6XVOLvNgsKv/R3CvIeIx/m2Fclb9wE0tDGktpUVsVq/Y+xsJMV1LID2H2o4xULzZkxgm
 JiGT42HWvt0iMG85TuSlWoqNcbyshOt5AB38rt/m7e7prwUgRbiCKenL50nEKgdjqMhC
 wOrA==
X-Gm-Message-State: APjAAAWz6g4yThPbcfHaD30+c9o8IM9CduMCa6oNHG/fAs87Cnu7CYOp
 duoD9L7hNTGlgNUhDvJ2IXKSUA==
X-Google-Smtp-Source: APXvYqwEVpWkPlTXXwPDDshzxieu2/r98ye8bf0EdrqX0Gh52Xi0xPSUapQTlfI6V2/1CU9iUBbDzw==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr4386992wrp.172.1571933189014; 
 Thu, 24 Oct 2019 09:06:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm27420032wrf.73.2019.10.24.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:06:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D31F1FF87;
 Thu, 24 Oct 2019 17:06:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] travis.yml: enable linux-gcc-debug-tcg cache
Date: Thu, 24 Oct 2019 17:06:19 +0100
Message-Id: <20191024160619.14179-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a new cache for the --enable-debug-tcg builds which is separate
from the normal debug builds which generate different code. We also
enable debug-tcg for the new plugins based builds as we want to ensure
any breakage to TCG is picked up by the sanity checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

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


