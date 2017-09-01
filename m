Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBQ-0001ca-8n
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBP-00075l-Au
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkBP-00075W-4T
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:19 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:29 +0200
Message-Id: <20170901112829.2571-14-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 13/13] qemu.py: don't launch again before
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
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 363f649a7e..05fca4d268 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -52,6 +52,7 @@ class QEMUMachine(object):
         self._debug = debug
         self._qemu_full_args = None
         self._created_files = []
+        self._pending_shutdown = False
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -168,10 +169,14 @@ class QEMUMachine(object):
         if self.is_running():
             raise QEMUMachineError('VM already running')
 
+        if self._pending_shutdown:
+            raise QEMUMachineError('Shutdown pending after previous launch')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
             self._launch()
+            self._pending_shutdown = True
         except:
             self.shutdown()
 
@@ -217,6 +222,8 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
+        self._pending_shutdown = False
+
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the result dict'''
-- 
2.13.5
