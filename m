Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpP-0002sN-Jq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpO-00046b-Ge
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:23 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:37035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPqpO-00045o-8b
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:22 -0400
Received: by mail-wr0-x22c.google.com with SMTP id d8-v6so13088013wro.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:51:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  4 Jun 2018 15:51:09 +0100
Message-Id: <20180604145109.30498-8-alex.bennee@linaro.org>
In-Reply-To: <20180604145109.30498-1-alex.bennee@linaro.org>
References: <20180604145109.30498-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 7/7] docker: add debian/tricore image
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

TriCore binutils is built from Bastian Koppelmann repository.

Note: There is no TriCore compiler in this image (only assembler/linker).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: base of Debian9, add to Makefile.include]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                 |  3 +++
 .../dockerfiles/debian-tricore-cross.docker   | 23 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ef1a3e62eb..f0aeb76a58 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,6 +62,9 @@ docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-travis: NOUSER=1
 
+# Specialist build images, sometimes very limited tools
+docker-image-tricore-cross: docker-image-debian9
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
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
