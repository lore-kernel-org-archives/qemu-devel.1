Received: from eggs.gnu.org ([2001:4830:134:3::10]:37257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHM-0000NJ-NZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHL-0006FB-SN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6GHL-0006Ey-MR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90B8F4E8AB
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:54:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 16:54:29 +0400
Message-Id: <20170504125432.21653-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-1-marcandre.lureau@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] qmp-shell: add -N option to skip negotiate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

qemu-ga doesn't have negotiate phase.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index eccb88a4e8..f80d02312a 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -256,8 +256,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._print(resp)
         return True
=20
-    def connect(self):
-        self._greeting =3D qmp.QEMUMonitorProtocol.connect(self)
+    def connect(self, negotiate):
+        self._greeting =3D qmp.QEMUMonitorProtocol.connect(self, negotia=
te)
         self.__completer_setup()
=20
     def show_banner(self, msg=3D'Welcome to the QMP low-level shell!'):
@@ -369,7 +369,7 @@ def die(msg):
 def fail_cmdline(option=3DNone):
     if option:
         sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % opt=
ion)
-    sys.stderr.write('qemu-shell [ -v ] [ -p ] [ -H ] < UNIX socket path=
> | < TCP address:port >\n')
+    sys.stderr.write('qemu-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX sock=
et path> | < TCP address:port >\n')
     sys.exit(1)
=20
 def main():
@@ -378,6 +378,7 @@ def main():
     hmp =3D False
     pretty =3D False
     verbose =3D False
+    negotiate =3D True
=20
     try:
         for arg in sys.argv[1:]:
@@ -387,6 +388,8 @@ def main():
                 hmp =3D True
             elif arg =3D=3D "-p":
                 pretty =3D True
+            elif arg =3D=3D "-N":
+                negotiate =3D False
             elif arg =3D=3D "-v":
                 verbose =3D True
             else:
@@ -404,7 +407,7 @@ def main():
         die('bad port number in command-line')
=20
     try:
-        qemu.connect()
+        qemu.connect(negotiate)
     except qmp.QMPConnectError:
         die('Didn\'t get QMP greeting message')
     except qmp.QMPCapabilitiesError:
--=20
2.12.0.191.gc5d8de91d
