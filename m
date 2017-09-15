Received: from eggs.gnu.org ([2001:4830:134:3::10]:56632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0C6-0005f0-UF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0C5-0002aN-Q9
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0C5-0002Vw-IQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:36 -0300
Message-Id: <20170915233739.26860-13-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] qemu.py: avoid writing to stdout/stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

This module should not write directly to stdout/stderr. Instead, it
should either raise exceptions or just log the messages and let the
callers handle them and decide what to do. For example, scripts could
choose to send the log messages stderr or/and write them to a file if
verbose or debugging mode is enabled.

This patch replaces the writes to stderr by an exception in the
send_fd_scm() when _socket_scm_helper is not set or not present. In the
same method, the subprocess Popen will now redirect the stdout/stderr to
logging.debug instead of writing to system stderr. As consequence, since
the Popen.communicate() is now used (in order to get the stdout), the
further call to wait() became redundant and was replaced by
Popen.returncode.

The shutdown() message on negative exit code will now be logged
to logging.warn instead of written to system stderr.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20170901112829.2571-3-apahim@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f80b008f7f..8d3d24dd2b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -13,12 +13,22 @@
 #
 
 import errno
+import logging
 import os
 import sys
 import subprocess
 import qmp.qmp
 
 
+LOG = logging.getLogger(__name__)
+
+
+class QEMUMachineError(Exception):
+    """
+    Exception called when an error in QEMUMachine happens.
+    """
+
+
 class MonitorResponseError(qmp.qmp.QMPError):
     '''
     Represents erroneous QMP monitor reply
@@ -107,18 +117,21 @@ class QEMUMachine(object):
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
         if self._socket_scm_helper is None:
-            print >>sys.stderr, "No path to socket_scm_helper set"
-            return -1
+            raise QEMUMachineError("No path to socket_scm_helper set")
         if not os.path.exists(self._socket_scm_helper):
-            print >>sys.stderr, "%s does not exist" % self._socket_scm_helper
-            return -1
+            raise QEMUMachineError("%s does not exist" %
+                                   self._socket_scm_helper)
         fd_param = ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
                     "%s" % fd_file_path]
         devnull = open('/dev/null', 'rb')
-        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=sys.stdout,
-                                stderr=sys.stderr)
-        return proc.wait()
+        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
+                                stderr=subprocess.STDOUT)
+        output = proc.communicate()[0]
+        if output:
+            LOG.debug(output)
+
+        return proc.returncode
 
     @staticmethod
     def _remove_if_exists(path):
@@ -202,8 +215,8 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n'
-                                 % (-exitcode, ' '.join(self._args)))
+                LOG.warn('qemu received signal %i: %s', -exitcode,
+                          ' '.join(self._args))
             self._load_io_log()
             self._post_shutdown()
 
-- 
2.13.5
