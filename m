Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fH1-0002Ix-7a
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fH0-0001Bm-Dh
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fH0-0001Am-8f
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:47 -0300
Message-Id: <20180329213857.15499-9-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 08/18] qemu.py: Close _qmp inside _post_shutdown()
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

This way all shutdown-related cleanup is kept in a single place.

While at it, set _qmp to None after closing the socket, to avoid
trying to reuse it by mistake later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 4a71542c6b..1241e7f10b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -199,6 +199,10 @@ class QEMUMachine(object):
         self._qmp.accept()
 
     def _post_shutdown(self):
+        if self._qmp is not None:
+            self._qmp.close()
+            self._qmp = None
+
         self._load_io_log()
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
@@ -250,7 +254,6 @@ class QEMUMachine(object):
     def wait(self):
         '''Wait for the VM to power off'''
         self._popen.wait()
-        self._qmp.close()
         self._post_shutdown()
 
     def shutdown(self):
-- 
2.14.3
