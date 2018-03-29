Received: from eggs.gnu.org ([2001:4830:134:3::10]:32821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGn-00023w-Nn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGm-0000kB-KX
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGm-0000hI-F9
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:45 -0300
Message-Id: <20180329213857.15499-7-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 06/18] qemu.py: Move _load_io_log() call to
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

All callers of _post_shutdown() call _load_io_log(), so it's
easier to simply call it inside _post_shutdown().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index d9f85bb153..84bb3da613 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -199,6 +199,7 @@ class QEMUMachine(object):
         self._qmp.accept()
 
     def _post_shutdown(self):
+        self._load_io_log()
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
             self._qemu_log_file = None
@@ -250,7 +251,6 @@ class QEMUMachine(object):
         '''Wait for the VM to power off'''
         self._popen.wait()
         self._qmp.close()
-        self._load_io_log()
         self._post_shutdown()
 
     def shutdown(self):
@@ -263,7 +263,6 @@ class QEMUMachine(object):
                 self._popen.kill()
             self._popen.wait()
 
-        self._load_io_log()
         self._post_shutdown()
 
         exitcode = self.exitcode()
-- 
2.14.3
