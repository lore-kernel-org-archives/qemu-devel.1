Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F595C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D0620650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D0620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXEF-0007O4-PA
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWr2-0006b1-3t
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqy-0008BW-HJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqr-00088r-K9; Thu, 10 Oct 2019 07:43:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4B3966974;
 Thu, 10 Oct 2019 11:43:24 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F12F60BE1;
 Thu, 10 Oct 2019 11:43:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/36] block/backup: introduce BlockCopyState
Date: Thu, 10 Oct 2019 13:42:34 +0200
Message-Id: <20191010114300.7746-11-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 10 Oct 2019 11:43:24 +0000 (UTC)
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

Split copying code part from backup to "block-copy", including separate
state structure and function renaming. This is needed to share it with
backup-top filter driver in further commits.

Notes:

1. As BlockCopyState keeps own BlockBackend objects, remaining
job->common.blk users only use it to get bs by blk_bs() call, so clear
job->commen.blk permissions set in block_job_create and add
job->source_bs to be used instead of blk_bs(job->common.blk), to keep
it more clear which bs we use when introduce backup-top filter in
further commit.

2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit better
as interface to BlockCopyState

3. Split is not very clean: there left some duplicated fields, backup
code uses some BlockCopyState fields directly, let's postpone it for
further improvements and keep this comment simpler for review.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190920142056.12778-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c     | 370 ++++++++++++++++++++++++++++-----------------
 block/trace-events |  12 +-
 2 files changed, 239 insertions(+), 143 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ae28849660..5dda1673ca 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -35,12 +35,52 @@ typedef struct CowRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;
=20
+typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
+typedef void (*ProgressResetCallbackFunc)(void *opaque);
+typedef struct BlockCopyState {
+    BlockBackend *source;
+    BlockBackend *target;
+    BdrvDirtyBitmap *copy_bitmap;
+    int64_t cluster_size;
+    bool use_copy_range;
+    int64_t copy_range_size;
+    uint64_t len;
+
+    BdrvRequestFlags write_flags;
+
+    /*
+     * skip_unallocated:
+     *
+     * Used by sync=3Dtop jobs, which first scan the source node for una=
llocated
+     * areas and clear them in the copy_bitmap.  During this process, th=
e bitmap
+     * is thus not fully initialized: It may still have bits set for are=
as that
+     * are unallocated and should actually not be copied.
+     *
+     * This is indicated by skip_unallocated.
+     *
+     * In this case, block_copy() will query the source=E2=80=99s alloca=
tion status,
+     * skip unallocated regions, clear them in the copy_bitmap, and invo=
ke
+     * block_copy_reset_unallocated() every time it does.
+     */
+    bool skip_unallocated;
+
+    /* progress_bytes_callback: called when some copying progress is don=
e. */
+    ProgressBytesCallbackFunc progress_bytes_callback;
+
+    /*
+     * progress_reset_callback: called when some bytes reset from copy_b=
itmap
+     * (see @skip_unallocated above). The callee is assumed to recalcula=
te how
+     * many bytes remain based on the dirty bit count of copy_bitmap.
+     */
+    ProgressResetCallbackFunc progress_reset_callback;
+    void *progress_opaque;
+} BlockCopyState;
+
 typedef struct BackupBlockJob {
     BlockJob common;
-    BlockBackend *target;
+    BlockDriverState *source_bs;
=20
     BdrvDirtyBitmap *sync_bitmap;
-    BdrvDirtyBitmap *copy_bitmap;
=20
     MirrorSyncMode sync_mode;
     BitmapSyncMode bitmap_mode;
@@ -53,11 +93,7 @@ typedef struct BackupBlockJob {
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
=20
-    bool use_copy_range;
-    int64_t copy_range_size;
-
-    BdrvRequestFlags write_flags;
-    bool initializing_bitmap;
+    BlockCopyState *bcs;
 } BackupBlockJob;
=20
 static const BlockJobDriver backup_job_driver;
@@ -99,9 +135,97 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
=20
+static void block_copy_state_free(BlockCopyState *s)
+{
+    if (!s) {
+        return;
+    }
+
+    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
+    blk_unref(s->source);
+    blk_unref(s->target);
+    g_free(s);
+}
+
+static BlockCopyState *block_copy_state_new(
+        BlockDriverState *source, BlockDriverState *target,
+        int64_t cluster_size, BdrvRequestFlags write_flags,
+        ProgressBytesCallbackFunc progress_bytes_callback,
+        ProgressResetCallbackFunc progress_reset_callback,
+        void *progress_opaque, Error **errp)
+{
+    BlockCopyState *s;
+    int ret;
+    uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
+                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
+    BdrvDirtyBitmap *copy_bitmap;
+
+    copy_bitmap =3D bdrv_create_dirty_bitmap(source, cluster_size, NULL,=
 errp);
+    if (!copy_bitmap) {
+        return NULL;
+    }
+    bdrv_disable_dirty_bitmap(copy_bitmap);
+
+    s =3D g_new(BlockCopyState, 1);
+    *s =3D (BlockCopyState) {
+        .source =3D blk_new(bdrv_get_aio_context(source),
+                          BLK_PERM_CONSISTENT_READ, no_resize),
+        .target =3D blk_new(bdrv_get_aio_context(target),
+                          BLK_PERM_WRITE, no_resize),
+        .copy_bitmap =3D copy_bitmap,
+        .cluster_size =3D cluster_size,
+        .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
+        .write_flags =3D write_flags,
+        .progress_bytes_callback =3D progress_bytes_callback,
+        .progress_reset_callback =3D progress_reset_callback,
+        .progress_opaque =3D progress_opaque,
+    };
+
+    s->copy_range_size =3D QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s->s=
ource),
+                                             blk_get_max_transfer(s->tar=
get)),
+                                         s->cluster_size);
+    /*
+     * Set use_copy_range, consider the following:
+     * 1. Compression is not supported for copy_range.
+     * 2. copy_range does not respect max_transfer (it's a TODO), so we =
factor
+     *    that in here. If max_transfer is smaller than the job->cluster=
_size,
+     *    we do not use copy_range (in that case it's zero after alignin=
g down
+     *    above).
+     */
+    s->use_copy_range =3D
+        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size=
 > 0;
