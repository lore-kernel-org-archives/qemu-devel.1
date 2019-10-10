Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28C0208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28C0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXZj-0001NA-9y
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWsF-0007u7-6j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWs5-0000BH-1r
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrh-0008Rm-KU; Thu, 10 Oct 2019 07:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C852130043E1;
 Thu, 10 Oct 2019 11:44:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B4010018F8;
 Thu, 10 Oct 2019 11:44:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/36] block/backup: use backup-top instead of write notifiers
Date: Thu, 10 Oct 2019 13:42:57 +0200
Message-Id: <20191010114300.7746-34-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 11:44:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Drop write notifiers and use filter node instead.

=3D Changes =3D

1. Add filter-node-name argument for backup qmp api. We have to do it
in this commit, as 257 needs to be fixed.

2. There are no more write notifiers here, so is_write_notifier
parameter is dropped from block-copy paths.

3. To sync with in-flight requests at job finish we now have drained
removing of the filter, we don't need rw-lock.

4. Block-copy is now using BdrvChildren instead of BlockBackends

5. As backup-top owns these children, we also move block-copy state
into backup-top's ownership.

=3D Iotest changes =3D

56: op-blocker doesn't shoot now, as we set it on source, but then
check on filter, when trying to start second backup.
To keep the test we instead can catch another collision: both jobs will
get 'drive0' job-id, as job-id parameter is unspecified. To prevent
interleaving with file-posix locks (as they are dependent on config)
let's use another target for second backup.

Also, it's obvious now that we'd like to drop this op-blocker at all
and add a test-case for two backups from one node (to different
destinations) actually works. But not in these series.

141: Output changed: prepatch, "Node is in use" comes from bdrv_has_blk
check inside qmp_blockdev_del. But we've dropped block-copy blk
objects, so no more blk objects on source bs (job blk is on backup-top
filter bs). New message is from op-blocker, which is the next check in
qmp_blockdev_add.

257: The test wants to emulate guest write during backup. They should
go to filter node, not to original source node, of course. Therefore we
need to specify filter node name and use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191001131409.14202-6-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json       |   8 +-
 include/block/block-copy.h |  14 +-
 include/block/block_int.h  |   1 +
 block/backup-top.c         |  21 +--
 block/backup.c             |  73 +++------
 block/block-copy.c         |  81 +++-------
 block/replication.c        |   2 +-
 blockdev.c                 |   1 +
 tests/qemu-iotests/056     |   8 +-
 tests/qemu-iotests/141.out |   2 +-
 tests/qemu-iotests/257     |   7 +-
 tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------
 12 files changed, 237 insertions(+), 287 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 859acea014..f66553aac7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1450,6 +1450,11 @@
 #                list without user intervention.
 #                Defaults to true. (Since 2.12)
 #
+# @filter-node-name: the node name that should be assigned to the
+#                    filter driver that the backup job inserts into the =
graph
+#                    above node specified by @drive. If this option is n=
ot given,
+#                    a node name is autogenerated. (Since: 4.2)
+#
 # Note: @on-source-error and @on-target-error only affect background
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
@@ -1463,7 +1468,8 @@
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*filter-node-name': 'str' } }
=20
 ##
 # @DriveBackup:
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 340d856246..e2e135ff1b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -27,8 +27,13 @@ typedef struct BlockCopyInFlightReq {
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*ProgressResetCallbackFunc)(void *opaque);
 typedef struct BlockCopyState {
-    BlockBackend *source;
-    BlockBackend *target;
+    /*
+     * BdrvChild objects are not owned or managed by block-copy. They ar=
e
+     * provided by block-copy user and user is responsible for appropria=
te
+     * permissions on these children.
+     */
+    BdrvChild *source;
+    BdrvChild *target;
     BdrvDirtyBitmap *copy_bitmap;
     int64_t cluster_size;
     bool use_copy_range;
@@ -66,8 +71,7 @@ typedef struct BlockCopyState {
     void *progress_opaque;
 } BlockCopyState;
=20
-BlockCopyState *block_copy_state_new(BlockDriverState *source,
-                                     BlockDriverState *target,
+BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *targe=
t,
                                      int64_t cluster_size,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
@@ -84,6 +88,6 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
=20
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t b=
ytes,
-                            bool *error_is_read, bool is_write_notifier)=
;
+                            bool *error_is_read);
=20
 #endif /* BLOCK_COPY_H */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2b113eb3c7..05056b308a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1197,6 +1197,7 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
                             BdrvDirtyBitmap *sync_bitmap,
                             BitmapSyncMode bitmap_mode,
                             bool compress,
