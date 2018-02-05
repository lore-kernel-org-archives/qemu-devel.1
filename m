Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptG-0001rC-7f
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptC-0007Cu-Vh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptC-0007C4-LW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:30 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:51 -0200
Message-Id: <20180205230900.11344-13-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] qemu.py: better control of created files
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
Message-Id: <20180122205033.24893-2-apahim@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 65d9ad688c..8d539206c4 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -17,6 +17,8 @@ import logging
 import os
 import subprocess
 import qmp.qmp
+import shutil
+import tempfile
 
 
 LOG = logging.getLogger(__name__)
@@ -72,10 +74,11 @@ class QEMUMachine(object):
             wrapper = []
         if name is None:
             name = "qemu-%d" % os.getpid()
-        if monitor_address is None:
-            monitor_address = os.path.join(test_dir, name + "-monitor.sock")
+        self._name = name
         self._monitor_address = monitor_address
-        self._qemu_log_path = os.path.join(test_dir, name + ".log")
+        self._vm_monitor = None
+        self._qemu_log_path = None
+        self._qemu_log_file = None
         self._popen = None
         self._binary = binary
         self._args = list(args)     # Force copy args in case we modify them
@@ -85,6 +88,8 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._qmp = None
         self._qemu_full_args = None
+        self._test_dir = test_dir
+        self._temp_dir = None
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -167,36 +172,50 @@ class QEMUMachine(object):
                 self._monitor_address[0],
                 self._monitor_address[1])
         else:
-            moncdev = 'socket,id=mon,path=%s' % self._monitor_address
+            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
         return ['-chardev', moncdev,
                 '-mon', 'chardev=mon,mode=control',
                 '-display', 'none', '-vga', 'none']
 
     def _pre_launch(self):
-        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
+        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
+        if self._monitor_address is not None:
+            self._vm_monitor = self._monitor_address
+        else:
+            self._vm_monitor = os.path.join(self._temp_dir,
+                                            self._name + "-monitor.sock")
+        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
+        self._qemu_log_file = open(self._qemu_log_path, 'wb')
+
+        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
                                                 server=True)
 
     def _post_launch(self):
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
2.14.3
