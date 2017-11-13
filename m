Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1eENlG-0000q6-CH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1eENlC-00020b-B5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:03:26 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:52694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1eENlC-0001zJ-3t
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:03:22 -0500
Received: by mail-io0-f171.google.com with SMTP id u42so4420889ioi.9
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 15:03:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113222358.30967-3-apahim@redhat.com>
References: <20171113222358.30967-1-apahim@redhat.com>
	<20171113222358.30967-3-apahim@redhat.com>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 00:03:18 +0100
Message-ID: <CALAZnb2wxK86kAG63RkZT-iRqKjmv=0kCpJHgWA_49eojpVJLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10 2/8] qemu.py: better control of created
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
Cc: Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>, ehabkost@redhat.com

On 13 Nov 2017 11:24 pm, "Amador Pahim" <apahim@redhat.com> wrote:

To launch a VM, we need to create basically two files: the monitor
socket (if it's a UNIX socket) and the qemu log file.

For the qemu log file, we currently just open the path, which will
create the file if it does not exist or overwrite the file if it does
exist.

For the monitor socket, if it already exists, we are currently removing
it, even if it's not created by us.

This patch moves to pre_launch() the responsibility to create a
temporary directory to host the files so we can remove the whole
directory on post_shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 65d9ad688c..c14d6cc8d4 100644
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
-            monitor_address = os.path.join(test_dir, name +
"-monitor.sock")
+        self._name = name
         self._monitor_address = monitor_address
-        self._qemu_log_path = os.path.join(test_dir, name + ".log")
+        self._qemu_log_path = None
+        self._qemu_log_fd = None
         self._popen = None
         self._binary = binary
         self._args = list(args)     # Force copy args in case we modify
them
@@ -85,6 +87,8 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._qmp = None
         self._qemu_full_args = None
+        self._test_dir = test_dir
+        self._temp_dir = None

         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -136,13 +140,13 @@ class QEMUMachine(object):

     @staticmethod
     def _remove_if_exists(path):
-        '''Remove file object at path if it exists'''
+    '''Remove file object at path if it exists'''


Messed indentation, please ignore. To be fixed in the next version or
before merge.

         try:
             os.remove(path)
         except OSError as exception:
             if exception.errno == errno.ENOENT:
                 return
-            raise
+        raise


Messed indentation, please ignore. To be fixed in the next version or
before merge.



     def is_running(self):
         return self._popen is not None and self._popen.returncode is None
@@ -173,6 +177,13 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']

     def _pre_launch(self):
+        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
+        if not isinstance(self._monitor_address, tuple):
+            self._monitor_address = os.path.join(self._temp_dir,
+                                                 self._name +
"-monitor.sock")
+        self._qemu_log_path = os.path.join(self._temp_dir, self._name +
".log")
+        self._qemu_log_fd = open(self._qemu_log_path, 'wb')
+
         self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
                                                 server=True)

@@ -180,23 +191,28 @@ class QEMUMachine(object):
         self._qmp.accept()

     def _post_shutdown(self):
-        if not isinstance(self._monitor_address, tuple):
-            self._remove_if_exists(self._monitor_address)
-        self._remove_if_exists(self._qemu_log_path)
+        if self._qemu_log_fd is not None:
+            self._qemu_log_fd.close()
+            self._qemu_log_fd = None
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
+                                           stdout=self._qemu_log_fd,
                                            stderr=subprocess.STDOUT,
                                            shell=False)
             self._post_launch()
--
2.13.6
