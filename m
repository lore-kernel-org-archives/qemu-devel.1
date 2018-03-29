Received: from eggs.gnu.org ([2001:4830:134:3::10]:33143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHb-0002uv-6G
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHa-0002Hu-4D
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fHZ-0002FT-VF
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:53 -0300
Message-Id: <20180329213857.15499-15-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 14/18] qemu.py: Don't try to quit cleanly on
 exceptions
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

Exceptions when starting a VM probably mean QEMU exited and the
monitor won't work.  It's better to simply terminate the process
instead of trying to communicate using QMP.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 045dca5d02..00b44ea0f4 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -251,7 +251,7 @@ class QEMUMachine(object):
             self._launch()
             self._launched = True
         except:
-            self.shutdown()
+            self.shutdown(force=True)
 
             LOG.debug('Error launching VM')
             if self._qemu_full_args:
-- 
2.14.3
