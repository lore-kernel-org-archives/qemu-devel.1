Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXS-0008Pb-5b
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXQ-0001OS-Ug
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRXQ-0001O4-O3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:28 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:16 +0000
Message-Id: <20180116134217.8725-14-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 13/14] travis: improve python version test
 coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently travis declares ancient python 2.4 is desired. Update that to
2.6 which is the oldest version any targetted distros still needs. If we
just list a python 3 version at the top level this will double the
number of travis jobs we run which is unreasonable.

So arbitrarily pick the clang test matrix entries to build with python
3.0 and 3.6, to extend coverage of python versions, without increasing
job count or build time.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .travis.yml | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f583839755..708c886017 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,7 +1,7 @@
 sudo: false
 language: c
 python:
-  - "2.4"
+  - "2.6"
 compiler:
   - gcc
 cache: ccache
@@ -115,15 +115,17 @@ matrix:
         - sudo apt-get build-dep -qq qemu
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
-    # Trusty System build with latest stable clang
+    # Trusty System build with latest stable clang & python 3.0
     - sudo: required
       addons:
       dist: trusty
       language: generic
       compiler: none
+      python:
+        - "3.0"
       env:
         - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9"
+        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
       before_install:
         - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
         - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
@@ -134,15 +136,17 @@ matrix:
         - git submodule update --init --recursive
       before_script:
         - ./configure ${CONFIG} || cat config.log
-    # Trusty Linux User build with latest stable clang
+    # Trusty Linux User build with latest stable clang & python 3.6
     - sudo: required
       addons:
       dist: trusty
       language: generic
       compiler: none
+      python:
+        - "3.6"
       env:
         - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
-        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9"
+        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
       before_install:
         - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
         - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
-- 
2.14.3
