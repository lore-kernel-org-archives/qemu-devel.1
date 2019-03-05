Received: from eggs.gnu.org ([209.51.188.92]:40360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiw-0007Hz-T3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiu-0005n0-VT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:50 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Mar 2019 18:43:35 -0500
Message-Id: <20190305234337.18353-4-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] block/qcow2-bitmap: don't remove bitmaps
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

We tend to remove bitmaps when we flush them to disk, but it's not appropriate
in all cases. let the reopen mechanism use the lighter weight flush instead of
the heavier store.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 4e11b6b05a..9373055d3b 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1560,7 +1560,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
     BdrvDirtyBitmap *bitmap;
     Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_flush_persistent_dirty_bitmaps(bs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return -EINVAL;
-- 
2.17.2
