Received: from eggs.gnu.org ([2001:4830:134:3::10]:42509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIb-0001sP-Dc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIY-0004M0-14
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:37 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:42:02 +0200
Message-Id: <20170511144208.24075-13-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 12/18] block: access write_gen with atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   | 2 +-
 block/io.c                | 6 +++---
 include/block/block_int.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 3a8e2e0ba4..98f48fe7f8 100644
--- a/block.c
+++ b/block.c
@@ -3333,7 +3333,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
-        ++bs->write_gen;
+        atomic_inc(&bs->write_gen);
     }
     return ret;
 }
diff --git a/block/io.c b/block/io.c
index 25a00d82ed..06ad9f3a80 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1410,7 +1410,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
 
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
@@ -2299,7 +2299,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto early_exit;
     }
 
-    current_gen = bs->write_gen;
+    current_gen = atomic_read(&bs->write_gen);
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
@@ -2524,7 +2524,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     }
     ret = 0;
 out:
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
                    req.bytes >> BDRV_SECTOR_BITS);
     tracked_request_end(&req);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a9a1b45302..d24efe5ef8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -598,7 +598,6 @@ struct BlockDriverState {
     QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
     CoQueue flush_queue;                  /* Serializing flush queue */
     bool active_flush_req;                /* Flush request in flight? */
-    unsigned int write_gen;               /* Current data generation */
     unsigned int flushed_gen;             /* Flushed write generation */
 
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
@@ -633,6 +632,7 @@ struct BlockDriverState {
 
     /* Accessed with atomic ops.  */
     int quiesce_counter;
+    unsigned int write_gen;               /* Current data generation */
 };
 
 struct BlockBackendRootState {
-- 
2.12.2
