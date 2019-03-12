Received: from eggs.gnu.org ([209.51.188.92]:46152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3WyZ-0006PX-NC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3WyY-0007Rd-SS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3WyY-0007RV-LG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:17:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 23:16:59 -0300
Message-Id: <20190312021659.24197-2-ehabkost@redhat.com>
In-Reply-To: <20190312021659.24197-1-ehabkost@redhat.com>
References: <20190312021659.24197-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20190205134926.8312-1-marcandre.lureau@redhat.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp-shell | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 9fec46e2ed..7776c7b141 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -73,7 +73,7 @@ import sys
 import os
 import errno
 import atexit
-import shlex
+import re
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
 from qemu import qmp
@@ -222,7 +222,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
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
2.18.0.rc1.1.g3f1ff2140
