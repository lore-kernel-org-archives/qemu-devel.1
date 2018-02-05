Received: from eggs.gnu.org ([2001:4830:134:3::10]:59420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptK-0001vF-CD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptJ-0007Gq-JH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptJ-0007GR-Dv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:53 -0200
Message-Id: <20180205230900.11344-15-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/21] qemu.py: always cleanup on shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

Currently we only cleanup on shutdown() if the VM is running.

To make sure we will always cleanup, this patch makes the
self._load_io_log() and the self._post_shutdown() to
always be called on shutdown(), regardless the VM running state.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20180122205033.24893-4-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 0333d1e7fa..52cf09eebd 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -163,8 +163,9 @@ class QEMUMachine(object):
         return self._popen.pid
 
     def _load_io_log(self):
-        with open(self._qemu_log_path, "r") as iolog:
-            self._iolog = iolog.read()
+        if self._qemu_log_path is not None:
+            with open(self._qemu_log_path, "r") as iolog:
+                self._iolog = iolog.read()
 
     def _base_args(self):
         if isinstance(self._monitor_address, tuple):
@@ -257,8 +258,8 @@ class QEMUMachine(object):
                 self._popen.kill()
             self._popen.wait()
 
-            self._load_io_log()
-            self._post_shutdown()
+        self._load_io_log()
+        self._post_shutdown()
 
         exitcode = self.exitcode()
         if exitcode is not None and exitcode < 0:
-- 
2.14.3
