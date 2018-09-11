Received: from eggs.gnu.org ([2001:4830:134:3::10]:55776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJP-0008Qk-JU
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJL-0007Vg-3O
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzjJK-0007UJ-P8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id g33-v6so26246361wrd.1
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:06:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Sep 2018 15:06:28 +0100
Message-Id: <20180911140631.18481-2-alex.bennee@linaro.org>
In-Reply-To: <20180911140631.18481-1-alex.bennee@linaro.org>
References: <20180911140631.18481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  1/4] docker: add debian-buildroot-base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We can build some more cross-compilers using buildroot. This base
system contains simply the minimum number of tools required for
buildroot to work. We also download and unpack the buildroot source
tree as that will be common for all system deriving from it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-buildroot-base.docker  | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-buildroot-base.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index d3101afecd..74a82de48a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian8-mxe debian-ports debian-sid debian-bootstrap
+DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian8-mxe debian-ports debian-sid debian-bootstrap debian-buildroot-base
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
diff --git a/tests/docker/dockerfiles/debian-buildroot-base.docker b/tests/docker/dockerfiles/debian-buildroot-base.docker
new file mode 100644
index 0000000000..c4a29abadd
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-buildroot-base.docker
@@ -0,0 +1,26 @@
+#
+# Buildroot base setup on Debian
+#
+
+FROM debian:stretch-slim
+ENV BUILDROOT_VERSION=2018.08
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y bc \
+                   build-essential \
+                   cpio \
+                   file \
+                   python \
+                   unzip \
+                   rsync \
+                   wget
+
+# Grab the current buildroot version and unpack in /opt
+RUN mkdir -p /opt
+RUN cd /opt && wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz
+RUN cd /opt && tar -xvf buildroot-${BUILDROOT_VERSION}.tar.gz
-- 
2.17.1
