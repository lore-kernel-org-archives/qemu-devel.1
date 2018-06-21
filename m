Received: from eggs.gnu.org ([2001:4830:134:3::10]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8T-0005ij-1y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8R-0003mr-Um
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:01 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:45632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8R-0003ls-O0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:59 -0400
Received: by mail-wr0-x232.google.com with SMTP id o12-v6so1810005wrm.12
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:31:59 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:47 +0100
Message-Id: <20180621062605.941-40-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 39/57] tests/tcg: enable building for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a2dd307a8e..fb465e729e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -74,6 +74,7 @@ docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
+docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles/debian-sparc64-cross.docker
new file mode 100644
index 0000000000..1e2c809274
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-sparc64-cross.docker
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
+        gcc-sparc64-linux-gnu \
+        libc6-dev-sparc64-cross
diff --git a/tests/tcg/sparc64/Makefile.include b/tests/tcg/sparc64/Makefile.include
new file mode 100644
index 0000000000..95fc8dee9f
--- /dev/null
+++ b/tests/tcg/sparc64/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-sparc64-cross
+DOCKER_CROSS_COMPILER=sparc64-linux-gnu-gcc
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
new file mode 100644
index 0000000000..408dace783
--- /dev/null
+++ b/tests/tcg/sparc64/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# sparc specific tweaks
+
+# On Sparc64 Linux support 8k pages
+EXTRA_RUNS+=run-test-mmap-8192
-- 
2.17.1
