Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BBB207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWxqrGXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BBB207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josup-0003tK-L1
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrm-0007Un-UT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrg-0001JL-DZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id 22so9650459wmg.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BoQbWA8pgX9GC2xijlmIAV/4o0rgmcM2g2psEePuq2U=;
 b=hWxqrGXsz36qzwCeXVhSjT+83pk8BWctvg22Wv2Emy+il1Fhtc7ZMaon6uHozo+7Mx
 1De2xyZYtfWafr6gZz+zl2eS2TvvKuTqh+ZfDJFnit16t4wMHKjvub2vtIhiIVIZoSP2
 UJ/qK1/1hjlMxbCLEKm//kdBqsb67S4MTmS6kvvEkBI3Plu806emuZjxIr4zaSPCeXLE
 2G0A9mFmbc1Vtcdz38SzzvlDAKvzS1TQrwJudokkN1NzKx5cP19FKiOYorrexPNN7ETW
 hkmYImsvQomjDZICZDKgpMEj8WzV8FiTwVG7sHlMPkRCQXU1J0FXRogyS8dN+WKc2exu
 nMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BoQbWA8pgX9GC2xijlmIAV/4o0rgmcM2g2psEePuq2U=;
 b=FfnAT2WcsZkjV5fGlsnP1chrgvwkVHS9DpFX0KX7znffpG5fj2uHz3LHn2N7NyIZDg
 +y6g+VyC6uKcS5zAAiOMGTNMJ5YVAmmC0/O0Ee1OfGfkA5Wl3GfFad6fZ3yvtU1rFe+G
 EON8vX0OdzXel5VsxbCv/hTyUcM1QpT7Oa3BfVT0Xlf6zDy2MUzuXS9doKzRtqkSd9lh
 KOmsw0UyVutub+QhRk2X2FTiC6hjeUn94xM9g0G+QjIhChfbrJ+tibf0TtSio42AfkMk
 uFwrFMIaWw1sjg4bm2L1n9lAq2auL56bT18pNT2h54o0j0EJVDbgPrO8KiXpm/H6AmKT
 738Q==
X-Gm-Message-State: AOAM532XWIcQGgjv+wfsGzfQXH5iSQOfrWV+/N66qoZBBcaTa+YhdBsz
 HHs205OqXpmgPQgpxu/nXCy1cg==
X-Google-Smtp-Source: ABdhPJxlKMLSvZR+MYg4gZ1LgSuaFbLj3SIQIT9vnqW+sVPQqu2GRaig6z0CWBuDI4F6txb1hMIo7g==
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr4495615wmf.57.1593195254714; 
 Fri, 26 Jun 2020 11:14:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t205sm18307821wmt.8.2020.06.26.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:14:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B62821FF9F;
 Fri, 26 Jun 2020 19:14:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/30] gitlab: introduce explicit "container" and "build"
 stages
Date: Fri, 26 Jun 2020 19:13:45 +0100
Message-Id: <20200626181357.26211-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Laszlo Ersek <lersek@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

If no stage is listed, jobs get put in an implicit "test" stage.
Some jobs which create container images to be used by later stages
are currently listed as in a "build" stages.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200622153318.751107-2-berrange@redhat.com>
---
 .gitlab-ci.d/edk2.yml    |  3 ++-
 .gitlab-ci.d/opensbi.yml |  3 ++-
 .gitlab-ci.yml           | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index a9990b71475..e1e04524166 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -1,5 +1,5 @@
 docker-edk2:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci.d/edk2.yml
@@ -24,6 +24,7 @@ docker-edk2:
  - docker push $IMAGE_TAG
 
 build-edk2:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/edk2/ is modified (submodule updated)
    - roms/edk2/*
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 6a1750784ac..62088ec5ec1 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -1,5 +1,5 @@
 docker-opensbi:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci.d/opensbi.yml
@@ -24,6 +24,7 @@ docker-opensbi:
  - docker push $IMAGE_TAG
 
 build-opensbi:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/opensbi/ is modified (submodule updated)
    - roms/opensbi/*
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa580..9fdc752ea63 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,7 @@
+stages:
+  - containers
+  - build
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
@@ -17,6 +21,7 @@ include:
   - JOBS=$(expr $(nproc) + 1)
 
 build-system1:
+ stage: build
  image: ubuntu:19.10
  <<: *before_script_apt
  script:
@@ -31,6 +36,7 @@ build-system1:
  - make -j"$JOBS" check
 
 build-system2:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -46,6 +52,7 @@ build-system2:
  - make -j"$JOBS" check
 
 build-disabled:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -62,6 +69,7 @@ build-disabled:
  - make -j"$JOBS" check-qtest SPEED=slow
 
 build-tcg-disabled:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
@@ -82,6 +90,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
+ stage: build
  <<: *before_script_apt
  script:
  - mkdir build
@@ -92,6 +101,7 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -106,6 +116,7 @@ build-clang:
  - make -j"$JOBS" check
 
 build-tci:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
-- 
2.20.1


