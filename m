Received: from eggs.gnu.org ([2001:4830:134:3::10]:48495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZq-00063v-TT
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZp-0002F4-Qq
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:38 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZp-0002Ev-My
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:37 -0400
Received: by mail-qk0-x243.google.com with SMTP id a77so6728248qkb.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:04 -0300
Message-Id: <20170809202712.6951-9-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 08/16] travis: reorder matrix to
 speedup failure
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e56c928bef..57462b0471 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -64,11 +64,11 @@ env:
     - MAKEFLAGS="-j3"
   matrix:
     - CONFIG=""
-    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
     - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
     - CONFIG="--enable-modules"
     - CONFIG="--with-coroutine=ucontext"
     - CONFIG="--with-coroutine=sigaltstack"
+    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
 git:
   # we want to do this ourselves
   submodules: false
@@ -83,30 +83,32 @@ script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
   include:
+    # We manually include builds which we disable "make check" for, they also
+    # are the faster jobs (no testing).
+    - env: CONFIG="--disable-tcg"
+           TEST_CMD=""
+      compiler: gcc
+    - env: CONFIG="--enable-trace-backends=ust"
+           TEST_CMD=""
+      compiler: gcc
+    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
+           TEST_CMD=""
+      compiler: gcc
+    - env: CONFIG="--enable-trace-backends=simple"
+           TEST_CMD=""
+      compiler: gcc
+    - env: CONFIG="--enable-trace-backends=ftrace"
+           TEST_CMD=""
+      compiler: gcc
     # Test with CLang for compile portability
     - env: CONFIG=""
       compiler: clang
+
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --disable-pie"
       compiler: gcc
     - env: CONFIG="--enable-gcov --disable-pie"
       compiler: gcc
-    # We manually include builds which we disable "make check" for
-    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-           TEST_CMD=""
-      compiler: gcc
-    - env: CONFIG="--enable-trace-backends=simple"
-           TEST_CMD=""
-      compiler: gcc
-    - env: CONFIG="--enable-trace-backends=ftrace"
-           TEST_CMD=""
-      compiler: gcc
-    - env: CONFIG="--enable-trace-backends=ust"
-           TEST_CMD=""
-      compiler: gcc
-    - env: CONFIG="--disable-tcg"
-           TEST_CMD=""
-      compiler: gcc
     - env: CONFIG=""
       os: osx
       compiler: clang
-- 
2.13.3
