Received: from eggs.gnu.org ([2001:4830:134:3::10]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXkT-0007zi-G4
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXkS-0002aQ-8l
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dhXkR-0002a4-VX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:02:52 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Tue, 15 Aug 2017 10:57:23 +0200
Message-Id: <20170815085732.9794-2-ldoktor@redhat.com>
In-Reply-To: <20170815085732.9794-1-ldoktor@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
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
---
 scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8..466aaab 100644
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
+        Create a QEMUMachine object
+
+        @param binary: path to the qemu binary (str)
+        @param args: initial list of extra arguments
+        @param wrapper: list of arguments used as prefix to qemu binary
+        @param name: name of this object (used for log/monitor/... file =
names)
+        @param test_dir: base location to put log/monitor/... files in
+        @param monitor_address: custom address for QMP monitor
+        @param socket_scm_helper: path to scm_helper binary (to forward =
fds)
+        @param debug: enable debug mode (forwarded to QMP helper and suc=
h)
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
@@ -114,8 +129,8 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
=20
     def _pre_launch(self):
-        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address,=
 server=3DTrue,
-                                                debug=3Dself._debug)
+        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
+                                                server=3DTrue, debug=3Ds=
elf._debug)
=20
     def _post_launch(self):
         self._qmp.accept()
@@ -131,9 +146,11 @@ class QEMUMachine(object):
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
@@ -149,28 +166,34 @@ class QEMUMachine(object):
             try:
                 self._qmp.cmd('quit')
                 self._qmp.close()
-            except:
+            except:     # kill VM on any failure pylint: disable=3DW0702
                 self._popen.kill()
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
         '''Invoke a QMP command and return the result dict'''
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
+        Invoke a QMP command and on success return result dict or on fai=
lure
+        raise exception with details.
+        '''
         reply =3D self.qmp(cmd, conv_keys, **args)
         if reply is None:
             raise Exception("Monitor is closed")
@@ -193,15 +216,18 @@ class QEMUMachine(object):
         return events
=20
     def event_wait(self, name, timeout=3D60.0, match=3DNone):
-        # Test if 'match' is a recursive subset of 'event'
-        def event_match(event, match=3DNone):
+        '''Wait for event in QMP, optionally filter results by match.'''
+        # Test if 'match' is a recursive subset of 'event'; skips branch
+        # processing on match's value `None`
+        #    {"foo": {"bar": 1} matches {"foo": None}
+        def _event_match(event, match=3DNone):
             if match is None:
                 return True
=20
             for key in match:
                 if key in event:
                     if isinstance(event[key], dict):
-                        if not event_match(event[key], match[key]):
+                        if not _event_match(event[key], match[key]):
                             return False
                     elif event[key] !=3D match[key]:
                         return False
@@ -212,18 +238,22 @@ class QEMUMachine(object):
=20
         # Search cached events
         for event in self._events:
-            if (event['event'] =3D=3D name) and event_match(event, match=
):
+            if (event['event'] =3D=3D name) and _event_match(event, matc=
h):
                 self._events.remove(event)
                 return event
=20
         # Poll for new events
         while True:
             event =3D self._qmp.pull_event(wait=3Dtimeout)
-            if (event['event'] =3D=3D name) and event_match(event, match=
):
+            if (event['event'] =3D=3D name) and _event_match(event, matc=
h):
                 return event
             self._events.append(event)
=20
         return None
=20
     def get_log(self):
+        '''
+        After self.shutdown or failed qemu execution this returns the ou=
tput
+        of the qemu process.
+        '''
         return self._iolog
--=20
2.9.4
