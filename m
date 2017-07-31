Received: from eggs.gnu.org ([2001:4830:134:3::10]:53364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Qs-0006Af-EV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Qr-0000U2-JT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dc6Qr-0000To-B0
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:09 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 10:51:06 +0200
Message-Id: <20170731085110.1050-4-apahim@redhat.com>
In-Reply-To: <20170731085110.1050-1-apahim@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
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

Let's provide extra control and flexibility by using python logging
system instead of print and/or sys.std*.write().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 77565eb092..e3ea534ec4 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -13,6 +13,7 @@
 #
 
 import errno
+import logging
 import string
 import os
 import sys
@@ -20,11 +21,19 @@ import subprocess
 import qmp.qmp
 
 
+logging.basicConfig()
+LOG = logging.getLogger(__name__)
+
+
 class QEMUMachine(object):
     '''A QEMU VM'''
 
     def __init__(self, binary, args=[], wrapper=[], name=None, test_dir="/var/tmp",
                  monitor_address=None, socket_scm_helper=None, debug=False):
+        if debug:
+            LOG.setLevel(logging.DEBUG)
+        else:
+            LOG.setLevel(logging.INFO)
         if name is None:
             name = "qemu-%d" % os.getpid()
         if monitor_address is None:
@@ -62,10 +71,10 @@ class QEMUMachine(object):
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
         if self._socket_scm_helper is None:
-            print >>sys.stderr, "No path to socket_scm_helper set"
+            LOG.error("No path to socket_scm_helper set")
             return -1
         if os.path.exists(self._socket_scm_helper) == False:
-            print >>sys.stderr, "%s does not exist" % self._socket_scm_helper
+            LOG.error("%s does not exist", self._socket_scm_helper)
             return -1
         fd_param = ["%s" % self._socket_scm_helper,
                     "%d" % self._qmp.get_sock_fd(),
@@ -154,7 +163,8 @@ class QEMUMachine(object):
 
             exitcode = self._popen.wait()
             if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
+                LOG.error('qemu received signal %i: %s', -exitcode,
+                          ' '.join(self._args))
             self._load_io_log()
             self._post_shutdown()
 
-- 
2.13.3
