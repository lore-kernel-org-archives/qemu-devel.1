Received: from eggs.gnu.org ([2001:4830:134:3::10]:37070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmne-0005qg-CG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnd-0003pL-0T
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:10 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOmnc-0003os-Qn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:08 -0400
Received: by mail-wm0-x22e.google.com with SMTP id a8-v6so4057003wmg.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:21:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Jun 2018 17:20:59 +0100
Message-Id: <20180601162101.895-6-alex.bennee@linaro.org>
In-Reply-To: <20180601162101.895-1-alex.bennee@linaro.org>
References: <20180601162101.895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/7] .travis.yml: rationalise clang testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

As Travis includes Clang 5.0 in its own build environment there is no
point manually building with older Clangs. We still need to test with
the two pythons though so we leave them as minimal system only builds.
We also split the clang build into two as it often exceeds the 40
minute build time limit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.travis.yml b/.travis.yml
index aa83e9aed7..f91db3ab1a 100644
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
-    - env: CONFIG="--disable-linux-user"
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
+    # Python builds
+    - env: CONFIG="--target-list=x86_64-softmmu"
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
+    - env: CONFIG="--target-list=x86_64-softmmu"
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
