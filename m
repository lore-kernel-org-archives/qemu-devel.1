Received: from eggs.gnu.org ([2001:4830:134:3::10]:33963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUN-0003qM-03
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMUK-0004EA-KT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMUK-0004Df-Et
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EA98FC7D3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:51 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:43 +0100
Message-Id: <20171113213945.20049-7-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 6/8] qemu.py: cleanup redundant calls in
 launch()
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

Now that shutdown() is guaranteed to always execute self._load_io_log()
and self._post_shutdown(), their calls in 'except' became redundant and
we can safely replace it by a call to shutdown().

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 1eb0889ce5..ed9fed58ed 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -202,11 +202,7 @@ class QEMUMachine(object):
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
2.13.6
