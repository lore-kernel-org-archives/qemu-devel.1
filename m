Received: from eggs.gnu.org ([2001:4830:134:3::10]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dZcl1-0002Ke-7y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dZckx-0001Xg-A1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dZckx-0001Wj-0u
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEA2B7EA96
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:46:37 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 24 Jul 2017 14:44:38 +0200
Message-Id: <20170724124438.27344-3-apahim@redhat.com>
In-Reply-To: <20170724124438.27344-1-apahim@redhat.com>
References: <20170724124438.27344-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] qemu.py: cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

is_running():
- Use Popen.poll() instead of Popen.returncode to check whether
  the VM is running or not.

exitcode():
- Use Popen.poll() instead of Popen.returncode to return an updated
exit code.

_load_io_log():
- Add a try/except to prevent raising exception when qemu io file
does not exist.

launch():
- If VM is already running, do nothing.
- If vm is not running but was not cleaned up, call shutdown()
  before launching again.
- Offload the core of this method to _launch().
- Load the args and try to call _launch().
- Make sure we cleanup on exception.
- On exception, print an error message with the qemu command line
  and output.

_launch():
- Execute _pre_launch(), subprocess.Popen() and self._post_launch().
- No try/except here. Any exceptions will be handled by the caller.

shutdown():
- Make sure self._popen is not None before calling self._popen.wait().
- Cleanup the message on negative exit codes.
- Always execute self._load_io_log() and self._post_shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 69 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index fb83e3f998..76d4880f36 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -39,6 +39,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._shutdown_pending = False
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -86,12 +87,12 @@ class QEMUMachine(object):
             raise
 
     def is_running(self):
-        return self._popen and (self._popen.returncode is None)
+        return self._popen and (self._popen.poll() is None)
 
     def exitcode(self):
         if self._popen is None:
             return None
-        return self._popen.returncode
+        return self._popen.poll()
 
     def get_pid(self):
         if not self.is_running():
@@ -99,8 +100,11 @@ class QEMUMachine(object):
         return self._popen.pid
 
     def _load_io_log(self):
-        with open(self._qemu_log_path, "r") as fh:
-            self._iolog = fh.read()
+        try:
+            with open(self._qemu_log_path, "r") as fh:
+                self._iolog = fh.read()
+        except IOError:
+            pass
 
     def _base_args(self):
         if isinstance(self._monitor_address, tuple):
@@ -126,25 +130,43 @@ class QEMUMachine(object):
         self._remove_if_exists(self._qemu_log_path)
 
     def launch(self):
-        '''Launch the VM and establish a QMP connection'''
-        devnull = open('/dev/null', 'rb')
-        qemulog = open(self._qemu_log_path, 'wb')
+        '''
+        Try to launch the VM and make sure we cleanup and expose the
+        command line/output in case of exception.
+        '''
+        if self.is_running():
+            return
+
+        if self._shutdown_pending:
+            sys.stderr.write('shutdown() was not called after previous '
+                             'launch(). Calling now.\n')
+            self.shutdown()
+
         try:
-            self._pre_launch()
-            args = self._wrapper + [self._binary] + self._base_args() + self._args
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
-                                           stderr=subprocess.STDOUT, shell=False)
-            self._post_launch()
+            args = None
+            args = self._wrapper + [self._binary] + self._base_args() + self.args
+            self._launch(args)
+            self._shutdown_pending = True
         except:
-            if self.is_running():
-                self._popen.kill()
-                self._popen.wait()
-            self._load_io_log()
-            self._post_shutdown()
+            self.shutdown()
+            sys.stderr.write('Error launching VM.\n%s%s' %
+                             ('Command:\n%s\n' %
+                              ' '.join(args) if args else '',
+                              'Output:\n%s\n' %
+                              ''.join(self._iolog) if self._iolog else ''))
             raise
 
+    def _launch(self, args):
+        '''Launch the VM and establish a QMP connection.'''
+        devnull = open('/dev/null', 'rb')
+        qemulog = open(self._qemu_log_path, 'wb')
+        self._pre_launch()
+        self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
+                                       stderr=subprocess.STDOUT, shell=False)
+        self._post_launch()
+
     def shutdown(self):
-        '''Terminate the VM and clean up'''
+        '''Terminate the VM and clean up.'''
         if self.is_running():
             try:
                 self._qmp.cmd('quit')
@@ -152,11 +174,12 @@ class QEMUMachine(object):
             except:
                 self._popen.kill()
 
-            exitcode = self._popen.wait()
-            if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
-            self._load_io_log()
-            self._post_shutdown()
+        if self._popen and self._popen.wait() < 0:
+            sys.stderr.write('qemu received signal %i\n' % -self.exitcode())
+
+        self._load_io_log()
+        self._post_shutdown()
+        self._shutdown_pending = False
 
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
-- 
2.13.3
