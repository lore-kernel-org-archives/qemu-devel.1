Received: from eggs.gnu.org ([2001:4830:134:3::10]:42098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dTCAN-0004DV-Pq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 15:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dTCAK-000345-JC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 15:10:19 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:42808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dTCAJ-0002yb-Hu
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 15:10:16 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Fri,  7 Jul 2017 00:38:47 +0530
Message-Id: <1499368127-19855-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH v2] Python3 Support for qmp.py
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

 * Python 3 does not have dict.has_key(key), use key in dict instead
 * Avoid line-based I/O since Python 2/3 have different character
   encoding behavior.  Explicitly encode/decode JSON UTF-8.
 * Replace print by print function.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 scripts/qmp/qmp.py | 58 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 62d3651..58fb7d1 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -42,6 +42,7 @@ class QEMUMonitorProtocol:
         self.__address = address
         self._debug = debug
         self.__sock = self.__get_sock()
+        self.__data = b""
         if server:
             self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
             self.__sock.bind(self.__address)
@@ -56,7 +57,7 @@ class QEMUMonitorProtocol:
 
     def __negotiate_capabilities(self):
         greeting = self.__json_read()
-        if greeting is None or not greeting.has_key('QMP'):
+        if greeting is None or 'QMP' not in greeting:
             raise QMPConnectError
         # Greeting seems ok, negotiate capabilities
         resp = self.cmd('qmp_capabilities')
@@ -64,15 +65,28 @@ class QEMUMonitorProtocol:
             return greeting
         raise QMPCapabilitiesError
 
+    def __sock_readline(self):
+        while True:
+            ch = self.__sock.recv(1)
+            if ch is None:
+                if self.__data:
+                    raise ValueError('socket closed mid-line')
+                return None
+            self.__data += ch
+            if ch == b'\n':
+                line = self.__data.decode('utf-8')
+                self.__data = b""
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
@@ -87,10 +101,10 @@ class QEMUMonitorProtocol:
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
@@ -98,9 +112,11 @@ class QEMUMonitorProtocol:
         try:
             self.__json_read()
         except socket.error as err:
-            if err[0] == errno.EAGAIN:
+            if err.errno == errno.EAGAIN:
                 # No data available
                 pass
+            else:
+                raise
         self.__sock.setblocking(1)
 
         # Wait for new events, if needed.
@@ -128,7 +144,6 @@ class QEMUMonitorProtocol:
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
         self.__sock.connect(self.__address)
-        self.__sockfile = self.__sock.makefile()
         if negotiate:
             return self.__negotiate_capabilities()
 
@@ -143,7 +158,6 @@ class QEMUMonitorProtocol:
         """
         self.__sock.settimeout(15)
         self.__sock, _ = self.__sock.accept()
-        self.__sockfile = self.__sock.makefile()
         return self.__negotiate_capabilities()
 
     def cmd_obj(self, qmp_cmd):
@@ -155,16 +169,17 @@ class QEMUMonitorProtocol:
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
@@ -175,7 +190,7 @@ class QEMUMonitorProtocol:
         @param args: command arguments (dict)
         @param id: command id (dict, list, string or int)
         """
-        qmp_cmd = { 'execute': name }
+        qmp_cmd = {'execute': name}
         if args:
             qmp_cmd['arguments'] = args
         if id:
@@ -184,7 +199,7 @@ class QEMUMonitorProtocol:
 
     def command(self, cmd, **kwds):
         ret = self.cmd(cmd, kwds)
-        if ret.has_key('error'):
+        if 'error' in ret:
             raise Exception(ret['error']['desc'])
         return ret['return']
 
@@ -197,8 +212,8 @@ class QEMUMonitorProtocol:
 
         @raise QMPTimeoutError: If a timeout float is provided and the timeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be retrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurred.
 
         @return The first available QMP event, or None.
         """
@@ -217,8 +232,8 @@ class QEMUMonitorProtocol:
 
         @raise QMPTimeoutError: If a timeout float is provided and the timeout
                                 period elapses.
-        @raise QMPConnectError: If wait is True but no events could be retrieved
-                                or if some other error occurred.
+        @raise QMPConnectError: If wait is True but no events could be
+                                retrieved or if some other error occurred.
 
         @return The list of available QMP events.
         """
@@ -245,3 +260,4 @@ class QEMUMonitorProtocol:
 
     def is_scm_available(self):
         return self.__sock.family == socket.AF_UNIX
+
-- 
2.7.4
