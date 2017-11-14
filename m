Received: from eggs.gnu.org ([2001:4830:134:3::10]:52114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNr-0000IT-2I
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNp-0003QM-0U
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNo-0003Q0-QN
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:56 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:46 +0100
Message-Id: <20171114102246.22221-9-apahim@redhat.com>
In-Reply-To: <20171114102246.22221-1-apahim@redhat.com>
References: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 8/8] qemu.py: don't launch again before
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
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, muriloo@linux.vnet.ibm.com, armbru@redhat.com, Amador Pahim <apahim@redhat.com>

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
index 0b0b61be39..862920099c 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -89,6 +89,7 @@ class QEMUMachine(object):
         self._qemu_full_args = None
         self._test_dir = test_dir
         self._temp_dir = None
+        self._launched = False
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -210,10 +211,14 @@ class QEMUMachine(object):
         if self.is_running():
             raise QEMUMachineError('VM already running')
 
+        if self._launched:
+            raise QEMUMachineError('Shutdown pending after previous launch')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
             self._launch()
+            self._launched = True
         except:
             self.shutdown()
 
@@ -266,6 +271,8 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
+        self._launched = False
+
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.13.6
