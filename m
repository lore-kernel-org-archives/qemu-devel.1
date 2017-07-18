Received: from eggs.gnu.org ([2001:4830:134:3::10]:46715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0d-0007ms-Hv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0b-0003IU-OM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:43 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0b-0003Hr-Ec
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:41 -0400
Received: by mail-wr0-x236.google.com with SMTP id w4so22837319wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:09 +0100
Message-Id: <20170718104513.23947-29-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/32] docker: add MXE (M cross environment)
 base image for MinGW-w64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

see http://mxe.cc/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 5a8283674a..e993e149e7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -58,6 +58,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
 
 # Enforce dependancies for composite images
+docker-image-debian8-mxe: docker-image-debian8
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
@@ -67,6 +68,8 @@ docker-image-debian-mips64el-cross: docker-image-debian9
 docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
+docker-image-debian-win32-cross: docker-image-debian8-mxe
+docker-image-debian-win64-cross: docker-image-debian8-mxe
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
new file mode 100644
index 0000000000..dd021f2df0
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -0,0 +1,32 @@
+#
+# Docker mingw32 cross-compiler target
+#
+# This docker target builds on the debian Jessie MXE base image.
+#
+FROM qemu:debian8-mxe
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+ENV TARGET i686
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        mxe-$TARGET-w64-mingw32.shared-bzip2 \
+        mxe-$TARGET-w64-mingw32.shared-curl \
+        mxe-$TARGET-w64-mingw32.shared-glib \
+        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
+        mxe-$TARGET-w64-mingw32.shared-libssh2 \
+        mxe-$TARGET-w64-mingw32.shared-libusb1 \
+        mxe-$TARGET-w64-mingw32.shared-lzo \
+        mxe-$TARGET-w64-mingw32.shared-nettle \
+        mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-pixman \
+        mxe-$TARGET-w64-mingw32.shared-pkgconf \
+        mxe-$TARGET-w64-mingw32.shared-pthreads \
+        mxe-$TARGET-w64-mingw32.shared-sdl2 \
+        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
+        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
+        mxe-$TARGET-w64-mingw32.shared-zlib
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=$TARGET-w64-mingw32.shared-
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
new file mode 100644
index 0000000000..4542bcc821
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -0,0 +1,32 @@
+#
+# Docker mingw64 cross-compiler target
+#
+# This docker target builds on the debian Jessie MXE base image.
+#
+FROM qemu:debian8-mxe
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+ENV TARGET x86-64
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        mxe-$TARGET-w64-mingw32.shared-bzip2 \
+        mxe-$TARGET-w64-mingw32.shared-curl \
+        mxe-$TARGET-w64-mingw32.shared-glib \
+        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
+        mxe-$TARGET-w64-mingw32.shared-libssh2 \
+        mxe-$TARGET-w64-mingw32.shared-libusb1 \
+        mxe-$TARGET-w64-mingw32.shared-lzo \
+        mxe-$TARGET-w64-mingw32.shared-nettle \
+        mxe-$TARGET-w64-mingw32.shared-ncurses \
+        mxe-$TARGET-w64-mingw32.shared-pixman \
+        mxe-$TARGET-w64-mingw32.shared-pkgconf \
+        mxe-$TARGET-w64-mingw32.shared-pthreads \
+        mxe-$TARGET-w64-mingw32.shared-sdl2 \
+        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
+        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
+        mxe-$TARGET-w64-mingw32.shared-zlib
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-
diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian8-mxe.docker
new file mode 100644
index 0000000000..7bf1b59e54
--- /dev/null
+++ b/tests/docker/dockerfiles/debian8-mxe.docker
@@ -0,0 +1,18 @@
+#
+# Docker mingw cross-compiler target
+#
+# This docker target builds on the debian Jessie base image.
+#
+FROM qemu:debian8
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB && \
+    echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt/sources.list.d/mxeapt.list
+RUN apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
+
+ENV PATH $PATH:/usr/lib/mxe/usr/bin/ 
-- 
2.13.0
