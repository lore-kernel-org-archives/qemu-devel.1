Received: from eggs.gnu.org ([2001:4830:134:3::10]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akF-0003PT-QL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akE-0007pB-PK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:03 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akE-0007p4-Lf
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:02 -0400
Received: by mail-qk0-x243.google.com with SMTP id u75so8660744qka.1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:58:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:56:56 -0300
Message-Id: <20170508045715.21770-5-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/23] docker: compact debian base
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

- install common/basic tools at once
- one-line Emdebian setup
- use eatmydata and remove apt cache to save space
- add bison and flex and git

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian.docker | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 52bd79938e..694f8d3b63 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -9,17 +9,19 @@
 #
 FROM debian:stable-slim
 
-# Setup some basic tools we need
-RUN apt update
-RUN apt install -yy curl aptitude
-
-# Setup Emdebian
-RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
-RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
+# Install some basic tools and common build utilities
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
+        eatmydata && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        curl aptitude \
+        build-essential clang git \
+        bison flex && \
+    rm -rf /var/lib/apt
 
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
 
-# Install common build utilities
-RUN apt update
-RUN apt install -yy build-essential clang
+# Setup Emdebian
+RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
+    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-- 
2.11.0
