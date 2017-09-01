Received: from eggs.gnu.org ([2001:4830:134:3::10]:59749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkB5-0001K2-Q5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAw-0006wd-BL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAw-0006wQ-51
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:50 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:23 +0200
Message-Id: <20170901112829.2571-8-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 07/13] qemu.py: close _qemu_log_path on
 cleanup
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

We are opening the _qemu_log_path during the launch() but we are
forgetting to close it.

This patch makes sure we will close the self._qemu_log_path during the
cleanup (post_shutdown()).

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index c26e1412f9..1b77fec48b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -153,6 +153,9 @@ class QEMUMachine(object):
         self._qmp.accept()
 
     def _post_shutdown(self):
+        if self._qemu_log_fd is not None:
+            self._qemu_log_fd.close()
+
         while self._created_files:
             self._remove_if_exists(self._created_files.pop())
 
-- 
2.13.5
