Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nk-00083n-Iu
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nh-0006KU-By
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:40 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Nh-0006J0-4E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:37 -0400
Received: by mail-wr0-x22a.google.com with SMTP id f16-v6so9979666wrm.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:13 +0100
Message-Id: <20180629205232.27190-3-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/21] travis: test out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Force one config to build 'out-of-tree' (object files and executables
are created in a tree outside the project source code).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 134d5331fe..32188d51f1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -50,6 +50,8 @@ notifications:
     on_failure: always
 env:
   global:
+    - SRC_DIR="."
+    - BUILD_DIR="."
     - TEST_CMD="make check"
     - MAKEFLAGS="-j3"
   matrix:
@@ -68,11 +70,15 @@ before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
   - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
-  - ./configure ${CONFIG} || { cat config.log && exit 1; }
+  - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
   include:
+    # Test out-of-tree builds
+    - env: CONFIG="--enable-debug --enable-debug-tcg"
+           BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - env: CONFIG="--disable-system"
       compiler: clang
-- 
2.17.1