+
+    /*
+     * We just allow aio context change on our block backends. block_cop=
y() user
+     * (now it's only backup) is responsible for source and target being=
 in same
+     * aio context.
+     */
+    blk_set_disable_request_queuing(s->source, true);
+    blk_set_allow_aio_context_change(s->source, true);
+    blk_set_disable_request_queuing(s->target, true);
+    blk_set_allow_aio_context_change(s->target, true);
+
+    ret =3D blk_insert_bs(s->source, source, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret =3D blk_insert_bs(s->target, target, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    return s;
+
+fail:
+    block_copy_state_free(s);
+
+    return NULL;
+}
+
 /* Copy range to target with a bounce buffer and return the bytes copied=
. If
  * error occurred, return a negative error number */
-static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *jo=
b,
+static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
                                                       bool is_write_noti=
fier,
@@ -109,30 +233,29 @@ static int coroutine_fn backup_cow_with_bounce_buff=
er(BackupBlockJob *job,
                                                       void **bounce_buff=
er)
 {
     int ret;
-    BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
=20
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
-    nbytes =3D MIN(job->cluster_size, job->len - start);
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
+    nbytes =3D MIN(s->cluster_size, s->len - start);
     if (!*bounce_buffer) {
-        *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
+        *bounce_buffer =3D blk_blockalign(s->source, s->cluster_size);
     }
=20
-    ret =3D blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags)=
;
+    ret =3D blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_=
flags);
     if (ret < 0) {
-        trace_backup_do_cow_read_fail(job, start, ret);
+        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read =3D true;
         }
         goto fail;
     }
=20
-    ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
-                        job->write_flags);
+    ret =3D blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+                        s->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, start, ret);
+        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read =3D false;
         }
@@ -141,36 +264,35 @@ static int coroutine_fn backup_cow_with_bounce_buff=
er(BackupBlockJob *job,
=20
     return nbytes;
 fail:
-    bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
+    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
=20
 }
=20
 /* Copy range to target and return the bytes copied. If error occurred, =
return a
  * negative error number. */