+                            const char *filter_node_name,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/block/backup-top.c b/block/backup-top.c
index 75a315744d..7cdb1f8eba 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -50,12 +50,11 @@ static coroutine_fn int backup_top_co_preadv(
 static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t of=
fset,
                                        uint64_t bytes)
 {
-    /*
-     * Here we'd like to use block_copy(), but block-copy need to be mov=
ed to
-     * use BdrvChildren to correctly use it in backup-top filter. It's a=
 TODO.
-     */
+    BDRVBackupTopState *s =3D bs->opaque;
+    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size)=
;
+    uint64_t off =3D QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
=20
-    abort();
+    return block_copy(s->bcs, off, end - off, NULL);
 }
=20
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
@@ -228,14 +227,10 @@ BlockDriverState *bdrv_backup_top_append(BlockDrive=
rState *source,
         goto failed_after_append;
     }
=20
-    /*
-     * TODO: Create block-copy-state here (which will utilize @cluster_s=
ize and
-     * @write_flags parameters which are unused now). For this, block-co=
py
-     * should be refactored to use BdrvChildren.
-     */
-    state->bcs =3D NULL;
-    if (!state->bcs) {
-        error_setg(&local_err, "Cannot create block-copy-state");
+    state->bcs =3D block_copy_state_new(top->backing, state->target,
+                                      cluster_size, write_flags, &local_=
err);
+    if (local_err) {
+        error_prepend(&local_err, "Cannot create block-copy-state: ");
         goto failed_after_append;
     }
     *bcs =3D state->bcs;
diff --git a/block/backup.c b/block/backup.c
index 1057ed0a4e..46978c1785 100644
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
@@ -27,10 +28,13 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
=20
+#include "block/backup-top.h"
+
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
=20
 typedef struct BackupBlockJob {
     BlockJob common;
+    BlockDriverState *backup_top;
     BlockDriverState *source_bs;
=20
     BdrvDirtyBitmap *sync_bitmap;
@@ -39,11 +43,9 @@ typedef struct BackupBlockJob {
     BitmapSyncMode bitmap_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
-    CoRwlock flush_rwlock;
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
-    NotifierWithReturn before_write;
=20
     BlockCopyState *bcs;
 } BackupBlockJob;
@@ -68,43 +70,23 @@ static void backup_progress_reset_callback(void *opaq=
ue)
=20
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
-                                      bool *error_is_read,
-                                      bool is_write_notifier)
+                                      bool *error_is_read)
 {
     int ret =3D 0;
     int64_t start, end; /* bytes */
=20
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
-
     start =3D QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end =3D QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
=20
     trace_backup_do_cow_enter(job, start, offset, bytes);
=20
-    ret =3D block_copy(job->bcs, start, end - start, error_is_read,
-                     is_write_notifier);
+    ret =3D block_copy(job->bcs, start, end - start, error_is_read);
=20
     trace_backup_do_cow_return(job, offset, bytes, ret);
=20
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
-
     return ret;
 }
=20
-static int coroutine_fn backup_before_write_notify(
-        NotifierWithReturn *notifier,
-        void *opaque)
-{
-    BackupBlockJob *job =3D container_of(notifier, BackupBlockJob, befor=
e_write);
-    BdrvTrackedRequest *req =3D opaque;
-
-    assert(req->bs =3D=3D job->source_bs);
-    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
-
-    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
@@ -154,7 +136,7 @@ static void backup_clean(Job *job)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
=20
-    block_copy_state_free(s->bcs);
+    bdrv_backup_top_drop(s->backup_top);
 }
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -220,8 +202,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *j=
ob)
             if (yield_and_check(job)) {
                 goto out;
             }
