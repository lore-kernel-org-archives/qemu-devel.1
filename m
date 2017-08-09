Received: from eggs.gnu.org ([2001:4830:134:3::10]:48538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZw-00068e-Es
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZt-0002J3-Ri
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:44 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZt-0002Iv-O5
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id p3so6881665qtg.5
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:06 -0300
Message-Id: <20170809202712.6951-11-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 10/16] travis: check ./configure
 outcome, dump config.log on failure
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

also de-duplicate 'before_script'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 72aad5ca35..88ca78c775 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,7 +79,7 @@ before_install:
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - travis_retry git submodule update --init --recursive
 before_script:
-  - ./configure ${CONFIG}
+  - ./configure ${CONFIG} || (cat config.log; exit 1)
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
@@ -155,8 +155,6 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - travis_retry git submodule update --init --recursive
-      before_script:
-        - ./configure ${CONFIG} || cat config.log
     # Trusty Linux User build with latest stable clang
     - sudo: required
       addons:
@@ -175,8 +173,6 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - travis_retry git submodule update --init --recursive
-      before_script:
-        - ./configure ${CONFIG} || cat config.log
     # Using newer GCC with sanitizers
     - addons:
         apt:
@@ -232,4 +228,4 @@ matrix:
         - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
-        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
+        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || (cat config.log; exit 1)
-- 
2.13.3
