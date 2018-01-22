Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3a-0004iU-9U
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3Y-0000eP-Of
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1edj3Y-0000dn-Ht
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A01DB7E420
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 20:51:03 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 22 Jan 2018 21:50:33 +0100
Message-Id: <20180122205033.24893-7-apahim@redhat.com>
In-Reply-To: <20180122205033.24893-1-apahim@redhat.com>
References: <20180122205033.24893-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v12 6/6] qemu.py: don't launch again before
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
 scripts/qemu.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 42a3fa5251..6c80edfd04 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -91,6 +91,7 @@ class QEMUMachine(object):
         self._qemu_full_args = None
         self._test_dir = test_dir
         self._temp_dir = None
+        self._launched = False
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -211,10 +212,15 @@ class QEMUMachine(object):
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
 
@@ -267,6 +273,8 @@ class QEMUMachine(object):
                 command = ''
             LOG.warn(msg, exitcode, command)
 
+        self._launched = False
+
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.14.3
