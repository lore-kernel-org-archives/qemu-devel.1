Received: from eggs.gnu.org ([2001:4830:134:3::10]:53145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVG-0000v7-4Y
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESx-0004Ll-Hh
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:10 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESx-0004Kx-5M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:47 -0400
Received: by mail-wr0-x235.google.com with SMTP id 94-v6so3030849wrf.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:41 +0100
Message-Id: <20180605160541.10664-7-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/6] docker: add debian/tricore image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

TriCore binutils is built from Bastian Koppelmann repository.

Note: There is no TriCore compiler in this image (only assembler/linker).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: base of Debian9, add to Makefile.include]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 9d5749887a..74fd51c22c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -63,6 +63,9 @@ docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-travis: NOUSER=1
 
+# Specialist build images, sometimes very limited tools
+docker-image-tricore-cross: docker-image-debian9
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
new file mode 100644
index 0000000000..898b8dd511
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -0,0 +1,23 @@
+#
+# Docker TriCore cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+# Copyright (c) 2018 Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM debian:9
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN git clone --single-branch \
+        https://github.com/bkoppelmann/tricore-binutils.git \
+        /usr/src/binutils && \
+    cd /usr/src/binutils && chmod +x missing && \
+    CFLAGS=-w ./configure --prefix=/usr --disable-nls --target=tricore && \
+    make && make install && \
+    rm -rf /usr/src/binutils
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=tricore-
-- 
2.17.0
