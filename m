Received: from eggs.gnu.org ([2001:4830:134:3::10]:34257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMy-00049p-BU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMv-0006KQ-3z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:56 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 26 Jun 2018 16:50:32 +0300
Message-Id: <20180626135035.133432-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180626135035.133432-1-vsementsov@virtuozzo.com>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/6] bloc/qcow2: drop dirty_bitmaps_loaded
 state variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This variable doesn't work as it should, because it is actually cleared
in qcow2_co_invalidate_cache() by memset(). Drop it, as the following
patch will introduce new behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h |  1 -
 block/qcow2.c | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 01b5250415..c9df19b6e6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -294,7 +294,6 @@ typedef struct BDRVQcow2State {
     uint32_t nb_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
-    bool dirty_bitmaps_loaded;
 
     int flags;
     int qcow_version;
diff --git a/block/qcow2.c b/block/qcow2.c
index 46194a33ca..0044ff58e7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1149,7 +1149,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
-    bool header_updated = false;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -1488,23 +1487,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
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
-- 
2.11.1
