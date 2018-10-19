Received: from eggs.gnu.org ([2001:4830:134:3::10]:59760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDaFc-0003vz-OO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDaFb-0005Li-B8
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:16:00 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 21:15:20 +0200
Message-Id: <20181019191523.12157-7-mreitz@redhat.com>
In-Reply-To: <20181019191523.12157-1-mreitz@redhat.com>
References: <20181019191523.12157-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/9] iotests: Explicitly inherit FDs in
 Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Python 3.4 introduced the inheritable attribute for FDs.  At the same
time, it changed the default so that all FDs are not inheritable by
default, that only inheritable FDs are inherited to subprocesses, and
only if close_fds is explicitly set to False.

Adhere to this by setting close_fds to False when working with
subprocesses that may want to inherit FDs, and by trying to
set_inheritable() on FDs that we do want to bequeath to them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 scripts/qemu.py        | 34 +++++++++++++++++++++++++++++-----
 tests/qemu-iotests/045 |  2 +-
 tests/qemu-iotests/147 |  2 +-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..fb29b73c30 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -142,11 +142,19 @@ class QEMUMachine(object):
         if opts:
             options.append(opts)
 
+        # This did not exist before 3.4, but since then it is
+        # mandatory for our purpose
+        if hasattr(os, 'set_inheritable'):
+            os.set_inheritable(fd, True)
+
         self._args.append('-add-fd')
         self._args.append(','.join(options))
         return self
 
-    def send_fd_scm(self, fd_file_path):
+    # Exactly one of fd and file_path must be given.
+    # (If it is file_path, the helper will open that file and pass its
+    # own fd)
+    def send_fd_scm(self, fd=None, file_path=None):
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
         if self._socket_scm_helper is None:
@@ -154,12 +162,27 @@ class QEMUMachine(object):
         if not os.path.exists(self._socket_scm_helper):
             raise QEMUMachineError("%s does not exist" %
                                    self._socket_scm_helper)
+
+        # This did not exist before 3.4, but since then it is
+        # mandatory for our purpose
+        if hasattr(os, 'set_inheritable'):
+            os.set_inheritable(self._qmp.get_sock_fd(), True)
+            if fd is not None:
+                os.set_inheritable(fd, True)
+
         fd_param = ["%s" % self._socket_scm_helper,
-                    "%d" % self._qmp.get_sock_fd(),
-                    "%s" % fd_file_path]
+                    "%d" % self._qmp.get_sock_fd()]
+
+        if file_path is not None:
+            assert fd is None
+            fd_param.append(file_path)
+        else:
+            assert fd is not None
+            fd_param.append(str(fd))
+
         devnull = open(os.path.devnull, 'rb')
         proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
-                                stderr=subprocess.STDOUT)
+                                stderr=subprocess.STDOUT, close_fds=False)
         output = proc.communicate()[0]
         if output:
             LOG.debug(output)
@@ -280,7 +303,8 @@ class QEMUMachine(object):
                                        stdin=devnull,
                                        stdout=self._qemu_log_file,
                                        stderr=subprocess.STDOUT,
-                                       shell=False)
+                                       shell=False,
+                                       close_fds=False)
         self._post_launch()
 
     def wait(self):
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 6be8fc4912..55a5d31ca8 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -140,7 +140,7 @@ class TestSCMFd(iotests.QMPTestCase):
         os.remove(image0)
 
     def _send_fd_by_SCM(self):
-        ret = self.vm.send_fd_scm(image0)
+        ret = self.vm.send_fd_scm(file_path=image0)
         self.assertEqual(ret, 0, 'Failed to send fd with UNIX SCM')
 
     def test_add_fd(self):
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index d2081df84b..05b374b7d3 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -229,7 +229,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
         sockfd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
         sockfd.connect(unix_socket)
 
-        result = self.vm.send_fd_scm(str(sockfd.fileno()))
+        result = self.vm.send_fd_scm(fd=sockfd.fileno())
         self.assertEqual(result, 0, 'Failed to send socket FD')
 
         result = self.vm.qmp('getfd', fdname='nbd-fifo')
-- 
2.17.1
