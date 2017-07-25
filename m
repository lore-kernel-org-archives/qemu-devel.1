Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3VC-000463-03
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3V6-0001QR-4P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3V5-0001Pt-UR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:04 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:14 +0200
Message-Id: <20170725171014.25193-7-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-1-apahim@redhat.com>
References: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 6/6] qemu.py: include qemu command line and
 output on launch error
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

When launching a VM, if an exception happens and the VM is not
initiated, it is useful to see the qemu command line that was executed
and the output of that command.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index e18e8ec657..abfa3eebe9 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -131,7 +131,8 @@ class QEMUMachine(object):
 
     def launch(self):
         '''
-        Try to launch the VM and make sure we cleanup on exception.
+        Try to launch the VM and make sure we cleanup and expose the
+        command line/output in case of exception.
         '''
         if self.is_running():
             return
@@ -142,18 +143,24 @@ class QEMUMachine(object):
             self.shutdown()
 
         try:
-            self._launch()
+            args = None
+            args = self._wrapper + [self._binary] + self._base_args() + self._args
+            self._launch(args)
             self._shutdown_pending = True
         except:
             self.shutdown()
+            sys.stderr.write('Error launching VM.\n%s%s' %
+                             ('Command:\n%s\n' %
+                              ' '.join(args) if args else '',
+                              'Output:\n%s\n' %
+                              ''.join(self._iolog) if self._iolog else ''))
             raise
 
-    def _launch(self):
+    def _launch(self, args):
         '''Launch the VM and establish a QMP connection.'''
         devnull = open('/dev/null', 'rb')
         qemulog = open(self._qemu_log_path, 'wb')
         self._pre_launch()
-        args = self._wrapper + [self._binary] + self._base_args() + self._args
         self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
                                        stderr=subprocess.STDOUT, shell=False)
         self._post_launch()
-- 
2.13.3
