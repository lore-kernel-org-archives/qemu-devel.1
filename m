Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bf-0005Il-RV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bd-0001dZ-TF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Bd-0001aU-OF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:31 -0300
Message-Id: <20170915233739.26860-8-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/15] qmp.py: Use object-based class for
 QEMUMonitorProtocol
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

There is no need to define QEMUMonitorProtocol as old-style class.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170818142613.32394-8-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py    | 2 +-
 scripts/qmp/qmp-shell | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 782d1ac5df..95ff5cc39a 100644
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
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 860ffb27f2..be449de621 100755
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
--=20
2.13.5
