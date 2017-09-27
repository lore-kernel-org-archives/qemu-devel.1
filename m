Received: from eggs.gnu.org ([2001:4830:134:3::10]:52826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0l-00010E-Gy
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0f-0006lb-Je
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxC0f-0006l8-Be
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:38 -0300
Message-Id: <20170927130339.21444-5-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-1-ehabkost@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] scripts: Remove debug parameter from
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
---
 scripts/qemu.py    |  3 +--
 scripts/qmp/qmp.py | 13 ++++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

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
index ef12e8a1a0..be79d7aa80 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -12,6 +12,7 @@ import json
 import errno
 import socket
 import sys
+import logging
=20
=20
 class QMPError(Exception):
@@ -32,6 +33,8 @@ class QMPTimeoutError(QMPError):
=20
 class QEMUMonitorProtocol(object):
=20
+    #: Logger object for debugging messages
+    logger =3D logging.getLogger('QMP')
     #: Socket's error class
     error =3D socket.error
     #: Socket's timeout
@@ -51,7 +54,6 @@ class QEMUMonitorProtocol(object):
         """
         self.__events =3D []
         self.__address =3D address
-        self._debug =3D debug
         self.__sock =3D self.__get_sock()
         self.__sockfile =3D None
         if server:
@@ -83,8 +85,7 @@ class QEMUMonitorProtocol(object):
                 return
             resp =3D json.loads(data)
             if 'event' in resp:
-                if self._debug:
-                    print >>sys.stderr, "QMP:<<< %s" % resp
+                self.logger.debug("<<< %s", resp)
                 self.__events.append(resp)
                 if not only_event:
                     continue
@@ -164,8 +165,7 @@ class QEMUMonitorProtocol(object):
         @return QMP response as a Python dict or None if the connection =
has
                 been closed
         """
-        if self._debug:
-            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
+        self.logger.debug("<<< %s", qmp_cmd)
         try:
             self.__sock.sendall(json.dumps(qmp_cmd))
         except socket.error as err:
@@ -173,8 +173,7 @@ class QEMUMonitorProtocol(object):
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
2.13.5
