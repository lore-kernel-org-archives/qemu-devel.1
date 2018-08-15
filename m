Received: from eggs.gnu.org ([2001:4830:134:3::10]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzd-0000k1-CG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzT-00083l-AB
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fppzS-00082S-SZ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73DC3CFB77
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:13:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Aug 2018 09:13:04 +0200
Message-Id: <20180815071308.11777-2-armbru@redhat.com>
In-Reply-To: <20180815071308.11777-1-armbru@redhat.com>
References: <20180815071308.11777-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] qmp-shell: learn to send commands with
 quoted arguments
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

Use shlex to split the CLI command, respecting quoted arguments, and
also comments. This allows to call for ex:

(QEMU) human-monitor-command command-line=3D"screendump /dev/null"
{"execute": "human-monitor-command", "arguments": {"command-line": "scree=
ndump /dev/null"}}

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180326150916.9602-3-marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qmp-shell | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index a42306dd89..770140772d 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -74,6 +74,7 @@ import sys
 import os
 import errno
 import atexit
+import shlex
=20
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -219,7 +220,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
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
2.17.1
