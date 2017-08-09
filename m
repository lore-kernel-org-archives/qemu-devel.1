Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZn-00060k-Gl
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZm-0002At-0C
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:35 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZl-0002AY-Qs
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id t37so6893980qtg.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:02 -0300
Message-Id: <20170809202712.6951-7-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 06/16] travis: retry when git
 submodules initialization fails
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

example of failure: https://travis-ci.org/philmd/qemu/jobs/245612939

  $ git submodule update --init --recursive
  [...]
  Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for path 'pixman'
  Cloning into 'pixman'...
  fatal: unable to connect to anongit.freedesktop.org:
  anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
  anongit.freedesktop.org[1: 2610:10:20:722:a800:ff:fe24:61cf]: errno=Network is unreachable
  Clone of 'git://anongit.freedesktop.org/pixman' into submodule path 'pixman' failed
  The command "git submodule update --init --recursive" failed and exited with 1 during .
  Your build has been stopped.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 82c1819c93..196412f5be 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -76,7 +76,7 @@ before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-  - git submodule update --init --recursive
+  - travis_retry git submodule update --init --recursive
 before_script:
   - ./configure ${CONFIG}
 script:
@@ -119,7 +119,7 @@ matrix:
         - sudo apt-get update -qq
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
+        - travis_retry git submodule update --init --recursive
     # Plain Trusty Linux User Build
     - env: CONFIG="--disable-system"
       sudo: required
@@ -131,7 +131,7 @@ matrix:
         - sudo apt-get update -qq
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
+        - travis_retry git submodule update --init --recursive
     # Trusty System build with latest stable clang
     - sudo: required
       addons:
@@ -149,7 +149,7 @@ matrix:
         - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
+        - travis_retry git submodule update --init --recursive
       before_script:
         - ./configure ${CONFIG} || cat config.log
     # Trusty Linux User build with latest stable clang
@@ -169,7 +169,7 @@ matrix:
         - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-        - git submodule update --init --recursive
+        - travis_retry git submodule update --init --recursive
       before_script:
         - ./configure ${CONFIG} || cat config.log
     # Using newer GCC with sanitizers
-- 
2.13.3
