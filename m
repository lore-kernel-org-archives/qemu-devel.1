Received: from eggs.gnu.org ([2001:4830:134:3::10]:56210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss0-0005ly-EK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrz-00054Q-E0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:24 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrz-00054I-9S
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:23 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so589600qtg.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:21 -0300
Message-Id: <20170622033231.19344-12-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/21] travis: cache git submodules
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

Travis caching uses the branch name to store packed cache, so each new branch
will trigger a cache miss and will clone all submodules. Subsequent builds will
benefit from the cache.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 62b9dfd2ae..777914f759 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -7,6 +7,8 @@ compiler:
 cache:
   ccache: true
   timeout: 1200 # https://docs.travis-ci.com/user/caching#setting-the-timeout
+  directories:
+  - $HOME/qemu/.git/modules
 addons:
   apt:
     packages:
@@ -74,7 +76,6 @@ git:
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
-  - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - git submodule update --init --recursive
 before_script:
   - ./configure ${CONFIG}
@@ -113,7 +114,6 @@ matrix:
       before_install:
         - sudo apt-get update -qq
         - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
     # Plain Trusty Linux User Build
     - env: CONFIG="--disable-system"
@@ -124,7 +124,6 @@ matrix:
       before_install:
         - sudo apt-get update -qq
         - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
     # Trusty System build with latest stable clang
     - sudo: required
@@ -142,7 +141,6 @@ matrix:
         - travis_retry sudo apt-get update -qq
         - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
       before_script:
         - ./configure ${CONFIG} || cat config.log
@@ -162,7 +160,6 @@ matrix:
         - travis_retry sudo apt-get update -qq
         - travis_retry sudo apt-get install -qq -y clang-3.9
         - sudo apt-get build-dep -qq qemu
-        - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
       before_script:
         - ./configure ${CONFIG} || cat config.log
-- 
2.11.0
