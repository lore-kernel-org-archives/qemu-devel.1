Received: from eggs.gnu.org ([2001:4830:134:3::10]:49520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3XC-0005aj-Bz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3X8-0002Ox-Ak
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:22:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3X8-0002Of-1f
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:22:10 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:12 +0200
Message-Id: <20170725171014.25193-5-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-1-apahim@redhat.com>
References: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/6] qemu.py: cleanup launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

launch() is currently taking care of a number of flows, each one if its
own exception treatment, depending on the VM state and the files
creation state.

This patch makes launch() more resilient, off-loading the core calls to
the new _launch() and calling shutdown() if any exception is raised by
_launch(), making sure VM will be terminated and cleaned up.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 56142ed59b..45a63e8e9d 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -99,8 +99,11 @@ class QEMUMachine(object):
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
@@ -126,23 +129,28 @@ class QEMUMachine(object):
         self._remove_if_exists(self._qemu_log_path)
 
     def launch(self):
-        '''Launch the VM and establish a QMP connection'''
-        devnull = open('/dev/null', 'rb')
-        qemulog = open(self._qemu_log_path, 'wb')
+        '''
+        Try to launch the VM and make sure we cleanup on exception.
+        '''
+        if self.is_running():
+            return
+
         try:
-            self._pre_launch()
-            args = self._wrapper + [self._binary] + self._base_args() + self.args
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
-                                           stderr=subprocess.STDOUT, shell=False)
-            self._post_launch()
+            self._launch()
         except:
-            if self.is_running():
-                self._popen.kill()
-                self._popen.wait()
-            self._load_io_log()
-            self._post_shutdown()
+            self.shutdown()
             raise
 
+    def _launch(self):
+        '''Launch the VM and establish a QMP connection.'''
+        devnull = open('/dev/null', 'rb')
+        qemulog = open(self._qemu_log_path, 'wb')
+        self._pre_launch()
+        args = self._wrapper + [self._binary] + self._base_args() + self._args
+        self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
+                                       stderr=subprocess.STDOUT, shell=False)
+        self._post_launch()
+
     def shutdown(self):
         '''Terminate the VM and clean up'''
         if self.is_running():
@@ -156,8 +164,8 @@ class QEMUMachine(object):
             if exitcode < 0:
                 sys.stderr.write('qemu received signal %i\n' % -exitcode)
 
-            self._load_io_log()
-            self._post_shutdown()
+        self._load_io_log()
+        self._post_shutdown()
 
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
-- 
2.13.3
