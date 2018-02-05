Received: from eggs.gnu.org ([2001:4830:134:3::10]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptQ-000226-IV
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptN-0007JI-CA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptN-0007Ii-6b
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:41 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:54 -0200
Message-Id: <20180205230900.11344-16-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/21] qemu.py: use poll() instead of
 'returncode'
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

The 'returncode' Popen attribute is not guaranteed to be updated. It
actually depends on a call to either poll(), wait() or communicate().

On the other hand, poll() will: "Check if child process has terminated.
Set and return returncode attribute."

Let's use the poll() to check whether the process is running and to get
the updated process exit code, when the process is finished.

Reviewed-by: Fam Zheng <famz@redhat.com>
eviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20180122205033.24893-5-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 52cf09eebd..dcb4f0ffe6 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -150,12 +150,12 @@ class QEMUMachine(object):
             raise
 
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
2.14.3
