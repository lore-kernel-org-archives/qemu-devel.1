Received: from eggs.gnu.org ([209.51.188.92]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndm-0002GM-Mq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndj-0008H0-1B
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  1 Mar 2019 14:15:43 -0500
Message-Id: <20190301191545.8728-6-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-1-jsnow@redhat.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/7] block/dirty-bitmaps: prohibit removing
 readonly bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

Remove is an inherently RW operation, so this will fail anyway, but
we can fail it very quickly instead of trying and failing, so do so.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index c8255dda0b..a9a059c570 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2881,7 +2881,8 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
+                                errp)) {
         return;
     }
 
-- 
2.17.2
