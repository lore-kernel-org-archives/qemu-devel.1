Received: from eggs.gnu.org ([209.51.188.92]:38014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHX-0004GW-L2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHW-00075z-OY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHW-00075a-Jc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:30 -0300
Message-Id: <20190503004130.8285-20-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/19] configure: automatically pick python3 is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Unless overridden via an env var or configure arg, QEMU will only look
for the 'python' binary in $PATH. This is unhelpful on distros which
are only shipping Python 3.x (eg Fedora) in their default install as,
if they comply with PEP 394, the bare 'python' binary won't exist.

This changes configure so that by default it will search for all three
common python binaries, preferring to find Python 3.x versions.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190327170701.23798-1-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5..f88011b94d 100755
--- a/configure
+++ b/configure
@@ -899,7 +899,18 @@ fi
=20
 : ${make=3D${MAKE-make}}
 : ${install=3D${INSTALL-install}}
-: ${python=3D${PYTHON-python}}
+# We prefer python 3.x. A bare 'python' is traditionally
+# python 2.x, but some distros have it as python 3.x, so
+# we check that before python2
+python=3D
+for binary in "${PYTHON-python3}" python python2
+do
+    if has "$binary"
+    then
+        python=3D"$binary"
+        break
+    fi
+done
 : ${smbd=3D${SMBD-/usr/sbin/smbd}}
=20
 # Default objcc to clang if available, otherwise use CC
@@ -1818,8 +1829,9 @@ EOF
 exit 0
 fi
=20
-if ! has $python; then
-  error_exit "Python not found. Use --python=3D/path/to/python"
+if test -z "$python"
+then
+    error_exit "Python not found. Use --python=3D/path/to/python"
 fi
=20
 # Note that if the Python conditional here evaluates True we will exit
--=20
2.18.0.rc1.1.g3f1ff2140
