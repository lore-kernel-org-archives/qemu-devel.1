Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BW-0005Bg-Sb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BV-0001Nd-MB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0BV-0001Ms-HC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:29 -0300
Message-Id: <20170915233739.26860-6-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/15] qemu.py: Use custom exceptions rather
 than Exception
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

The naked Exception should not be widely used. It makes sense to be a
bit more specific and use better-suited custom exceptions. As a benefit
we can store the full reply in the exception in case someone needs it
when catching the exception.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170818142613.32394-6-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index bde8da8fe7..7c6802609a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -19,6 +19,19 @@ import subprocess
 import qmp.qmp
=20
=20
+class MonitorResponseError(qmp.qmp.QMPError):
+    '''
+    Represents erroneous QMP monitor reply
+    '''
+    def __init__(self, reply):
+        try:
+            desc =3D reply["error"]["desc"]
+        except KeyError:
+            desc =3D reply
+        super(MonitorResponseError, self).__init__(desc)
+        self.reply =3D reply
+
+
 class QEMUMachine(object):
     '''A QEMU VM
=20
@@ -213,9 +226,9 @@ class QEMUMachine(object):
         '''
         reply =3D self.qmp(cmd, conv_keys, **args)
         if reply is None:
-            raise Exception("Monitor is closed")
+            raise qmp.qmp.QMPError("Monitor is closed")
         if "error" in reply:
-            raise Exception(reply["error"]["desc"])
+            raise MonitorResponseError(reply)
         return reply["return"]
=20
     def get_qmp_event(self, wait=3DFalse):
--=20
2.13.5
