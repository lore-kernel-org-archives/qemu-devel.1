Received: from eggs.gnu.org ([209.51.188.92]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOh-0004lj-9I
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008SR-20
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:39 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOf-0007oU-Pl
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: by mail-wm1-x344.google.com with SMTP id f188so12873117wmf.5
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:09 +0000
Message-Id: <20190110174516.21586-13-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 12/19] travis: stop redefining the script
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

One of the matrix entries redefines the script command in order to add
the ${MAKEFLAGS} variable. Ideally ${MAKEFLAGS} would be referenced by
the definition of the ${TEST_CMD} env variable, but this isn't possible
in travis. ${MAKEFLAGS} exists to eliminate duplication of flags in
every "make" command, but this cure causes a worse problem, namely the
reduplication of the "script" command. It is simpler to just insert "-j3"
directly into any "make" command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 2ef7997d25..7b18d33e9d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -65,8 +65,7 @@ env:
   global:
     - SRC_DIR="."
     - BUILD_DIR="."
-    - TEST_CMD="make check"
-    - MAKEFLAGS="-j3"
+    - TEST_CMD="make check -j3"
 
 
 git:
@@ -78,7 +77,7 @@ before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
 script:
-  - make ${MAKEFLAGS} && ${TEST_CMD}
+  - make -j3 && ${TEST_CMD}
 
 
 matrix:
@@ -255,9 +254,7 @@ matrix:
 
     - env:
         - CONFIG="--disable-system --disable-docs"
-        - TEST_CMD="make check-tcg"
-      script:
-        - make ${MAKEFLAGS} && ${TEST_CMD} ${MAKEFLAGS}
+        - TEST_CMD="make -j3 check-tcg"
       sudo: required
       dist: trusty
       compiler: gcc
-- 
2.17.1
