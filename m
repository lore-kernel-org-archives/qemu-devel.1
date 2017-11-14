Received: from eggs.gnu.org ([2001:4830:134:3::10]:54251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexc-0006rX-04
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexX-0004jZ-L1
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:19 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:12 +0100
Message-Id: <20171114172417.7654-16-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 15/20] block/snapshot: dirty all dirty bitmaps
 on snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Snapshot-switch actually changes active state of disk so it should
reflect on dirty bitmaps. Otherwise next incremental backup using
these bitmaps will be invalid.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20171023092945.54532-1-vsementsov@virtuozzo.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/snapshot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/snapshot.c b/block/snapshot.c
index a46564e7b7..1d5ab5f90f 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -181,10 +181,24 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
 {
     BlockDriver *drv = bs->drv;
     int ret, open_ret;
+    int64_t len;
 
     if (!drv) {
         return -ENOMEDIUM;
     }
+
+    len = bdrv_getlength(bs);
+    if (len < 0) {
+        return len;
+    }
+    /* We should set all bits in all enabled dirty bitmaps, because dirty
+     * bitmaps reflect active state of disk and snapshot switch operation
+     * actually dirties active state.
+     * TODO: It may make sense not to set all bits but analyze block status of
+     * current state and destination snapshot and do not set bits corresponding
+     * to both-zero or both-unallocated areas. */
+    bdrv_set_dirty(bs, 0, len);
+
     if (drv->bdrv_snapshot_goto) {
         return drv->bdrv_snapshot_goto(bs, snapshot_id);
     }
-- 
2.13.6
