Received: from eggs.gnu.org ([2001:4830:134:3::10]:35148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7t-00060d-SA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7p-0001yu-Pl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:57 -0500
Received: from mail-wj0-f173.google.com ([209.85.210.173]:33531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHD7p-0001yk-Is
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:53 -0500
Received: by mail-wj0-f173.google.com with SMTP id xy5so42545731wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:13:53 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Dec 2016 17:12:42 +0000
Message-Id: <20161214171244.26813-3-alex.bennee@linaro.org>
In-Reply-To: <20161214171244.26813-1-alex.bennee@linaro.org>
References: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC/POC PATCH 2/4] new
 tests/docker/dockerfiles/debian-multiarch-cross.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, marcandre.lureau@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

This provides a basic Debian install with access to the emdebian cross
compilers for armhf, arm64 and ppc64el. On its own it provides the
basic cross build essentials for building any of those architectures.
More complex cross-compilations would need to install library
dependencies on top of this image.

An example use:

  docker run --rm -it \
    -v /home/alex/lsrc/qemu/qemu.git/:/home/alex/lsrc/qemu/qemu.git/ \
    --user=alex:alex \
    -w /home/alex/lsrc/qemu/qemu.git/arm-linux-user/tests \
    -e CROSS_CC="arm-linux-gnueabihf-gcc" \
    debian:cross make -f ../../tests/tcg/arm/Makefile

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-multiarch-cross.docker      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.docker

diff --git a/tests/docker/dockerfiles/debian-multiarch-cross.docker b/tests/docker/dockerfiles/debian-multiarch-cross.docker
new file mode 100644
index 0000000000..dba66374c0
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-multiarch-cross.docker
@@ -0,0 +1,39 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian and Emdebian's cross compiler targets
+# to build distro with a selection of cross compilers for building test binaries.
+#
+# This does not include the build dependancies for QEMU as there are
+# so many there are unresolvable clashes.
+#
+FROM debian:stable-slim
+
+# Do we want to tweak the user?
+ADD . /
+RUN if test -e /setup_user.sh; then /setup_user.sh; fi
+
+# Setup some basic tools we need
+RUN apt update
+RUN apt install -yy curl
+
+# Setup Emdebian
+RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
+RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
+
+# Add the foriegn architectures we want
+RUN dpkg --add-architecture armhf
+RUN dpkg --add-architecture arm64
+RUN dpkg --add-architecture ppc64el
+
+# Final update
+RUN apt update
+
+# Install the crossbuild essential packages
+RUN apt install -yy crossbuild-essential-arm64 crossbuild-essential-armhf crossbuild-essential-ppc64el
+
+# To install greater dependencies you do a
+# RUN apt-get build-dep -yy -a armhf qemu
-- 
2.11.0
