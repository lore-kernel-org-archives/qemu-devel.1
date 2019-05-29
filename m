Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173CC28CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEA623C4E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEA623C4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56943 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0sQ-0008VK-Ub
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:52:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0nA-0004VV-BR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n7-00053n-VO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:43144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n7-00051v-I2; Wed, 29 May 2019 11:47:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n3-0004iP-0I; Wed, 29 May 2019 18:46:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 18:46:54 +0300
Message-Id: <20190529154654.95870-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 7/7] block/backup: use backup-top instead of
 write notifiers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop write notifiers and use filter node instead. Changes:

1. copy-before-writes now handled by filter node, so, drop all
   is_write_notifier arguments.

2. we don't have intersecting requests, so their handling is dropped.
Instead, synchronization works as follows:
when backup or backup-top starts copying of some area it firstly
clears copy-bitmap bits, and nobody touches areas, not marked with
dirty bits in copy-bitmap, so there is no intersection. Also, backup
job copy operations are surrounded by bdrv region lock, which is
actually serializing request, to not interfere with guest writes and
not read changed data from source (before reading we clear
corresponding bit in copy-bitmap, so, this area is not more handled by
backup-top).

3. To sync with in-flight requests at job finish we now have drained
removing of the filter, we don't need rw-lock.

== RFC part ==

iotests changed:
56: op-blocker doesn't shot now, as we set it on source, but then check
on filter, when trying to start second backup... Should I workaround it
somehow?

129: Hmm, now it is not busy at this moment.. But it's illegal to check
busy, as job has pause-points and set busy to false in these points.
Why we assert it in this test?

141: Obvious, as drv0 is not root node now, but backing of the filter,
when we try to remove it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c             | 171 ++++++++++++++-----------------------
 tests/qemu-iotests/056     |   2 +-
 tests/qemu-iotests/129     |   1 -
 tests/qemu-iotests/141.out |   2 +-
 4 files changed, 68 insertions(+), 108 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 00f4f8af53..a5b8e04c9c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -2,6 +2,7 @@
  * QEMU backup
  *
  * Copyright (C) 2013 Proxmox Server Solutions
+ * Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
  *
  * Authors:
  *  Dietmar Maurer (dietmar@proxmox.com)
@@ -26,14 +27,9 @@
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
@@ -43,13 +39,10 @@ typedef struct BackupBlockJob {
     MirrorSyncMode sync_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
-    CoRwlock flush_rwlock;
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
     bool compress;
-    NotifierWithReturn before_write;
-    QLIST_HEAD(, CowRequest) inflight_reqs;
 
     HBitmap *copy_bitmap;
     bool use_copy_range;
@@ -60,56 +53,17 @@ typedef struct BackupBlockJob {
 
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
 /* Copy range to target with a bounce buffer and return the bytes copied. If
  * error occurred, return a negative error number */
 static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       int64_t start,
                                                       int64_t end,
-                                                      bool is_write_notifier,
                                                       bool *error_is_read,
                                                       void **bounce_buffer)
 {
     int ret;
     BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
@@ -119,7 +73,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
     }
 
-    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags);
+    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, 0);
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -154,15 +108,12 @@ fail:
 /* Copy range to target and return the bytes copied. If error occurred, return a
  * negative error number. */
 static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
-                                                int64_t start,
-                                                int64_t end,
-                                                bool is_write_notifier)
+                                                int64_t start, int64_t end)
 {
     int ret;
     int nr_clusters;
     BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
@@ -171,7 +122,7 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
     hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, write_flags);
+                            0, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
         hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clusters);
@@ -183,24 +134,17 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
-                                      bool *error_is_read,
-                                      bool is_write_notifier)
+                                      bool *error_is_read)
 {
-    CowRequest cow_request;
     int ret = 0;
     int64_t start, end; /* bytes */
     void *bounce_buffer = NULL;
 
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
-
     start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
 
     trace_backup_do_cow_enter(job, start, offset, bytes);
 
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
     while (start < end) {
         if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
@@ -211,13 +155,13 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         trace_backup_do_cow_process(job, start);
 
         if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, end, is_write_notifier);
+            ret = backup_cow_with_offload(job, start, end);
             if (ret < 0) {
                 job->use_copy_range = false;
             }
         }
         if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, end, is_write_notifier,
+            ret = backup_cow_with_bounce_buffer(job, start, end,
                                                 error_is_read, &bounce_buffer);
         }
         if (ret < 0) {
@@ -237,29 +181,11 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         qemu_vfree(bounce_buffer);
     }
 
-    cow_request_end(&cow_request);
-
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
@@ -295,14 +221,30 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+    BlockJob *bjob = &s->common;
+    BlockDriverState *backup_top = blk_bs(s->common.blk);
+    BlockDriverState *src = backup_top->backing->bs;
+
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
 
+    bdrv_ref(backup_top);
+    bdrv_ref(src);
+
     if (s->copy_bitmap) {
         hbitmap_free(s->copy_bitmap);
         s->copy_bitmap = NULL;
     }
