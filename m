Received: from eggs.gnu.org ([2001:4830:134:3::10]:56231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss2-0005ox-MN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss1-00057C-G2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:26 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss1-00056Y-BW
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:25 -0400
Received: by mail-qt0-x244.google.com with SMTP id w12so39138qta.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:22 -0300
Message-Id: <20170622033231.19344-13-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/21] travis: build using all available
 cores
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

Few improvement as of today, but if Travis release their limit on the opensource
plan or upgrade their hardware, new builds will get some benefit.

Restrict to as most 4 cores to respect Travis Open Source plan.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 777914f759..a7512f3ab0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -62,7 +62,14 @@ notifications:
     on_failure: always
 env:
   global:
-    - TEST_CMD="make check"
+    # jobs
+      # detects cores on the hosting hardware, rather than the VM (https://docs.travis-ci.com/user/languages/c#hints)
+    - VM_CORES="4" HW_CORES="$(getconf _NPROCESSORS_ONLN)"
+      # be kind with Travis free plan, restrict to at most 4 cores
+    - PARALLEL_JOBS="$(($(test ${HW_CORES} -gt ${VM_CORES} && echo ${VM_CORES} || echo ${HW_CORES}) + 1))"
+    - HOMEBREW_MAKE_JOBS="${PARALLEL_JOBS}"
+    # tests
+    - TEST_CMD="make -j${PARALLEL_JOBS} check"
   matrix:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
@@ -78,9 +85,11 @@ before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
   - git submodule update --init --recursive
 before_script:
+  - echo "Using ${PARALLEL_JOBS} parallel jobs"
   - ./configure ${CONFIG}
 script:
-  - make -j3 && ${TEST_CMD}
+  - make -j${PARALLEL_JOBS}
+  - ${TEST_CMD}
 matrix:
   include:
     # Test with CLang for compile portability
@@ -234,7 +243,7 @@ matrix:
       group: edge
       env:
         - COVERITY=1
-        - COVERITY_BUILD_CMD="make -j3"
+        - COVERITY_BUILD_CMD="make -j${PARALLEL_JOBS}"
         - COVERITY_EMAIL=peter.maydell@linaro.org
         # This 'secure' setting sets COVERITY_TOKEN=<secret token>
         # and was created with travis encrypt -r qemu/qemu COVERITY_TOKEN=...
-- 
2.11.0
