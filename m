Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEX-00040F-P0
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEW-0006qZ-GN
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:09 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEW-0006pJ-Bs
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:08 -0400
Received: by mail-qk0-x22d.google.com with SMTP id r62so65373588qkf.0
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 12:30:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 25 Jun 2017 16:29:47 -0300
Message-Id: <20170625192950.17677-2-f4bug@amsat.org>
In-Reply-To: <20170625192950.17677-1-f4bug@amsat.org>
References: <20170625192950.17677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/4] XXX travis: simplify matrix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

to speedup further testing

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 119 ------------------------------------------------------------
 1 file changed, 119 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..4761569183 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -48,11 +48,6 @@ env:
     - TEST_CMD="make check"
   matrix:
     - CONFIG=""
-    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
-    - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
-    - CONFIG="--enable-modules"
-    - CONFIG="--with-coroutine=ucontext"
-    - CONFIG="--with-coroutine=sigaltstack"
 git:
   # we want to do this ourselves
   submodules: false
@@ -67,39 +62,6 @@ script:
   - make -j3 && ${TEST_CMD}
 matrix:
   include:
-    # Test with CLang for compile portability
-    - env: CONFIG=""
-      compiler: clang
-    # gprof/gcov are GCC features
-    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
-      compiler: gcc
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
-    - env: CONFIG=""
-      os: osx
-      compiler: clang
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
     # Plain Trusty Linux User Build
     - env: CONFIG="--disable-system"
       sudo: required
@@ -111,84 +73,3 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
-    # Trusty System build with latest stable clang
-    - sudo: required
-      addons:
-      dist: trusty
-      language: generic
-      compiler: none
-      env:
-        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9"
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
-    # Trusty Linux User build with latest stable clang
-    - sudo: required
-      addons:
-      dist: trusty
-      language: generic
-      compiler: none
-      env:
-        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9"
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
-    # Using newer GCC with sanitizers
-    - addons:
-        apt:
-          sources:
-            # PPAs for newer toolchains
-            - ubuntu-toolchain-r-test
-          packages:
-            # Extra toolchains
-            - gcc-5
-            - g++-5
-            # Build dependencies
-            - libaio-dev
-            - libattr1-dev
-            - libbrlapi-dev
-            - libcap-ng-dev
-            - libgnutls-dev
-            - libgtk-3-dev
-            - libiscsi-dev
-            - liblttng-ust-dev
-            - libnfs-dev
-            - libncurses5-dev
-            - libnss3-dev
-            - libpixman-1-dev
-            - libpng12-dev
-            - librados-dev
-            - libsdl1.2-dev
-            - libseccomp-dev
-            - libspice-protocol-dev
-            - libspice-server-dev
-            - libssh2-1-dev
-            - liburcu-dev
-            - libusb-1.0-0-dev
-            - libvte-2.90-dev
-            - sparse
-            - uuid-dev
-      language: generic
-      compiler: none
-      env:
-        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
-        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
-        - TEST_CMD=""
-      before_script:
-        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
-- 
2.13.1
