Received: from eggs.gnu.org ([209.51.188.92]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzl6o-0000uQ-1a
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzl6n-0007Fy-9P
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gzl6j-00074p-C9
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3F803088A9C
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 16:33:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  1 Mar 2019 16:33:46 +0000
Message-Id: <20190301163346.6545-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: automatically pick python3 is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Unless overridden via an env var or configure arg, QEMU will only look
for the 'python' binary in $PATH. This is unhelpful on distros which
are only shipping Python 3.x (eg Fedora) in their default install as,
if they comply with PEP 394, the bare 'python' binary won't exist.

This changes configure so that by default it will search for all three
common python binaries, preferring to find Python 3.x versions.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 540bee19ba..ef2e5bf9f5 100755
--- a/configure
+++ b/configure
@@ -902,7 +902,10 @@ fi
=20
 : ${make=3D${MAKE-make}}
 : ${install=3D${INSTALL-install}}
-: ${python=3D${PYTHON-python}}
+# We prefer python 3.x. A bare 'python' is traditionally
+# python 2.x, but some distros have it as python 3.x, so
+# we check that before python2
+: ${python=3D${PYTHON-python3 python python2}}
 : ${smbd=3D${SMBD-/usr/sbin/smbd}}
=20
 # Default objcc to clang if available, otherwise use CC
@@ -1797,8 +1800,20 @@ EOF
 exit 0
 fi
=20
-if ! has $python; then
-  error_exit "Python not found. Use --python=3D/path/to/python"
+try_python=3D"$python"
+python=3D
+for binary in $try_python
+do
+    if has $binary
+    then
+       python=3D$binary
+       break
+    fi
+done
+
+if test -z "$python"
+then
+    error_exit "Python not found. Use --python=3D/path/to/python"
 fi
=20
 # Note that if the Python conditional here evaluates True we will exit
--=20
2.20.1
