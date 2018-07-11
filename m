Received: from eggs.gnu.org ([2001:4830:134:3::10]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6ph-00057b-VF
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6ph-0005oJ-3O
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:29 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:43668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pg-0005o9-Un
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:29 -0400
Received: by mail-qt0-x241.google.com with SMTP id f18-v6so20325436qtp.10
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 21:34:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 11 Jul 2018 01:34:16 -0300
Message-Id: <20180711043417.24097-2-f4bug@amsat.org>
In-Reply-To: <20180711043417.24097-1-f4bug@amsat.org>
References: <20180711043417.24097-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-3.1 1/2] docker: Fix TriCore binutils
 build
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

- Use recent 'missing' from libtool,
- Fix 'ylwrap' permissions

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Shippable runs 'clang --version'.

 .../dockerfiles/debian-tricore-cross.docker   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 898b8dd511..f833a6ca16 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,16 +7,33 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM debian:9
+FROM debian:9-slim
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
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
+        git \
+        libtool && \
+    ln -s /usr/bin/cc /usr/bin/clang && \
+    ln -s /usr/bin/gcc /usr/bin/tricore-gcc
+
 RUN git clone --single-branch \
         https://github.com/bkoppelmann/tricore-binutils.git \
         /usr/src/binutils && \
-    cd /usr/src/binutils && chmod +x missing && \
+    cd /usr/src/binutils && \
+    cp /usr/share/libtool/build-aux/missing . && \
+    chmod +x ylwrap binutils/ylwrap && \
     CFLAGS=-w ./configure --prefix=/usr --disable-nls --target=tricore && \
-    make && make install && \
+    make all install && \
     rm -rf /usr/src/binutils
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
-- 
2.18.0
