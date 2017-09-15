Received: from eggs.gnu.org ([2001:4830:134:3::10]:56491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Br-0005TB-NM
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bq-0001sE-RM
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Bq-0001rz-Kw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:33 -0300
Message-Id: <20170915233739.26860-10-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/15] qmp.py: Avoid overriding a builtin object
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

The "id" is a builtin method to get object's identity and should not be
overridden. This might bring some issues in case someone was directly
calling "cmd(..., id=3Did)" but I haven't found such usage on brief searc=
h
for "cmd\(.*id=3D".

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170818142613.32394-10-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index f2f5a9b296..ef12e8a1a0 100644
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
2.13.5
