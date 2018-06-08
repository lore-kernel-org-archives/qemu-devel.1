Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGpO-0005uf-Ls
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGpL-0006dB-Gh
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:14 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:40362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGpL-0006cj-9s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:11 -0400
Received: by mail-wm0-x234.google.com with SMTP id n5-v6so3488546wmc.5
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:49:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:32:52 +0100
Message-Id: <20180608123307.24773-35-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 34/49] tests/tcg: enable building for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v5
  - add EXTRA_RUNS for mmap tests
---
 tests/docker/Makefile.include                     |  1 +
 tests/docker/dockerfiles/debian-m68k-cross.docker | 12 ++++++++++++
 tests/tcg/m68k/Makefile.include                   |  2 ++
 tests/tcg/m68k/Makefile.target                    |  7 +++++++
 4 files changed, 22 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 create mode 100644 tests/tcg/m68k/Makefile.include
 create mode 100644 tests/tcg/m68k/Makefile.target

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a83e979e6d..b1ae717010 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,6 +71,7 @@ docker-image-debian-sid: NOCACHE=1
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
+docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
new file mode 100644
index 0000000000..21ba3b0132
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
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
+        gcc-m68k-linux-gnu \
+        libc6-dev-m68k-cross
diff --git a/tests/tcg/m68k/Makefile.include b/tests/tcg/m68k/Makefile.include
new file mode 100644
index 0000000000..cd7c6bf50d
--- /dev/null
+++ b/tests/tcg/m68k/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-m68k-cross
+DOCKER_CROSS_COMPILER=m68k-linux-gnu-gcc
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
new file mode 100644
index 0000000000..62f109eef4
--- /dev/null
+++ b/tests/tcg/m68k/Makefile.target
@@ -0,0 +1,7 @@
+# -*- Mode: makefile -*-
+#
+# m68k specific tweaks - specifically masking out broken tests
+#
+
+# On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
+EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
-- 
2.17.1
