Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897AFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EADD20673
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EADD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HmI-0008Aw-7A
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2Hcv-0000v7-R6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2Hcl-00014t-Iy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:13:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:44736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2HcN-0000lk-N9; Mon, 26 Aug 2019 12:13:20 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2HcJ-0006QJ-Nx; Mon, 26 Aug 2019 19:13:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 26 Aug 2019 19:13:12 +0300
Message-Id: <20190826161312.489398-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190826161312.489398-1-vsementsov@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 13/13] block/backup: use backup-top instead
 of write notifiers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop write notifiers and use filter node instead.

= Changes =

1. add filter-node-name argument for backup qmp api. We have to do it
in this commit, as 257 needs to be fixed.

2. there no move write notifiers here, so is_write_notifier parameter
is dropped from block-copy paths.

3. Intersecting requests handling changed, now synchronization between
backup-top, backup and guest writes are all done in block/block-copy.c
and works as follows:

On copy operation, we work only with dirty areas. If bits are dirty it
means that there are no requests intersecting with this area. We clear
dirty bits and take bdrv range lock (bdrv_co_try_lock) on this area to
prevent further operations from interaction with guest (only with
guest, as neither backup nor backup-top will touch non-dirty area). If
copy-operation failed we set dirty bits back together with releasing
the lock.

The actual difference with old scheme is that on guest writes we
don't lock the whole region but only dirty-parts, and to be more
precise: only dirty-part we are currently operate on. In old scheme
guest write to non-dirty area (which may be safely ignored by backup)
may wait for intersecting request, touching some other area which is
dirty.

4. To sync with in-flight requests at job finish we now have drained
removing of the filter, we don't need rw-lock.

= Notes =

Note the consequence of three objects appearing: backup-top, backup job
and block-copy-state:

1. We want to insert backup-top before job creation, to behave similar
with mirror and commit, where job is started upon filter.

2. We also have to create block-copy-state after filter injection, as
we don't want it's source child be replaced by fitler. Instead we want
to keep BCS.source to be real source node, as we want to use
bdrv_co_try_lock in CBW operations and it can't be used on filter, as
on filter we already have in-flight (write) request from upper layer.

So, we firstly create inject backup-top, then create job and BCS. BCS
is the latest just to not create extra variable for it. Finally we set
bcs for backup-top filter.

= Iotest changes =

56: op-blocker doesn't shot now, as we set it on source, but then check
on filter, when trying to start second backup, so error caught in
test_dismiss_collision is changed. It's OK anyway, as this test-case
seems to test that after some collision we can dismiss first job and
successfully start the second one. So, the change is that collision is
changed from op-blocker to file-posix locks.
However, it's obvious now that we'd better drop this op-blocker at all
and add a test-case for two backups from one node (to different
destinations) actually works. But not in these series.

257: The test wants to emulate guest write during backup. They should
go to filter node, not to original source node, of course. Therefore we
need to specify filter node name and use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json       |   8 +-
 include/block/block-copy.h |   2 +-
 include/block/block_int.h  |   1 +
 block/backup-top.c         |  14 +-
 block/backup.c             | 113 +++-----------
 block/block-copy.c         |  55 ++++---
 block/replication.c        |   2 +-
 blockdev.c                 |   1 +
 tests/qemu-iotests/056     |   2 +-
 tests/qemu-iotests/257     |   7 +-
 tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------
 11 files changed, 230 insertions(+), 281 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..b5cd00c361 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1391,6 +1391,11 @@
 #                list without user intervention.
 #                Defaults to true. (Since 2.12)
 #
+# @filter-node-name: the node name that should be assigned to the
+#                    filter driver that the backup job inserts into the graph
+#                    above node specified by @drive. If this option is not given,
+#                    a node name is autogenerated. (Since: 4.2)
+#
 # Note: @on-source-error and @on-target-error only affect background
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
@@ -1404,7 +1409,8 @@
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*filter-node-name': 'str' } }
 
 ##
 # @DriveBackup:
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0dd7a3f7bf..c15d47a70d 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -54,6 +54,6 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, uint64_t bytes,
-                            bool *error_is_read, bool is_write_notifier);
+                            bool *error_is_read);
 
 #endif /* BLOCK_COPY_H */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0307cc78c6..27c4bf4673 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1179,6 +1179,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BdrvDirtyBitmap *sync_bitmap,
                             BitmapSyncMode bitmap_mode,
                             bool compress,
