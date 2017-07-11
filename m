Received: from eggs.gnu.org ([2001:4830:134:3::10]:54070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUla7-0001hH-O7
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUla3-0004X1-22
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:23 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUla2-0004Wj-TZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id c20so15134239qte.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:45 -0300
Message-Id: <20170711031000.24844-4-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 03/18] docker: debian/s390x no more in
 unstable, now available in Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 01d7af9698..1eb32eebfa 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -59,6 +59,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
+docker-image-debian-s390x-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index cfc354ce5d..18fe813aa7 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,27 +1,27 @@
 #
 # Docker s390 cross-compiler target
 #
-# This docker target is based on stretch (testing) as the stable build
-# doesn't have the cross compiler available.
+# This docker target builds on the debian Stretch base image.
 #
-FROM debian:testing-slim
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
+FROM qemu:debian9
 
 # Add the s390x architecture
 RUN dpkg --add-architecture s390x
 
 # Grab the updated list of packages
 RUN apt update && apt dist-upgrade -yy
-RUN apt install -yy build-essential clang
-RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
-RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        binutils-multiarch \
+        gcc-multilib-s390x-linux-gnu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a s390x qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 
-RUN DEBIAN_FRONTEND=noninteractive \
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         glusterfs-common:s390x \
         libbz2-dev:s390x \
-- 
2.13.2
