Received: from eggs.gnu.org ([2001:4830:134:3::10]:51820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVyfv-0007mr-Hy
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVyfp-00022w-5Q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:26:55 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVyfo-00022g-Vu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:26:49 -0400
Received: by mail-qt0-x243.google.com with SMTP id z6-v6so2612765qti.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 05:26:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 09:26:37 -0300
Message-Id: <20180621122638.12113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] travis: Test out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Force one config to build 'out-of-tree' (object files and executables
are created in a tree outside the project source code).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I noticed various out-of-tree issue in the last 2 merge windows.

Pseudo-randomly picked a build from the matrix which covers system + user.

 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..02e096f6a9 100644
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
@@ -69,11 +71,15 @@ before_install:
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - git submodule update --init --recursive
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
2.18.0.rc2
