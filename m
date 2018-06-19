Received: from eggs.gnu.org ([2001:4830:134:3::10]:39282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvc-0004Mx-G0
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvL-0001wg-Re
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:20 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:52954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvL-0001vl-Fx
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:03 -0400
Received: by mail-wm0-x22f.google.com with SMTP id p126-v6so1223244wmb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:52:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:14 +0100
Message-Id: <20180619154435.18898-36-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/56] tests/tcg: enable building for HPPA
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v5
  - add EXTRA_RUNS for mmap tests

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8c24f8807e..65e3dee741 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,6 +71,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
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
