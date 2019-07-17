Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9580BC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5283A208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giNs+fTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5283A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkG5-0006vR-AO
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDg-0005AP-O3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDe-0004Wo-VU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDe-0004Vj-P5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x4so24867060wrt.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=11ttVeY/tQgpJ8esBqmxS74iEBNqWAWeQN3tEMbd6AY=;
 b=giNs+fTJqu459Ra85k3rt+TwVJfpMwbneEuiXNGDpEjbfJV3MQDrS0+UJ7rPfSzoQi
 izJyE3+knowWEAZOcvIRl0yuzQvBjCskG3BeA8M9PnWNXCo7Xq0IvGfk+R0JuROw5EbP
 JnVELzoUJCMHZOBXM/6a6FNUjp0rUVqNUw+gB0tN1qdZPqWDrlEWze0dp6nrhxsXY0d1
 LU9bs2PoaGVeiDA8yoNZe5MfzPTdrGhVG9E4lgOh9uW9Usts7uGnNuj/DMHdjT7xm0Y9
 nD9U8txRTRvSen4kej8/u4mvPNuqw6kPnmqiX4qyadV4R0LuzD9v5W6B4/VagV+Iz0g3
 4Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=11ttVeY/tQgpJ8esBqmxS74iEBNqWAWeQN3tEMbd6AY=;
 b=Av7MPvhZnwMozIA1x00OFONbnsc+PRllxRiXPEaicDqQ1tjRcpS+gdarASmN+6gHC8
 oa9wPxRzrzrKdCeVraYqOogKZQCWOUlfgyVSdorQVRKTWy6HZp2v5EsZEzygQheDEzha
 /NN0JNFArO111nJvxZ9dHWSakG3Ksbbvg5jazFEs+Xv2l817x350Q75pngxK1mlHjdxg
 ZVNEhQ5kT6PkpBOdS2ALnZuUkNCotdn36DAFifTxfaVXmZsVrim8Io1rrYNTe6xl90fT
 fyYXTVz19PwLwWquvrrtZpR1uHijqhn2+zK3+8wHsOYgMTtgOiMaVXNOmjT25PvxYsIl
 zvpQ==
X-Gm-Message-State: APjAAAV2HH5jGZAB1d73gJ0rNJ41/MczG3QRE0XvNX9+FTPEOsMrD0lp
 J+OZ9rKlku42zsp3mFedXoG9Ww==
X-Google-Smtp-Source: APXvYqzeZsbzVxYxFSTKa+P5/jqphCzlvBvVh8/7PxznOXdMdHJQwIRKAtPrnQdML0B3M23d06rudA==
X-Received: by 2002:adf:f042:: with SMTP id t2mr42957217wro.139.1563371021579; 
 Wed, 17 Jul 2019 06:43:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c3sm27339337wrx.19.2019.07.17.06.43.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D6EE1FF96;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:19 +0100
Message-Id: <20190717134335.15351-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PATCH v2 07/23] tests/dockerfiles: update the win
 cross builds to stretch
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

While fixing up pkg.mxe.cc they move the URLs around a bit and dropped
Jessie support in favour of Stretch. We also need to update the keys
used to verify the packages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/Makefile.include                         |  6 +++---
 tests/docker/dockerfiles/debian-win32-cross.docker    |  4 ++--
 tests/docker/dockerfiles/debian-win64-cross.docker    |  4 ++--
 .../{debian8-mxe.docker => debian9-mxe.docker}        | 11 +++++++----
 4 files changed, 14 insertions(+), 11 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaf5396b85d..dbd58e548c1 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -85,7 +85,7 @@ endif
 
 # Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
-docker-image-debian8-mxe: docker-image-debian8
+docker-image-debian9-mxe: docker-image-debian9
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
@@ -96,8 +96,8 @@ docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
-docker-image-debian-win32-cross: docker-image-debian8-mxe
-docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-debian-win32-cross: docker-image-debian9-mxe
+docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index 0a4970c0683..c787e432454 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mingw32 cross-compiler target
 #
-# This docker target builds on the debian Jessie MXE base image.
+# This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian8-mxe
+FROM qemu:debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index b27985b1b1f..a7068ed6ac6 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mingw64 cross-compiler target
 #
-# This docker target builds on the debian Jessie MXE base image.
+# This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian8-mxe
+FROM qemu:debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
similarity index 56%
rename from tests/docker/dockerfiles/debian8-mxe.docker
rename to tests/docker/dockerfiles/debian9-mxe.docker
index 2df4cc8c5c9..5bc8a6d5c36 100644
--- a/tests/docker/dockerfiles/debian8-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -1,15 +1,18 @@
 #
 # Docker mingw cross-compiler target
 #
-# This docker target builds on the debian Jessie base image.
+# This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian8
+FROM qemu:debian9
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends gnupg dirmngr
+
 # Add the foreign architecture we want and install dependencies
-RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB && \
-    echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt/sources.list.d/mxeapt.list
+RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 && \
+    echo "deb http://pkg.mxe.cc/repos/apt stretch main" > /etc/apt/sources.list.d/mxeapt.list
 RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-- 
2.20.1


