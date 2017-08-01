Received: from eggs.gnu.org ([2001:4830:134:3::10]:60345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXYx-0005hq-Vc
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXYw-0005JQ-Vw
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:20 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue,  1 Aug 2017 16:49:06 +0300
Message-Id: <20170801134907.31253-3-el13635@mail.ntua.gr>
In-Reply-To: <20170801134907.31253-1-el13635@mail.ntua.gr>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 2/3] block: skip implicit nodes in snapshots,
 blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

Implicit filter nodes added at the top of nodes can interfere with block
jobs. This is not a problem when they are added by other jobs since
adding another job will issue a QERR_DEVICE_IN_USE, but it can happen in
the next commit which introduces an implicitly created throttle filter
node below BlockBackend, which we want to be skipped during automatic
operations on the graph since the user does not necessarily know about
their existence.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                   | 17 +++++++++++++++++
 blockdev.c                | 12 ++++++++++++
 include/block/block_int.h |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/block.c b/block.c
index 886a457ab0..9ebdba28b0 100644
--- a/block.c
+++ b/block.c
@@ -4947,3 +4947,20 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
 }
+
+/* Get first non-implicit node down a bs chain. */
+BlockDriverState *bdrv_get_first_non_implicit(BlockDriverState *bs)
+{
+    if (!bs) {
+        return NULL;
+    }
+
+    if (!bs->implicit) {
+        return bs;
+    }
+
+    /* at this point bs is implicit and must have a child */
+    assert(bs->file);
+
+    return bdrv_get_first_non_implicit(bs->file->bs);
+}
diff --git a/blockdev.c b/blockdev.c
index 23475abb72..d903a23786 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1664,6 +1664,9 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    state->old_bs = bdrv_get_first_non_implicit(state->old_bs);
+
     /* Acquire AioContext now so any threads operating on old_bs stop */
     state->aio_context = bdrv_get_aio_context(state->old_bs);
     aio_context_acquire(state->aio_context);
@@ -3095,6 +3098,9 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_non_implicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3209,6 +3215,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_non_implicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3484,6 +3493,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_non_implicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7584..9eeae490f0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -981,4 +981,6 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
+BlockDriverState *bdrv_get_first_non_implicit(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_H */
-- 
2.11.0
