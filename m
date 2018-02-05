Received: from eggs.gnu.org ([2001:4830:134:3::10]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptI-0001tN-MO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptH-0007FY-P2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptH-0007FB-IR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:35 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:52 -0200
Message-Id: <20180205230900.11344-14-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 13/21] qemu.py: refactor launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

This is just a refactor to separate the exception handler from the
actual launch procedure, improving the readability and making future
maintenances in this piece of code easier.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20180122205033.24893-3-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 8d539206c4..0333d1e7fa 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -205,20 +205,14 @@ class QEMUMachine(object):
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
@@ -233,6 +227,19 @@ class QEMUMachine(object):
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
2.14.3
