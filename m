Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUN-0003qL-05
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUI-0004Cp-4n
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMUH-0004CO-VW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C1DC2C9708
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:49 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:42 +0100
Message-Id: <20171113213945.20049-6-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 5/8] qemu.py: use poll() instead of
 'returncode'
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

The 'returncode' Popen attribute is not guaranteed to be updated. It
actually depends on a call to either poll(), wait() or communicate().

On the other hand, poll() will: "Check if child process has terminated.
Set and return returncode attribute."

Let's use the poll() to check whether the process is running and to get
the updated process exit code, when the process is finished.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 310522cf48..1eb0889ce5 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -139,12 +139,12 @@ class QEMUMachine(object):
         return proc.returncode
 
     def is_running(self):
-        return self._popen is not None and self._popen.returncode is None
+        return self._popen is not None and self._popen.poll() is None
 
     def exitcode(self):
         if self._popen is None:
             return None
-        return self._popen.returncode
+        return self._popen.poll()
 
     def get_pid(self):
         if not self.is_running():
-- 
2.13.6