-static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
+static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
                                                 int64_t start,
                                                 int64_t end,
                                                 bool is_write_notifier)
 {
     int ret;
     int nr_clusters;
-    BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
=20
-    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    nbytes =3D MIN(job->copy_range_size, MIN(end, job->len) - start);
-    nr_clusters =3D DIV_ROUND_UP(nbytes, job->cluster_size);
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
-                            job->cluster_size * nr_clusters);
-    ret =3D blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, job->write_flags);
+    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    nbytes =3D MIN(s->copy_range_size, MIN(end, s->len) - start);
+    nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
+                            s->cluster_size * nr_clusters);
+    ret =3D blk_co_copy_range(s->source, start, s->target, start, nbytes=
,
+                            read_flags, s->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_copy_range_fail(job, start, ret);
-        bdrv_set_dirty_bitmap(job->copy_bitmap, start,
-                              job->cluster_size * nr_clusters);
+        trace_block_copy_with_offload_fail(s, start, ret);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
+                              s->cluster_size * nr_clusters);
         return ret;
     }
=20
@@ -181,10 +303,10 @@ static int coroutine_fn backup_cow_with_offload(Bac=
kupBlockJob *job,
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this alloca=
tion.
  */
-static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset=
,
-                                       int64_t *pnum)
+static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t of=
fset,
+                                           int64_t *pnum)
 {
-    BlockDriverState *bs =3D blk_bs(s->common.blk);
+    BlockDriverState *bs =3D blk_bs(s->source);
     int64_t count, total_count =3D 0;
     int64_t bytes =3D s->len - offset;
     int ret;
@@ -225,13 +347,13 @@ static int backup_is_cluster_allocated(BackupBlockJ=
ob *s, int64_t offset,
  * @return 0 when the cluster at @offset was unallocated,
  *         1 otherwise, and -ret on error.
  */
-static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
-                                               int64_t offset, int64_t *=
count)
+static int64_t block_copy_reset_unallocated(BlockCopyState *s,
+                                            int64_t offset, int64_t *cou=
nt)
 {
     int ret;
-    int64_t clusters, bytes, estimate;
+    int64_t clusters, bytes;
=20
-    ret =3D backup_is_cluster_allocated(s, offset, &clusters);
+    ret =3D block_copy_is_cluster_allocated(s, offset, &clusters);
     if (ret < 0) {
         return ret;
     }
@@ -240,46 +362,51 @@ static int64_t backup_bitmap_reset_unallocated(Back=
upBlockJob *s,
=20
     if (!ret) {
         bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        estimate =3D bdrv_get_dirty_count(s->copy_bitmap);
-        job_progress_set_remaining(&s->common.job, estimate);
+        s->progress_reset_callback(s->progress_opaque);
     }
=20
     *count =3D bytes;
     return ret;
 }
=20
-static int coroutine_fn backup_do_copy(BackupBlockJob *job,
-                                       int64_t start, uint64_t bytes,
-                                       bool *error_is_read,
-                                       bool is_write_notifier)
+static int coroutine_fn block_copy(BlockCopyState *s,
+                                   int64_t start, uint64_t bytes,
+                                   bool *error_is_read,
+                                   bool is_write_notifier)
 {
     int ret =3D 0;
     int64_t end =3D bytes + start; /* bytes */
     void *bounce_buffer =3D NULL;
     int64_t status_bytes;
=20
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, job->cluster_size));
+    /*
+     * block_copy() user is responsible for keeping source and target in=
 same
+     * aio context
+     */
+    assert(blk_get_aio_context(s->source) =3D=3D blk_get_aio_context(s->=
target));
+
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
=20
     while (start < end) {
         int64_t dirty_end;
=20
-        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
-            trace_backup_do_cow_skip(job, start);
-            start +=3D job->cluster_size;
+        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
+            trace_block_copy_skip(s, start);
+            start +=3D s->cluster_size;
             continue; /* already copied */
         }
=20
-        dirty_end =3D bdrv_dirty_bitmap_next_zero(job->copy_bitmap, star=
t,
+        dirty_end =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
                                                 (end - start));
         if (dirty_end < 0) {
             dirty_end =3D end;
         }
=20
-        if (job->initializing_bitmap) {
-            ret =3D backup_bitmap_reset_unallocated(job, start, &status_=
bytes);
+        if (s->skip_unallocated) {
+            ret =3D block_copy_reset_unallocated(s, start, &status_bytes=
);
             if (ret =3D=3D 0) {
-                trace_backup_do_cow_skip_range(job, start, status_bytes)=
;
+                trace_block_copy_skip_range(s, start, status_bytes);
                 start +=3D status_bytes;
                 continue;
             }
@@ -287,17 +414,17 @@ static int coroutine_fn backup_do_copy(BackupBlockJ=
ob *job,
             dirty_end =3D MIN(dirty_end, start + status_bytes);
         }
=20
-        trace_backup_do_cow_process(job, start);
+        trace_block_copy_process(s, start);
=20
-        if (job->use_copy_range) {
-            ret =3D backup_cow_with_offload(job, start, dirty_end,
+        if (s->use_copy_range) {
+            ret =3D block_copy_with_offload(s, start, dirty_end,
                                           is_write_notifier);
             if (ret < 0) {
-                job->use_copy_range =3D false;
+                s->use_copy_range =3D false;
             }
         }
-        if (!job->use_copy_range) {
-            ret =3D backup_cow_with_bounce_buffer(job, start, dirty_end,
+        if (!s->use_copy_range) {
+            ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
                                                 is_write_notifier,
                                                 error_is_read, &bounce_b=
uffer);
         }
@@ -305,12 +432,8 @@ static int coroutine_fn backup_do_copy(BackupBlockJo=
b *job,
             break;
         }
=20
-        /* Publish progress, guest I/O counts as progress too.  Note tha=
t the
-         * offset field is an opaque progress value, it is not a disk of=
fset.
-         */
         start +=3D ret;
-        job->bytes_read +=3D ret;
-        job_progress_update(&job->common.job, ret);
+        s->progress_bytes_callback(ret, s->progress_opaque);
         ret =3D 0;
     }
=20
@@ -321,6 +444,22 @@ static int coroutine_fn backup_do_copy(BackupBlockJo=
b *job,
     return ret;
 }
=20
+static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
+{
+    BackupBlockJob *s =3D opaque;
+
+    s->bytes_read +=3D bytes;
+    job_progress_update(&s->common.job, bytes);
+}
+
+static void backup_progress_reset_callback(void *opaque)
+{
+    BackupBlockJob *s =3D opaque;
+    uint64_t estimate =3D bdrv_get_dirty_count(s->bcs->copy_bitmap);
+
+    job_progress_set_remaining(&s->common.job, estimate);
+}
+
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
                                       bool *error_is_read,
@@ -340,8 +479,8 @@ static int coroutine_fn backup_do_cow(BackupBlockJob =
*job,
     wait_for_overlapping_requests(job, start, end);
     cow_request_begin(&cow_request, job, start, end);
=20
-    ret =3D backup_do_copy(job, start, end - start, error_is_read,
-                         is_write_notifier);
+    ret =3D block_copy(job->bcs, start, end - start, error_is_read,
+                     is_write_notifier);
=20
     cow_request_end(&cow_request);
=20
@@ -359,7 +498,7 @@ static int coroutine_fn backup_before_write_notify(
     BackupBlockJob *job =3D container_of(notifier, BackupBlockJob, befor=
e_write);
     BdrvTrackedRequest *req =3D opaque;
=20
-    assert(req->bs =3D=3D blk_bs(job->common.blk));
+    assert(req->bs =3D=3D job->source_bs);
     assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
=20
@@ -369,7 +508,6 @@ static int coroutine_fn backup_before_write_notify(
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
-    BlockDriverState *bs =3D blk_bs(job->common.blk);
     bool sync =3D (((ret =3D=3D 0) || (job->bitmap_mode =3D=3D BITMAP_SY=
NC_MODE_ALWAYS)) \
                  && (job->bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER));
=20
@@ -378,20 +516,20 @@ static void backup_cleanup_sync_bitmap(BackupBlockJ=
ob *job, int ret)
          * We succeeded, or we always intended to sync the bitmap.
          * Delete this bitmap and install the child.
          */
-        bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
+        bm =3D bdrv_dirty_bitmap_abdicate(job->source_bs, job->sync_bitm=
ap, NULL);
     } else {
         /*
          * We failed, or we never intended to sync the bitmap anyway.
          * Merge the successor back into the parent, keeping all data.
          */
-        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
+        bm =3D bdrv_reclaim_dirty_bitmap(job->source_bs, job->sync_bitma=
p, NULL);
     }
=20
     assert(bm);
=20
     if (ret < 0 && job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
         /* If we failed and synced, merge in the bits we didn't copy: */
-        bdrv_dirty_bitmap_merge_internal(bm, job->copy_bitmap,
+        bdrv_dirty_bitmap_merge_internal(bm, job->bcs->copy_bitmap,
                                          NULL, true);
     }
 }
@@ -415,16 +553,8 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs =3D blk_bs(s->common.blk);
=20
-    if (s->copy_bitmap) {
-        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
-        s->copy_bitmap =3D NULL;
-    }
-
-    assert(s->target);
-    blk_unref(s->target);
-    s->target =3D NULL;
+    block_copy_state_free(s->bcs);
 }
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -439,7 +569,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp=
)
         return;
     }
=20
-    bdrv_set_dirty_bitmap(backup_job->copy_bitmap, 0, backup_job->len);
+    bdrv_set_dirty_bitmap(backup_job->bcs->copy_bitmap, 0, backup_job->l=
en);
 }
=20
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
@@ -482,7 +612,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *j=
ob)
     BdrvDirtyBitmapIter *bdbi;
     int ret =3D 0;
=20
-    bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
+    bdbi =3D bdrv_dirty_iter_new(job->bcs->copy_bitmap);
     while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
         do {
             if (yield_and_check(job)) {
@@ -509,7 +639,7 @@ static void backup_init_copy_bitmap(BackupBlockJob *j=
ob)
     uint64_t estimate;
=20
     if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
-        ret =3D bdrv_dirty_bitmap_merge_internal(job->copy_bitmap,
+        ret =3D bdrv_dirty_bitmap_merge_internal(job->bcs->copy_bitmap,
                                                job->sync_bitmap,
                                                NULL, true);
         assert(ret);
@@ -519,19 +649,18 @@ static void backup_init_copy_bitmap(BackupBlockJob =
*job)
              * We can't hog the coroutine to initialize this thoroughly.
              * Set a flag and resume work when we are able to yield safe=
ly.
              */
-            job->initializing_bitmap =3D true;
+            job->bcs->skip_unallocated =3D true;
         }
-        bdrv_set_dirty_bitmap(job->copy_bitmap, 0, job->len);
+        bdrv_set_dirty_bitmap(job->bcs->copy_bitmap, 0, job->len);
     }
=20
-    estimate =3D bdrv_get_dirty_count(job->copy_bitmap);
+    estimate =3D bdrv_get_dirty_count(job->bcs->copy_bitmap);
     job_progress_set_remaining(&job->common.job, estimate);
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs =3D blk_bs(s->common.blk);
     int ret =3D 0;
=20
     QLIST_INIT(&s->inflight_reqs);
@@ -540,7 +669,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
     backup_init_copy_bitmap(s);
=20
     s->before_write.notify =3D backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
+    bdrv_add_before_write_notifier(s->source_bs, &s->before_write);
=20
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
         int64_t offset =3D 0;
@@ -552,14 +681,14 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
                 goto out;
             }
=20
-            ret =3D backup_bitmap_reset_unallocated(s, offset, &count);
+            ret =3D block_copy_reset_unallocated(s->bcs, offset, &count)=
;
             if (ret < 0) {
                 goto out;
             }
=20
             offset +=3D count;
         }
-        s->initializing_bitmap =3D false;
+        s->bcs->skip_unallocated =3D false;
     }
