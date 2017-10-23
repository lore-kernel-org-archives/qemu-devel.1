Received: from eggs.gnu.org ([2001:4830:134:3::10]:39343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e6Z3T-0004jQ-K4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e6Z3Q-0000J1-GP
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:29:55 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16993 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e6Z3Q-0000GQ-3z
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:29:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Oct 2017 12:29:45 +0300
Message-Id: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com

Snapshot-switch actually changes active state of disk so it should
reflect on dirty bitmaps. Otherwise next incremental backup using
these bitmaps will be invalid.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.11.1
