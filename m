Received: from eggs.gnu.org ([2001:4830:134:3::10]:55454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKe-0003D6-BY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKd-00018S-0G
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKc-00017V-Nw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:14 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e7-v6so4043728wrs.9
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:05:02 +0100
Message-Id: <20180718100505.7546-8-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 07/10] docker: fall-back to binfmt_misc
 debian-s390x-user-cross on non-x86
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
for all host architectures. For s390x let's fall back to a linux-user
based image when we can't use the native ones.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                    |  9 ++++++++-
 .../dockerfiles/debian-s390x-user-cross.docker   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-s390x-user-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 879bacde93..e1eba21f06 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -169,8 +169,15 @@ docker-image-debian-ppc64el-user-cross: docker-binfmt-image-debian-ppc64el-user
 DOCKER_USER_IMAGES += debian-ppc64el-user-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 
+# No s390x cross-compilers in non-x86 Debian images, so use linux-user
+docker-binfmt-image-debian-s390x-user: DEB_ARCH = s390x
+docker-binfmt-image-debian-s390x-user: DEB_TYPE = stretch
+docker-binfmt-image-debian-s390x-user: EXECUTABLE = ${BUILD_DIR}/s390x-linux-user/qemu-s390x
+docker-image-debian-s390x-user-cross: docker-binfmt-image-debian-s390x-user
+DOCKER_USER_IMAGES += debian-s390x-user-cross
+DOCKER_PARTIAL_IMAGES += debian-s390x-cross
 else
-DOCKER_PARTIAL_IMAGES += debian-mips64el-user-cross debian-ppc64el-user-cross
+DOCKER_PARTIAL_IMAGES += debian-mips64el-user-cross debian-ppc64el-user-cross debian-s390x-user-cross
 endif
 
 
diff --git a/tests/docker/dockerfiles/debian-s390x-user-cross.docker b/tests/docker/dockerfiles/debian-s390x-user-cross.docker
new file mode 100644
index 0000000000..396763f10e
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-s390x-user-cross.docker
@@ -0,0 +1,16 @@
+#
+# Docker s390x user cross-compiler target
+#
+# This is a binfmt image for when the s390x cross compilers are not
+# available in the host architecture archives. This image is based of
+# the debootstrapped qemu:debian-s390x-user but doesn't need any
+# extra magic once it is setup.
+#
+
+FROM qemu:debian-s390x-user
+
+MAINTAINER Alex Bennee <alex.bennee@linaro.org>
+
+RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-- 
2.17.1
