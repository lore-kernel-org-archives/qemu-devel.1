Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0C0-0005Yj-GZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bz-0002BS-3v
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0By-00029r-UI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:35 -0300
Message-Id: <20170915233739.26860-12-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] qemu.py: fix is_running() return before
 first launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

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
Message-Id: <20170901112829.2571-2-apahim@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 7c6802609a..f80b008f7f 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -131,7 +131,7 @@ class QEMUMachine(object):
             raise
 
     def is_running(self):
-        return self._popen and (self._popen.returncode is None)
+        return self._popen is not None and self._popen.returncode is None
 
     def exitcode(self):
         if self._popen is None:
-- 
2.13.5
