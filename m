Received: from eggs.gnu.org ([2001:4830:134:3::10]:45738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDg-00026y-7Y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDf-0007w4-5J
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:06 -0400
Message-Id: <20180723222210.11077-4-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 3/7] block/qcow2: drop
 dirty_bitmaps_loaded state variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This variable doesn't work as it should, because it is actually cleared
in qcow2_co_invalidate_cache() by memset(). Drop it, as the following
patch will introduce new behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 19 ++-----------------
 block/qcow2.h |  1 -
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7444133ccd..72d4e67b99 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1157,7 +1157,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
-    bool header_updated = false;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -1496,23 +1495,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (s->dirty_bitmaps_loaded) {
-        /* It's some kind of reopen. There are no known cases where we need to
-         * reload bitmaps in such a situation, so it's safer to skip them.
-         *
-         * Moreover, if we have some readonly bitmaps and we are reopening for
-         * rw we should reopen bitmaps correspondingly.
-         */
-        if (bdrv_has_readonly_bitmaps(bs) &&
-            !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
-        {
-            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
-        }
-    } else {
-        header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
-        s->dirty_bitmaps_loaded = true;
+    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
+        update_header = false;
     }
-    update_header = update_header && !header_updated;
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..4b4e61fe61 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -295,7 +295,6 @@ typedef struct BDRVQcow2State {
     uint32_t nb_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
-    bool dirty_bitmaps_loaded;
 
     int flags;
     int qcow_version;
-- 
2.14.4
