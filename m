Received: from eggs.gnu.org ([2001:4830:134:3::10]:41710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI6-0008Ua-E1
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI5-0005xu-J4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrI5-0005xT-B4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:25 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 555333DBC0
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:01 +0200
Message-Id: <20170605123908.18777-13-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 12/19] block: access write_gen with atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   | 2 +-
 block/io.c                | 6 +++---
 include/block/block_int.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index af6366bcef..361005cba9 100644
--- a/block.c
+++ b/block.c
@@ -3424,7 +3424,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
-        ++bs->write_gen;
+        atomic_inc(&bs->write_gen);
     }
     return ret;
 }
diff --git a/block/io.c b/block/io.c
index bc69b4cecd..036f5a4870 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1402,7 +1402,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
 
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
@@ -2291,7 +2291,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto early_exit;
     }
 
-    current_gen = bs->write_gen;
+    current_gen = atomic_read(&bs->write_gen);
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
@@ -2516,7 +2516,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     }
     ret = 0;
 out:
-    ++bs->write_gen;
+    atomic_inc(&bs->write_gen);
     bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
                    req.bytes >> BDRV_SECTOR_BITS);
     tracked_request_end(&req);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8f36d1fc1d..8a9bc0bebc 100644
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
2.13.0
