Received: from eggs.gnu.org ([2001:4830:134:3::10]:33043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHN-0002hR-Di
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHK-0001mJ-C5
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHJ-0001j5-Qo
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:50 -0300
Message-Id: <20180329213857.15499-12-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 11/18] qemu.py: Log crashes inside
 _post_shutdown()
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

This will allow us to log QEMU crashes even if the test code uses
.wait() instead of .shutdown().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 226d2c4d48..e19e4b34d0 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -225,6 +225,15 @@ class QEMUMachine(object):
             shutil.rmtree(self._temp_dir)
             self._temp_dir = None
 
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal %i: %s'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.warn(msg, exitcode, command)
+
         self._launched = False
 
     def launch(self):
@@ -279,15 +288,6 @@ class QEMUMachine(object):
 
         self.wait()
 
-        exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0:
-            msg = 'qemu received signal %i: %s'
-            if self._qemu_full_args:
-                command = ' '.join(self._qemu_full_args)
-            else:
-                command = ''
-            LOG.warn(msg, exitcode, command)
-
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-- 
2.14.3
