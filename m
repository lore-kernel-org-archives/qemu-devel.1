Received: from eggs.gnu.org ([2001:4830:134:3::10]:59859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBG-0001U4-Lo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBF-00072k-J8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkBF-00072M-E9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:09 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:27 +0200
Message-Id: <20170901112829.2571-12-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 11/13] qemu.py: cleanup redundant calls in
 launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

Now that shutdown() is guaranteed to always execute self._load_io_log()
and self._post_shutdown(), their calls in 'except' became redundant and
we can safely replace it by a call to shutdown().

Due to this change, shutdown() can be now called even before the
creation of the _qemu_log_path. So, to avoid errors with _load_io_log(),
this patch makes sure we will only read the _qemu_log_path if it was
previously created by us.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 87a2212b77..03e4cc34b7 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -115,8 +115,9 @@ class QEMUMachine(object):
         return self._popen.pid
 
     def _load_io_log(self):
-        with open(self._qemu_log_path, "r") as fh:
-            self._iolog = fh.read()
+        if self._qemu_log_path in self._created_files:
+            with open(self._qemu_log_path, "r") as fh:
+                self._iolog = fh.read()
 
     def _base_args(self):
         if isinstance(self._monitor_address, tuple):
@@ -169,11 +170,7 @@ class QEMUMachine(object):
         try:
             self._launch()
         except:
-            if self.is_running():
-                self._popen.kill()
-                self._popen.wait()
-            self._load_io_log()
-            self._post_shutdown()
+            self.shutdown()
 
             LOG.debug('Error launching VM')
             if self._qemu_full_args:
-- 
2.13.5
