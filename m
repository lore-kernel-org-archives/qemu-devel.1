Received: from eggs.gnu.org ([2001:4830:134:3::10]:50192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6I-0006Sg-45
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6H-0000rj-2N
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e2M6G-0000rC-Pm
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 11 Oct 2017 15:51:02 -0300
Message-Id: <20171011185103.26259-5-ehabkost@redhat.com>
In-Reply-To: <20171011185103.26259-1-ehabkost@redhat.com>
References: <20171011185103.26259-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] scripts: Remove debug parameter from
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Use logging module for the QMP debug messages.  The only scripts
that set debug=3DTrue are iotests.py and guestperf/engine.py, and
they already call logging.basicConfig() to set up logging.

Scripts that don't configure logging are safe as long as they
don't need debugging output, because debug messages don't trigger
the "No handlers could be found for logger" message from the
Python logging module.

Scripts that already configure logging but don't use debug=3DTrue
(e.g. scripts/vm/basevm.py) will get QMP debugging enabled for
free.

Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>
Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171005172013.3098-3-ehabkost@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py    |  3 +--
 scripts/qmp/qmp.py | 16 +++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index c9a106fbce..f6d2e68627 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -177,8 +177,7 @@ class QEMUMachine(object):
=20
     def _pre_launch(self):
         self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
-                                                server=3DTrue,
-                                                debug=3Dself._debug)
+                                                server=3DTrue)
=20
     def _post_launch(self):
         self._qmp.accept()
diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index ef12e8a1a0..07c9632e9e 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -11,7 +11,7 @@
 import json
 import errno
 import socket
-import sys
+import logging
=20
=20
 class QMPError(Exception):
@@ -32,12 +32,14 @@ class QMPTimeoutError(QMPError):
=20
 class QEMUMonitorProtocol(object):
=20
+    #: Logger object for debugging messages
+    logger =3D logging.getLogger('QMP')
     #: Socket's error class
     error =3D socket.error
     #: Socket's timeout
     timeout =3D socket.timeout
=20
-    def __init__(self, address, server=3DFalse, debug=3DFalse):
+    def __init__(self, address, server=3DFalse):
         """
         Create a QEMUMonitorProtocol class.
=20
@@ -51,7 +53,6 @@ class QEMUMonitorProtocol(object):
         """
         self.__events =3D []
         self.__address =3D address
-        self._debug =3D debug
         self.__sock =3D self.__get_sock()
         self.__sockfile =3D None
         if server:
@@ -83,8 +84,7 @@ class QEMUMonitorProtocol(object):
                 return
             resp =3D json.loads(data)
             if 'event' in resp:
-                if self._debug:
-                    print >>sys.stderr, "QMP:<<< %s" % resp
+                self.logger.debug("<<< %s", resp)
                 self.__events.append(resp)
                 if not only_event:
                     continue
@@ -164,8 +164,7 @@ class QEMUMonitorProtocol(object):
         @return QMP response as a Python dict or None if the connection =
has
                 been closed
         """
-        if self._debug:
-            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
+        self.logger.debug(">>> %s", qmp_cmd)
         try:
             self.__sock.sendall(json.dumps(qmp_cmd))
         except socket.error as err:
@@ -173,8 +172,7 @@ class QEMUMonitorProtocol(object):
                 return
             raise socket.error(err)
         resp =3D self.__json_read()
-        if self._debug:
-            print >>sys.stderr, "QMP:<<< %s" % resp
+        self.logger.debug("<<< %s", resp)
         return resp
=20
     def cmd(self, name, args=3DNone, cmd_id=3DNone):
--=20
2.13.6
