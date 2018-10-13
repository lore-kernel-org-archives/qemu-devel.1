Received: from eggs.gnu.org ([2001:4830:134:3::10]:45122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBC4e-0004Xb-LI
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 01:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBC4d-00015E-SB
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 01:02:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 13 Oct 2018 02:02:27 -0300
Message-Id: <20181013050227.17022-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
I'd like to do this in QEMU 3.1.  I think it's time to drop
support for old systems that have only Python 2.

We still have a few scripts that are not required for building
QEMU that still work only with Python 2 (iotests being the most
relevant set).  Requiring Python 3 for building QEMU won't
prevent people from using those scripts with Python 2 until they
are finally ported.
---
 configure   | 8 ++++----
 .travis.yml | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index f89d293585..43b45745dc 100755
--- a/configure
+++ b/configure
@@ -885,7 +885,7 @@ fi
 
 : ${make=${MAKE-make}}
 : ${install=${INSTALL-install}}
-: ${python=${PYTHON-python}}
+: ${python=${PYTHON-python3}}
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -1730,13 +1730,13 @@ exit 0
 fi
 
 if ! has $python; then
-  error_exit "Python not found. Use --python=/path/to/python"
+  error_exit "Python 3 not found. Use --python=/path/to/python"
 fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
-  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
+  error_exit "Cannot use '$python', Python 3 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
diff --git a/.travis.yml b/.travis.yml
index 95be6ec59f..caca9685fa 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -5,7 +5,7 @@ sudo: false
 dist: trusty
 language: c
 python:
-  - "2.6"
+  - "3.6"
 compiler:
   - gcc
 cache: ccache
-- 
2.18.0.rc1.1.g3f1ff2140