+                            const char *filter_node_name,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/block/backup-top.c b/block/backup-top.c
index 41cb015452..cac46f05b1 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -49,15 +49,11 @@ static coroutine_fn int backup_top_co_preadv(
 static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
                                        uint64_t bytes)
 {
-    /*
-     * Here we'd like to use block_copy(), but it needs some additional
-     * synchronization mechanism to prevent intersecting guest writes during
-     * copy operation. The will appear in further commit (it should be done
-     * together with moving backup to using of backup-top and to the same
-     * synchronization mechanism), and for now it is a TODO.
-     */
-
-    abort();
+    BDRVBackupTopState *s = bs->opaque;
+    uint64_t end = QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
+    uint64_t off = QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+
+    return block_copy(s->bcs, off, end - off, NULL);
 }
 
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
diff --git a/block/backup.c b/block/backup.c
index d927c63e5a..259a165405 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -2,6 +2,7 @@
  * QEMU backup
  *
  * Copyright (C) 2013 Proxmox Server Solutions
+ * Copyright (c) 2019 Virtuozzo International GmbH.
  *
  * Authors:
  *  Dietmar Maurer (dietmar@proxmox.com)
@@ -27,14 +28,9 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 
-#define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
+#include "block/backup-top.h"
 
-typedef struct CowRequest {
-    int64_t start_byte;
-    int64_t end_byte;
-    QLIST_ENTRY(CowRequest) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} CowRequest;
+#define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 
 typedef struct BackupBlockJob {
     BlockJob common;
@@ -45,55 +41,15 @@ typedef struct BackupBlockJob {
     BitmapSyncMode bitmap_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
-    CoRwlock flush_rwlock;
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
-    NotifierWithReturn before_write;
-    QLIST_HEAD(, CowRequest) inflight_reqs;
 
     BlockCopyState *bcs;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
 
-/* See if in-flight requests overlap and wait for them to complete */
-static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
-                                                       int64_t start,
-                                                       int64_t end)
-{
-    CowRequest *req;
-    bool retry;
-
-    do {
-        retry = false;
-        QLIST_FOREACH(req, &job->inflight_reqs, list) {
-            if (end > req->start_byte && start < req->end_byte) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
-                retry = true;
-                break;
-            }
-        }
-    } while (retry);
-}
-
-/* Keep track of an in-flight request */
-static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
-                              int64_t start, int64_t end)
-{
-    req->start_byte = start;
-    req->end_byte = end;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
-}
-
-/* Forget about a completed request */
-static void cow_request_end(CowRequest *req)
-{
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
-}
-
 static void backup_progress_callback(int64_t bytes, void *opaque)
 {
     BackupBlockJob *s = opaque;
@@ -110,49 +66,23 @@ static void backup_progress_callback(int64_t bytes, void *opaque)
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
-                                      bool *error_is_read,
-                                      bool is_write_notifier)
+                                      bool *error_is_read)
 {
-    CowRequest cow_request;
     int ret = 0;
     int64_t start, end; /* bytes */
 
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
-
     start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
 
     trace_backup_do_cow_enter(job, start, offset, bytes);
 
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
-    ret = block_copy(job->bcs, start, end - start, error_is_read,
-                     is_write_notifier);
-
-    cow_request_end(&cow_request);
+    ret = block_copy(job->bcs, start, end - start, error_is_read);
 
     trace_backup_do_cow_return(job, offset, bytes, ret);
 
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
-
     return ret;
 }
 
-static int coroutine_fn backup_before_write_notify(
-        NotifierWithReturn *notifier,
-        void *opaque)
-{
-    BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
-    BdrvTrackedRequest *req = opaque;
-
-    assert(req->bs == blk_bs(job->common.blk));
-    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
-
-    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
@@ -202,7 +132,9 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+    BlockDriverState *backup_top = blk_bs(s->common.blk);
 
+    bdrv_backup_top_drop(backup_top);
     block_copy_state_free(s->bcs);
     s->bcs = NULL;
 }
