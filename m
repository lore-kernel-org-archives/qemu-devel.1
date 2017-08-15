Received: from eggs.gnu.org ([2001:4830:134:3::10]:57113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXgD-0003Cc-2p
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXgC-0006uX-CO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dhXgC-0006u5-5u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:28 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Tue, 15 Aug 2017 10:57:31 +0200
Message-Id: <20170815085732.9794-10-ldoktor@redhat.com>
In-Reply-To: <20170815085732.9794-1-ldoktor@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 09/10] qmp.py: Avoid overriding a builtin
 object
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

The "id" is a builtin method to get object's identity and should not be
overridden. This might bring some issues in case someone was directly
calling "cmd(..., id=3Did)" but I haven't found such usage on brief searc=
h
for "cmd\(.*id=3D".

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index f2f5a9b..ef12e8a 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
             print >>sys.stderr, "QMP:<<< %s" % resp
         return resp
=20
-    def cmd(self, name, args=3DNone, id=3DNone):
+    def cmd(self, name, args=3DNone, cmd_id=3DNone):
         """
         Build a QMP command and send it to the QMP Monitor.
=20
         @param name: command name (string)
         @param args: command arguments (dict)
-        @param id: command id (dict, list, string or int)
+        @param cmd_id: command id (dict, list, string or int)
         """
         qmp_cmd =3D {'execute': name}
         if args:
             qmp_cmd['arguments'] =3D args
-        if id:
-            qmp_cmd['id'] =3D id
+        if cmd_id:
+            qmp_cmd['id'] =3D cmd_id
         return self.cmd_obj(qmp_cmd)
=20
     def command(self, cmd, **kwds):
--=20
2.9.4
