Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB68C208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoOlX5/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB68C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cE6-0001tr-Tz
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008Bu-N4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv9-0006e3-EV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv7-0006bL-Hz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id u16so217929wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9p8BAxT30zLuPs+PTsow4wewanfEgFRokJTEPp+OXPU=;
 b=RoOlX5/tEuce1rgHi/eF2JXXwzwfTUntqM+MZSbyyyZj5UQTRwPSmQ7ciwraxRycax
 C9Sug2K1OynTgpaSzTWsNvmCC/Ph7IE9Gy2a7ugms/6AmfpiEQ8JtYGbNWLtmwNO0eiD
 Zm+DuI6FZIlVdNFGcqzfQOmgI2ojW/TZqYU87+WN18zL4M3b4idOuhvoKfQLVj8Ceq2T
 eOLnRno0gj0xROVreUEzpWnQ9Rf/ehxnbrfLej6k3eNAgKGuyACnZpDXVC5WZcjqJAgo
 l0r1kx4VsJIg6G9jdAxbV6Ne6AXQE+7LtZAdCXdO/BxmKBiYD/1J81/VWNwG1NqiI9K6
 aUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9p8BAxT30zLuPs+PTsow4wewanfEgFRokJTEPp+OXPU=;
 b=tFa0j5vW6VXhjPlQHr7F5/J2PImj4ahHUPZuokIU7xFZgRbl8WhIljy/dRpbVl7ADj
 P5pjWYiHMB9AmfQQypTYocqEev+SBrp4ma8N6Fi1zaE9n0E8h9PMkwTVKOwFP0eK3vTl
 YZsij4PZmcSga2gd0iYIHPC7Q81XvbBw7blMcTtuA3e0ykNVnirCW28MxrpsUR3LBwHH
 /IWqy7aUzh7YYTSHMvYmWJl4JITnqnuY/Ej49D0hT8QUS4YntImdXn08mwnksHMB2mos
 XjlxTq4BebGOawyrUBwLO0ld42IHJqrsfUBhD/shADlPIYpClZpv6LpU9qSI0HbnDxZ5
 qR8Q==
X-Gm-Message-State: APjAAAWTKHCespDZRdDZO+bG35LXqptdV7tmvF/J/XaUWTAFfFtUPwz2
 IZ1lgmoDqtqtfcz2u9GddaBkrg==
X-Google-Smtp-Source: APXvYqwnX77nFTqQzAkhmQYfXUvdRgy27+9I+x9nGJSjTIyzFcC5J5tAovjs0yMQcj9RWUuTzzzf2Q==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr24089975wru.51.1567629024275; 
 Wed, 04 Sep 2019 13:30:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm196901wme.23.2019.09.04.13.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E2DC1FF9B;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:42 +0100
Message-Id: <20190904203013.9028-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 11/42] tests/docker: move our arm64 cross
 compile to Buster
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

Now Buster is released we can unify our cross build images for both
QEMU and tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                    |  5 ++---
 .../docker/dockerfiles/debian-arm64-cross.docker |  4 ++--
 .../dockerfiles/debian-buster-arm64-cross.docker | 16 ----------------
 tests/tcg/configure.sh                           |  2 +-
 4 files changed, 5 insertions(+), 22 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 89881fb5f5d..48c22ae40c0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -86,13 +86,10 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 endif
 
 # Enforce dependencies for composite images
-docker-image-debian: docker-image-debian9
 docker-image-debian9-mxe: docker-image-debian9
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
-docker-image-debian-arm64-cross: docker-image-debian9
-docker-image-debian-buster-arm64-cross: docker-image-debian10
 docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
@@ -101,6 +98,8 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+docker-image-debian-arm64-cross: docker-image-debian10
+
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6b59ef0843a..55045ff5d5a 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker arm64 cross-compiler target
 #
-# This docker target builds on the debian Stretch base image.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
diff --git a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
deleted file mode 100644
index 52787edcc2c..00000000000
--- a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# Docker arm64 cross-compiler target
-#
-# This docker target builds on the Debian's Buster base image. There
-# are no QEMU pre-requistes so this image can only be used to build
-# test cases.
-#
-FROM qemu:debian10
-
-# Add the foreign architecture we want and install dependencies
-RUN dpkg --add-architecture arm64
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        crossbuild-essential-arm64
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 5f794b664b8..2a351a00048 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -95,7 +95,7 @@ for target in $target_list; do
   case $target in
     aarch64-*)
       # We don't have any bigendian build tools so we only use this for AArch64
-      container_image=debian-buster-arm64-cross
+      container_image=debian-arm64-cross
       container_cross_cc=aarch64-linux-gnu-gcc
       ;;
     alpha-*)
-- 
2.20.1


