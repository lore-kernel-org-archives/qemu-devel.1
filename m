Received: from eggs.gnu.org ([2001:4830:134:3::10]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGl-0001zO-NY
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGk-0000ca-PS
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGk-0000YU-K0
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:44 -0300
Message-Id: <20180329213857.15499-6-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 05/18] qemu.py: Split _base_args()
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

Split it into _monitor_args() and _display_args(), so we can make
monitor args optional later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index c051c4525a..d9f85bb153 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -173,15 +173,20 @@ class QEMUMachine(object):
         else:
             return os.path.join(self._temp_dir, self._name + "-monitor.sock")
 
-    def _base_args(self):
+    def _monitor_args(self):
         addr = self._vm_monitor()
         if isinstance(addr, tuple):
             moncdev = "socket,id=mon,host=%s,port=%s" % (addr[0], addr[1])
         else:
             moncdev = 'socket,id=mon,path=%s' % (addr)
         return ['-chardev', moncdev,
-                '-mon', 'chardev=mon,mode=control',
-                '-display', 'none', '-vga', 'none']
+                '-mon', 'chardev=mon,mode=control']
+
+    def _display_args(self):
+        return ['-display', 'none', '-vga', 'none']
+
+    def _base_args(self):
+        return self._monitor_args() + self._display_args()
 
     def _pre_launch(self):
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
-- 
2.14.3
