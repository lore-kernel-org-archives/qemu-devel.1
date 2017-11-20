Received: from eggs.gnu.org ([2001:4830:134:3::10]:44008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnPD-0005gd-DE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnPC-0005DJ-Lm
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:50:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 20 Nov 2017 15:50:06 +0100
Message-Id: <20171120145006.551-4-kwolf@redhat.com>
In-Reply-To: <20171120145006.551-1-kwolf@redhat.com>
References: <20171120145006.551-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 3/3] block: Error out on load_vm with
 active dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

Loading a snapshot invalidates the bitmap. Just marking all blocks dirty
is not a useful response in practice, instead the user needs to be aware
that we switch to a completely different state. If they are okay with
losing the dirty bitmap, they can just explicitly delete it.

This effectively reverts commit 04dec3c3ae5.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 13ec3b1c8c..6b338978c5 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -182,25 +182,16 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
 {
     BlockDriver *drv = bs->drv;
     int ret, open_ret;
-    int64_t len;
 
     if (!drv) {
         error_setg(errp, "Block driver is closed");
         return -ENOMEDIUM;
     }
 
-    len = bdrv_getlength(bs);
-    if (len < 0) {
-        error_setg_errno(errp, -len, "Cannot get block device size");
-        return len;
+    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
+        error_setg(errp, "Device has active dirty bitmaps");
+        return -EBUSY;
     }
-    /* We should set all bits in all enabled dirty bitmaps, because dirty
-     * bitmaps reflect active state of disk and snapshot switch operation
-     * actually dirties active state.
-     * TODO: It may make sense not to set all bits but analyze block status of
-     * current state and destination snapshot and do not set bits corresponding
-     * to both-zero or both-unallocated areas. */
-    bdrv_set_dirty(bs, 0, len);
 
     if (drv->bdrv_snapshot_goto) {
         ret = drv->bdrv_snapshot_goto(bs, snapshot_id);
-- 
2.13.6
