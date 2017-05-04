Received: from eggs.gnu.org ([2001:4830:134:3::10]:56519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic6-0002Aj-Oj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic2-0008OY-Oi
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic2-0008N2-CQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 473D015561
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:24:02 +0200
Message-Id: <1493911445-19568-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/28] qmp-shell: add -N option to skip negotiate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qemu-ga doesn't have negotiate phase.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170504125432.21653-2-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qmp-shell | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 6ece6e7..b4d2dbd 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -277,8 +277,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
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
@@ -390,7 +390,7 @@ def die(msg):
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
@@ -399,6 +399,7 @@ def main():
     hmp =3D False
     pretty =3D False
     verbose =3D False
+    negotiate =3D True
=20
     try:
         for arg in sys.argv[1:]:
@@ -408,6 +409,8 @@ def main():
                 hmp =3D True
             elif arg =3D=3D "-p":
                 pretty =3D True
+            elif arg =3D=3D "-N":
+                negotiate =3D False
             elif arg =3D=3D "-v":
                 verbose =3D True
             else:
@@ -425,7 +428,7 @@ def main():
         die('bad port number in command-line')
=20
     try:
-        qemu.connect()
+        qemu.connect(negotiate)
     except qmp.QMPConnectError:
         die('Didn\'t get QMP greeting message')
     except qmp.QMPCapabilitiesError:
--=20
2.7.4
