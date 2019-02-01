Received: from eggs.gnu.org ([209.51.188.92]:49118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcMy-00049c-AS
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcMs-00007W-S6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpcMq-000053-V8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:12:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id g67so6962910wmd.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:12:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Feb 2019 17:12:29 +0000
Message-Id: <20190201171229.3361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] .travis.yml: separate tools and docs into
 another entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Re-building the tools and documents by default is a little wasteful as
they are not really affected by the main build options. Split tools
and documents into their own task with a minimal softmmu and
linux-user target list just to check they don't interact badly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 87d9fa971c..1c8effcf63 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,6 +61,7 @@ env:
   global:
     - SRC_DIR="."
     - BUILD_DIR="."
+    - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_CMD="make check -j3 V=1"
 
 
@@ -71,7 +72,7 @@ git:
 
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
+  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && ${TEST_CMD}
 
@@ -106,6 +107,15 @@ matrix:
         - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
 
 
+    # Check we can build docs and tools
+    - env:
+        - BASE_CONFIG=""
+        - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
+      addons:
+        apt:
+          packages:
+            - python-sphinx
+
     # Test out-of-tree builds
     - env:
         - CONFIG="--enable-debug --enable-debug-tcg"
@@ -243,5 +253,5 @@ matrix:
 
 
     - env:
-        - CONFIG="--disable-system --disable-docs"
+        - CONFIG="--disable-system"
         - TEST_CMD="make -j3 check-tcg V=1"
-- 
2.20.1
