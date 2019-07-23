Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6178C76194
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BA821842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BA821842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpvaB-0005M8-9i
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpvZs-0004lb-3R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpvZo-0004TU-Nq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpvZo-0004RG-FG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD80286679;
 Tue, 23 Jul 2019 14:15:34 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-56.brq.redhat.com [10.40.204.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69EC85C230;
 Tue, 23 Jul 2019 14:15:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 16:15:27 +0200
Message-Id: <20190723141528.18023-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 23 Jul 2019 14:15:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/docker: Refresh APT cache before
 installing new packages on Debian
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since docker caches the different layers, updating the package
list does not invalidate the previous "apt-get update" layer,
and it is likely "apt-get install" hits an outdated repository.

See commit beac6a98f6eb and
https://docs.docker.com/develop/develop-images/dockerfile_best-practices/=
#apt-get

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../dockerfiles/debian-alpha-cross.docker     |  5 +++--
 tests/docker/dockerfiles/debian-amd64.docker  | 20 +++++++++++--------
 .../dockerfiles/debian-arm64-cross.docker     | 16 ++++++++-------
 .../dockerfiles/debian-armel-cross.docker     | 13 ++++++------
 .../dockerfiles/debian-armhf-cross.docker     | 16 ++++++++-------
 .../debian-buster-arm64-cross.docker          |  5 +++--
 .../dockerfiles/debian-hppa-cross.docker      |  5 +++--
 .../dockerfiles/debian-m68k-cross.docker      |  5 +++--
 .../dockerfiles/debian-mips-cross.docker      | 16 ++++++++-------
 .../dockerfiles/debian-mips64-cross.docker    |  5 +++--
 .../dockerfiles/debian-mips64el-cross.docker  | 16 ++++++++-------
 .../dockerfiles/debian-mipsel-cross.docker    | 16 ++++++++-------
 tests/docker/dockerfiles/debian-ports.docker  |  4 ++--
 .../dockerfiles/debian-powerpc-cross.docker   |  5 +++--
 .../dockerfiles/debian-ppc64-cross.docker     |  5 +++--
 .../dockerfiles/debian-ppc64el-cross.docker   | 14 +++++++------
 .../dockerfiles/debian-riscv64-cross.docker   |  5 +++--
 .../dockerfiles/debian-s390x-cross.docker     | 15 ++++++++------
 .../dockerfiles/debian-sh4-cross.docker       |  5 +++--
 tests/docker/dockerfiles/debian-sid.docker    |  6 +++---
 .../dockerfiles/debian-sparc64-cross.docker   |  5 +++--
 .../dockerfiles/debian-win32-cross.docker     |  3 ++-
 .../dockerfiles/debian-win64-cross.docker     |  3 ++-
 .../dockerfiles/debian-xtensa-cross.docker    |  4 ++--
 tests/docker/dockerfiles/debian10.docker      |  6 +++---
 tests/docker/dockerfiles/debian8-mxe.docker   |  4 ++--
 tests/docker/dockerfiles/debian8.docker       |  6 +++---
 tests/docker/dockerfiles/debian9.docker       |  6 +++---
 28 files changed, 133 insertions(+), 101 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/d=
ocker/dockerfiles/debian-alpha-cross.docker
index 29a25d0dfd..23444342f0 100644
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-alpha-linux-gnu \
         libc6.1-dev-alpha-cross || { echo "Failed to build - see debian-=
sid.docker notes"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
index d770a11a52..431e947ebd 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -7,11 +7,13 @@
 FROM qemu:debian9
 MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy qemu
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev \
         liblzo2-dev \
         librdmacm-dev \
@@ -19,8 +21,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         libvte-dev
=20
 # virgl
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
@@ -29,8 +32,9 @@ RUN git clone https://anongit.freedesktop.org/git/virgl=
renderer.git /usr/src/vir
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx =
--disable-tests && make install
=20
 # netmap
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         linux-headers-amd64
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
 RUN cd /usr/src/netmap && git checkout v11.3
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/d=
ocker/dockerfiles/debian-arm64-cross.docker
index 877d863475..7c2cc93daf 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -7,18 +7,20 @@ FROM qemu:debian9
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
-RUN apt update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         crossbuild-essential-arm64
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a arm64 qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a arm64 qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Daarch64-linux-gnu-
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:arm64 \
         liblzo2-dev:arm64 \
         librdmacm-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/d=
ocker/dockerfiles/debian-armel-cross.docker
index e3bd68f51e..d866fe5d75 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -8,16 +8,17 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armel && \
-    apt update
-RUN apt install -yy crossbuild-essential-armel
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a armel qemu
+    apt update && \
+    apt install -yy crossbuild-essential-armel && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a armel qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabi-
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:armel \
         liblzo2-dev:armel \
         librdmacm-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
index 5100b0afc0..2b8627673c 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -7,18 +7,20 @@ FROM qemu:debian9
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
-RUN apt update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         crossbuild-essential-armhf
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a armhf qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a armhf qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabihf-
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:armhf \
         liblzo2-dev:armhf \
         librdmacm-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker b/=
tests/docker/dockerfiles/debian-buster-arm64-cross.docker
index 33ada13806..52787edcc2 100644
--- a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
@@ -9,7 +9,8 @@ FROM qemu:debian10
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
-RUN apt update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         crossbuild-essential-arm64
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/do=
cker/dockerfiles/debian-hppa-cross.docker
index ad443defac..ee6d9a24ce 100644
--- a/tests/docker/dockerfiles/debian-hppa-cross.docker
+++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-hppa-linux-gnu \
         libc6-dev-hppa-cross
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/do=
cker/dockerfiles/debian-m68k-cross.docker
index 21ba3b0132..4311c9cf86 100644
--- a/tests/docker/dockerfiles/debian-m68k-cross.docker
+++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-m68k-linux-gnu \
         libc6-dev-m68k-cross
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/do=
cker/dockerfiles/debian-mips-cross.docker
index 550f43281b..3c4d6f9ec1 100644
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -9,20 +9,22 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture mips
-RUN apt-get update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-mips-linux-gnu
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a mips qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a mips qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmips-linux-gnu-
=20
 # Install extra libraries to increase code coverage
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:mips \
         liblzo2-dev:mips \
         librdmacm-dev:mips \
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/=
docker/dockerfiles/debian-mips64-cross.docker
index ed1ce0e919..bf0073a466 100644
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-mips64-linux-gnuabi64 \
         libc6-dev-mips64-cross
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/test=
s/docker/dockerfiles/debian-mips64el-cross.docker
index fd2aafeb01..34b0b82895 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -10,20 +10,22 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture mips64el && \
-    apt-get update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+    apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-mips64el-linux-gnuabi64
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a mips64el qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a mips64el qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmips64el-linux-gnuabi64-
=20
 # Install extra libraries to increase code coverage
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:mips64el \
         liblzo2-dev:mips64el \
         librdmacm-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/=
docker/dockerfiles/debian-mipsel-cross.docker
index 6378bd41e7..88accad269 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -9,20 +9,22 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture mipsel
-RUN apt-get update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-mipsel-linux-gnu
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a mipsel qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a mipsel qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dmipsel-linux-gnu-
=20
 # Install extra libraries to increase code coverage
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:mipsel \
         liblzo2-dev:mipsel \
         librdmacm-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/=
dockerfiles/debian-ports.docker
index e05a9a9802..61bc3f2993 100644
--- a/tests/docker/dockerfiles/debian-ports.docker
+++ b/tests/docker/dockerfiles/debian-ports.docker
@@ -18,8 +18,8 @@ RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*=
\]\ \)\?\(.*\)/deb-src \2
=20
 # Setup some basic tools we need
 RUN apt-get update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         bison \
         build-essential \
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests=
/docker/dockerfiles/debian-powerpc-cross.docker
index 5e62ca0df1..5d08fad7cd 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -7,7 +7,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-powerpc-linux-gnu \
         libc6-dev-powerpc-cross || { echo "Failed to build - see debian-=
sid.docker notes"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/d=
ocker/dockerfiles/debian-ppc64-cross.docker
index 7f239c322d..e5757fe46e 100644
--- a/tests/docker/dockerfiles/debian-ppc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
@@ -5,7 +5,8 @@
 # contains cross compilers for Debian "ports" targets.
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
        gcc-powerpc64-linux-gnu \
        libc6-dev-ppc64-cross || { echo "Failed to build - see debian-sid=
.docker notes"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests=
/docker/dockerfiles/debian-ppc64el-cross.docker
index f44a35880a..fc056d7bc3 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -7,18 +7,20 @@ FROM qemu:debian9
=20
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture ppc64el && \
-    apt update
-RUN apt install -yy crossbuild-essential-ppc64el
+    apt update && \
+    apt install -yy crossbuild-essential-ppc64el
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a ppc64el qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a ppc64el qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dpowerpc64le-linux-gnu-
=20
 # Install extra libraries to increase code coverage
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:ppc64el \
         liblzo2-dev:ppc64el \
         librdmacm-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests=
/docker/dockerfiles/debian-riscv64-cross.docker
index 2b2e64cee6..221697f9d1 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-riscv64-linux-gnu \
         libc6-dev-riscv64-cross
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
index e188bfeda4..6732f9ec78 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -10,19 +10,22 @@ RUN dpkg --add-architecture s390x
=20
 # Grab the updated list of packages
 RUN apt update && apt dist-upgrade -yy
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-multilib-s390x-linux-gnu
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get build-dep -yy -a s390x qemu
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt build-dep -yy -a s390x qemu
=20
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Ds390x-linux-gnu-
=20
 # Install extra libraries to increase code coverage
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         libbz2-dev:s390x \
         liblzo2-dev:s390x \
         librdmacm-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/doc=
ker/dockerfiles/debian-sh4-cross.docker
index 88a2423094..29983b2d75 100644
--- a/tests/docker/dockerfiles/debian-sh4-cross.docker
+++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-sh4-linux-gnu \
         libc6-dev-sh4-cross
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
index 676941cb32..513459ca7f 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -26,9 +26,9 @@ RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/=
\? \(.*\)%deb [check-vali
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
=20
 # Install common build utilities
-RUN apt update
-RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
         build-essential \
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests=
/docker/dockerfiles/debian-sparc64-cross.docker
index 1e2c809274..7a2c2ab19c 100644
--- a/tests/docker/dockerfiles/debian-sparc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-sparc64-cross.docker
@@ -6,7 +6,8 @@
 #
 FROM qemu:debian-sid
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt install -y --no-install-recommends \
         gcc-sparc64-linux-gnu \
         libc6-dev-sparc64-cross
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/d=
ocker/dockerfiles/debian-win32-cross.docker
index 0a4970c068..e9fe10fb2c 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -9,7 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
 ENV TARGET i686
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt-get update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
         mxe-$TARGET-w64-mingw32.shared-curl \
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/d=
ocker/dockerfiles/debian-win64-cross.docker
index b27985b1b1..a8235081cb 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -9,7 +9,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=20
 ENV TARGET x86-64
=20
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt-get update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
         mxe-$TARGET-w64-mingw32.shared-curl \
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/=
docker/dockerfiles/debian-xtensa-cross.docker
index afd2ab9163..b9c2e2e531 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -8,8 +8,8 @@
 FROM debian:stretch-slim
=20
 RUN apt-get update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         bison \
         build-essential \
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
index aeeb151b52..d2c6675a55 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -13,9 +13,9 @@ FROM debian:buster-slim
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
=20
 # Install common build utilities
-RUN apt update
-RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
         build-essential \
diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/d=
ockerfiles/debian8-mxe.docker
index 2df4cc8c5c..66618e0074 100644
--- a/tests/docker/dockerfiles/debian8-mxe.docker
+++ b/tests/docker/dockerfiles/debian8-mxe.docker
@@ -10,8 +10,8 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
 # Add the foreign architecture we want and install dependencies
 RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B=
16ABE9643FE1AFD8FFF16DB45C6AB && \
     echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt=
/sources.list.d/mxeapt.list
-RUN apt-get update
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt-get update && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         libpython2.7-stdlib \
         $(apt-get -s install -y --no-install-recommends gw32.shared-ming=
w-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/docke=
rfiles/debian8.docker
index 52945631cd..1212a85c35 100644
--- a/tests/docker/dockerfiles/debian8.docker
+++ b/tests/docker/dockerfiles/debian8.docker
@@ -15,9 +15,9 @@ MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
=20
 # Setup some basic tools we need
-RUN apt-get update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         bison \
         binutils-multiarch \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
index 5f23a35404..486f1a1394 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -13,9 +13,9 @@ FROM debian:stretch-slim
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
=20
 # Install common build utilities
-RUN apt-get update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
-RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+RUN apt update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
         build-essential \
--=20
2.20.1


