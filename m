Received: from eggs.gnu.org ([2001:4830:134:3::10]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3R-0004bZ-GS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3Q-0000XW-GQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:50:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1edj3Q-0000Wq-7M
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44BD71A407E
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 20:50:55 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 22 Jan 2018 21:50:28 +0100
Message-Id: <20180122205033.24893-2-apahim@redhat.com>
In-Reply-To: <20180122205033.24893-1-apahim@redhat.com>
References: <20180122205033.24893-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v12 1/6] qemu.py: better control of created
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
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

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
 scripts/qemu.py | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9bfdf6d37d..453a67250a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -18,6 +18,8 @@ import os
 import sys
 import subprocess
 import qmp.qmp
+import shutil
+import tempfile
 
 
 LOG = logging.getLogger(__name__)
@@ -73,10 +75,11 @@ class QEMUMachine(object):
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
@@ -86,6 +89,8 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._qmp = None
         self._qemu_full_args = None
+        self._test_dir = test_dir
+        self._temp_dir = None
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -168,36 +173,50 @@ class QEMUMachine(object):
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
