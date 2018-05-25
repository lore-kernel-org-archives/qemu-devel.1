Received: from eggs.gnu.org ([2001:4830:134:3::10]:44407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDZ0-00014n-O6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDYz-0000Sy-Gh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:26 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDYz-0000SA-7t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:25 -0400
Received: by mail-wm0-x236.google.com with SMTP id m129-v6so15023203wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:19:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:06 +0100
Message-Id: <20180525141910.6384-6-alex.bennee@linaro.org>
In-Reply-To: <20180525141910.6384-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141910.6384-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 35/49] tests/tcg: enable building for Alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

We can't use our normal Debian based compilers as Alpha isn't an
officially supported architecture. However it is available as a port
and fortunately cross compilers for all these targets are included in
Debian Sid, the perpetual rolling/unstable/testing version of Debian.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v5
  - drop the unused debian-cross-build docker image
  - add note to debian-sid docker image
  - echo reference to notes on build failure
  - include EXTRA_RUNS for mmap tests
---
 tests/docker/Makefile.include                 |  1 +
 .../dockerfiles/debian-alpha-cross.docker     | 12 +++++++
 tests/docker/dockerfiles/debian-sid.docker    | 32 +++++++++++++++++++
 tests/tcg/alpha/Makefile.include              |  2 ++
 tests/tcg/alpha/Makefile.target               |  6 ++++
 5 files changed, 53 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sid.docker
 create mode 100644 tests/tcg/alpha/Makefile.include
 create mode 100644 tests/tcg/alpha/Makefile.target

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b56386f49e..5dc49c6a54 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,6 +62,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
new file mode 100644
index 0000000000..29a25d0dfd
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
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
+        gcc-alpha-linux-gnu \
+        libc6.1-dev-alpha-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
new file mode 100644
index 0000000000..9a3d168705
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -0,0 +1,32 @@
+#
+# Debian Sid Base
+#
+# A number of our guests exist as ports only. We can either use the
+# ports repo or get everything from Sid. However Sid is a rolling
+# distro which may be broken at any particular time. If you are
+# unlucky and try and build your images while gcc is in the process of
+# being uploaded this can fail. Your only recourse is to try again in
+# a few hours when the repos have re-synced. Once built however you
+# won't be affected by repo changes unless the docker recipies are
+# updated and trigger a re-build.
+#
+
+FROM debian:sid-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt update
+RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        flex \
+        git \
+        pkg-config \
+        psmisc \
+        python \
+        texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
diff --git a/tests/tcg/alpha/Makefile.include b/tests/tcg/alpha/Makefile.include
new file mode 100644
index 0000000000..c7dc48eadb
--- /dev/null
+++ b/tests/tcg/alpha/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-alpha-cross
+DOCKER_CROSS_COMPILER=alpha-linux-gnu-gcc
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
new file mode 100644
index 0000000000..bedf1b6444
--- /dev/null
+++ b/tests/tcg/alpha/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# Alpha specific tweaks
+
+# On Alpha Linux only supports 8k pages
+EXTRA_RUNS+=run-test-mmap-8192
-- 
2.17.0
