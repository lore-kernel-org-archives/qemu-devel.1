Received: from eggs.gnu.org ([2001:4830:134:3::10]:33097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHW-0002pE-Nz
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHV-0002AL-SO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHV-00029T-JT
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:25 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:52 -0300
Message-Id: <20180329213857.15499-14-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 13/18] qemu.py: 'force' parameter on shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

This will allow test code to shut down the VM without trying to
run a 'quit' QMP command.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index aaba04b3c1..045dca5d02 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -279,13 +279,24 @@ class QEMUMachine(object):
             self._popen.wait()
         self._post_shutdown()
 
-    def shutdown(self):
-        '''Terminate the VM and clean up'''
-        if self.is_running():
+    def shutdown(self, force=None):
+        '''Terminate the VM and clean up
+
+        @param force: If True, terminate QEMU process, if False always try
+                      clean shutdown, if None terminate QEMU process if
+                      clean shutdown fails.
+        '''
+        if not force and self.is_running():
             try:
                 self._qmp.cmd('quit')
             except:
-                self._popen.kill()
+                if force is None:
+                    force = True
+                else:
+                    raise
+
+        if force and self.is_running():
+            self._popen.kill()
 
         self.wait()
 
-- 
2.14.3
