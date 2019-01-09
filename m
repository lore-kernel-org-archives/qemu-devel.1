Received: from eggs.gnu.org ([209.51.188.92]:45831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlm-0002HH-L8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlk-0001K9-RS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlk-0001Ec-Kz
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:52 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:11 +0000
Message-Id: <20190109163114.17010-11-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/13] travis: stop redefining the script
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

One of the matrix entries redefines the script command in order to add
the ${MAKEFLAGS} variable. Ideally ${MAKEFLAGS} would be referenced by
the definition of the ${TEST_CMD} env variable, but this isn't possible
in travis. ${MAKEFLAGS} exists to eliminate duplication of flags in
every "make" command, but this cure causes a worse problem, namely the
reduplication of the "script" command. It is simpler to just insert "-j3"
directly into any "make" command.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b5f520034f..ddfef6d738 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -59,8 +59,7 @@ env:
   global:
     - SRC_DIR=3D"."
     - BUILD_DIR=3D"."
-    - TEST_CMD=3D"make check"
-    - MAKEFLAGS=3D"-j3"
+    - TEST_CMD=3D"make check -j3"
=20
=20
 git:
@@ -72,7 +71,7 @@ before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
 script:
-  - make ${MAKEFLAGS} && ${TEST_CMD}
+  - make -j3 && ${TEST_CMD}
=20
=20
 matrix:
@@ -253,9 +252,7 @@ matrix:
=20
     - env:
         - CONFIG=3D"--disable-system --disable-docs"
-        - TEST_CMD=3D"make check-tcg"
-      script:
-        - make ${MAKEFLAGS} && ${TEST_CMD} ${MAKEFLAGS}
+        - TEST_CMD=3D"make -j3 check-tcg"
       sudo: required
       dist: trusty
       compiler: gcc
--=20
2.19.2
