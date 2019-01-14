Received: from eggs.gnu.org ([209.51.188.92]:35418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kC-0006Go-NV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kB-0005L6-U8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3kB-0005KZ-Nj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id v13so23223283wrw.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:20 +0000
Message-Id: <20190114150129.1013-13-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/21] travis: stop redefining the script
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
