Received: from eggs.gnu.org ([2001:4830:134:3::10]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYETP-0005xL-Bq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYETM-0002iy-5U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYETL-0002ih-SH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0044C0467DA
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:30 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:10 +0200
Message-Id: <20170720162815.19802-7-ldoktor@redhat.com>
In-Reply-To: <20170720162815.19802-1-ldoktor@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

No actual code changes, just a few pylint/style fixes and docstring
clarifications.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 62d3651..bb4d614 100644
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
+        Build and send a QMP command to the monitor, report errors when =
any
+        """
         ret =3D self.cmd(cmd, kwds)
         if ret.has_key('error'):
             raise Exception(ret['error']['desc'])
@@ -190,15 +203,15 @@ class QEMUMonitorProtocol:
=20
     def pull_event(self, wait=3DFalse):
         """
-        Get and delete the first available QMP event.
+        Get and pop the first available QMP event.
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
2.9.4
