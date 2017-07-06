Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nr-00050f-DO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9np-00067y-W4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:55 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:26 +0200
Message-Id: <20170706163828.24082-10-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] block/replication: do not acquire
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Replication functions are mostly called when the BDS is quiescent and
does not have any pending I/O.  They do not need to synchronize on
anything since BDS and BB are now thread-safe.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/replication.c | 51 ++++++++++++---------------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 5d6e2ec916..7a3b94b90f 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -41,6 +41,8 @@ typedef struct BDRVReplicationState {
     Error *blocker;
     int orig_hidden_flags;
     int orig_secondary_flags;
+
+    /* This field is accessed asynchronously.  */
     int error;
 } BDRVReplicationState;
 
@@ -201,7 +203,7 @@ static int replication_return_value(BDRVReplicationState *s, int ret)
     }
 
     if (ret < 0) {
-        s->error = ret;
+        atomic_set(&s->error, ret);
         ret = 0;
     }
 
@@ -311,6 +313,7 @@ static bool replication_recurse_is_first_non_filter(BlockDriverState *bs,
     return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
 }
 
+/* Called with no I/O pending.  */
 static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
 {
     Error *local_err = NULL;
@@ -405,7 +408,7 @@ static void backup_job_completed(void *opaque, int ret)
 
     if (s->stage != BLOCK_REPLICATION_FAILOVER) {
         /* The backup job is cancelled unexpectedly */
-        s->error = -EIO;
+        atomic_set(&s->error, -EIO);
     }
 
     backup_job_cleanup(bs);
@@ -430,6 +433,7 @@ static bool check_top_bs(BlockDriverState *top_bs, BlockDriverState *bs)
     return false;
 }
 
+/* Called with no I/O pending.  */
 static void replication_start(ReplicationState *rs, ReplicationMode mode,
                               Error **errp)
 {
@@ -437,24 +441,19 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     BDRVReplicationState *s;
     BlockDriverState *top_bs;
     int64_t active_length, hidden_length, disk_length;
-    AioContext *aio_context;
     Error *local_err = NULL;
     BlockJob *job;
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
     s = bs->opaque;
 
     if (s->stage != BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is running or done");
-        aio_context_release(aio_context);
         return;
     }
 
     if (s->mode != mode) {
         error_setg(errp, "The parameter mode's value is invalid, needs %d,"
                    " but got %d", s->mode, mode);
-        aio_context_release(aio_context);
         return;
     }
 
@@ -466,21 +465,18 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (!s->active_disk || !s->active_disk->bs ||
                                     !s->active_disk->bs->backing) {
             error_setg(errp, "Active disk doesn't have backing file");
-            aio_context_release(aio_context);
             return;
         }
 
         s->hidden_disk = s->active_disk->bs->backing;
         if (!s->hidden_disk->bs || !s->hidden_disk->bs->backing) {
             error_setg(errp, "Hidden disk doesn't have backing file");
-            aio_context_release(aio_context);
             return;
         }
 
         s->secondary_disk = s->hidden_disk->bs->backing;
         if (!s->secondary_disk->bs || !bdrv_has_blk(s->secondary_disk->bs)) {
             error_setg(errp, "The secondary disk doesn't have block backend");
-            aio_context_release(aio_context);
             return;
         }
 
@@ -492,7 +488,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             active_length != hidden_length || hidden_length != disk_length) {
             error_setg(errp, "Active disk, hidden disk, secondary disk's length"
                        " are not the same");
-            aio_context_release(aio_context);
             return;
         }
 
@@ -500,7 +495,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             !s->hidden_disk->bs->drv->bdrv_make_empty) {
             error_setg(errp,
                        "Active disk or hidden disk doesn't support make_empty");
-            aio_context_release(aio_context);
             return;
         }
 
@@ -508,7 +502,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         reopen_backing_file(bs, true, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            aio_context_release(aio_context);
             return;
         }
 
@@ -521,7 +514,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             reopen_backing_file(bs, false, NULL);
-            aio_context_release(aio_context);
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
@@ -535,13 +527,11 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             backup_job_cleanup(bs);
-            aio_context_release(aio_context);
             return;
         }
         block_job_start(job);
         break;
     default:
-        aio_context_release(aio_context);
         abort();
     }
 
@@ -551,48 +541,38 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         secondary_do_checkpoint(s, errp);
     }
 
-    s->error = 0;
-    aio_context_release(aio_context);
+    atomic_set(&s->error, 0);
 }
 
+/* Called with no I/O pending.  */
 static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
 {
     BlockDriverState *bs = rs->opaque;
     BDRVReplicationState *s;
-    AioContext *aio_context;
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
     s = bs->opaque;
 
     if (s->mode == REPLICATION_MODE_SECONDARY) {
         secondary_do_checkpoint(s, errp);
     }
-    aio_context_release(aio_context);
 }
 
 static void replication_get_error(ReplicationState *rs, Error **errp)
 {
     BlockDriverState *bs = rs->opaque;
     BDRVReplicationState *s;
-    AioContext *aio_context;
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
     s = bs->opaque;
 
     if (s->stage != BLOCK_REPLICATION_RUNNING) {
         error_setg(errp, "Block replication is not running");
-        aio_context_release(aio_context);
         return;
     }
 
-    if (s->error) {
+    if (atomic_read(&s->error)) {
         error_setg(errp, "I/O error occurred");
-        aio_context_release(aio_context);
         return;
     }
-    aio_context_release(aio_context);
 }
 
 static void replication_done(void *opaque, int ret)
@@ -608,10 +588,10 @@ static void replication_done(void *opaque, int ret)
         s->active_disk = NULL;
         s->secondary_disk = NULL;
         s->hidden_disk = NULL;
-        s->error = 0;
+        atomic_set(&s->error, 0);
     } else {
         s->stage = BLOCK_REPLICATION_FAILOVER_FAILED;
-        s->error = -EIO;
+        atomic_set(&s->error, -EIO);
     }
 }
 
@@ -619,22 +599,18 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
 {
     BlockDriverState *bs = rs->opaque;
     BDRVReplicationState *s;
-    AioContext *aio_context;
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
     s = bs->opaque;
 
     if (s->stage != BLOCK_REPLICATION_RUNNING) {
         error_setg(errp, "Block replication is not running");
-        aio_context_release(aio_context);
         return;
     }
 
     switch (s->mode) {
     case REPLICATION_MODE_PRIMARY:
         s->stage = BLOCK_REPLICATION_DONE;
-        s->error = 0;
+        atomic_set(&s->error, 0);
         break;
     case REPLICATION_MODE_SECONDARY:
         /*
@@ -649,7 +625,6 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
         if (!failover) {
             secondary_do_checkpoint(s, errp);
             s->stage = BLOCK_REPLICATION_DONE;
-            aio_context_release(aio_context);
             return;
         }
 
@@ -659,10 +634,8 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
                             NULL, replication_done, bs, true, errp);
         break;
     default:
-        aio_context_release(aio_context);
         abort();
     }
-    aio_context_release(aio_context);
 }
 
 BlockDriver bdrv_replication = {
-- 
2.13.0
