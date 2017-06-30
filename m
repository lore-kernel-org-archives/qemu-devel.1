Received: from eggs.gnu.org ([2001:4830:134:3::10]:48622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dR1Ix-00078y-87
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dR1Iu-0003Xx-3H
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:10:11 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dR1It-0003PV-2P
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:10:08 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Sat,  1 Jul 2017 00:39:41 +0530
Message-Id: <1498849781-12776-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH] Python3 Support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This patch intends to make qmp.py compatible with both python2 and python3.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 scripts/qmp/qmp.py | 66 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 62d3651..9926c36 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -13,18 +13,23 @@ import errno
 import socket
 import sys
 
+
 class QMPError(Exception):
     pass
 
+
 class QMPConnectError(QMPError):
     pass
 
+
 class QMPCapabilitiesError(QMPError):
     pass
 
+
 class QMPTimeoutError(QMPError):
     pass
 
+
 class QEMUMonitorProtocol:
     def __init__(self, address, server=False, debug=False):
         """
@@ -42,6 +47,7 @@ class QEMUMonitorProtocol:
         self.__address = address
         self._debug = debug
         self.__sock = self.__get_sock()
+        self.data = b""
         if server:
             self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
             self.__sock.bind(self.__address)
@@ -56,23 +62,35 @@ class QEMUMonitorProtocol:
 
     def __negotiate_capabilities(self):
         greeting = self.__json_read()
-        if greeting is None or not greeting.has_key('QMP'):
+        if greeting is None or 'QMP' not in greeting:
             raise QMPConnectError
-        # Greeting seems ok, negotiate capabilities
         resp = self.cmd('qmp_capabilities')
         if "return" in resp:
             return greeting
         raise QMPCapabilitiesError
 
+    def __sock_readline(self):
+        while True:
+            ch = self.__sock.recv(1)
+            if ch is None:
+                if self.data:
+                    raise ValueError('socket closed mid-line')
+                return None
+            self.data += ch
+            if ch == b'\n':
+                line = self.data.decode('utf-8')
+                self.data = b""
+                return line
+
     def __json_read(self, only_event=False):
         while True:
-            data = self.__sockfile.readline()
+            data = self.__sock_readline()
             if not data:
                 return
             resp = json.loads(data)
             if 'event' in resp:
                 if self._debug:
-                    print >>sys.stderr, "QMP:<<< %s" % resp
+                    print("QMP:<<< %s" % resp)
                 self.__events.append(resp)
                 if not only_event:
                     continue
@@ -87,18 +105,18 @@ class QEMUMonitorProtocol:
         @param wait (bool): block until an event is available.
         @param wait (float): If wait is a float, treat it as a timeout value.
 
-        @raise QMPTimeoutError: If a timeout float is provided and the timeout
-                                period elapses.
-        @raise QMPConnectError: If wait is True but no events could be retrieved
-                                or if some other error occurred.
+        @raise QMPTimeoutError: If a timeout float is provided and the
+                                timeout period elapses.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurred.
         """
 
         # Check for new events regardless and pull them into the cache:
         self.__sock.setblocking(0)
         try:
-            self.__json_read()
+            test = self.__json_read()
         except socket.error as err:
-            if err[0] == errno.EAGAIN:
+            if err.errno == errno.EAGAIN:
                 # No data available
                 pass
         self.__sock.setblocking(1)
@@ -128,7 +146,7 @@ class QEMUMonitorProtocol:
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
         self.__sock.connect(self.__address)
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile('rb')
         if negotiate:
             return self.__negotiate_capabilities()
 
@@ -143,7 +161,7 @@ class QEMUMonitorProtocol:
         """
         self.__sock.settimeout(15)
         self.__sock, _ = self.__sock.accept()
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile('rb')
         return self.__negotiate_capabilities()
 
     def cmd_obj(self, qmp_cmd):
@@ -155,16 +173,17 @@ class QEMUMonitorProtocol:
                 been closed
         """
         if self._debug:
-            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
+            print("QMP:>>> %s" % qmp_cmd)
         try:
-            self.__sock.sendall(json.dumps(qmp_cmd))
+            command = json.dumps(qmp_cmd)
+            self.__sock.sendall(command.encode('UTF-8'))
         except socket.error as err:
-            if err[0] == errno.EPIPE:
+            if err.errno == errno.EPIPE:
                 return
-            raise socket.error(err)
+            raise
         resp = self.__json_read()
         if self._debug:
-            print >>sys.stderr, "QMP:<<< %s" % resp
+            print("QMP:<<< %s" % resp)
         return resp
 
     def cmd(self, name, args=None, id=None):
@@ -175,7 +194,7 @@ class QEMUMonitorProtocol:
         @param args: command arguments (dict)
         @param id: command id (dict, list, string or int)
         """
-        qmp_cmd = { 'execute': name }
+        qmp_cmd = {'execute': name}
         if args:
             qmp_cmd['arguments'] = args
         if id:
@@ -184,7 +203,7 @@ class QEMUMonitorProtocol:
 
     def command(self, cmd, **kwds):
         ret = self.cmd(cmd, kwds)
-        if ret.has_key('error'):
+        if 'error' in ret:
             raise Exception(ret['error']['desc'])
         return ret['return']
 
@@ -197,8 +216,8 @@ class QEMUMonitorProtocol:
 
         @raise QMPTimeoutError: If a timeout float is provided and the timeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be retrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurred.
 
         @return The first available QMP event, or None.
         """
@@ -217,8 +236,8 @@ class QEMUMonitorProtocol:
 
         @raise QMPTimeoutError: If a timeout float is provided and the timeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be retrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurred.
 
         @return The list of available QMP events.
         """
@@ -245,3 +264,4 @@ class QEMUMonitorProtocol:
 
     def is_scm_available(self):
         return self.__sock.family == socket.AF_UNIX
+
-- 
2.7.4
