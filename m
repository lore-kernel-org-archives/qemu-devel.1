Received: from eggs.gnu.org ([2001:4830:134:3::10]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfj-0005mn-Ij
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfe-0000th-O7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:15 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGfe-0000tH-Ge
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:10 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r125-v6so3449089wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:39:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:32:51 +0100
Message-Id: <20180608123307.24773-34-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 33/49] tests/tcg: enable building for HPPA
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v5
  - add EXTRA_RUNS for mmap tests
---
 tests/docker/Makefile.include                     |  1 +
 tests/docker/dockerfiles/debian-hppa-cross.docker | 12 ++++++++++++
 tests/tcg/hppa/Makefile.include                   |  2 ++
 tests/tcg/hppa/Makefile.target                    |  6 ++++++
 4 files changed, 21 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/tcg/hppa/Makefile.include
 create mode 100644 tests/tcg/hppa/Makefile.target

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 1a4664c04e..a83e979e6d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -70,6 +70,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-debian-sid: NOCACHE=1
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
+docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles/debian-hppa-cross.docker
new file mode 100644
index 0000000000..ad443defac
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
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
+        gcc-hppa-linux-gnu \
+        libc6-dev-hppa-cross
diff --git a/tests/tcg/hppa/Makefile.include b/tests/tcg/hppa/Makefile.include
new file mode 100644
index 0000000000..da2353430e
--- /dev/null
+++ b/tests/tcg/hppa/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-hppa-cross
+DOCKER_CROSS_COMPILER=hppa-linux-gnu-gcc
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
new file mode 100644
index 0000000000..8bf01966bd
--- /dev/null
+++ b/tests/tcg/hppa/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# HPPA specific tweaks - specifically masking out broken tests
+
+# On parisc Linux supports 4K/16K/64K (but currently only 4k works)
+EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-16384 run-test-mmap-65536
-- 
2.17.1
