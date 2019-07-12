Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E5BC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D7920863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqlQGiQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D7920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltaN-0002Jd-Rl
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZo-0000H6-BQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZm-0000LJ-UZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZm-0000KO-MB
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id y4so9595620wrm.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S6vlCzd8bs8oUu9Zqj4pZDk3kYEbnE2MFo03V6K4g9k=;
 b=NqlQGiQ3liFYjXGiUFdSU2ZXvLkRXo1Mf5q3R45PAnbXkCRx9NpKVKyQOzv8bMqvB8
 y5MT/UAvtUwThWaUrWiDFa4Q1mYtdhIlZhA192VYfj70Ta23EQ3DiL+QqOLSrJYM7nYI
 J85pXEXH39wxfpLlZD4TwPT+NB31NiJ3YPVn+0/hN5ywkgQsdV03rvbhYZv1ovCC1I69
 lm7dEMz5YXUkQEV6FUi5cxgerI7KZ9H0CNcRf67uFMlGH90VvzyupaUawu8Q0UbF9jvA
 FjVzQ+slpuYXN5P/FYLEBWxq+0x7e1GW1HalOLdklnohfTGXMSNMZ2GgjbkdajdNoxTo
 IzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S6vlCzd8bs8oUu9Zqj4pZDk3kYEbnE2MFo03V6K4g9k=;
 b=ddwro6PFNRBuGbLueHZqxKyZAk5I7R5OTHQCoJ31NzaIg9w41nLtNvgIvQtz/aETsw
 F8lBBzhZilM55292BrGKIWmfgaoeD4PhWcbNYR8tWZe1aRrJXPONQ1dUocMPqfeP3u/o
 VFF1uMdjHkQRVVmYCHEa7DyzCw5zJAXpPfp19kElQEmFIy8oY9JjEyaayF+v5SBSE+Of
 hDdtgU3D4QvBFLtCG6NGcPhi5F28xqXheJJUy+jJUgqVu74Vl3aJf2Cc+ljG8thoCN6c
 9llJdnzwBRVPPGhh2GPBQEg8W+NikzHoJYT7LS8Li2LEeMbh8/JMcnPtYWhx+eqICAY3
 SOzg==
X-Gm-Message-State: APjAAAVEreNhMyj/MN4Ib2D2T22kGpNiX52uEqT12kgH/v/kXwmCyZfm
 ALkxqiKy09lOV9SV82VtxCoYmw==
X-Google-Smtp-Source: APXvYqxkbsSDECkBhJd40mHHADZ8d8aqPYyuf1t+jbOzIS1dI6+dgBLSDMFxDbsGj6C48MFy3yjcaA==
X-Received: by 2002:adf:f186:: with SMTP id h6mr11095370wro.274.1562930333444; 
 Fri, 12 Jul 2019 04:18:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o6sm13811824wra.27.2019.07.12.04.18.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D7A61FF91;
 Fri, 12 Jul 2019 12:18:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:46 +0100
Message-Id: <20190712111849.9006-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH v1 4/7] tests/docker: Install Ubuntu images
 noninteractively
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We correctly use the DEBIAN_FRONTEND environment variable on
the Debian images, but forgot the Ubuntu ones are based on it.

Since building docker images is not interactive, we need to
inform the APT tools about it using the DEBIAN_FRONTEND
environment variable (we already use it on our Debian images).

This fixes:

  $ make docker-image-ubuntu V=1
  [...]
  Setting up tzdata (2019b-0ubuntu0.19.04) ...
  debconf: unable to initialize frontend: Dialog
  debconf: (TERM is not set, so the dialog frontend is not usable.)
  debconf: falling back to frontend: Readline
  Configuring tzdata
  ------------------

  Please select the geographic area in which you live. Subsequent configuration
  questions will narrow this down by presenting a list of cities, representing
  the time zones in which they are located.

    1. Africa      4. Australia  7. Atlantic  10. Pacific  13. Etc
    2. America     5. Arctic     8. Europe    11. SystemV
    3. Antarctica  6. Asia       9. Indian    12. US
  Geographic area: 12
  [HANG]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190711124805.26476-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/ubuntu.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 2500ec84b6f..a4f601395c8 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -66,6 +66,6 @@ ENV PACKAGES flex bison \
     texinfo \
     xfslibs-dev
 RUN apt-get update && \
-    apt-get -y install $PACKAGES
+    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 0bb8088658d..44bbf0f77ae 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -53,6 +53,6 @@ ENV PACKAGES flex bison \
     texinfo \
     xfslibs-dev
 RUN apt-get update && \
-    apt-get -y install $PACKAGES
+    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
-- 
2.20.1


