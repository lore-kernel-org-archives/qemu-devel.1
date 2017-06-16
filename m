Received: from eggs.gnu.org ([2001:4830:134:3::10]:55448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsn-00048h-BN
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsl-0002gw-Mj
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:01 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsl-0002gk-If
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:59 -0400
Received: by mail-qt0-x22c.google.com with SMTP id c10so69221555qtd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:13:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:26 -0300
Message-Id: <20170616161334.7492-4-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/11] travis: use yes/no variable to
 enable/disable tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

having the command to run in the variable make scripts harder to manage.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

using 0/1 or no/yes is pretty much the same.

 .travis.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b2c69fdd59..c9ac741afc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,7 +46,7 @@ notifications:
 env:
   global:
     - PARALLEL_JOBS="$(($(getconf _NPROCESSORS_ONLN) + 1))"
-    - TEST_CMD="make check"
+    - RUN_TESTS="yes"
   matrix:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
@@ -66,7 +66,7 @@ before_script:
   - ./configure ${CONFIG}
 script:
   - make -j${PARALLEL_JOBS}
-  - test -z "${TEST_CMD}" || ${TEST_CMD}
+  - if [ "${RUN_TESTS}" == "yes" ]; then make check; fi
 matrix:
   include:
     # Test with CLang for compile portability
@@ -77,16 +77,16 @@ matrix:
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-           TEST_CMD=""
+           RUN_TESTS="no"
       compiler: gcc
     - env: CONFIG="--enable-trace-backends=simple"
-           TEST_CMD=""
+           RUN_TESTS="no"
       compiler: gcc
     - env: CONFIG="--enable-trace-backends=ftrace"
-           TEST_CMD=""
+           RUN_TESTS="no"
       compiler: gcc
     - env: CONFIG="--enable-trace-backends=ust"
-           TEST_CMD=""
+           RUN_TESTS="no"
       compiler: gcc
     - env: CONFIG=""
       os: osx
@@ -191,6 +191,6 @@ matrix:
       env:
         - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
         - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
-        - TEST_CMD=""
+        - RUN_TESTS="no"
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
-- 
2.11.0
