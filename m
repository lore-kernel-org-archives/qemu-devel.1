Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3558DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0402E2467C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBatA27F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0402E2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDCc-0000tE-0y
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9Z-0005vo-F7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9X-00085P-Uc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuD9X-00084i-O7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so6669682wrr.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zIaWGD0nhATksvssU385Tb+Vkuh573SQJiN/xNTgN2Q=;
 b=pBatA27F/hZbPGOXW/JZYwMc15N5EMht6n22Jy3a8sw1i/3MzD2yCxQGF6USvmr4qM
 AsSioPYo/bQtunx4Tu/7EXmPnHuZ5UhM1w7PAVLySFY4PswSCmsVl+67lci6j9cXyPdn
 ouFu2cK/5OENrqMMFWXiAFmiXEfYajikCgUv/ME2ub/lwPerCC0//WJ60Kis5Dmgr9U3
 TnK1RFQcdA0IJHjx/LXtPsU9MkGtia7lDkdQh1BtKfSWSuJQ4eTITvUDJ53dIUL6FiMA
 C6s8yXw6HgmIp7cAp4dF1eJEnOgMYp/pv4tYfGehHj0oAZ6VPXoNrv+X33CZs59kkgeX
 8Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zIaWGD0nhATksvssU385Tb+Vkuh573SQJiN/xNTgN2Q=;
 b=HhElOvaPzp0e77sZinwBGOnH7C8a8QURCYi3+41QKkievaZ5OtI1qEYOTItAgNxvGD
 rxxmeirsue00s8CU/XAvXSE0jWDXIIkwuz3FIeItAGe4fI6hNWx7TvC4me1XVjM6RTqL
 aZir5e1PeLfdrPbp9fu0aX/GYWRqJJU3S01La18/TNtVORY3cXzunZMnRCUq/dEphenB
 Jvdn6p9LKkkDs3WATwXWXMz4fBQjtifFxEKZhLjAo/hhCpCZ7QoKI0Tae98qE5+TaTqk
 BYIMLEw6WA58tfQ8MX5/Uc8ejyKUtVek60uv2JlvQwX7usqmsMO2ta/cze2LINAd2HuJ
 0CrA==
X-Gm-Message-State: APjAAAXHsaeiwDCAYu+OH+LA5EGG9XmcTG9mty2I8j7ge6H0ENbwlgNa
 AEoPVHdJpTQKqKKzMoFUNKl5QYsRkXA=
X-Google-Smtp-Source: APXvYqyJ3kas9Gnq6JDJMZEU+JC/iHCs99UaIPnA66A+3ItG88BP1QuSLdHJd29fyAYpOBnXgQFtmA==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr10365142wrq.314.1579688546508; 
 Wed, 22 Jan 2020 02:22:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm3351763wmc.27.2020.01.22.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:22:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9C681FF8C;
 Wed, 22 Jan 2020 10:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] tests/docker: move most cross compilers to buster base
Date: Wed, 22 Jan 2020 10:22:21 +0000
Message-Id: <20200122102223.20036-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122102223.20036-1-alex.bennee@linaro.org>
References: <20200122102223.20036-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This includes fixing up the dependencies (Which were already wrong for
one of the mips variants).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                    | 16 ++++++++--------
 tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
 .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
 .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
 .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
 .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
 .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 19dbe26169..43a8678688 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -91,19 +91,12 @@ endif
 # Enforce dependencies for composite images
 docker-image-debian9-mxe: docker-image-debian9
 ifeq ($(HOST_ARCH),x86_64)
-docker-image-debian-amd64: docker-image-debian9
+docker-image-debian-amd64: docker-image-debian10
 DOCKER_PARTIAL_IMAGES += debian-amd64-cross
 else
 docker-image-debian-amd64-cross: docker-image-debian10
 DOCKER_PARTIAL_IMAGES += debian-amd64
 endif
-docker-image-debian-armel-cross: docker-image-debian9
-docker-image-debian-armhf-cross: docker-image-debian9
-docker-image-debian-mips-cross: docker-image-debian9
-docker-image-debian-mipsel-cross: docker-image-debian9
-docker-image-debian-mips64el-cross: docker-image-debian9
-docker-image-debian-ppc64el-cross: docker-image-debian9
-docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
@@ -118,12 +111,19 @@ endif
 
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
+docker-image-debian-armel-cross: docker-image-debian10
+docker-image-debian-armhf-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
+docker-image-debian-mips-cross: docker-image-debian10
 docker-image-debian-mips64-cross: docker-image-debian10
+docker-image-debian-mips64el-cross: docker-image-debian10
+docker-image-debian-mipsel-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 docker-image-debian-ppc64-cross: docker-image-debian10
+docker-image-debian-ppc64el-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
+docker-image-debian-s390x-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 431e947ebd..3b860af106 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image. Further
 # libraries which are not widely available are installed by hand.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 15378f8ea2..e3794a61c9 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 # Add the foreign architecture we want and install dependencies
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 4a20af6fe1..e163b8b956 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2fca112405..453b53ef72 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image.
 #
 
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4abf7832ac..3b6e975c68 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 9973df9ff7..cd386f01d9 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture ppc64el && \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index eb73c98855..43fe59836f 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the s390x architecture
 RUN dpkg --add-architecture s390x
-- 
2.20.1


