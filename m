Received: from eggs.gnu.org ([2001:4830:134:3::10]:48933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3VA-00043n-3s
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3V6-0001QW-5G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3V5-0001Pr-VJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:04 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:13 +0200
Message-Id: <20170725171014.25193-6-apahim@redhat.com>
In-Reply-To: <20170725171014.25193-1-apahim@redhat.com>
References: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/6] qemu.py: make sure shutdown() is called
 before launching again
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

If launch() is called twice or if the VM is terminated not using
shutdown(), the new call to launch() will fail due to the dirty
environment, with files from the previous instance laying around.

This patch add to launch() the ability to check whether shutdown() was
called after a previous launch(), calling it when applies.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 45a63e8e9d..e18e8ec657 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -39,6 +39,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._shutdown_pending = False
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -135,8 +136,14 @@ class QEMUMachine(object):
         if self.is_running():
             return
 
+        if self._shutdown_pending:
+            sys.stderr.write('shutdown() was not called after previous '
+                             'launch(). Calling now.\n')
+            self.shutdown()
+
         try:
             self._launch()
+            self._shutdown_pending = True
         except:
             self.shutdown()
             raise
@@ -166,6 +173,7 @@ class QEMUMachine(object):
 
         self._load_io_log()
         self._post_shutdown()
+        self._shutdown_pending = False
 
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
-- 
2.13.3
