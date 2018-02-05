Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptS-00023T-Gn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptR-0007SG-Kp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptR-0007Qb-FJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:45 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:55 -0200
Message-Id: <20180205230900.11344-17-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 16/21] qemu.py: cleanup redundant calls in
 launch()
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

Now that shutdown() is guaranteed to always execute self._load_io_log()
and self._post_shutdown(), their calls in 'except' became redundant and
we can safely replace it by a call to shutdown().

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20180122205033.24893-6-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index dcb4f0ffe6..09db6249a3 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -215,11 +215,7 @@ class QEMUMachine(object):
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
2.14.3
