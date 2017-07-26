Received: from eggs.gnu.org ([2001:4830:134:3::10]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNQw-0003lA-Se
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNQv-0002cb-SD
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daNQv-0002c6-Lo
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:05 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Wed, 26 Jul 2017 16:35:35 +0200
Message-Id: <20170726143543.2530-7-ldoktor@redhat.com>
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
References: <20170726143543.2530-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/14] qemu|qtest: Avoid dangerous arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, jsnow@redhat.com

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
---
 scripts/qemu.py  | 6 +++++-
 scripts/qtest.py | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 191c916..66fd863 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -23,7 +23,7 @@ import qmp.qmp
 class QEMUMachine(object):
     '''A QEMU VM'''
=20
-    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
+    def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
                  socket_scm_helper=3DNone, debug=3DFalse):
         '''
@@ -39,6 +39,10 @@ class QEMUMachine(object):
         @param debug: enable debug mode (forwarded to QMP helper and suc=
h)
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
index d5aecb5..ab183c0 100644
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
2.9.4
