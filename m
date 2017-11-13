Received: from eggs.gnu.org ([2001:4830:134:3::10]:34010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUQ-00041v-Mb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUP-0004GC-Rj
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMUP-0004Fq-Ke
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD2526A7CA
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:56 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:45 +0100
Message-Id: <20171113213945.20049-9-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 8/8] qemu.py: don't launch again before
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
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

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
index 7303952328..c615f3075d 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -89,6 +89,7 @@ class QEMUMachine(object):
         self._qemu_full_args = None
         self._test_dir = test_dir
         self._temp_dir = None
+        self._launched = False
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -200,10 +201,14 @@ class QEMUMachine(object):
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
 
@@ -256,6 +261,8 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
+        self._launched = False
+
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.13.6
