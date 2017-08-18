Received: from eggs.gnu.org ([2001:4830:134:3::10]:58176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEh-00005O-0L
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEd-00077r-OW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1diiEd-000764-Et
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:51 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Fri, 18 Aug 2017 16:26:04 +0200
Message-Id: <20170818142613.32394-2-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-1-ldoktor@redhat.com>
References: <20170818142613.32394-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 01/10] qemu.py: Pylint/style fixes
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

No actual code changes, just several pylint/style fixes and docstring
clarifications.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemu.py | 73 +++++++++++++++++++++++++++++++++++++++++++--------=
------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8..dd679f1 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -23,8 +23,22 @@ import qmp.qmp
 class QEMUMachine(object):
     '''A QEMU VM'''
=20
-    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone, tes=
t_dir=3D"/var/tmp",
-                 monitor_address=3DNone, socket_scm_helper=3DNone, debug=
=3DFalse):
+    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
+                 test_dir=3D"/var/tmp", monitor_address=3DNone,
+                 socket_scm_helper=3DNone, debug=3DFalse):
+        '''
+        Initialize a QEMUMachine
+
+        @param binary: path to the qemu binary
+        @param args: list of extra arguments
+        @param wrapper: list of arguments used as prefix to qemu binary
+        @param name: prefix for socket and log file names (default: qemu=
-PID)
+        @param test_dir: where to create socket and log file
+        @param monitor_address: address for QMP monitor
+        @param socket_scm_helper: helper program, required for send_fd_s=
cm()"
+        @param debug: enable debug mode
+        @note: Qemu process is not started until launch() is used.
+        '''
         if name is None:
             name =3D "qemu-%d" % os.getpid()
         if monitor_address is None:
@@ -33,12 +47,13 @@ class QEMUMachine(object):
         self._qemu_log_path =3D os.path.join(test_dir, name + ".log")
         self._popen =3D None
         self._binary =3D binary
-        self._args =3D list(args) # Force copy args in case we modify th=
em
+        self._args =3D list(args)     # Force copy args in case we modif=
y them
         self._wrapper =3D wrapper
         self._events =3D []
         self._iolog =3D None
         self._socket_scm_helper =3D socket_scm_helper
         self._debug =3D debug
+        self._qmp =3D None
=20
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -64,16 +79,16 @@ class QEMUMachine(object):
         if self._socket_scm_helper is None:
             print >>sys.stderr, "No path to socket_scm_helper set"
             return -1
-        if os.path.exists(self._socket_scm_helper) =3D=3D False:
+        if not os.path.exists(self._socket_scm_helper):
             print >>sys.stderr, "%s does not exist" % self._socket_scm_h=
elper
             return -1
         fd_param =3D ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
                     "%s" % fd_file_path]
         devnull =3D open('/dev/null', 'rb')
-        p =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsys.s=
tdout,
-                             stderr=3Dsys.stderr)
-        return p.wait()
+        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsy=
s.stdout,
+                                stderr=3Dsys.stderr)
+        return proc.wait()
=20
     @staticmethod
     def _remove_if_exists(path):
@@ -99,8 +114,8 @@ class QEMUMachine(object):
         return self._popen.pid
=20
     def _load_io_log(self):
-        with open(self._qemu_log_path, "r") as fh:
-            self._iolog =3D fh.read()
+        with open(self._qemu_log_path, "r") as iolog:
+            self._iolog =3D iolog.read()
=20
     def _base_args(self):
         if isinstance(self._monitor_address, tuple):
@@ -114,7 +129,8 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
=20
     def _pre_launch(self):
-        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address,=
 server=3DTrue,
+        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
+                                                server=3DTrue,
                                                 debug=3Dself._debug)
=20
     def _post_launch(self):
@@ -131,9 +147,11 @@ class QEMUMachine(object):
         qemulog =3D open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            args =3D self._wrapper + [self._binary] + self._base_args() =
+ self._args
+            args =3D (self._wrapper + [self._binary] + self._base_args()=
 +
+                    self._args)
             self._popen =3D subprocess.Popen(args, stdin=3Ddevnull, stdo=
ut=3Dqemulog,
-                                           stderr=3Dsubprocess.STDOUT, s=
hell=3DFalse)
+                                           stderr=3Dsubprocess.STDOUT,
+                                           shell=3DFalse)
             self._post_launch()
         except:
             if self.is_running():
@@ -154,23 +172,30 @@ class QEMUMachine(object):
=20
             exitcode =3D self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exi=
tcode, ' '.join(self._args)))
+                sys.stderr.write('qemu received signal %i: %s\n'
+                                 % (-exitcode, ' '.join(self._args)))
             self._load_io_log()
             self._post_shutdown()
=20
     underscore_to_dash =3D string.maketrans('_', '-')
+
     def qmp(self, cmd, conv_keys=3DTrue, **args):
-        '''Invoke a QMP command and return the result dict'''
+        '''Invoke a QMP command and return the response dict'''
         qmp_args =3D dict()
-        for k in args.keys():
+        for key in args.keys():
             if conv_keys:
-                qmp_args[k.translate(self.underscore_to_dash)] =3D args[=
k]
+                qmp_args[key.translate(self.underscore_to_dash)] =3D arg=
s[key]
             else:
-                qmp_args[k] =3D args[k]
+                qmp_args[key] =3D args[key]
=20
         return self._qmp.cmd(cmd, args=3Dqmp_args)
=20
     def command(self, cmd, conv_keys=3DTrue, **args):
+        '''
+        Invoke a QMP command.
+        On success return the response dict.
+        On failure raise an exception.
+        '''
         reply =3D self.qmp(cmd, conv_keys, **args)
         if reply is None:
             raise Exception("Monitor is closed")
@@ -193,7 +218,15 @@ class QEMUMachine(object):
         return events
=20
     def event_wait(self, name, timeout=3D60.0, match=3DNone):
-        # Test if 'match' is a recursive subset of 'event'
+        '''
+        Wait for specified timeout on named event in QMP; optionally fil=
ter
+        results by match.
+
+        The 'match' is checked to be a recursive subset of the 'event'; =
skips
+        branch processing on match's value None
+           {"foo": {"bar": 1}} matches {"foo": None}
+           {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
+        '''
         def event_match(event, match=3DNone):
             if match is None:
                 return True
@@ -226,4 +259,8 @@ class QEMUMachine(object):
         return None
=20
     def get_log(self):
+        '''
+        After self.shutdown or failed qemu execution, this returns the o=
utput
+        of the qemu process.
+        '''
         return self._iolog
--=20
2.9.4
