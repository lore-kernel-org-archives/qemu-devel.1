Received: from eggs.gnu.org ([2001:4830:134:3::10]:56396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bf-0005Io-RX
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bc-0001Wx-8V
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Bc-0001UP-0M
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:30 -0300
Message-Id: <20170915233739.26860-7-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/15] qmp.py: Couple of pylint/style fixes
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

No actual code changes, just initializing attributes earlier to avoid
AttributeError on early introspection, a few pylint/style fixes and
docstring clarifications.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170818142613.32394-7-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 62d3651967..782d1ac5df 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -13,19 +13,30 @@ import errno
 import socket
 import sys
=20
+
 class QMPError(Exception):
     pass
=20
+
 class QMPConnectError(QMPError):
     pass
=20
+
 class QMPCapabilitiesError(QMPError):
     pass
=20
+
 class QMPTimeoutError(QMPError):
     pass
=20
+
 class QEMUMonitorProtocol:
+
+    #: Socket's error class
+    error =3D socket.error
+    #: Socket's timeout
+    timeout =3D socket.timeout
+
     def __init__(self, address, server=3DFalse, debug=3DFalse):
         """
         Create a QEMUMonitorProtocol class.
@@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
         self.__address =3D address
         self._debug =3D debug
         self.__sock =3D self.__get_sock()
+        self.__sockfile =3D None
         if server:
             self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADD=
R, 1)
             self.__sock.bind(self.__address)
@@ -56,7 +68,7 @@ class QEMUMonitorProtocol:
=20
     def __negotiate_capabilities(self):
         greeting =3D self.__json_read()
-        if greeting is None or not greeting.has_key('QMP'):
+        if greeting is None or "QMP" not in greeting:
             raise QMPConnectError
         # Greeting seems ok, negotiate capabilities
         resp =3D self.cmd('qmp_capabilities')
@@ -78,8 +90,6 @@ class QEMUMonitorProtocol:
                     continue
             return resp
=20
-    error =3D socket.error
-
     def __get_events(self, wait=3DFalse):
         """
         Check for new events in the stream and cache them in __events.
@@ -89,8 +99,8 @@ class QEMUMonitorProtocol:
=20
         @raise QMPTimeoutError: If a timeout float is provided and the t=
imeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be r=
etrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurre=
d.
         """
=20
         # Check for new events regardless and pull them into the cache:
@@ -175,7 +185,7 @@ class QEMUMonitorProtocol:
         @param args: command arguments (dict)
         @param id: command id (dict, list, string or int)
         """
-        qmp_cmd =3D { 'execute': name }
+        qmp_cmd =3D {'execute': name}
         if args:
             qmp_cmd['arguments'] =3D args
         if id:
@@ -183,6 +193,9 @@ class QEMUMonitorProtocol:
         return self.cmd_obj(qmp_cmd)
=20
     def command(self, cmd, **kwds):
+        """
+        Build and send a QMP command to the monitor, report errors if an=
y
+        """
         ret =3D self.cmd(cmd, kwds)
         if ret.has_key('error'):
             raise Exception(ret['error']['desc'])
@@ -190,15 +203,15 @@ class QEMUMonitorProtocol:
=20
     def pull_event(self, wait=3DFalse):
         """
-        Get and delete the first available QMP event.
+        Pulls a single event.
=20
         @param wait (bool): block until an event is available.
         @param wait (float): If wait is a float, treat it as a timeout v=
alue.
=20
         @raise QMPTimeoutError: If a timeout float is provided and the t=
imeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be r=
etrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurre=
d.
=20
         @return The first available QMP event, or None.
         """
@@ -217,8 +230,8 @@ class QEMUMonitorProtocol:
=20
         @raise QMPTimeoutError: If a timeout float is provided and the t=
imeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be r=
etrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurre=
d.
=20
         @return The list of available QMP events.
         """
@@ -235,8 +248,6 @@ class QEMUMonitorProtocol:
         self.__sock.close()
         self.__sockfile.close()
=20
-    timeout =3D socket.timeout
-
     def settimeout(self, timeout):
         self.__sock.settimeout(timeout)
=20
--=20
2.13.5
