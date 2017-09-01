Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkB3-0001Ik-Hx
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkB0-0006xZ-Cp
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkB0-0006xG-75
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:54 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:24 +0200
Message-Id: <20170901112829.2571-9-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 08/13] qemu.py: refactor launch()
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

This is just an refactor to separate the exception handler from the
actual launch procedure, improving the readability and making future
maintenances in this piece of code easier.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 1b77fec48b..06f07bfaa2 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -160,20 +160,14 @@ class QEMUMachine(object):
             self._remove_if_exists(self._created_files.pop())
 
     def launch(self):
-        '''Launch the VM and establish a QMP connection'''
+        '''
+        Try to launch the VM and make sure we cleanup and expose the
+        command line/output in case of exception.
+        '''
         self._iolog = None
         self._qemu_full_args = None
-        devnull = open(os.path.devnull, 'rb')
         try:
-            self._pre_launch()
-            self._qemu_full_args = (self._wrapper + [self._binary] +
-                                    self._base_args() + self._args)
-            self._popen = subprocess.Popen(self._qemu_full_args,
-                                           stdin=devnull,
-                                           stdout=self._qemu_log_fd,
-                                           stderr=subprocess.STDOUT,
-                                           shell=False)
-            self._post_launch()
+            self._launch()
         except:
             if self.is_running():
                 self._popen.kill()
@@ -188,6 +182,19 @@ class QEMUMachine(object):
                 LOG.debug('Output: %r', self._iolog)
             raise
 
+    def _launch(self):
+        '''Launch the VM and establish a QMP connection'''
+        devnull = open(os.path.devnull, 'rb')
+        self._pre_launch()
+        self._qemu_full_args = (self._wrapper + [self._binary] +
+                                self._base_args() + self._args)
+        self._popen = subprocess.Popen(self._qemu_full_args,
+                                       stdin=devnull,
+                                       stdout=self._qemu_log_fd,
+                                       stderr=subprocess.STDOUT,
+                                       shell=False)
+        self._post_launch()
+
     def shutdown(self):
         '''Terminate the VM and clean up'''
         if self.is_running():
-- 
2.13.5
