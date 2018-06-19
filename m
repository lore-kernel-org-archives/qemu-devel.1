Received: from eggs.gnu.org ([2001:4830:134:3::10]:38858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvJ-00048f-K3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvC-0001kF-91
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:01 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:37132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvC-0001ik-0x
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:54 -0400
Received: by mail-wr0-x22c.google.com with SMTP id d8-v6so179063wro.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:18 +0100
Message-Id: <20180619154435.18898-40-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/56] tests/tcg: enable building for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fb465e729e..8fd4041716 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -75,6 +75,7 @@ docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
+docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
new file mode 100644
index 0000000000..ed1ce0e919
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
@@ -0,0 +1,12 @@
+#
+# Docker cross-compiler target
+#
+# This docker target builds on the debian sid base image which
+# contains cross compilers for Debian "ports" targets.
+#
+FROM qemu:debian-sid
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-mips64-linux-gnuabi64 \
+        libc6-dev-mips64-cross
diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
index a9beceb623..4a14fc078d 100644
--- a/tests/tcg/mips/Makefile.include
+++ b/tests/tcg/mips/Makefile.include
@@ -8,6 +8,9 @@
 ifeq ($(TARGET_NAME),mips64el)
 DOCKER_IMAGE=debian-mips64el-cross
 DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
+else ifeq ($(TARGET_NAME),mips64)
+DOCKER_IMAGE=debian-mips64-cross
+DOCKER_CROSS_COMPILER=mips64-linux-gnuabi64-gcc
 else ifeq ($(TARGET_NAME),mipsel)
 DOCKER_IMAGE=debian-mipsel-cross
 DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
-- 
2.17.1