@@ -283,8 +215,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
             if (yield_and_check(job)) {
                 goto out;
             }
-            ret = backup_do_cow(job, offset,
-                                job->cluster_size, &error_is_read, false);
+            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
             {
@@ -326,17 +257,10 @@ static void backup_init_copy_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
     int ret = 0;
 
-    QLIST_INIT(&s->inflight_reqs);
-    qemu_co_rwlock_init(&s->flush_rwlock);
-
     backup_init_copy_bitmap(s);
 
-    s->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
-
     if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
         int64_t offset = 0;
         int64_t count;
@@ -370,12 +294,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     }
 
  out:
-    notifier_with_return_remove(&s->before_write);
-
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&s->flush_rwlock);
-    qemu_co_rwlock_unlock(&s->flush_rwlock);
-
     return ret;
 }
 
@@ -435,6 +353,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   BitmapSyncMode bitmap_mode,
                   bool compress,
+                  const char *filter_node_name,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -444,6 +363,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int64_t len;
     BackupBlockJob *job = NULL;
     int64_t cluster_size;
+    BlockDriverState *backup_top = NULL;
 
     assert(bs);
     assert(target);
@@ -508,8 +428,14 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
+    backup_top = bdrv_backup_top_append(bs, filter_node_name, errp);
+    if (!backup_top) {
+        goto error;
+    }
+
     /* job->len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK_PERM_ALL,
+    job = block_job_create(job_id, &backup_job_driver, txn, backup_top,
+                           0, BLK_PERM_ALL,
                            speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
@@ -537,6 +463,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     job->cluster_size = cluster_size;
 
+    bdrv_backup_top_set_bcs(backup_top, job->bcs);
+
     /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
@@ -552,6 +480,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         backup_clean(&job->common.job);
         job_early_fail(&job->common.job);
     }
+    if (backup_top) {
+        bdrv_backup_top_drop(backup_top);
+    }
 
     return NULL;
 }
diff --git a/block/block-copy.c b/block/block-copy.c
index 6828c46ba0..f3102ec3ff 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -98,27 +98,32 @@ fail:
  * error occurred, return a negative error number
  */
 static int coroutine_fn block_copy_with_bounce_buffer(
-        BlockCopyState *s, int64_t start, int64_t end, bool is_write_notifier,
+        BlockCopyState *s, int64_t start, int64_t end,
         bool *error_is_read, void **bounce_buffer)
 {
     int ret;
-    int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+    int nbytes = MIN(s->cluster_size, s->len - start);
+    void *lock = bdrv_co_try_lock(blk_bs(s->source), start, nbytes);
+
+    /*
+     * Function must be called only on full-dirty region, so nobody touching or
+     * touched these bytes. Therefore, we must successfully get lock.
+     */
+    assert(lock);
 
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    nbytes = MIN(s->cluster_size, s->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(s->source, s->cluster_size);
     }
 
-    ret = blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_flags);
+    ret = blk_co_pread(s->source, start, nbytes, *bounce_buffer, 0);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
-        goto fail;
+        goto out;
     }
 
     ret = blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
@@ -128,13 +133,16 @@ static int coroutine_fn block_copy_with_bounce_buffer(
         if (error_is_read) {
             *error_is_read = false;
         }
-        goto fail;
+        goto out;
     }
 
-    return nbytes;
-fail:
-    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    return ret;
+out:
+    if (ret < 0) {
+        bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
+    }
+    bdrv_co_unlock(lock);
+
+    return ret < 0 ? ret : nbytes;
 
 }
 
