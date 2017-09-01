Received: from eggs.gnu.org ([2001:4830:134:3::10]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAc-0000wI-4J
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAX-0006fW-HE
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAX-0006fN-Ap
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:25 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:17 +0200
Message-Id: <20170901112829.2571-2-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 01/13] qemu.py: fix is_running() return
 before first launch()
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

is_running() returns None when called before the first time we
call launch():

    >>> import qemu
    >>> vm = qemu.QEMUMachine('qemu-system-x86_64')
    >>> vm.is_running()
    >>>

It should return False instead. This patch fixes that.

For consistence, this patch removes the parenthesis from the
second clause as it's not really needed.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8219..0ae5d39414 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -86,7 +86,7 @@ class QEMUMachine(object):
             raise
 
     def is_running(self):
-        return self._popen and (self._popen.returncode is None)
+        return self._popen is not None and self._popen.returncode is None
 
     def exitcode(self):
         if self._popen is None:
-- 
2.13.5
