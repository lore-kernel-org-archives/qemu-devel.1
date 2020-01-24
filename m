Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56672C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2607E2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfiN8VK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5nU-0004ZI-9V
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kp-0007wd-6S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kn-0005n4-PN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kl-0005kd-Vv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so3605522wrr.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zIaWGD0nhATksvssU385Tb+Vkuh573SQJiN/xNTgN2Q=;
 b=AfiN8VK28p3D3UsWR9yoySXSUwwz0QOh5IaHc0z7X4SGc/UJkp3jutTTIk0NITZMxB
 oEBzXPe42Qc0ZtlNMD80csF/jQTRUcoH86zqi4T5He+1M0h+9avKR6y8iDdpI4WJAR0k
 VNk9hZbE28HElZvBVXa4gyA9hYbmu+qhbNTJJybz9CQ6Y4/lWl7+uww9z++4+1misjMA
 vCjOz54XW4zO/5IVQcuYAxM68GFYxH099UnNgmBIYGcOlIAI+gBgi4qMQxG9TJfcIrpC
 GDa2JigJ+xasPRf5kcFRVh5KKFwSnhzUqtQKBxe7vNPqL/oMaf26QTQWAMnwwuJIETHh
 M9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zIaWGD0nhATksvssU385Tb+Vkuh573SQJiN/xNTgN2Q=;
 b=c/ZsIuclg3bFKcoqbzPR3uQi34RUuliqQNzr881aSBx8LP6v/CNzxr1JXKa8nURUf3
 Cr59nSUSiN0XuT48Oo6NeO6jkvIZ+68haLkJo2+nX5qh5bP7RrhcKIuxg9Z5iVutAvnT
 JZYLduQu5laDlecxWf7GtgR3rwtjbj+6kavB1Hp1rtjyyn6+8/9w1UmkZ+NMqPdMQEYE
 +t/tjylchJ22FhkINc+NNL5sNQL24bcvjJurPYITyaTkzCptg7DL5rrL7J3ybQKvgWDC
 GD4YrFrgMNNTiMozR2bJSHNTl7iC9INpPQOTvhrGvFqkzsCWommaKTbhgErFdhnYSEHc
 T/bw==
X-Gm-Message-State: APjAAAWJvBARLmA48pn5R6x3F6pIVUkcmIPnjtWe6j4mPNyA1XsZllIq
 gRnmGUsOZ9l1SsZK1awoe8wGZQ==
X-Google-Smtp-Source: APXvYqxp8lbpnweDvSryE15hiLeAsPkvdcmqH/MRQNz9+1GKnbTAR8wQwby1izJTWQsL2qB/RqdcTQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr6032090wro.375.1579898429840; 
 Fri, 24 Jan 2020 12:40:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm8285555wmj.40.2020.01.24.12.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7FD551FF8C;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/13] tests/docker: move most cross compilers to buster
 base
Date: Fri, 24 Jan 2020 20:40:14 +0000
Message-Id: <20200124204026.2107-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
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


