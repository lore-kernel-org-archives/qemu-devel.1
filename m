Received: from eggs.gnu.org ([2001:4830:134:3::10]:37170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7alr-0004m4-00
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7alp-00084w-Ql
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:59:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:57:11 -0300
Message-Id: <20170508045715.21770-20-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/23] docker: add powerpc build target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  1 +
 .../docker/dockerfiles/debian-powerpc-cross.docker | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ca6f57a292..704b74bfbd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -61,6 +61,7 @@ docker-image-debian: EXTRA_FILE:=tests/docker/dockerfiles/debian-apt-fake.sh
 docker-image-debian-armhf-cross: docker-image-debian
 docker-image-debian-arm64-cross: docker-image-debian
 docker-image-debian-mipsel-cross: docker-image-debian
+docker-image-debian-powerpc-cross: docker-image-debian
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
new file mode 100644
index 0000000000..9107ebc2d3
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -0,0 +1,23 @@
+#
+# Docker powerpc cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture powerpc && \
+    apt-get update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        crossbuild-essential-powerpc
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata apt-get build-dep -yy -a powerpc qemu && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
+        glusterfs-common:powerpc \
+        libncursesw5-dev:powerpc libnfs-dev:powerpc \
+        libbz2-dev:powerpc liblzo2-dev:powerpc \
+        libsnappy-dev:powerpc librdmacm-dev:powerpc
-- 
2.11.0
