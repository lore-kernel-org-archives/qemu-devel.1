Received: from eggs.gnu.org ([209.51.188.92]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gr16c-0003l4-LB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gr16Y-0001RX-V2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:49:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gr16T-0001Gf-JR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:49:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F3EBC05D404
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 13:49:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  5 Feb 2019 14:49:26 +0100
Message-Id: <20190205134926.8312-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kchamart@redhat.com, ehabkost@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Cleber Rosa <crosa@redhat.com>

Commit fcfab7541 ("qmp-shell: learn to send commands with quoted
arguments") introduces the usage of Python 'shlex' to handle quoted
arguments, but it accidentally broke generation of nested JSON
structs.

shlex drops quotes, which breaks parsing of the nested struct.

cmd=3D'blockdev-create job-id=3D"job0 foo" options=3D{"driver":"qcow2","s=
ize":16384,"file":{"driver":"file","filename":"foo.qcow2"}}'

shlex.split(cmd)
['blockdev-create',
 'job-id=3Djob0 foo',
 'options=3D{driver:qcow2,size:16384,file:{driver:file,filename:foo.qcow2=
}}']

Replace with a regexp to split while respecting quoted strings and preser=
ving quotes:

re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmd)
['blockdev-create',
 'job-id=3D"job0 foo"',
 'options=3D{"driver":"qcow2","size":16384,"file":{"driver":"file","filen=
ame":"foo.qcow2"}}']

Fixes: fcfab7541 ("qmp-shell: learn to send commands with quoted argument=
s")
Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 770140772d..813dd68232 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -74,7 +74,7 @@ import sys
 import os
 import errno
 import atexit
-import shlex
+import re
=20
 class QMPCompleter(list):
     def complete(self, text, state):
@@ -220,7 +220,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
=20
             < command-name > [ arg-name1=3Darg1 ] ... [ arg-nameN=3DargN=
 ]
         """
-        cmdargs =3D shlex.split(cmdline)
+        cmdargs =3D re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^=
'])*')+''', cmdline)
=20
         # Transactional CLI entry/exit:
         if cmdargs[0] =3D=3D 'transaction(':
--=20
2.20.1.98.gecbdaf0899
