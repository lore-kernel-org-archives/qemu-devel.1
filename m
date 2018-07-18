Received: from eggs.gnu.org ([2001:4830:134:3::10]:55419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKc-000395-3n
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKa-00016K-Cs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKa-00014y-4h
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id t6-v6so4045672wrn.7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:05:01 +0100
Message-Id: <20180718100505.7546-7-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 06/10] docker: fall-back to binfmt_misc
 debian-ppc64el-user-cross on non-x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The Debian archives don't package their large array of cross compilers
for all host architectures. For ppc64el let's fall back to a linux-user
based image when we can't use the native ones.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                    | 10 +++++++++-
 .../dockerfiles/debian-ppc64el-user-cross.docker | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-user-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 5cfb1a57bb..879bacde93 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -161,8 +161,16 @@ docker-image-debian-mips64el-user-cross: docker-binfmt-image-debian-mips64el-use
 DOCKER_USER_IMAGES += debian-mips64el-user-cross
 DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
 
+# No ppc64el cross-compilers in non-x86 Debian images, so use linux-user
+docker-binfmt-image-debian-ppc64el-user: DEB_ARCH = ppc64el
+docker-binfmt-image-debian-ppc64el-user: DEB_TYPE = stretch
+docker-binfmt-image-debian-ppc64el-user: EXECUTABLE = ${BUILD_DIR}/ppc64le-linux-user/qemu-ppc64le
+docker-image-debian-ppc64el-user-cross: docker-binfmt-image-debian-ppc64el-user
+DOCKER_USER_IMAGES += debian-ppc64el-user-cross
+DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
+
 else
-DOCKER_PARTIAL_IMAGES += debian-mips64el-user-cross
+DOCKER_PARTIAL_IMAGES += debian-mips64el-user-cross debian-ppc64el-user-cross
 endif
 
 
diff --git a/tests/docker/dockerfiles/debian-ppc64el-user-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-user-cross.docker
new file mode 100644
index 0000000000..aeb207e9c2
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ppc64el-user-cross.docker
@@ -0,0 +1,16 @@
+#
+# Docker ppc64el user cross-compiler target
+#
+# This is a binfmt image for when the ppc64el cross compilers are not
+# available in the host architecture archives. This image is based of
+# the debootstrapped qemu:debian-ppc64el-user but doesn't need any
+# extra magic once it is setup.
+#
+
+FROM qemu:debian-ppc64el-user
+
+MAINTAINER Alex Bennee <alex.bennee@linaro.org>
+
+RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-- 
2.17.1
