Received: from eggs.gnu.org ([2001:4830:134:3::10]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyO-0000i2-Tp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyN-0007uV-Tk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:28 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyN-0007tx-CO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:27 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 69-v6so5779276wmf.3
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:49 +0100
Message-Id: <20180615194705.28019-39-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 38/54] tests/tcg: enable building for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v5
   - add Makefile with EXTRA_RUNS for mmap tests
---
 tests/docker/Makefile.include                        |  1 +
 tests/docker/dockerfiles/debian-sparc64-cross.docker | 12 ++++++++++++
 tests/tcg/sparc64/Makefile.include                   |  2 ++
 tests/tcg/sparc64/Makefile.target                    |  6 ++++++
 4 files changed, 21 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
 create mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/sparc64/Makefile.target

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
