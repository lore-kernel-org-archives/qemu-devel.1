Received: from eggs.gnu.org ([2001:4830:134:3::10]:51980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNd-0008Vr-La
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNX-0003Bx-St
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNX-0003Ax-Kc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:39 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:40 +0100
Message-Id: <20171114102246.22221-3-apahim@redhat.com>
In-Reply-To: <20171114102246.22221-1-apahim@redhat.com>
References: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 2/8] qemu.py: better control of created
 files
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

To launch a VM, we need to create basically two files: the monitor
socket (if it's a UNIX socket) and the qemu log file.

For the qemu log file, we currently just open the path, which will
create the file if it does not exist or overwrite the file if it does
exist.

For the monitor socket, if it already exists, we are currently removing
it, even if it's not created by us.

This patch moves to _pre_launch() the responsibility to create a
temporary directory to host the files so we can remove the whole
directory on _post_shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 65d9ad688c..d5b1cde044 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -17,6 +17,8 @@ import logging
 import os
 import subprocess
 import qmp.qmp
+import shutil
+import tempfile
 
 
 LOG = logging.getLogger(__name__)
@@ -72,10 +74,10 @@ class QEMUMachine(object):
             wrapper = []
         if name is None:
             name = "qemu-%d" % os.getpid()
-        if monitor_address is None:
-            monitor_address = os.path.join(test_dir, name + "-monitor.sock")
+        self._name = name
         self._monitor_address = monitor_address
-        self._qemu_log_path = os.path.join(test_dir, name + ".log")
+        self._qemu_log_path = None
+        self._qemu_log_file = None
         self._popen = None
         self._binary = binary
         self._args = list(args)     # Force copy args in case we modify them
@@ -85,6 +87,8 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._qmp = None
         self._qemu_full_args = None
+        self._test_dir = test_dir
+        self._temp_dir = None
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -173,6 +177,13 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
 
     def _pre_launch(self):
+        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
+        if not isinstance(self._monitor_address, tuple):
+            self._monitor_address = os.path.join(self._temp_dir,
+                                                 self._name + "-monitor.sock")
+        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
+        self._qemu_log_file = open(self._qemu_log_path, 'wb')
+
         self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
                                                 server=True)
 
@@ -180,23 +191,28 @@ class QEMUMachine(object):
         self._qmp.accept()
 
     def _post_shutdown(self):
-        if not isinstance(self._monitor_address, tuple):
-            self._remove_if_exists(self._monitor_address)
-        self._remove_if_exists(self._qemu_log_path)
+        if self._qemu_log_file is not None:
+            self._qemu_log_file.close()
+            self._qemu_log_file = None
+
+        self._qemu_log_path = None
+
+        if self._temp_dir is not None:
+            shutil.rmtree(self._temp_dir)
+            self._temp_dir = None
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
         self._iolog = None
         self._qemu_full_args = None
         devnull = open(os.path.devnull, 'rb')
-        qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
             self._qemu_full_args = (self._wrapper + [self._binary] +
                                     self._base_args() + self._args)
             self._popen = subprocess.Popen(self._qemu_full_args,
                                            stdin=devnull,
-                                           stdout=qemulog,
+                                           stdout=self._qemu_log_file,
                                            stderr=subprocess.STDOUT,
                                            shell=False)
             self._post_launch()
-- 
2.13.6
