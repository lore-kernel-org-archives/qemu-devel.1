Received: from eggs.gnu.org ([2001:4830:134:3::10]:54763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkc-00054x-Hp
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TkZ-0002fv-Dk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38271 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TkZ-0002fQ-9Q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:40 +0200
Message-Id: <20180326150916.9602-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/38] qmp-shell: learn to send commands
 with quoted arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use shlex to split the CLI command, respecting quoted arguments, and
also comments. This allows to call for ex:

(QEMU) human-monitor-command command-line=3D"screendump /dev/null"
{"execute": "human-monitor-command", "arguments": {"command-line": "scree=
ndump /dev/null"}}

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index be449de621..af7033c765 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -73,6 +73,7 @@ import sys
 import os
 import errno
 import atexit
+import shlex
=20
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -218,7 +219,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
=20
             < command-name > [ arg-name1=3Darg1 ] ... [ arg-nameN=3DargN=
 ]
         """
-        cmdargs =3D cmdline.split()
+        cmdargs =3D shlex.split(cmdline)
=20
         # Transactional CLI entry/exit:
         if cmdargs[0] =3D=3D 'transaction(':
--=20
2.17.0.rc1.1.g4c4f2b46a3
