Received: from eggs.gnu.org ([2001:4830:134:3::10]:37353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywb-0008P1-FM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywa-0001zQ-17
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:05 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:41243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywZ-0001zB-OQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:03 -0400
Received: by mail-wr0-x234.google.com with SMTP id u12-v6so29062949wrn.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:52 +0100
Message-Id: <20180530110655.22022-6-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/8] .travis.yml: rationalise clang testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As Travis includes Clang 5.0 in its own build environment there is no
point manually building with older Clangs. We still need to test with
the two pythons though so we leave them as system only builds. We also
split the clang build into two as it often exceeds the 40 minute build
time limit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 67 +++++------------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index aa83e9aed7..85ee2a1edb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -70,8 +70,10 @@ script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
   include:
-    # Test with CLang for compile portability
-    - env: CONFIG=""
+    # Test with Clang for compile portability (Travis uses clang-5.0)
+    - env: CONFIG="--disable-system"
+      compiler: clang
+    - env: CONFIG="--disable-user"
       compiler: clang
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
@@ -95,70 +97,13 @@ matrix:
     - env: CONFIG=""
       os: osx
       compiler: clang
-    # Plain Trusty System Build
+    # Python builds
     - env: CONFIG="--disable-linux-user"
-      sudo: required
-      addons:
-      dist: trusty
-      compiler: gcc
-      before_install:
-        - sudo apt-get update -qq
-        - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
-    # Plain Trusty Linux User Build
-    - env: CONFIG="--disable-system"
-      sudo: required
-      addons:
-      dist: trusty
-      compiler: gcc
-      before_install:
-        - sudo apt-get update -qq
-        - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
-    # Trusty System build with latest stable clang & python 3.0
-    - sudo: required
-      addons:
-      dist: trusty
-      language: generic
-      compiler: none
       python:
         - "3.0"
-      env:
-        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
-      before_install:
-        - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
-        - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-        - sudo apt-get update -qq
-        - sudo apt-get install -qq -y clang-3.9
-        - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
-      before_script:
-        - ./configure ${CONFIG} || cat config.log
-    # Trusty Linux User build with latest stable clang & python 3.6
-    - sudo: required
-      addons:
-      dist: trusty
-      language: generic
-      compiler: none
+    - env: CONFIG="--disable-linux-user"
       python:
         - "3.6"
-      env:
-        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
-      before_install:
-        - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
-        - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-        - sudo apt-get update -qq
-        - sudo apt-get install -qq -y clang-3.9
-        - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
-      before_script:
-        - ./configure ${CONFIG} || cat config.log
     # Using newer GCC with sanitizers
     - addons:
         apt:
-- 
2.17.0
