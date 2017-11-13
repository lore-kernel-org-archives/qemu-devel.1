Received: from eggs.gnu.org ([2001:4830:134:3::10]:33787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU5-00030n-S7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU5-000460-03
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMU4-00045d-Q5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E40985D5E9
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:35 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:40 +0100
Message-Id: <20171113213945.20049-4-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 3/8] qemu.py: refactor launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

This is just an refactor to separate the exception handler from the
actual launch procedure, improving the readability and making future
maintenances in this piece of code easier.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 58f00bdd64..8a1c97d964 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -192,20 +192,14 @@ class QEMUMachine(object):
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
-                                           stdout=self._qemu_log_fd,
-                                           stderr=subprocess.STDOUT,
-                                           shell=False)
-            self._post_launch()
+            self._launch()
         except:
             if self.is_running():
                 self._popen.kill()
@@ -220,6 +214,19 @@ class QEMUMachine(object):
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
     def wait(self):
         '''Wait for the VM to power off'''
         self._popen.wait()
-- 
2.13.6
