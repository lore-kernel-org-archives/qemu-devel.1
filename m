Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB06M-0005SA-1N
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB06G-0000kQ-Dg
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:30 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fB06G-0000jl-71
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:24 -0400
Received: by mail-wm0-x244.google.com with SMTP id w195so1934458wmw.2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:43:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:59 +0100
Message-Id: <20180424152405.10304-41-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 40/46] tests/tcg: enable building for sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers. While the compiler can be
coerced into generating big-endian code it seems the linker can't deal
with it so we only enable the building for little endian SH4.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                    |  1 +
 tests/docker/dockerfiles/debian-sh4-cross.docker | 12 ++++++++++++
 tests/tcg/sh4/Makefile.include                   |  4 ++++
 3 files changed, 17 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 create mode 100644 tests/tcg/sh4/Makefile.include

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 15c52127c7..c08f32ca58 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -65,6 +65,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
+docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
new file mode 100644
index 0000000000..88a2423094
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
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
+        gcc-sh4-linux-gnu \
+        libc6-dev-sh4-cross
diff --git a/tests/tcg/sh4/Makefile.include b/tests/tcg/sh4/Makefile.include
new file mode 100644
index 0000000000..ad21594d9d
--- /dev/null
+++ b/tests/tcg/sh4/Makefile.include
@@ -0,0 +1,4 @@
+ifneq ($(TARGET_NAME), sh4eb)
+DOCKER_IMAGE=debian-sh4-cross
+DOCKER_CROSS_COMPILER=sh4-linux-gnu-gcc
+endif
-- 
2.17.0
