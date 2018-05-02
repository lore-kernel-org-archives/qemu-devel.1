Received: from eggs.gnu.org ([2001:4830:134:3::10]:35197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfXO-0004mR-IF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfXL-00007L-Cw
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:22:26 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:43726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfXL-00007A-6x
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:22:23 -0400
Received: by mail-vk0-x243.google.com with SMTP id v134-v6so7930999vkd.10
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 17:22:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  1 May 2018 21:21:43 -0300
Message-Id: <20180502002143.30624-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] docker: add debian/tricore image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

TriCore binutils is built from Bastian Koppelmann repository.

Note: There is no TriCore compiler in this image (only assembler/linker).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
See http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00074.html

$ docker images --format "{{.Repository}}:{{.Tag}} {{.Size}}"
qemu:debian-tricore-cross 323MB

 .../dockerfiles/debian-tricore-cross.docker   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
new file mode 100644
index 0000000000..f71ac3eb47
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -0,0 +1,35 @@
+#
+# Docker TriCore cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+# Copyright (c) 2018 Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM debian:stretch-slim
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Install common build utilities
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        automake \
+        bison \
+        build-essential \
+        ca-certificates \
+        flex \
+        git
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
