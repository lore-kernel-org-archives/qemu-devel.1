Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C38C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C117E206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k39KOTs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C117E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJbA-00059g-Ma
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNK-0006vv-Ld
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007dc-BX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id j2so1445945wrx.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MBf1qUg7JcJrCu84N6vb1LPcLVQ94tKpJ0eYWnc5ilw=;
 b=k39KOTs+iZrYeTkhNoafUr2kyJlTMWDGk1GDv5ZheRUF50+EEsrEc58tfUJbeGnsuu
 oFpAIyt745a0qvu73kCrG3R/RBONBKvyqxN6bm+0OkW1iMoXteOTzVKV227mwR4JjUGO
 OXop2qxkMgraYm6/u5iHplDrvN3gqHAIlbl4LZUDWPlFwOyz+YiiVFPvl0IAlKc7MyT5
 Vh+njKTRLIPZFdgCnVEXf/B0VYozYArA9iSG6VQbY7H/jwUfFKxC20pKS4XhPAlMsOB8
 79PHQQad3mcPjp7sI1Nm092iyulkIu5v02u5ALqbuEroDSXCN5i+n2yRQDPnOYmrTgvq
 UGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBf1qUg7JcJrCu84N6vb1LPcLVQ94tKpJ0eYWnc5ilw=;
 b=knV4wYMxAViFp/gmQNpyw37YuWDHaUdj71ign5XBkgBs8PwiLtLUL0cv6RkHt+Vii0
 5N8k94EBu5muMm0MjYp1oSaoLcQ25aVVh2O+iGFdSIuJwWH/QjNN5rk7zUz79KhJ4MDR
 8yAgzhXEQbWPARTPR3w7u0lSuYMVyxT7ePplVEaG6gulDXX2EgLdQmRZ0iFcLMOHZqOR
 E0el40vwj7/xnAhnEtTb5vhVxkJQt8Tp3NrDDBIhiVU4nRr4jNA5AqEfGb1K+2MK/Nd6
 W69xqGKPHnOG3OZ7GeXw70fgCdlQGlkigW7+Cvuc1FuebtoPz5ur8k+6vBg7KNaKbRGe
 VFJQ==
X-Gm-Message-State: AOAM532G+KNcvLHJofonUkyI+PBQHx7cO/EhXNSdfZ9YQY7vLN+o17+F
 VO/jbiYrLrNAj4lpq4vJuJacIA==
X-Google-Smtp-Source: ABdhPJwsoOfPXbdEYzR/NjyCuFGLO0D0IRrIVrdJDbT30YpXE5m5ZA0H7nsrUPalcsJyHMY6dSSuUw==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr2758487wro.249.1601638631177; 
 Fri, 02 Oct 2020 04:37:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t10sm1485615wmi.1.2020.10.02.04.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D926B1FF99;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/14] tests/docker: Remove old Debian 9 containers
Date: Fri,  2 Oct 2020 12:36:41 +0100
Message-Id: <20201002113645.17693-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
are now no longer used in the gitlab-CI. Time to remove them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200921174320.46062-6-thuth@redhat.com>
Message-Id: <20200925154027.12672-14-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 089cea7c14..11d079ea58 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -48,18 +48,6 @@ amd64-debian11-container:
   variables:
     NAME: debian11
 
