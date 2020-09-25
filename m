Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2666B21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU35PRZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2666B21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq91-0004Zu-4h
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpyD-0002Yn-QF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpy9-0000VV-JR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id k18so3807712wmj.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GEgAIy3Gb432FQIIBfbH6rEBsgGzghVjuElpT6S9p1E=;
 b=DU35PRZL5dZiqMF1B5UlZK99Fkrw15w545/K7aWYWGwvjXcOj/ucLUwUZIX4u+4H7b
 labIFr+ZDoLZqO6+8w9zf3DWWng/b8d2iBviW5COT8blcuAJxBqxzCcg+bWEns6pURCC
 h9ppNxkHIgV4pA7IlC3LBeJiWnQDqPUn2TgNBGCR4Cv4AeVuKtalcoyUy567KDMpfiBt
 uiAcuTpBCeFoFwZAdkqk46xGSnKTsh4RAxKxoYTq8NUyyTUp6bsJwZ9Q7x4ABYHK6MJh
 +y6srtpGxzhR6ibN7o3F3DgeXkS0M+ByTsvgMW/5PTX1BMLRHGbKMopA8l+q9Ktsu/1I
 GnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GEgAIy3Gb432FQIIBfbH6rEBsgGzghVjuElpT6S9p1E=;
 b=DTnizRETIn9Djzs8GzPm3DH4e3pXVcAxWefLTNDK/a4XRB1WnnuLpry9GcnDaD6sRu
 PzV+OOhoVozAnjLL5kxW1BBMtOUMPkLt+EUE6KRtmvFmVCpZAjcIHNW94HgxCbQ9O0Lc
 4CZQaJs1uC3US4gvWK73w2viZj80ILpBUm6RJN5Nds3kfpDqdhTrj8iqsz98hV/OvDoE
 g8CCxGB5a0RJCJLoiat7We/7FvwQlJxLBytj2PN3TcZBVhSXZyI1TW5PGG3pE4rT3J6D
 7og9CUrGEhMU2mw33ahqYC412Mo3Nbwhb7zfOgYS6OhZgX0IGkuNwCeNR868rP1rh0Rj
 pAwg==
X-Gm-Message-State: AOAM531gPbwYxEftUGAkJ85zfG6voBB2KvmqALnjA+m5/ozPhJlCrTCX
 wISinDjfPzf6oCct3hr5DcxpfdZrTdVBdQ==
X-Google-Smtp-Source: ABdhPJylLb16ToRfVowy12faH0FAJN7HDj/sGxNMyizaqMtLtuq2BhkdxuTT8zknjNfbgNQHJiiJnQ==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr3835065wmj.30.1601048947951; 
 Fri, 25 Sep 2020 08:49:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r206sm3342155wma.47.2020.09.25.08.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:49:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 563291FF9C;
 Fri, 25 Sep 2020 16:40:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/15] tests/docker: Remove old Debian 9 containers
Date: Fri, 25 Sep 2020 16:40:25 +0100
Message-Id: <20200925154027.12672-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
are now no longer used in the gitlab-CI. Time to remove them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921174320.46062-6-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .gitlab-ci.d/containers.yml                   | 12 -----
 .../dockerfiles/debian-win32-cross.docker     | 38 ----------------
 .../dockerfiles/debian-win64-cross.docker     | 45 -------------------
 tests/docker/dockerfiles/debian9-mxe.docker   | 21 ---------
 tests/docker/dockerfiles/debian9.docker       | 32 -------------
 5 files changed, 148 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
 delete mode 100644 tests/docker/dockerfiles/debian9.docker

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 089cea7c14c1..11d079ea5810 100644
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
index b045e821b910..000000000000
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
index 4cc4a3f3657f..000000000000
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
index ae2c222a6f08..000000000000
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
index 3edb5147ef3e..000000000000
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