-            ret =3D backup_do_cow(job, offset,
-                                job->cluster_size, &error_is_read, false=
);
+            ret =3D backup_do_cow(job, offset, job->cluster_size, &error=
_is_read);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret)=
 =3D=3D
                            BLOCK_ERROR_ACTION_REPORT)
             {
@@ -265,13 +246,8 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     int ret =3D 0;
=20
-    qemu_co_rwlock_init(&s->flush_rwlock);
-
     backup_init_copy_bitmap(s);
=20
-    s->before_write.notify =3D backup_before_write_notify;
-    bdrv_add_before_write_notifier(s->source_bs, &s->before_write);
-
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
         int64_t offset =3D 0;
         int64_t count;
@@ -309,12 +285,6 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
     }
=20
  out:
-    notifier_with_return_remove(&s->before_write);
-
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&s->flush_rwlock);
-    qemu_co_rwlock_unlock(&s->flush_rwlock);
-
     return ret;
 }
=20
@@ -372,6 +342,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap=
,
                   BitmapSyncMode bitmap_mode,
                   bool compress,
+                  const char *filter_node_name,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -382,6 +353,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     BackupBlockJob *job =3D NULL;
     int64_t cluster_size;
     BdrvRequestFlags write_flags;
+    BlockDriverState *backup_top =3D NULL;
+    BlockCopyState *bcs =3D NULL;
=20
     assert(bs);
     assert(target);
@@ -463,33 +436,35 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
     write_flags =3D (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALIS=
ING : 0) |
                   (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
=20
+    backup_top =3D bdrv_backup_top_append(bs, target, filter_node_name,
+                                        cluster_size, write_flags, &bcs,=
 errp);
+    if (!backup_top) {
+        goto error;
+    }
+
     /* job->len is fixed, so we can't allow resize */
-    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK=
_PERM_ALL,
+    job =3D block_job_create(job_id, &backup_job_driver, txn, backup_top=
,
+                           0, BLK_PERM_ALL,
                            speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
     }
=20
+    job->backup_top =3D backup_top;
     job->source_bs =3D bs;
     job->on_source_error =3D on_source_error;
     job->on_target_error =3D on_target_error;
     job->sync_mode =3D sync_mode;
     job->sync_bitmap =3D sync_bitmap;
     job->bitmap_mode =3D bitmap_mode;
-
-    job->bcs =3D block_copy_state_new(bs, target, cluster_size, write_fl=
ags,
-                                    errp);
-    if (!job->bcs) {
-        goto error;
-    }
-
+    job->bcs =3D bcs;
     job->cluster_size =3D cluster_size;
     job->len =3D len;
=20
-    block_copy_set_callbacks(job->bcs, backup_progress_bytes_callback,
+    block_copy_set_callbacks(bcs, backup_progress_bytes_callback,
                              backup_progress_reset_callback, job);
=20
-    /* Required permissions are already taken by block-copy-state target=
 */
+    /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
=20
@@ -502,6 +477,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     if (job) {
         backup_clean(&job->common.job);
         job_early_fail(&job->common.job);
+    } else if (backup_top) {
+        bdrv_backup_top_drop(backup_top);
     }
=20
     return NULL;
diff --git a/block/block-copy.c b/block/block-copy.c
index fcb112da14..0f76ea1e63 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -60,24 +60,22 @@ void block_copy_state_free(BlockCopyState *s)
         return;
     }
=20
-    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
-    blk_unref(s->source);
-    blk_unref(s->target);
+    bdrv_release_dirty_bitmap(s->source->bs, s->copy_bitmap);
     g_free(s);
 }
