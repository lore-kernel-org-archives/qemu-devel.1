Received: from eggs.gnu.org ([2001:4830:134:3::10]:55504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsu-0004Hb-1X
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtss-0002jk-QM
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:08 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:33791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtss-0002jf-MH
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:06 -0400
Received: by mail-qt0-x22e.google.com with SMTP id u12so69335474qth.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:29 -0300
Message-Id: <20170616161334.7492-7-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] travis: retry if llvm.org timeouts
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
---
 .travis.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index dbbb11617d..69a960b714 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -123,10 +123,10 @@ matrix:
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
@@ -142,10 +142,10 @@ matrix:
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
