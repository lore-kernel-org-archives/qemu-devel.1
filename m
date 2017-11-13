Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU8-00034N-GP
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU7-00046s-P6
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMU7-00046a-IR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7038C049D66
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:38 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:41 +0100
Message-Id: <20171113213945.20049-5-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 4/8] qemu.py: always cleanup on shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

Currently we only cleanup on shutdown() if the VM is running.

To make sure we will always cleanup, this patch makes the
self._load_io_log() and the self._post_shutdown() to
always be called on shutdown(), regardless the VM running state.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 8a1c97d964..310522cf48 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -152,8 +152,9 @@ class QEMUMachine(object):
         return self._popen.pid
 
     def _load_io_log(self):
-        with open(self._qemu_log_path, "r") as iolog:
-            self._iolog = iolog.read()
+        if self._qemu_log_path is not None:
+            with open(self._qemu_log_path, "r") as iolog:
+                self._iolog = iolog.read()
 
     def _base_args(self):
         if isinstance(self._monitor_address, tuple):
@@ -244,8 +245,8 @@ class QEMUMachine(object):
                 self._popen.kill()
             self._popen.wait()
 
-            self._load_io_log()
-            self._post_shutdown()
+        self._load_io_log()
+        self._post_shutdown()
 
         exitcode = self.exitcode()
         if exitcode is not None and exitcode < 0:
-- 
2.13.6