=20
-BlockCopyState *block_copy_state_new(BlockDriverState *source,
-                                     BlockDriverState *target,
+BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *targe=
t,
                                      int64_t cluster_size,
                                      BdrvRequestFlags write_flags, Error=
 **errp)
 {
     BlockCopyState *s;
-    int ret;
-    uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
     BdrvDirtyBitmap *copy_bitmap;
+    uint32_t max_transfer =3D
+            MIN_NON_ZERO(INT_MAX, MIN_NON_ZERO(source->bs->bl.max_transf=
er,
+                                               target->bs->bl.max_transf=
er));
=20
-    copy_bitmap =3D bdrv_create_dirty_bitmap(source, cluster_size, NULL,=
 errp);
+    copy_bitmap =3D bdrv_create_dirty_bitmap(source->bs, cluster_size, N=
ULL,
+                                           errp);
     if (!copy_bitmap) {
         return NULL;
     }
@@ -85,19 +83,15 @@ BlockCopyState *block_copy_state_new(BlockDriverState=
 *source,
=20
     s =3D g_new(BlockCopyState, 1);
     *s =3D (BlockCopyState) {
-        .source =3D blk_new(bdrv_get_aio_context(source),
-                          BLK_PERM_CONSISTENT_READ, no_resize),
-        .target =3D blk_new(bdrv_get_aio_context(target),
-                          BLK_PERM_WRITE, no_resize),
+        .source =3D source,
+        .target =3D target,
         .copy_bitmap =3D copy_bitmap,
         .cluster_size =3D cluster_size,
         .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
         .write_flags =3D write_flags,
     };
=20
-    s->copy_range_size =3D QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s->s=
ource),
-                                             blk_get_max_transfer(s->tar=
get)),
-                                         s->cluster_size);
+    s->copy_range_size =3D QEMU_ALIGN_DOWN(max_transfer, cluster_size),
     /*
      * Set use_copy_range, consider the following:
      * 1. Compression is not supported for copy_range.
@@ -111,32 +105,7 @@ BlockCopyState *block_copy_state_new(BlockDriverStat=
e *source,
=20
     QLIST_INIT(&s->inflight_reqs);
=20
-    /*
-     * We just allow aio context change on our block backends. block_cop=
y() user
-     * (now it's only backup) is responsible for source and target being=
 in same
-     * aio context.
-     */
-    blk_set_disable_request_queuing(s->source, true);
-    blk_set_allow_aio_context_change(s->source, true);
-    blk_set_disable_request_queuing(s->target, true);
-    blk_set_allow_aio_context_change(s->target, true);
-
-    ret =3D blk_insert_bs(s->source, source, errp);
-    if (ret < 0) {
-        goto fail;
-    }
-
-    ret =3D blk_insert_bs(s->target, target, errp);
-    if (ret < 0) {
-        goto fail;
-    }
-
     return s;
-
-fail:
-    block_copy_state_free(s);
-
-    return NULL;
 }
