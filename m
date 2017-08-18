Received: from eggs.gnu.org ([2001:4830:134:3::10]:41895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoV-0007SQ-7S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoS-0005fb-2g
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikoR-0005fP-Qe
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:00 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:21 +0200
Message-Id: <20170818170526.13496-7-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-1-apahim@redhat.com>
References: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 06/11] qemu.py: improve message on negative
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
index 902d4c6c78..0bcec4b3b1 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -49,6 +49,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._qemu_full_args = None
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -146,13 +147,18 @@ class QEMUMachine(object):
 
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
             self.shutdown()
@@ -166,11 +172,17 @@ class QEMUMachine(object):
                 self._qmp.close()
             except:
                 self._popen.kill()
+            self._popen.wait()
+
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal -%i: %s'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.debug(msg, exitcode, command)
 
-            exitcode = self._popen.wait()
-            if exitcode < 0:
-                LOG.debug('qemu received signal %i: %s', -exitcode,
-                          ' '.join(self._args))
         self._load_io_log()
         self._post_shutdown()
 
-- 
2.13.5
