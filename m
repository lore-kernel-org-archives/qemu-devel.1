Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BI-0004t0-Lu
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BH-0001CB-LY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0BH-0001Bu-G8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:26 -0300
Message-Id: <20170915233739.26860-3-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/15] qemu|qtest: Avoid dangerous arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The list object is mutable in python and potentially might modify other
object's arguments when used as default argument. Reproducer:

    >>> vm1 =3D QEMUMachine("qemu")
    >>> vm2 =3D QEMUMachine("qemu")
    >>> vm1._wrapper.append("foo")
    >>> print vm2._wrapper
    ['foo']

In this case the `args` is actually copied so it would be safe to keep
it, but it's not a good practice to keep it. The same issue applies in
inherited qtest module.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20170818142613.32394-3-ldoktor@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py  | 6 +++++-
 scripts/qtest.py | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index b45e691538..afd98a290e 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -30,7 +30,7 @@ class QEMUMachine(object):
         # vm is guaranteed to be shut down here
     '''
=20
-    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
+    def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
                  socket_scm_helper=3DNone, debug=3DFalse):
         '''
@@ -46,6 +46,10 @@ class QEMUMachine(object):
         @param debug: enable debug mode
         @note: Qemu process is not started until launch() is used.
         '''
+        if args is None:
+            args =3D []
+        if wrapper is None:
+            wrapper =3D []
         if name is None:
             name =3D "qemu-%d" % os.getpid()
         if monitor_address is None:
diff --git a/scripts/qtest.py b/scripts/qtest.py
index d5aecb5f49..ab183c0635 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -79,7 +79,7 @@ class QEMUQtestProtocol(object):
 class QEMUQtestMachine(qemu.QEMUMachine):
     '''A QEMU VM'''
=20
-    def __init__(self, binary, args=3D[], name=3DNone, test_dir=3D"/var/=
tmp",
+    def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"/va=
r/tmp",
                  socket_scm_helper=3DNone):
         if name is None:
             name =3D "qemu-%d" % os.getpid()
--=20
2.13.5