=20
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
@@ -646,9 +775,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
 {
     int64_t len;
     BackupBlockJob *job =3D NULL;
-    int ret;
     int64_t cluster_size;
-    BdrvDirtyBitmap *copy_bitmap =3D NULL;
+    BdrvRequestFlags write_flags;
=20
     assert(bs);
     assert(target);
@@ -713,33 +841,14 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
         goto error;
     }
=20
-    copy_bitmap =3D bdrv_create_dirty_bitmap(bs, cluster_size, NULL, err=
p);
-    if (!copy_bitmap) {
-        goto error;
-    }
-    bdrv_disable_dirty_bitmap(copy_bitmap);
-
     /* job->len is fixed, so we can't allow resize */
-    job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
-                           BLK_PERM_CONSISTENT_READ,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD=
,
+    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK=
_PERM_ALL,
                            speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
     }
=20
-    /* The target must match the source in size, so no resize here eithe=
r */
-    job->target =3D blk_new(job->common.job.aio_context,
-                          BLK_PERM_WRITE,
-                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD)=
;
-    ret =3D blk_insert_bs(job->target, target, errp);
-    if (ret < 0) {
-        goto error;
-    }
-    blk_set_disable_request_queuing(job->target, true);
-
+    job->source_bs =3D bs;
     job->on_source_error =3D on_source_error;
     job->on_target_error =3D on_target_error;
     job->sync_mode =3D sync_mode;
