Received: from eggs.gnu.org ([209.51.188.92]:50513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHA-00075X-Tz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBGw-0003pX-Hf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBGs-0003kL-Km
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t18so269388wrx.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:12 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:04:52 +0000
Message-Id: <20190211130507.8710-4-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/18] .travis.yml: separate tools and docs into
 another entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Re-building the tools and documents by default is a little wasteful as
they are not really affected by the main build options. Split tools
and documents into their own task with a minimal softmmu and
linux-user target list just to check they don't interact badly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index beea941408..652be702ac 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -59,6 +59,7 @@ env:
   global:
     - SRC_DIR="."
     - BUILD_DIR="."
+    - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_CMD="make check -j3 V=1"
 
 
@@ -69,7 +70,7 @@ git:
 
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
+  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && ${TEST_CMD}
 
@@ -104,6 +105,17 @@ matrix:
         - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
 
 
+    # Check we can build docs and tools
+    - env:
+        - BASE_CONFIG="--enable-tools --enable-docs"
+        - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
+      addons:
+        apt:
+          packages:
+            - python-sphinx
+            - texinfo
+            - perl
+
     # Test out-of-tree builds
     - env:
         - CONFIG="--enable-debug --enable-debug-tcg"
@@ -241,5 +253,5 @@ matrix:
 
 
     - env:
-        - CONFIG="--disable-system --disable-docs"
+        - CONFIG="--disable-system"
         - TEST_CMD="make -j3 check-tcg V=1"
-- 
2.20.1
