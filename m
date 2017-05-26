Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA43-0004aS-8u
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA41-0006Tl-Jf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA41-0006Sf-9y
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:40 +0800
Message-Id: <20170526075246.20265-17-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 16/22] block: access write_gen with atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-13-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   | 2 +-
 block/io.c                | 6 +++---
 include/block/block_int.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index f6066ef..45a77f5 100644
--- a/block.c
+++ b/block.c
@@ -3384,7 +3384,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
-        ++bs->write_gen;
+        atomic_inc(&bs->write_gen);
     }
     return ret;
 }
diff --git a/block/io.c b/block/io.c
index afb8294..8021b5b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1415,7 +1415,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
 
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
@@ -2304,7 +2304,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto early_exit;
     }
 
-    current_gen = bs->write_gen;
+    current_gen = atomic_read(&bs->write_gen);
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
@@ -2529,7 +2529,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     }
     ret = 0;
 out:
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
                    req.bytes >> BDRV_SECTOR_BITS);
     tracked_request_end(&req);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a23e4bb..74d6e62 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -612,7 +612,6 @@ struct BlockDriverState {
     QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
     CoQueue flush_queue;                  /* Serializing flush queue */
     bool active_flush_req;                /* Flush request in flight? */
-    unsigned int write_gen;               /* Current data generation */
     unsigned int flushed_gen;             /* Flushed write generation */
 
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
@@ -647,6 +646,7 @@ struct BlockDriverState {
 
     /* Accessed with atomic ops.  */
     int quiesce_counter;
+    unsigned int write_gen;               /* Current data generation */
 };
 
 struct BlockBackendRootState {
-- 
2.9.4
