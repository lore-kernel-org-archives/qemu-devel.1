Received: from eggs.gnu.org ([2001:4830:134:3::10]:37468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AV-0004Xf-FM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AU-0005Kw-NM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AU-0005Ki-Gy
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:54 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r144so212046853wme.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:45 +0000
Message-Id: <20170124143346.22240-7-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/7] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

Ostensibly Shippable offers a similar set of services as Travis.
However they are focused on Container based work-flows so we can use
our existing containers to run a few extra builds - in this case a
bunch of cross-compiled targets on a Debian multiarch system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 24 ++++++++++++++++++++++++
 MAINTAINERS    |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 .shippable.yml

diff --git a/.shippable.yml b/.shippable.yml
new file mode 100644
index 0000000000..10496acb7c
--- /dev/null
+++ b/.shippable.yml
@@ -0,0 +1,24 @@
+language: c
+env:
+  matrix:
+    - CROSS_ARCH=armhf   CROSS_PREFIX=arm-linux-gnueabihf-
+    - CROSS_ARCH=arm64   CROSS_PREFIX=aarch64-linux-gnu-
+    - CROSS_ARCH=mipsel  CROSS_PREFIX=mipsel-linux-gnu-
+    - CROSS_ARCH=ppc64el CROSS_PREFIX=powerpc64le-linux-gnu-
+build:
+  pre_ci:
+    - mkdir -p docker-build
+    - cp ./tests/docker/dockerfiles/debian-multiarch-cross.docker docker-build/Dockerfile
+    - docker build -t debian-multiarch-cross:base docker-build
+    - echo -e "FROM debian-multiarch-cross:base\nRUN apt-get build-dep -a ${CROSS_ARCH} -qq qemu" | docker build -t debian-multiarch-cross:${CROSS_ARCH} -
+  pre_ci_boot:
+    image_name: debian-multiarch-cross
+    image_tag: ${CROSS_ARCH}
+    pull: false
+    options: "-e HOME=/root"
+  ci:
+    - env
+    - apt-get build-dep -a ${CROSS_ARCH} -qq qemu
+    - unset CC
+    - ./configure --cross-prefix=${CROSS_PREFIX}
+    - make -j2
diff --git a/MAINTAINERS b/MAINTAINERS
index ad1000415d..5e7d1a7548 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1784,6 +1784,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 L: qemu-devel@nongnu.org
 S: Supported
 F: .travis.yml
+F: .shippable.yml
 
 Documentation
 -------------
-- 
2.11.0
