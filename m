Received: from eggs.gnu.org ([2001:4830:134:3::10]:32780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGe-0001sJ-1X
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGd-0000AG-7j
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGd-00009G-1l
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:43 -0300
Message-Id: <20180329213857.15499-5-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 04/18] qemu.py: Make _vm_monitor a method
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

Use a function instead of a data field.  Less state to keep track
of, less chance of bugs.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 08a3e9af5a..c051c4525a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -76,7 +76,6 @@ class QEMUMachine(object):
             name = "qemu-%d" % os.getpid()
         self._name = name
         self._monitor_address = monitor_address
-        self._vm_monitor = None
         self._qemu_log_path = None
         self._qemu_log_file = None
         self._popen = None
@@ -168,29 +167,28 @@ class QEMUMachine(object):
             with open(self._qemu_log_path, "r") as iolog:
                 self._iolog = iolog.read()
 
+    def _vm_monitor(self):
+        if self._monitor_address is not None:
+            return self._monitor_address
+        else:
+            return os.path.join(self._temp_dir, self._name + "-monitor.sock")
+
     def _base_args(self):
-        if isinstance(self._monitor_address, tuple):
-            moncdev = "socket,id=mon,host=%s,port=%s" % (
-                self._monitor_address[0],
-                self._monitor_address[1])
+        addr = self._vm_monitor()
+        if isinstance(addr, tuple):
+            moncdev = "socket,id=mon,host=%s,port=%s" % (addr[0], addr[1])
         else:
-            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
+            moncdev = 'socket,id=mon,path=%s' % (addr)
         return ['-chardev', moncdev,
                 '-mon', 'chardev=mon,mode=control',
                 '-display', 'none', '-vga', 'none']
 
     def _pre_launch(self):
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
-        if self._monitor_address is not None:
-            self._vm_monitor = self._monitor_address
-        else:
-            self._vm_monitor = os.path.join(self._temp_dir,
-                                            self._name + "-monitor.sock")
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
-        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
-                                                server=True)
+        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor(), server=True)
 
     def _post_launch(self):
         self._qmp.accept()
-- 
2.14.3
