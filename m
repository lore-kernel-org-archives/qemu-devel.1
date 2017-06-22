Received: from eggs.gnu.org ([2001:4830:134:3::10]:56096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrd-0005Or-2y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrc-0004cM-48
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:01 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrb-0004bo-Vg
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:00 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so610170qkg.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:32:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:12 -0300
Message-Id: <20170622033231.19344-3-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/21] travis: retry if llvm.org timeouts
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

example of failure: https://travis-ci.org/qemu/qemu/jobs/243232857

    $ sudo apt-get update -qq
    W: Failed to fetch http://llvm.org/apt/trusty/dists/llvm-toolchain-trusty-3.9/Release.gpg  Connection failed
    E: Some index files failed to download. They have been ignored, or old ones used instead.
    The command "sudo apt-get update -qq" failed and exited with 100 during .
    Your build has been stopped.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..f78300ee99 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -121,10 +121,10 @@ matrix:
         - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
         - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9"
       before_install:
-        - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
-        - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-        - sudo apt-get update -qq
-        - sudo apt-get install -qq -y clang-3.9
+        - travis_retry wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
+        - travis_retry sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
+        - travis_retry sudo apt-get update -qq
+        - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
@@ -140,10 +140,10 @@ matrix:
         - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
         - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9"
       before_install:
-        - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
-        - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-        - sudo apt-get update -qq
-        - sudo apt-get install -qq -y clang-3.9
+        - travis_retry wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
+        - travis_retry sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
+        - travis_retry sudo apt-get update -qq
+        - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
-- 
2.11.0
