Received: from eggs.gnu.org ([2001:4830:134:3::10]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbOR5-00080F-0w
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbOR2-0006fS-Uc
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbOR2-0006e6-Px
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5620881A4EA9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:57:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:27 +0200
Message-Id: <20180706105753.26700-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 01/27] qmp-shell: learn to send commands
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.18.0.rc1
