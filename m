Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqihN-0002d0-Gl
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqihH-0006t0-S8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cqihH-0006sX-Le
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A14361D01
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:01:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Mar 2017 13:00:50 -0300
Message-Id: <20170322160052.2820-2-ehabkost@redhat.com>
In-Reply-To: <20170322160052.2820-1-ehabkost@redhat.com>
References: <20170322160052.2820-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu.py: Always save QEMU exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Instead of saving the QEMU exit code only if shutdown() gets
called, move it to _post_shutdown(), so it gets saved even if the
launch() method has failed.

Add a exitcode() method that scripts can use to query the QEMU
exit code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6d1b6230b7..c9f35b97f5 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -39,6 +39,7 @@ class QEMUMachine(object):
         self._iolog = None
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
+        self._exitcode = None
 
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
@@ -116,6 +117,9 @@ class QEMUMachine(object):
         if not isinstance(self._monitor_address, tuple):
             self._remove_if_exists(self._monitor_address)
         self._remove_if_exists(self._qemu_log_path)
+        self._exitcode = self._popen.wait()
+        if self._exitcode < 0:
+            sys.stderr.write('qemu received signal %i: %s\n' % (-self._exitcode, ' '.join(self._args)))
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
@@ -135,6 +139,9 @@ class QEMUMachine(object):
             self._popen = None
             raise
 
+    def exitcode(self):
+        return self._exitcode
+
     def shutdown(self):
         '''Terminate the VM and clean up'''
         if not self._popen is None:
@@ -144,9 +151,6 @@ class QEMUMachine(object):
             except:
                 self._popen.kill()
 
-            exitcode = self._popen.wait()
-            if exitcode < 0:
-                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
             self._load_io_log()
             self._post_shutdown()
             self._popen = None
-- 
2.11.0.259.g40922b1
