Received: from eggs.gnu.org ([2001:4830:134:3::10]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Qq-0006AY-8L
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Qo-0000ST-5r
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dc6Qn-0000Rq-Vl
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:52:06 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 10:51:05 +0200
Message-Id: <20170731085110.1050-3-apahim@redhat.com>
In-Reply-To: <20170731085110.1050-1-apahim@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/7] qemu.py: fix is_running() return before
 first launch()
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

It should retunt False instead. This patch fixes that.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 2f1984c93c..77565eb092 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -86,7 +86,7 @@ class QEMUMachine(object):
             raise
 
     def is_running(self):
-        return self._popen and (self._popen.poll() is None)
+        return self._popen is not None and (self._popen.poll() is None)
 
     def exitcode(self):
         if self._popen is None:
-- 
2.13.3