=20
 void block_copy_set_callbacks(
@@ -157,22 +126,20 @@ void block_copy_set_callbacks(
 static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
-                                                      bool is_write_noti=
fier,
                                                       bool *error_is_rea=
d,
                                                       void **bounce_buff=
er)
 {
     int ret;
     int nbytes;
-    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
=20
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     nbytes =3D MIN(s->cluster_size, s->len - start);
     if (!*bounce_buffer) {
-        *bounce_buffer =3D blk_blockalign(s->source, s->cluster_size);
+        *bounce_buffer =3D qemu_blockalign(s->source->bs, s->cluster_siz=
e);
     }
=20
-    ret =3D blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_=
flags);
+    ret =3D bdrv_co_pread(s->source, start, nbytes, *bounce_buffer, 0);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
@@ -181,8 +148,8 @@ static int coroutine_fn block_copy_with_bounce_buffer=
(BlockCopyState *s,
         goto fail;
     }
=20
-    ret =3D blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
-                        s->write_flags);
+    ret =3D bdrv_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+                         s->write_flags);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
         if (error_is_read) {
@@ -204,13 +171,11 @@ fail:
  */
 static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
                                                 int64_t start,
-                                                int64_t end,
-                                                bool is_write_notifier)
+                                                int64_t end)
 {
     int ret;
     int nr_clusters;
     int nbytes;
-    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
=20
     assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
@@ -218,8 +183,8 @@ static int coroutine_fn block_copy_with_offload(Block=
CopyState *s,
     nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
                             s->cluster_size * nr_clusters);
-    ret =3D blk_co_copy_range(s->source, start, s->target, start, nbytes=
,
-                            read_flags, s->write_flags);
+    ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nbyte=
s,
+                             0, s->write_flags);
     if (ret < 0) {
         trace_block_copy_with_offload_fail(s, start, ret);
         bdrv_set_dirty_bitmap(s->copy_bitmap, start,
@@ -237,7 +202,7 @@ static int coroutine_fn block_copy_with_offload(Block=
CopyState *s,
 static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t of=
fset,
                                            int64_t *pnum)
 {
-    BlockDriverState *bs =3D blk_bs(s->source);
+    BlockDriverState *bs =3D s->source->bs;
     int64_t count, total_count =3D 0;
     int64_t bytes =3D s->len - offset;
     int ret;
@@ -302,8 +267,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *=
s,
=20
 int coroutine_fn block_copy(BlockCopyState *s,
                             int64_t start, uint64_t bytes,
-                            bool *error_is_read,
-                            bool is_write_notifier)
+                            bool *error_is_read)
 {
     int ret =3D 0;
     int64_t end =3D bytes + start; /* bytes */
@@ -315,7 +279,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
      * block_copy() user is responsible for keeping source and target in=
 same
      * aio context
      */
-    assert(blk_get_aio_context(s->source) =3D=3D blk_get_aio_context(s->=
target));
+    assert(bdrv_get_aio_context(s->source->bs) =3D=3D
+           bdrv_get_aio_context(s->target->bs));
=20
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end, s->cluster_size));
@@ -352,15 +317,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
         trace_block_copy_process(s, start);
=20
         if (s->use_copy_range) {
-            ret =3D block_copy_with_offload(s, start, dirty_end,
-                                          is_write_notifier);
+            ret =3D block_copy_with_offload(s, start, dirty_end);
             if (ret < 0) {
                 s->use_copy_range =3D false;
             }
         }
         if (!s->use_copy_range) {
             ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                is_write_notifier,
                                                 error_is_read, &bounce_b=
uffer);
         }
         if (ret < 0) {
diff --git a/block/replication.c b/block/replication.c
index 936b2f8b5a..99532ce521 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -543,7 +543,7 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
=20
         s->backup_job =3D backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_d=
isk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false=
,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false=
, NULL,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_e=
rr);
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..f89e48fc79 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3601,6 +3601,7 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
     job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
                             backup->sync, bmap, backup->bitmap_mode,
                             backup->compress,
+                            backup->filter_node_name,
                             backup->on_source_error,
                             backup->on_target_error,
                             job_flags, NULL, NULL, txn, errp);
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 98c55d8e5a..f39287c162 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -133,6 +133,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm =3D iotests.VM()
         self.test_img =3D img_create('test')
         self.dest_img =3D img_create('dest')
+        self.dest_img2 =3D img_create('dest2')
         self.ref_img =3D img_create('ref')
         self.vm.add_drive(self.test_img)
         self.vm.launch()
@@ -141,6 +142,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm.shutdown()
         try_remove(self.test_img)
         try_remove(self.dest_img)
+        try_remove(self.dest_img2)
         try_remove(self.ref_img)
=20
     def hmp_io_writes(self, drive, patterns):
@@ -253,9 +255,9 @@ class BackupTest(iotests.QMPTestCase):
         res =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'concluded')
         # Leave zombie job un-dismissed, observe a failure:
-        res =3D self.qmp_backup_and_wait(serror=3D"Node 'drive0' is busy=
: block device is in use by block job: backup",
+        res =3D self.qmp_backup_and_wait(serror=3D"Job ID 'drive0' alrea=
dy in use",
                                        device=3D'drive0', format=3Diotes=
ts.imgfmt,
-                                       sync=3D'full', target=3Dself.dest=
_img,
+                                       sync=3D'full', target=3Dself.dest=
_img2,
                                        auto_dismiss=3DFalse)
         self.assertEqual(res, False)
         # OK, dismiss the zombie.
@@ -265,7 +267,7 @@ class BackupTest(iotests.QMPTestCase):
         self.assert_qmp(res, 'return', [])
         # Ensure it's really gone.
         self.qmp_backup_and_wait(device=3D'drive0', format=3Diotests.img=
fmt,
-                                 sync=3D'full', target=3Dself.dest_img,
+                                 sync=3D'full', target=3Dself.dest_img2,
                                  auto_dismiss=3DFalse)
=20
     def dismissal_failure(self, dismissal_opt):
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index dbd3bdef6c..e3b578282d 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -10,7 +10,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/m.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node i=
s used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "of=
fset": 0, "speed": 0, "type": "backup"}}
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index de8b45f094..a9828251cf 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -190,6 +190,7 @@ def blockdev_backup(vm, device, target, sync, **kwarg=
s):
                         device=3Ddevice,
                         target=3Dtarget,
                         sync=3Dsync,
+                        filter_node_name=3D'backup-top',
                         **kwargs)
     return result
