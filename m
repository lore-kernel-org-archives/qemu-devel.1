Received: from eggs.gnu.org ([2001:4830:134:3::10]:32867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGt-0002BJ-RX
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGt-00014R-1t
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGs-000132-Rg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:46 -0300
Message-Id: <20180329213857.15499-8-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 07/18] qemu.py: Use wait() logic inside shutdown()
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

This way we will have a single method where we wait for the QEMU
process to finish.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 84bb3da613..4a71542c6b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -258,12 +258,10 @@ class QEMUMachine(object):
         if self.is_running():
             try:
                 self._qmp.cmd('quit')
-                self._qmp.close()
             except:
                 self._popen.kill()
-            self._popen.wait()
 
-        self._post_shutdown()
+        self.wait()
 
         exitcode = self.exitcode()
         if exitcode is not None and exitcode < 0:
-- 
2.14.3
