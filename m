Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAm-00013s-FP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAh-0006qq-GC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAh-0006oy-74
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:35 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:20 +0200
Message-Id: <20170901112829.2571-5-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 04/13] qemu.py: improve message on negative
 exit code
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

The current message shows 'self._args', which contains only part of the
options used in the Qemu command line.

This patch makes the qemu full args list an instance variable and then
uses it in the negative exit code message.

Message was moved outside the 'if is_running' block to make sure it will
be logged if the VM finishes before the call to shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index a6e06291ea..670c048569 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -49,6 +49,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._qemu_full_args = None
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -140,13 +141,18 @@ class QEMUMachine(object):
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
+        self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            args = self._wrapper + [self._binary] + self._base_args() + self._args
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
-                                           stderr=subprocess.STDOUT, shell=False)
+            self._qemu_full_args = (self._wrapper + [self._binary] +
+                                    self._base_args() + self._args)
+            self._popen = subprocess.Popen(self._qemu_full_args,
+                                           stdin=devnull,
+                                           stdout=qemulog,
+                                           stderr=subprocess.STDOUT,
+                                           shell=False)
             self._post_launch()
         except:
             if self.is_running():
@@ -164,14 +170,20 @@ class QEMUMachine(object):
                 self._qmp.close()
             except:
                 self._popen.kill()
+            self._popen.wait()
 
-            exitcode = self._popen.wait()
-            if exitcode < 0:
-                LOG.warn('qemu received signal %i: %s', -exitcode,
-                          ' '.join(self._args))
             self._load_io_log()
             self._post_shutdown()
 
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal %i: %s'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.warn(msg, exitcode, command)
+
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the result dict'''
-- 
2.13.5
