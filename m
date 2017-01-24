Received: from eggs.gnu.org ([2001:4830:134:3::10]:37455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AV-0004Wm-53
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AS-0005KR-Sd
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AS-0005K8-Ml
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:52 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c206so212471227wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:52 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:41 +0000
Message-Id: <20170124143346.22240-3-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/7] .travis.yml: split VM based builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

The Trusty based builds run a little slower than the main container
based ones. This is also true for the latest version of Clang. The
builds are getting very close (and occasionally run over) the 50 minute
timeout. Rather than partitioning by target I just split them into
linux-user and system builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3dc1e6439d..9008a796f0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -92,8 +92,19 @@ matrix:
     - env: CONFIG=""
       os: osx
       compiler: clang
-    # Plain Trusty Build
-    - env: CONFIG=""
+    # Plain Trusty System Build
+    - env: CONFIG="--disable-linux-user"
+      sudo: required
+      addons:
+      dist: trusty
+      compiler: gcc
+      before_install:
+        - sudo apt-get update -qq
+        - sudo apt-get build-dep -qq qemu
+        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
+        - git submodule update --init --recursive
+    # Plain Trusty Linux User Build
+    - env: CONFIG="--disable-system"
       sudo: required
       addons:
       dist: trusty
@@ -103,7 +114,26 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
-    # Trusty build with latest stable clang
+    # Trusty System build with latest stable clang
+    - sudo: required
+      addons:
+      dist: trusty
+      language: generic
+      compiler: none
+      env:
+        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
+        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9"
+      before_install:
+        - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
+        - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
+        - sudo apt-get update -qq
+        - sudo apt-get install -qq -y clang-3.9
+        - sudo apt-get build-dep -qq qemu
+        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
+        - git submodule update --init --recursive
+      before_script:
+        - ./configure ${CONFIG} || cat config.log
+    # Trusty Linux User build with latest stable clang
     - sudo: required
       addons:
       dist: trusty
@@ -111,7 +141,7 @@ matrix:
       compiler: none
       env:
         - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--cc=clang-3.9 --cxx=clang++-3.9"
+        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9"
       before_install:
         - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
         - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-- 
2.11.0