@@ -143,29 +151,37 @@ fail:
  * negative error number.
  */
 static int coroutine_fn block_copy_with_offload(
-        BlockCopyState *s, int64_t start, int64_t end, bool is_write_notifier)
+        BlockCopyState *s, int64_t start, int64_t end)
 {
     int ret;
     int nr_clusters;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+    void *lock;
 
     assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     nbytes = MIN(s->copy_range_size, MIN(end - start, s->len - start));
+    lock = bdrv_co_try_lock(blk_bs(s->source), start, nbytes);
+    /*
+     * Function must be called only on full-dirty region, so nobody touching or
+     * touched these bytes. Therefore, we must successfully get lock.
+     */
+    assert(lock);
+
     nr_clusters = DIV_ROUND_UP(nbytes, s->cluster_size);
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
                             s->cluster_size * nr_clusters);
     ret = blk_co_copy_range(s->source, start, s->target, start, nbytes,
-                            read_flags, s->write_flags);
+                            0, s->write_flags);
     if (ret < 0) {
         trace_block_copy_with_offload_fail(s, start, ret);
         bdrv_set_dirty_bitmap(s->copy_bitmap, start,
                               s->cluster_size * nr_clusters);
-        return ret;
     }
 
-    return nbytes;
+    bdrv_co_unlock(lock);
+
+    return ret < 0 ? ret : nbytes;
 }
 
 /*
@@ -239,8 +255,7 @@ int64_t block_copy_reset_unallocated(
 }
 
 int coroutine_fn block_copy(
-        BlockCopyState *s, int64_t offset, uint64_t bytes, bool *error_is_read,
-        bool is_write_notifier)
+        BlockCopyState *s, int64_t offset, uint64_t bytes, bool *error_is_read)
 {
     int ret = 0;
     int64_t start = offset, end = bytes + offset; /* bytes */
@@ -279,15 +294,13 @@ int coroutine_fn block_copy(
         trace_block_copy_process(s, start);
 
         if (s->use_copy_range) {
-            ret = block_copy_with_offload(s, start, dirty_end,
-                                          is_write_notifier);
+            ret = block_copy_with_offload(s, start, dirty_end);
             if (ret < 0) {
                 s->use_copy_range = false;
             }
         }
         if (!s->use_copy_range) {
             ret = block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                is_write_notifier,
                                                 error_is_read, &bounce_buffer);
         }
         if (ret < 0) {
diff --git a/block/replication.c b/block/replication.c
index 936b2f8b5a..99532ce521 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -543,7 +543,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..f89e48fc79 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3601,6 +3601,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->bitmap_mode,
                             backup->compress,
+                            backup->filter_node_name,
                             backup->on_source_error,
                             backup->on_target_error,
                             job_flags, NULL, NULL, txn, errp);
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index e761e465ae..9c7c653320 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -253,7 +253,7 @@ class BackupTest(iotests.QMPTestCase):
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'concluded')
         # Leave zombie job un-dismissed, observe a failure:
-        res = self.qmp_backup_and_wait(serror="Node 'drive0' is busy: block device is in use by block job: backup",
+        res = self.qmp_backup_and_wait(serror='Failed to get "write" lock',
                                        device='drive0', format=iotests.imgfmt,
                                        sync='full', target=self.dest_img,
                                        auto_dismiss=False)
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 7bc6069e1b..2dbcc6e7e1 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -190,6 +190,7 @@ def blockdev_backup(vm, device, target, sync, **kwargs):
                         device=device,
                         target=target,
                         sync=sync,
+                        filter_node_name='backup-top',
                         **kwargs)
     return result
 
@@ -216,7 +217,7 @@ def backup(drive, n, filepath, sync, **kwargs):
                              job_id=job_id, **kwargs)
     return job_id
 
-def perform_writes(drive, n):
+def perform_writes(drive, n, filter_node_name=None):
     log("--- Write #{:d} ---\n".format(n))
     for pattern in GROUPS[n].patterns:
         cmd = "write -P{:s} 0x{:07x} 0x{:x}".format(
@@ -224,7 +225,7 @@ def perform_writes(drive, n):
             pattern.offset,
             pattern.size)
         log(cmd)
-        log(drive.vm.hmp_qemu_io(drive.node, cmd))
+        log(drive.vm.hmp_qemu_io(filter_node_name or drive.node, cmd))
     bitmaps = drive.vm.query_bitmaps()
     log(bitmaps, indent=2)
     log('')
@@ -355,7 +356,7 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
             """Issue writes while the job is open to test bitmap divergence."""
             # Note: when `failure` is 'intermediate', this isn't called.
             log('')