+
+    bdrv_backup_top_drop(backup_top);
+
+    blk_remove_bs(bjob->blk);
+    blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(bjob->blk, backup_top, &error_abort);
+
+    bdrv_unref(src);
+    bdrv_unref(backup_top);
 }
 
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -391,28 +333,41 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
     int64_t offset;
     HBitmapIter hbi;
     BlockDriverState *bs = blk_bs(job->common.blk);
+    void *lock;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((offset = hbitmap_iter_next(&hbi)) != -1) {
+        lock = bdrv_co_try_lock(backing_bs(blk_bs(job->common.blk)), offset,
+                                job->cluster_size);
+        /*
+         * Dirty bit is set, which means that there are no in-flight
+         * write requests on this area. We must succeed.
+         */
+        assert(lock);
+
         if (job->sync_mode == MIRROR_SYNC_MODE_TOP &&
             bdrv_is_unallocated_range(bs, offset, job->cluster_size))
         {
             hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            bdrv_co_unlock(lock);
             continue;
         }
 
         do {
             if (yield_and_check(job)) {
+                bdrv_co_unlock(lock);
                 return 0;
             }
-            ret = backup_do_cow(job, offset,
-                                job->cluster_size, &error_is_read, false);
+            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
             {
+                bdrv_co_unlock(lock);
                 return ret;
             }
         } while (ret < 0);
+
+        bdrv_co_unlock(lock);
     }
 
     return 0;
@@ -444,12 +399,8 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
     int ret = 0;
 
-    QLIST_INIT(&s->inflight_reqs);
-    qemu_co_rwlock_init(&s->flush_rwlock);
-
     job_progress_set_remaining(job, s->len);
 
     if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
@@ -458,27 +409,20 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         hbitmap_set(s->copy_bitmap, 0, s->len);
     }
 
-    s->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
-
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
         /* All bits are set in copy_bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied. */
         while (!job_is_cancelled(job)) {
-            /* Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests. */
+            /*
+             * Yield until the job is cancelled.  We just let our backup-top
+             * filter driver service CbW requests.
+             */
             job_yield(job);
         }
     } else {
         ret = backup_loop(s);
     }
 
-    notifier_with_return_remove(&s->before_write);
-
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&s->flush_rwlock);
-    qemu_co_rwlock_unlock(&s->flush_rwlock);
-
     return ret;
 }
 
@@ -533,6 +477,11 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
     return MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
 }
 
+static void backup_top_progress(uint64_t done, void *opaque)
+{
+    job_progress_update((Job *)opaque, done);
+}
+
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
@@ -548,6 +497,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int ret;
     int64_t cluster_size;
     HBitmap *copy_bitmap = NULL;
+    BlockDriverState *backup_top = NULL;
 
     assert(bs);
     assert(target);
@@ -616,8 +566,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
 
+    backup_top = bdrv_backup_top_append(bs, target, copy_bitmap, errp);
+    if (!backup_top) {
+        goto error;
+    }
+
     /* job->len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, txn, bs,
+    job = block_job_create(job_id, &backup_job_driver, txn, backup_top,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
@@ -626,6 +581,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
+    bdrv_backup_top_set_progress_callback(backup_top, backup_top_progress,
+                                          &job->common.job);
+
     /* The target must match the source in size, so no resize here either */
     job->target = blk_new(BLK_PERM_WRITE,
                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
@@ -662,10 +620,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     return &job->common;
 
  error:
-    if (copy_bitmap) {
-        assert(!job || !job->copy_bitmap);
-        hbitmap_free(copy_bitmap);
-    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
@@ -673,6 +627,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         backup_clean(&job->common.job);
         job_early_fail(&job->common.job);
     }
+    if (backup_top) {
+        bdrv_backup_top_drop(backup_top);
+    }
+    if (copy_bitmap) {
+        assert(!job || !job->copy_bitmap);
+        hbitmap_free(copy_bitmap);
+    }
 
     return NULL;
 }
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f40fc11a09..d3e6fe4b11 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -214,7 +214,7 @@ class BackupTest(iotests.QMPTestCase):
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'concluded')
         # Leave zombie job un-dismissed, observe a failure:
-        res = self.qmp_backup_and_wait(serror="Node 'drive0' is busy: block device is in use by block job: backup",
+        res = self.qmp_backup_and_wait(serror='Failed to get "write" lock',
                                        device='drive0', format=iotests.imgfmt,
                                        sync='full', target=self.dest_img,
                                        auto_dismiss=False)
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c8d9..d719492deb 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -66,7 +66,6 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         result = self.vm.qmp("stop")
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp("query-block-jobs")
-        self.assert_qmp(result, 'return[0]/busy', True)
         self.assert_qmp(result, 'return[0]/ready', False)
 
     def test_drive_mirror(self):
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 41c7291258..a2645bea1a 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -11,7 +11,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 0, "speed": 0, "type": "backup"}}
-- 
2.18.0