=20
@@ -216,7 +217,7 @@ def backup(drive, n, filepath, sync, **kwargs):
                              job_id=3Djob_id, **kwargs)
     return job_id
=20
-def perform_writes(drive, n):
+def perform_writes(drive, n, filter_node_name=3DNone):
     log("--- Write #{:d} ---\n".format(n))
     for pattern in GROUPS[n].patterns:
         cmd =3D "write -P{:s} 0x{:07x} 0x{:x}".format(
@@ -224,7 +225,7 @@ def perform_writes(drive, n):
             pattern.offset,
             pattern.size)
         log(cmd)
-        log(drive.vm.hmp_qemu_io(drive.node, cmd))
+        log(drive.vm.hmp_qemu_io(filter_node_name or drive.node, cmd))
     bitmaps =3D drive.vm.query_bitmaps()
     log({'bitmaps': bitmaps}, indent=3D2)
     log('')
@@ -355,7 +356,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
             """Issue writes while the job is open to test bitmap diverge=
nce."""
             # Note: when `failure` is 'intermediate', this isn't called.
             log('')
-            bitmaps =3D perform_writes(drive0, 2)
+            bitmaps =3D perform_writes(drive0, 2, filter_node_name=3D'ba=
ckup-top')
             # Named bitmap (static, should be unchanged)
             ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
                                           bitmaps=3Dbitmaps))
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index ec7e25877b..64dd460055 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -30,7 +30,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -78,7 +78,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -92,7 +92,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": =
"backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -205,7 +205,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -219,7 +219,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": =
"backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -290,7 +290,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -338,7 +338,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -354,7 +354,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": =
"backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -416,7 +416,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -430,7 +430,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": =
"backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -501,7 +501,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -549,7 +549,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -563,7 +563,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target": =
"backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -676,7 +676,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -690,7 +690,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target": =
"backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -761,7 +761,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -809,7 +809,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -823,7 +823,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "targ=
et": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -936,7 +936,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -950,7 +950,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1021,7 +1021,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1069,7 +1069,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1085,7 +1085,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "targ=
et": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -1147,7 +1147,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1161,7 +1161,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1232,7 +1232,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1280,7 +1280,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1294,7 +1294,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "targ=
et": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -1407,7 +1407,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1421,7 +1421,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1492,7 +1492,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1540,7 +1540,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1554,7 +1554,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target":=
 "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -1667,7 +1667,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1681,7 +1681,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1752,7 +1752,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1800,7 +1800,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1816,7 +1816,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target":=
 "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -1878,7 +1878,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -1892,7 +1892,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -1963,7 +1963,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2011,7 +2011,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2025,7 +2025,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "bitmap", "target":=
 "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -2138,7 +2138,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2152,7 +2152,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2223,7 +2223,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2271,7 +2271,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2285,7 +2285,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target=
": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -2398,7 +2398,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2412,7 +2412,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2483,7 +2483,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2531,7 +2531,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2547,7 +2547,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target=
": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
@@ -2609,7 +2609,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2623,7 +2623,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2694,7 +2694,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2742,7 +2742,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2756,7 +2756,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target=
": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -2869,7 +2869,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -2883,7 +2883,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -2954,7 +2954,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3002,7 +3002,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3016,7 +3016,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "=
backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -3129,7 +3129,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3143,7 +3143,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3214,7 +3214,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3262,7 +3262,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3278,7 +3278,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "=
backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
@@ -3340,7 +3340,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3354,7 +3354,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3425,7 +3425,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3473,7 +3473,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3487,7 +3487,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "=
backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -3600,7 +3600,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3614,7 +3614,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3685,7 +3685,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3733,7 +3733,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3747,7 +3747,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target"=
: "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -3860,7 +3860,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3874,7 +3874,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -3945,7 +3945,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -3993,7 +3993,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4009,7 +4009,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target"=
: "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 45=
8752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -4071,7 +4071,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4085,7 +4085,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4156,7 +4156,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4204,7 +4204,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4218,7 +4218,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_1", "sync": "top", "target"=
: "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -4331,7 +4331,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4345,7 +4345,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "targ=
et": "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4416,7 +4416,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4464,7 +4464,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4478,7 +4478,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "b=
ackup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -4591,7 +4591,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4605,7 +4605,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4676,7 +4676,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4724,7 +4724,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4740,7 +4740,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "b=
ackup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 45=
8752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -4802,7 +4802,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4816,7 +4816,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -4887,7 +4887,7 @@ write -P0x76 0x3ff0000 0x10000
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "tar=
get": "ref_target_0"}}
 {"return": {}}
 {"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4935,7 +4935,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "tar=
get": "ref_target_1"}}
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -4949,7 +4949,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_1", "sync": "top", "target": "b=
ackup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -5062,7 +5062,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "tar=
get": "ref_target_2"}}
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
@@ -5076,7 +5076,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "backup-top", "job-id": "backup_2", "sync": "bitmap", "target":=
 "backup_target_2"}}
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
@@ -5139,155 +5139,155 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/P=
ID-fbackup2" =3D=3D> Identical, OK!
=20
 -- Sync mode incremental tests --
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "incremental", "target=
": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_jo=
b", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "=
backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", =
"sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "b=
ackup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "=
sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "api_job", "sync": "incremental", "t=
arget": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "incremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "backup-=
top", "job-id": "api_job", "sync": "incremental", "target": "backup_targe=
t"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "in=
cremental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "backup-top"=
, "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "inc=
remental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "backup-top",=
 "job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "ba=
ckup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "s=
ync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "incr=
emental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "backup-top", =
"job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "incre=
mental", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "=
job-id": "api_job", "sync": "incremental", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
 -- Sync mode bitmap tests --
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "b=
ackup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_jo=
b", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backu=
p_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", =
"sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup=
_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "=
sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter=
-node-name": "backup-top", "job-id": "api_job", "sync": "bitmap", "target=
": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "bitmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "backup-=
top", "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "bi=
tmap", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "backup-top"=
, "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "bit=
map", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "backup-top",=
 "job-id": "api_job", "sync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_=
target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "s=
ync": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_ta=
rget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "syn=
c": "bitmap", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
=20
 -- Sync mode full tests --
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "full", "target": "bac=
kup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_jo=
b", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_=
target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", =
"sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_t=
arget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "=
sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "full", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "backup-=
top", "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "fu=
ll", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "backup-top"=
, "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "ful=
l", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "backup-top",=
 "job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_ta=
rget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "s=
ync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "full"=
, "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "=
job-id": "api_job", "sync": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' ha=
s no meaningful effect when combined with sync mode 'full'"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_targ=
et"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "syn=
c": "full", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
=20
 -- Sync mode top tests --
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "top", "target": "back=
up_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_jo=
b", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_t=
arget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", =
"sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_ta=
rget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "=
sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "top", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "backup-=
top", "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "to=
p", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "backup-top"=
, "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top=
", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "backup-top",=
 "job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_tar=
get"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "s=
ync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top",=
 "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "=
job-id": "api_job", "sync": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' ha=
s no meaningful effect when combined with sync mode 'top'"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_targe=
t"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "syn=
c": "top", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
=20
 -- Sync mode none tests --
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "none", "target": "bac=
kup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "backup-top", "job-id": "api_jo=
b", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_=
target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", =
"sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_t=
arget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "=
sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "backup-=
top", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "no=
ne", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "backup-top"=
, "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "non=
e", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "backup-top",=
 "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_ta=
rget"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "s=
ync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "=
none", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "backup-to=
p", "job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "none=
", "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "backup-top", =
"job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "none"=
, "target": "backup_target"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "backup-top", "=
job-id": "api_job", "sync": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
=20
-{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_targ=
et"}}
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "backup-top", "job-id": "api_job", "syn=
c": "none", "target": "backup_target"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
=20
--=20
2.21.0


