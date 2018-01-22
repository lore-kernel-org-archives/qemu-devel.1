Received: from eggs.gnu.org ([2001:4830:134:3::10]:36334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3a-0004iS-91
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1edj3X-0000d2-4s
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1edj3W-0000bz-V3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:51:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 166A77E42F
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 20:51:02 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 22 Jan 2018 21:50:32 +0100
Message-Id: <20180122205033.24893-6-apahim@redhat.com>
In-Reply-To: <20180122205033.24893-1-apahim@redhat.com>
References: <20180122205033.24893-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v12 5/6] qemu.py: cleanup redundant calls in
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 874ac2e424..42a3fa5251 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -216,11 +216,7 @@ class QEMUMachine(object):
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
