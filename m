Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNb-0008UF-EX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNa-0003F4-DG
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNa-0003E2-7C
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:42 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:41 +0100
Message-Id: <20171114102246.22221-4-apahim@redhat.com>
In-Reply-To: <20171114102246.22221-1-apahim@redhat.com>
References: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 3/8] qemu.py: refactor launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, muriloo@linux.vnet.ibm.com, armbru@redhat.com, Amador Pahim <apahim@redhat.com>

This is just an refactor to separate the exception handler from the
actual launch procedure, improving the readability and making future
maintenances in this piece of code easier.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index d5b1cde044..28aa3712c7 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -202,20 +202,14 @@ class QEMUMachine(object):
             self._temp_dir = None
 
     def launch(self):
-        '''Launch the VM and establish a QMP connection'''
+        """
+        Launch the VM and make sure we cleanup and expose the
+        command line/output in case of exception
+        """
         self._iolog = None
         self._qemu_full_args = None
-        devnull = open(os.path.devnull, 'rb')
         try:
-            self._pre_launch()
-            self._qemu_full_args = (self._wrapper + [self._binary] +
-                                    self._base_args() + self._args)
-            self._popen = subprocess.Popen(self._qemu_full_args,
-                                           stdin=devnull,
-                                           stdout=self._qemu_log_file,
-                                           stderr=subprocess.STDOUT,
-                                           shell=False)
-            self._post_launch()
+            self._launch()
         except:
             if self.is_running():
                 self._popen.kill()
@@ -230,6 +224,19 @@ class QEMUMachine(object):
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
+                                       stdout=self._qemu_log_file,
+                                       stderr=subprocess.STDOUT,
+                                       shell=False)
+        self._post_launch()
+
     def wait(self):
         '''Wait for the VM to power off'''
         self._popen.wait()
-- 
2.13.6