-            bitmaps = perform_writes(drive0, 2)
+            bitmaps = perform_writes(drive0, 2, filter_node_name='backup-top')
             # Named bitmap (static, should be unchanged)
             ebitmap.compare(vm.get_bitmap(bitmaps, drive0.node, 'bitmap0'))
             # Anonymous bitmap (dynamic, shows new writes)
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index ec7e25877b..64dd460055 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -30,7 +30,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -78,7 +78,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -92,7 +92,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -205,7 +205,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -219,7 +219,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -290,7 +290,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -338,7 +338,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -354,7 +354,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -416,7 +416,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -430,7 +430,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -501,7 +501,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -549,7 +549,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -563,7 +563,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -676,7 +676,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -690,7 +690,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -761,7 +761,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -809,7 +809,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -823,7 +823,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -936,7 +936,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -950,7 +950,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1021,7 +1021,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1069,7 +1069,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1085,7 +1085,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -1147,7 +1147,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1161,7 +1161,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1232,7 +1232,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1280,7 +1280,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1294,7 +1294,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -1407,7 +1407,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1421,7 +1421,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1492,7 +1492,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1540,7 +1540,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1554,7 +1554,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -1667,7 +1667,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1681,7 +1681,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1752,7 +1752,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1800,7 +1800,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1816,7 +1816,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -1878,7 +1878,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -1892,7 +1892,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1963,7 +1963,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2011,7 +2011,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2025,7 +2025,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -2138,7 +2138,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2152,7 +2152,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2223,7 +2223,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2271,7 +2271,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2285,7 +2285,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -2398,7 +2398,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2412,7 +2412,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2483,7 +2483,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2531,7 +2531,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2547,7 +2547,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -2609,7 +2609,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2623,7 +2623,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2694,7 +2694,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2742,7 +2742,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2756,7 +2756,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -2869,7 +2869,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -2883,7 +2883,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2954,7 +2954,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3002,7 +3002,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3016,7 +3016,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -3129,7 +3129,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3143,7 +3143,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3214,7 +3214,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3262,7 +3262,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3278,7 +3278,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -3340,7 +3340,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3354,7 +3354,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3425,7 +3425,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3473,7 +3473,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3487,7 +3487,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -3600,7 +3600,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3614,7 +3614,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3685,7 +3685,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3733,7 +3733,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3747,7 +3747,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -3860,7 +3860,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3874,7 +3874,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3945,7 +3945,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -3993,7 +3993,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4009,7 +4009,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 458752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -4071,7 +4071,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4085,7 +4085,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4156,7 +4156,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4204,7 +4204,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4218,7 +4218,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -4331,7 +4331,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4345,7 +4345,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4416,7 +4416,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4464,7 +4464,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4478,7 +4478,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -4591,7 +4591,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4605,7 +4605,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4676,7 +4676,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4724,7 +4724,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4740,7 +4740,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 458752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -4802,7 +4802,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4816,7 +4816,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4887,7 +4887,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4935,7 +4935,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -4949,7 +4949,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "backup_target_1"}}
 {"return": {}}
 
 --- Write #2 ---
@@ -5062,7 +5062,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
@@ -5076,7 +5076,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -5139,155 +5139,155 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 -- Sync mode incremental tests --
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'incremental' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'incremental' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'incremental' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'incremental' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'on-success' when using sync mode 'incremental'"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'on-success' when using sync mode 'incremental'"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'on-success' when using sync mode 'incremental'"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'on-success' when using sync mode 'incremental'"}}
 
 -- Sync mode bitmap tests --
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'bitmap' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'bitmap' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'bitmap' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap name for 'bitmap' sync mode"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be given when providing a bitmap"}}
 
 -- Sync mode full tests --
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' has no meaningful effect when combined with sync mode 'full'"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be given when providing a bitmap"}}
 
 -- Sync mode top tests --
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' has no meaningful effect when combined with sync mode 'top'"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be given when providing a bitmap"}}
 
 -- Sync mode none tests --
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync mode without a bitmap"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could not be found"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not produce meaningful bitmap outputs"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not produce meaningful bitmap outputs"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not produce meaningful bitmap outputs"}}
 
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be given when providing a bitmap"}}
 
-- 
2.18.0


