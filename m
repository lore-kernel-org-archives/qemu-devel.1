Received: from eggs.gnu.org ([2001:4830:134:3::10]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fHA-0002Qx-Nj
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fH8-0001Ne-V4
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fH8-0001Mx-Mk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:40:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:48 -0300
Message-Id: <20180329213857.15499-10-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 09/18] qemu.py: Make monitor optional
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

This will allow us to use the QEMUMachine class on test cases
that don't use QMP at all.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 1241e7f10b..e82540a235 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -54,7 +54,7 @@ class QEMUMachine(object):
     '''
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
-                 test_dir="/var/tmp", monitor_address=None,
+                 test_dir="/var/tmp", monitor_address=None, qmp=True,
                  socket_scm_helper=None):
         '''
         Initialize a QEMUMachine
@@ -65,6 +65,7 @@ class QEMUMachine(object):
         @param name: prefix for socket and log file names (default: qemu-PID)
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
+        @param qmp: if False, disable QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()"
         @note: Qemu process is not started until launch() is used.
         '''
@@ -90,6 +91,7 @@ class QEMUMachine(object):
         self._test_dir = test_dir
         self._temp_dir = None
         self._launched = False
+        self._qmp_enabled = qmp
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -168,13 +170,18 @@ class QEMUMachine(object):
                 self._iolog = iolog.read()
 
     def _vm_monitor(self):
-        if self._monitor_address is not None:
+        if not self._qmp_enabled:
+            return None
+        elif self._monitor_address is not None:
             return self._monitor_address
         else:
             return os.path.join(self._temp_dir, self._name + "-monitor.sock")
 
     def _monitor_args(self):
         addr = self._vm_monitor()
+        if addr is None:
+            return []
+
         if isinstance(addr, tuple):
             moncdev = "socket,id=mon,host=%s,port=%s" % (addr[0], addr[1])
         else:
@@ -193,10 +200,14 @@ class QEMUMachine(object):
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
 
-        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor(), server=True)
+        self._qmp = \
+            qmp.qmp.QEMUMonitorProtocol(self._vm_monitor(), server=True) \
+            if self._qmp_enabled \
+            else None
 
     def _post_launch(self):
-        self._qmp.accept()
+        if self._qmp:
+            self._qmp.accept()
 
     def _post_shutdown(self):
         if self._qmp is not None:
-- 
2.14.3
