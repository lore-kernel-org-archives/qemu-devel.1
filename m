Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0U-0007do-Kh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0T-0003EK-OO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:34 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0T-0003Ds-ID
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:33 -0400
Received: by mail-wr0-x233.google.com with SMTP id y43so23113825wrd.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:33 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:53 +0100
Message-Id: <20170718104513.23947-13-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/32] docker: add debian/amd64 based on Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

By itself this doesn't add much to our coverage. However later patches
will extend this image to include more bleeding edge libraries which
are not yet widely available in distros.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: extend commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 553465ef6d..b5eec5dc68 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -56,6 +56,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"BUILD","$*")
 
 # Enforce dependancies for composite images
+docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
new file mode 100644
index 0000000000..2ab76120a4
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -0,0 +1,18 @@
+#
+# Docker x86_64 target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy qemu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev \
+        liblzo2-dev \
+        librdmacm-dev \
+        libsnappy-dev \
+        libvte-dev
-- 
2.13.0
