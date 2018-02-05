Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptU-00023h-9P
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptT-0007W5-GT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptT-0007Us-9p
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:47 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:56 -0200
Message-Id: <20180205230900.11344-18-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 17/21] qemu.py: don't launch again before
 shutdown()
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

If a VM is launched, files are created and a cleanup is required before
a new launch. This cleanup is executed by shutdown(), so shutdown() must
be called even if the VM is manually terminated (i.e. using kill).

This patch creates a control to make sure launch() will not be executed
again if shutdown() is not called after the previous launch().

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20180122205033.24893-7-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 09db6249a3..305a946562 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -90,6 +90,7 @@ class QEMUMachine(object):
         self._qemu_full_args = None
         self._test_dir = test_dir
         self._temp_dir = None
+        self._launched = False
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -210,10 +211,15 @@ class QEMUMachine(object):
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
         """
+
+        if self._launched:
+            raise QEMUMachineError('VM already launched')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
             self._launch()
+            self._launched = True
         except:
             self.shutdown()
 
@@ -266,6 +272,8 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
+        self._launched = False
+
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.14.3
