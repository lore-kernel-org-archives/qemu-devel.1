Received: from eggs.gnu.org ([2001:4830:134:3::10]:41831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoK-0007IP-6o
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoH-0005cn-24
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikoG-0005cc-Sb
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:11:49 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:25 +0200
Message-Id: <20170818170526.13496-11-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-1-apahim@redhat.com>
References: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/11] qemu.py: don't launch again before
 shutdown()
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

If a VM is launched, files are created and a cleanup is required before
a new launch. This cleanup is executed by shutdown(), so shutdown() must
be called even if the VM is manually terminated (i.e. using kill).

This patch creates a control to make sure launch() will not be executed
again if shutdown() is not called after the previous launch().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 46e8ff3232..2bd81afcf2 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -52,6 +52,7 @@ class QEMUMachine(object):
         self._debug = debug
         self._qemu_full_args = None
         self._created_files = []
+        self._pending_shutdown = False
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -173,6 +174,9 @@ class QEMUMachine(object):
         if self.is_running():
             raise QEMULaunchError('VM already running')
 
+        if self._pending_shutdown:
+            raise QEMULaunchError('Shutdown pending after previous launch')
+
         try:
             self._pre_launch()
             self._qemu_full_args = (self._wrapper + [self._binary] +
@@ -183,6 +187,7 @@ class QEMUMachine(object):
                                            stderr=subprocess.STDOUT,
                                            shell=False)
             self._post_launch()
+            self._pending_shutdown = True
         except:
             self.shutdown()
 
@@ -215,6 +220,7 @@ class QEMUMachine(object):
 
         self._load_io_log()
         self._post_shutdown()
+        self._pending_shutdown = False
 
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
-- 
2.13.5