@@ -760,28 +869,19 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
      * For more information see commit f8d59dfb40bb and test
      * tests/qemu-iotests/222
      */
-    job->write_flags =3D
-        (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
-        (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    write_flags =3D (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALIS=
ING : 0) |
+                  (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
+
+    job->bcs =3D block_copy_state_new(bs, target, cluster_size, write_fl=
ags,
+                                    backup_progress_bytes_callback,
+                                    backup_progress_reset_callback, job,=
 errp);
+    if (!job->bcs) {
+        goto error;
+    }
=20
     job->cluster_size =3D cluster_size;
-    job->copy_bitmap =3D copy_bitmap;
-    copy_bitmap =3D NULL;
-    job->copy_range_size =3D MIN_NON_ZERO(blk_get_max_transfer(job->comm=
on.blk),
-                                        blk_get_max_transfer(job->target=
));
-    job->copy_range_size =3D QEMU_ALIGN_DOWN(job->copy_range_size,
-                                           job->cluster_size);
-    /*
-     * Set use_copy_range, consider the following:
-     * 1. Compression is not supported for copy_range.
-     * 2. copy_range does not respect max_transfer (it's a TODO), so we =
factor
-     *    that in here. If max_transfer is smaller than the job->cluster=
_size,
-     *    we do not use copy_range (in that case it's zero after alignin=
g down
-     *    above).
-     */
-    job->use_copy_range =3D !compress && job->copy_range_size > 0;
=20
-    /* Required permissions are already taken with target's blk_new() */
+    /* Required permissions are already taken by block-copy-state target=
 */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     job->len =3D len;
@@ -789,10 +889,6 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
     return &job->common;
=20
  error:
-    if (copy_bitmap) {
-        assert(!job || !job->copy_bitmap);
-        bdrv_release_dirty_bitmap(bs, copy_bitmap);
-    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
diff --git a/block/trace-events b/block/trace-events
index 3aa27e6b1e..cec8e40dba 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -40,12 +40,12 @@ mirror_yield_in_flight(void *s, int64_t offset, int i=
n_flight) "s %p offset %" P
 # backup.c
 backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t b=
ytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
 backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret)=
 "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
-backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
-backup_do_cow_skip_range(void *job, int64_t start, uint64_t bytes) "job =
%p start %"PRId64" bytes %"PRId64
-backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
-backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start=
 %"PRId64" ret %d"
-backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p star=
t %"PRId64" ret %d"
-backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job %p=
 start %"PRId64" ret %d"
+block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
+block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p =
start %"PRId64" bytes %"PRId64
+block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
+block_copy_with_bounce_buffer_read_fail(void *bcs, int64_t start, int re=
t) "bcs %p start %"PRId64" ret %d"
+block_copy_with_bounce_buffer_write_fail(void *bcs, int64_t start, int r=
et) "bcs %p start %"PRId64" ret %d"
+block_copy_with_offload_fail(void *bcs, int64_t start, int ret) "bcs %p =
start %"PRId64" ret %d"
=20
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
--=20
2.21.0


