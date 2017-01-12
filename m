Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFc-0006oe-EY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFX-0003a3-Es
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:08 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cRfFX-0003Zq-9X
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:03 -0500
Received: by mail-wm0-x229.google.com with SMTP id r144so19027342wme.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 05:17:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Jan 2017 13:16:58 +0000
Message-Id: <20170112131658.19837-3-alex.bennee@linaro.org>
In-Reply-To: <20170112131658.19837-1-alex.bennee@linaro.org>
References: <20170112131658.19837-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] travis: add Trusty with clang stable build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Although we've reduced the matrix to avoid repeating clang builds we can
still add an additional clang build to use the latest stable version of
clang which will typically be available on current distros.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 0706b9a1df..d83e2d493b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -103,6 +103,26 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
+    # Trusty build with latest stable clang
+    - env: CONFIG=""
+      sudo: required
+      addons:
+      dist: trusty
+      language: generic
+      compiler: none
+      env:
+        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
+        - CONFIG="--cc=clang-3.9 --cxx=clang++-3.9"
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
     # Using newer GCC with sanitizers
     - addons:
         apt:
-- 
2.11.0
