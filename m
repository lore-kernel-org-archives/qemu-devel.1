Received: from eggs.gnu.org ([2001:4830:134:3::10]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBF-0001Sh-6g
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBA-00070s-Kx
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkBA-00070c-FE
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:04 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:26 +0200
Message-Id: <20170901112829.2571-11-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 10/13] qemu.py: use poll() instead of
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
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

The 'returncode' Popen attribute is not guaranteed to be updated. It
actually depends on a call to either poll(), wait() or communicate().

On the other hand, poll() will: "Check if child process has terminated.
Set and return returncode attribute."

Let's use the poll() to check whether the process is running and to get
the updated process exit code, when the process is finished.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index ede734328b..87a2212b77 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -102,12 +102,12 @@ class QEMUMachine(object):
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
2.13.5