-amd64-debian9-container:
-  <<: *container_job_definition
-  variables:
-    NAME: debian9
-
-amd64-debian9-mxe-container:
-  <<: *container_job_definition
-  stage: containers-layer2
-  needs: ['amd64-debian9-container']
-  variables:
-    NAME: debian9-mxe
-
 alpha-debian-cross-container:
   <<: *container_job_definition
   stage: containers-layer2
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
deleted file mode 100644
index b045e821b9..0000000000
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ /dev/null
@@ -1,38 +0,0 @@
-#
-# Docker mingw32 cross-compiler target
-#
-# This docker target builds on the debian Stretch MXE base image.
-#
-FROM qemu/debian9-mxe
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-ENV TARGET i686
-
-ENV PATH $PATH:/usr/lib/mxe/usr/bin:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
-
-ENV PKG_CONFIG_PATH \
-    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
-
-RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        mxe-$TARGET-w64-mingw32.shared-bzip2 \
-        mxe-$TARGET-w64-mingw32.shared-curl \
-        mxe-$TARGET-w64-mingw32.shared-glib \
-        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
-        mxe-$TARGET-w64-mingw32.shared-libusb1 \
-        mxe-$TARGET-w64-mingw32.shared-lzo \
-        mxe-$TARGET-w64-mingw32.shared-nettle \
-        mxe-$TARGET-w64-mingw32.shared-ncurses \
-        mxe-$TARGET-w64-mingw32.shared-nsis \
-        mxe-$TARGET-w64-mingw32.shared-pixman \
-        mxe-$TARGET-w64-mingw32.shared-pkgconf \
-        mxe-$TARGET-w64-mingw32.shared-pthreads \
-        mxe-$TARGET-w64-mingw32.shared-sdl2 \
-        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
-        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
-        mxe-$TARGET-w64-mingw32.shared-zlib
-
-# Specify the cross prefix for this image (see tests/docker/common.rc)
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=$TARGET-w64-mingw32.shared-
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
deleted file mode 100644
index 4cc4a3f365..0000000000
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Docker mingw64 cross-compiler target
-#
-# This docker target builds on the debian Stretch MXE base image.
-#
-FROM qemu/debian9-mxe
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-ENV TARGET x86-64
-
-ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
-
-ENV PKG_CONFIG_PATH \
-    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
-
-RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        mxe-$TARGET-w64-mingw32.shared-bzip2 \
-        mxe-$TARGET-w64-mingw32.shared-curl \
-        mxe-$TARGET-w64-mingw32.shared-glib \
-        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
-        mxe-$TARGET-w64-mingw32.shared-libusb1 \
-        mxe-$TARGET-w64-mingw32.shared-lzo \
-        mxe-$TARGET-w64-mingw32.shared-nettle \
-        mxe-$TARGET-w64-mingw32.shared-ncurses \
-        mxe-$TARGET-w64-mingw32.shared-nsis \
-        mxe-$TARGET-w64-mingw32.shared-pixman \
-        mxe-$TARGET-w64-mingw32.shared-pkgconf \
-        mxe-$TARGET-w64-mingw32.shared-pthreads \
-        mxe-$TARGET-w64-mingw32.shared-sdl2 \
-        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
-        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
-        mxe-$TARGET-w64-mingw32.shared-zlib \
-        curl && \
-    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
-        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvemulation.h?format=raw" && \
-    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
-        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatform.h?format=raw" && \
-    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
-        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatformdefs.h?format=raw"
-
-# Specify the cross prefix for this image (see tests/docker/common.rc)
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-
diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
deleted file mode 100644
index ae2c222a6f..0000000000
--- a/tests/docker/dockerfiles/debian9-mxe.docker
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Docker mingw cross-compiler target
-#
-# This docker target builds on the debian Stretch base image.
-#
-FROM qemu/debian9
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends gnupg dirmngr
-
-# Add the foreign architecture we want and install dependencies
-RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 && \
-    echo "deb http://pkg.mxe.cc/repos/apt stretch main" > /etc/apt/sources.list.d/mxeapt.list
-RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
-
-ENV PATH $PATH:/usr/lib/mxe/usr/bin/
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
deleted file mode 100644
index 3edb5147ef..0000000000
--- a/tests/docker/dockerfiles/debian9.docker
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# Docker multiarch cross-compiler target
-#
-# This docker target is builds on Debian cross compiler targets to build distro
-# with a selection of cross compilers for building test binaries.
-#
-# On its own you can't build much but the docker-foo-cross targets
-# build on top of the base debian image.
-#
-FROM debian:stretch-slim
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        bc \
-        build-essential \
-        ca-certificates \
-        clang \
-        gdb-multiarch \
-        gettext \
-        git \
-        libncurses5-dev \
-        pkg-config \
-        psmisc \
-        python3 \
-        python3-setuptools \
-        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.20.1


