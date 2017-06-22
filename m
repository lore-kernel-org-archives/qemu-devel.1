Received: from eggs.gnu.org ([2001:4830:134:3::10]:56243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss4-0005yT-RA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss3-0005AV-Pl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:28 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss3-0005AQ-L0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:27 -0400
Received: by mail-qk0-x244.google.com with SMTP id d14so612224qkb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:23 -0300
Message-Id: <20170622033231.19344-14-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/21] travis: improve ccache use
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a7512f3ab0..96ddc16cfd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -68,6 +68,8 @@ env:
       # be kind with Travis free plan, restrict to at most 4 cores
     - PARALLEL_JOBS="$(($(test ${HW_CORES} -gt ${VM_CORES} && echo ${VM_CORES} || echo ${HW_CORES}) + 1))"
     - HOMEBREW_MAKE_JOBS="${PARALLEL_JOBS}"
+    # ccache
+    - CCACHE_SLOPPINESS="file_macro,time_macros"
     # tests
     - TEST_CMD="make -j${PARALLEL_JOBS} check"
   matrix:
@@ -82,14 +84,21 @@ git:
   submodules: false
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
+  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
   - git submodule update --init --recursive
 before_script:
+  # https://docs.travis-ci.com/user/caching#ccache-on-os-x
+  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then export PATH=/usr/local/opt/ccache/libexec:$PATH ; fi
+  - if [ "$CC" == "clang" ]; then export CCACHE_CPP2=1 ; fi
+  - if [ -x "$(command -v ccache 2>/dev/null)" ]; then export CC="ccache ${CC}"; ccache -s -M 0 -z; fi
   - echo "Using ${PARALLEL_JOBS} parallel jobs"
+  - export HOST_CC="${CC}"
   - ./configure ${CONFIG}
 script:
-  - make -j${PARALLEL_JOBS}
+  - make -j${PARALLEL_JOBS} && ccache -s
   - ${TEST_CMD}
+before_cache:
+  - ccache -s
 matrix:
   include:
     # Test with CLang for compile portability
@@ -112,6 +121,7 @@ matrix:
            TEST_CMD=""
       compiler: gcc
     - env: CONFIG=""
+           CCACHE_SLOPPINESS="file_macro,time_macros,include_file_ctime,include_file_mtime"
       os: osx
       compiler: clang
     # Plain Trusty System Build
-- 
2.11.0
