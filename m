Received: from eggs.gnu.org ([2001:4830:134:3::10]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEM-00020i-Ig
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEJ-00086s-Cy
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxEJ-00086V-7b
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:25 -0300
Message-Id: <20170605185927.12111-9-ehabkost@redhat.com>
In-Reply-To: <20170605185927.12111-1-ehabkost@redhat.com>
References: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] qemu.py: Don't set _popen=None on
 error/shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

Keep the Popen object around to we can query its exit code later.

To keep the existing 'self._popen is None' checks working, add a
is_running() method, that will check if the process is still running.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170526181200.17227-2-ehabkost@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6d1b6230b7..16934f1e02 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -85,8 +85,11 @@ class QEMUMachine(object):
                 return
             raise
 
+    def is_running(self):
+        return self._popen and (self._popen.returncode is None)
+
     def get_pid(self):
-        if not self._popen:
+        if not self.is_running():
             return None
         return self._popen.pid
 
@@ -128,16 +131,16 @@ class QEMUMachine(object):
                                            stderr=subprocess.STDOUT, shell=False)
             self._post_launch()
         except:
-            if self._popen:
+            if self.is_running():
                 self._popen.kill()
+                self._popen.wait()
             self._load_io_log()
             self._post_shutdown()
-            self._popen = None
             raise
 
     def shutdown(self):
         '''Terminate the VM and clean up'''
-        if not self._popen is None:
+        if self.is_running():
             try:
                 self._qmp.cmd('quit')
                 self._qmp.close()
@@ -149,7 +152,6 @@ class QEMUMachine(object):
                 sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
             self._load_io_log()
             self._post_shutdown()
-            self._popen = None
 
     underscore_to_dash = string.maketrans('_', '-')
     def qmp(self, cmd, conv_keys=True, **args):
-- 
2.11.0.259.g40922b1
