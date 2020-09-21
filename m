Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB9C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E29220BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YP/Lnlos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E29220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPzt-0003n5-Qe
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPr8-0001vV-BC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPr4-0000UM-78
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600710237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txVtSusGIWUv9yp1/LucJfBamvhPtUCA/Mzl8njc4j4=;
 b=YP/LnlosQATb5tPLzCTt4yO6J1lsJyt1bHzenHVRjVQrh2tNcCMQ2/pYnyblm6TK6b+fBg
 j8lnqzUdshpAcPzfbPfLbhSfQnkp21nGgoeE3Ghy4ImGwgFXxR8puFbXV/lYUhzl4aUUmO
 4Z69X9KWOSXf9Yf39Sm6eq8WNJsFQ4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Czk9A0wDPZaGps6Q6BZwKg-1; Mon, 21 Sep 2020 13:43:53 -0400
X-MC-Unique: Czk9A0wDPZaGps6Q6BZwKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 711451018F60;
 Mon, 21 Sep 2020 17:43:52 +0000 (UTC)
Received: from thuth.com (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 378EE5D9CD;
 Mon, 21 Sep 2020 17:43:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/7] tests/docker: Remove old Debian 9 containers
Date: Mon, 21 Sep 2020 19:43:18 +0200
Message-Id: <20200921174320.46062-6-thuth@redhat.com>
In-Reply-To: <20200921174320.46062-1-thuth@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
are now no longer used in the gitlab-CI. Time to remove them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.2


