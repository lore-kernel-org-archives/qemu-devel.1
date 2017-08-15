Received: from eggs.gnu.org ([2001:4830:134:3::10]:57090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXgC-0003Bv-9G
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXg7-0006of-EX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dhXg7-0006m9-8S
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:23 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Tue, 15 Aug 2017 10:57:29 +0200
Message-Id: <20170815085732.9794-8-ldoktor@redhat.com>
In-Reply-To: <20170815085732.9794-1-ldoktor@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 07/10] qmp.py: Use object-based class for
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

There is no need to define QEMUMonitorProtocol as old-style class.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp-shell | 4 ++--
 scripts/qmp/qmp.py    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 860ffb2..be449de 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -106,7 +106,7 @@ class FuzzyJSON(ast.NodeTransformer):
 #       _execute_cmd()). Let's design a better one.
 class QMPShell(qmp.QEMUMonitorProtocol):
     def __init__(self, address, pretty=3DFalse):
-        qmp.QEMUMonitorProtocol.__init__(self, self.__get_address(addres=
s))
+        super(QMPShell, self).__init__(self.__get_address(address))
         self._greeting =3D None
         self._completer =3D None
         self._pretty =3D pretty
@@ -281,7 +281,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         return True
=20
     def connect(self, negotiate):
-        self._greeting =3D qmp.QEMUMonitorProtocol.connect(self, negotia=
te)
+        self._greeting =3D super(QMPShell, self).connect(negotiate)
         self.__completer_setup()
=20
     def show_banner(self, msg=3D'Welcome to the QMP low-level shell!'):
diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 782d1ac..95ff5cc 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -30,7 +30,7 @@ class QMPTimeoutError(QMPError):
     pass
=20
=20
-class QEMUMonitorProtocol:
+class QEMUMonitorProtocol(object):
=20
     #: Socket's error class
     error =3D socket.error
--=20
2.9.4
