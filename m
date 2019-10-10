Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97422C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F44B2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F44B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXOi-0002s7-C2
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWr7-0006dE-BI
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWr3-0008Cz-Rt
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqw-0008Au-9P; Thu, 10 Oct 2019 07:43:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62C5B3D955;
 Thu, 10 Oct 2019 11:43:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E28319C4F;
 Thu, 10 Oct 2019 11:43:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/36] block: move block_copy from block/backup.c to separate
 file
Date: Thu, 10 Oct 2019 13:42:36 +0200
Message-Id: <20191010114300.7746-13-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 10 Oct 2019 11:43:29 +0000 (UTC)
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

Split block_copy to separate file, to be cleanly shared with backup-top
filter driver in further commits.

It's a clean movement, the only change is drop "static" from interface
functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190920142056.12778-8-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs        |   1 +
 include/block/block-copy.h |  76 ++++++++
 block/backup.c             | 355 +------------------------------------
 block/block-copy.c         | 333 ++++++++++++++++++++++++++++++++++
 block/trace-events         |   2 +
 5 files changed, 413 insertions(+), 354 deletions(-)
 create mode 100644 include/block/block-copy.h
 create mode 100644 block/block-copy.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index c2eb8c8769..f06f1fa1ac 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -37,6 +37,7 @@ block-obj-y +=3D write-threshold.o
 block-obj-y +=3D backup.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
 block-obj-y +=3D throttle.o copy-on-read.o
+block-obj-y +=3D block-copy.o
=20
 block-obj-y +=3D crypto.o
=20
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
new file mode 100644
index 0000000000..54f90d0c9a
--- /dev/null
+++ b/include/block/block-copy.h
@@ -0,0 +1,76 @@
+/*
+ * block_copy API
+ *
+ * Copyright (C) 2013 Proxmox Server Solutions
+ * Copyright (c) 2019 Virtuozzo International GmbH.
+ *
+ * Authors:
+ *  Dietmar Maurer (dietmar@proxmox.com)
+ *  Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BLOCK_COPY_H
+#define BLOCK_COPY_H
+
+#include "block/block.h"
+
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
+BlockCopyState *block_copy_state_new(
+        BlockDriverState *source, BlockDriverState *target,
+        int64_t cluster_size, BdrvRequestFlags write_flags,
+        ProgressBytesCallbackFunc progress_bytes_callback,
+        ProgressResetCallbackFunc progress_reset_callback,
+        void *progress_opaque, Error **errp);
+
+void block_copy_state_free(BlockCopyState *s);
+
+int64_t block_copy_reset_unallocated(BlockCopyState *s,
+                                     int64_t offset, int64_t *count);
+
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t b=
ytes,
+                            bool *error_is_read, bool is_write_notifier)=
;
+
+#endif /* BLOCK_COPY_H */
diff --git a/block/backup.c b/block/backup.c
index f5125984db..4613b8c88d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -18,6 +18,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "block/block_backup.h"
+#include "block/block-copy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
@@ -35,47 +36,6 @@ typedef struct CowRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;
=20
-typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
-typedef void (*ProgressResetCallbackFunc)(void *opaque);
-typedef struct BlockCopyState {
-    BlockBackend *source;
-    BlockBackend *target;
-    BdrvDirtyBitmap *copy_bitmap;
-    int64_t cluster_size;
-    bool use_copy_range;
-    int64_t copy_range_size;
-    uint64_t len;
-
-    BdrvRequestFlags write_flags;
-
-    /*
-     * skip_unallocated:
-     *
-     * Used by sync=3Dtop jobs, which first scan the source node for una=
llocated
-     * areas and clear them in the copy_bitmap.  During this process, th=
e bitmap
-     * is thus not fully initialized: It may still have bits set for are=
as that
-     * are unallocated and should actually not be copied.
-     *
-     * This is indicated by skip_unallocated.
-     *
-     * In this case, block_copy() will query the source=E2=80=99s alloca=
tion status,
-     * skip unallocated regions, clear them in the copy_bitmap, and invo=
ke
-     * block_copy_reset_unallocated() every time it does.
-     */
-    bool skip_unallocated;
-
-    /* progress_bytes_callback: called when some copying progress is don=
e. */
-    ProgressBytesCallbackFunc progress_bytes_callback;
-
-    /*
-     * progress_reset_callback: called when some bytes reset from copy_b=
itmap
-     * (see @skip_unallocated above). The callee is assumed to recalcula=
te how
-     * many bytes remain based on the dirty bit count of copy_bitmap.
-     */
-    ProgressResetCallbackFunc progress_reset_callback;
-    void *progress_opaque;
-} BlockCopyState;
-
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockDriverState *source_bs;
@@ -135,319 +95,6 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
=20
-static void block_copy_state_free(BlockCopyState *s)
-{
-    if (!s) {
-        return;
-    }
-
-    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
-    blk_unref(s->source);
-    blk_unref(s->target);
-    g_free(s);
-}
-
-static BlockCopyState *block_copy_state_new(
-        BlockDriverState *source, BlockDriverState *target,
-        int64_t cluster_size, BdrvRequestFlags write_flags,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
-        void *progress_opaque, Error **errp)
-{
-    BlockCopyState *s;
-    int ret;
-    uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
-    BdrvDirtyBitmap *copy_bitmap;
-
-    copy_bitmap =3D bdrv_create_dirty_bitmap(source, cluster_size, NULL,=
 errp);
-    if (!copy_bitmap) {
-        return NULL;
-    }
-    bdrv_disable_dirty_bitmap(copy_bitmap);
-
-    s =3D g_new(BlockCopyState, 1);
-    *s =3D (BlockCopyState) {
-        .source =3D blk_new(bdrv_get_aio_context(source),
-                          BLK_PERM_CONSISTENT_READ, no_resize),
-        .target =3D blk_new(bdrv_get_aio_context(target),
-                          BLK_PERM_WRITE, no_resize),
-        .copy_bitmap =3D copy_bitmap,
-        .cluster_size =3D cluster_size,
-        .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
-        .write_flags =3D write_flags,
-        .progress_bytes_callback =3D progress_bytes_callback,
-        .progress_reset_callback =3D progress_reset_callback,
-        .progress_opaque =3D progress_opaque,
-    };
-
-    s->copy_range_size =3D QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s->s=
ource),
-                                             blk_get_max_transfer(s->tar=
get)),
-                                         s->cluster_size);
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
-    s->use_copy_range =3D
-        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size=
 > 0;
-
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
-    return s;
-
-fail:
-    block_copy_state_free(s);
-
-    return NULL;
-}
-
-/*
- * Copy range to target with a bounce buffer and return the bytes copied=
. If
- * error occurred, return a negative error number
- */
-static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
-                                                      int64_t start,
-                                                      int64_t end,
-                                                      bool is_write_noti=
fier,
-                                                      bool *error_is_rea=
d,
-                                                      void **bounce_buff=
er)
-{
-    int ret;
-    int nbytes;
-    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    nbytes =3D MIN(s->cluster_size, s->len - start);
-    if (!*bounce_buffer) {
-        *bounce_buffer =3D blk_blockalign(s->source, s->cluster_size);
-    }
-
-    ret =3D blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_=
flags);
-    if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
-        if (error_is_read) {
-            *error_is_read =3D true;
-        }
-        goto fail;
-    }
-
-    ret =3D blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
-                        s->write_flags);
-    if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
-        if (error_is_read) {
-            *error_is_read =3D false;
-        }
-        goto fail;
-    }
-
-    return nbytes;
-fail:
-    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    return ret;
-
-}
-
-/*
- * Copy range to target and return the bytes copied. If error occurred, =
return a
- * negative error number.
- */
-static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
-                                                int64_t start,
-                                                int64_t end,
-                                                bool is_write_notifier)
-{
-    int ret;
-    int nr_clusters;
-    int nbytes;
-    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-
-    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    nbytes =3D MIN(s->copy_range_size, MIN(end, s->len) - start);
-    nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
-                            s->cluster_size * nr_clusters);
-    ret =3D blk_co_copy_range(s->source, start, s->target, start, nbytes=
,
-                            read_flags, s->write_flags);
-    if (ret < 0) {
-        trace_block_copy_with_offload_fail(s, start, ret);
-        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
-                              s->cluster_size * nr_clusters);
-        return ret;
-    }
-
-    return nbytes;
-}
-
-/*
- * Check if the cluster starting at offset is allocated or not.
- * return via pnum the number of contiguous clusters sharing this alloca=
tion.
- */
-static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t of=
fset,
-                                           int64_t *pnum)
-{
-    BlockDriverState *bs =3D blk_bs(s->source);
-    int64_t count, total_count =3D 0;
-    int64_t bytes =3D s->len - offset;
-    int ret;
-
-    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-
-    while (true) {
-        ret =3D bdrv_is_allocated(bs, offset, bytes, &count);
-        if (ret < 0) {
-            return ret;
-        }
-
-        total_count +=3D count;
-
-        if (ret || count =3D=3D 0) {
-            /*
-             * ret: partial segment(s) are considered allocated.
-             * otherwise: unallocated tail is treated as an entire segme=
nt.
-             */
-            *pnum =3D DIV_ROUND_UP(total_count, s->cluster_size);
-            return ret;
-        }
-
-        /* Unallocated segment(s) with uncertain following segment(s) */
-        if (total_count >=3D s->cluster_size) {
-            *pnum =3D total_count / s->cluster_size;
-            return 0;
-        }
-
-        offset +=3D count;
-        bytes -=3D count;
-    }
-}
-
-/*
- * Reset bits in copy_bitmap starting at offset if they represent unallo=
cated
- * data in the image. May reset subsequent contiguous bits.
- * @return 0 when the cluster at @offset was unallocated,
- *         1 otherwise, and -ret on error.
- */
-static int64_t block_copy_reset_unallocated(BlockCopyState *s,
-                                            int64_t offset, int64_t *cou=
nt)
-{
-    int ret;
-    int64_t clusters, bytes;
-
-    ret =3D block_copy_is_cluster_allocated(s, offset, &clusters);
-    if (ret < 0) {
-        return ret;
-    }
-
-    bytes =3D clusters * s->cluster_size;
-
-    if (!ret) {
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        s->progress_reset_callback(s->progress_opaque);
-    }
-
-    *count =3D bytes;
-    return ret;
-}
-
-static int coroutine_fn block_copy(BlockCopyState *s,
-                                   int64_t start, uint64_t bytes,
-                                   bool *error_is_read,
-                                   bool is_write_notifier)
-{
-    int ret =3D 0;
-    int64_t end =3D bytes + start; /* bytes */
-    void *bounce_buffer =3D NULL;
-    int64_t status_bytes;
-
-    /*
-     * block_copy() user is responsible for keeping source and target in=
 same
-     * aio context
-     */
-    assert(blk_get_aio_context(s->source) =3D=3D blk_get_aio_context(s->=
target));
-
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
-
-    while (start < end) {
-        int64_t dirty_end;
-
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
-            trace_block_copy_skip(s, start);
-            start +=3D s->cluster_size;
-            continue; /* already copied */
-        }
-
-        dirty_end =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                (end - start));
-        if (dirty_end < 0) {
-            dirty_end =3D end;
-        }
-
-        if (s->skip_unallocated) {
-            ret =3D block_copy_reset_unallocated(s, start, &status_bytes=
);
-            if (ret =3D=3D 0) {
-                trace_block_copy_skip_range(s, start, status_bytes);
-                start +=3D status_bytes;
-                continue;
-            }
-            /* Clamp to known allocated region */
-            dirty_end =3D MIN(dirty_end, start + status_bytes);
-        }
-
-        trace_block_copy_process(s, start);
-
-        if (s->use_copy_range) {
-            ret =3D block_copy_with_offload(s, start, dirty_end,
-                                          is_write_notifier);
-            if (ret < 0) {
-                s->use_copy_range =3D false;
-            }
-        }
-        if (!s->use_copy_range) {
-            ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                is_write_notifier,
-                                                error_is_read, &bounce_b=
uffer);
-        }
-        if (ret < 0) {
-            break;
-        }
-
-        start +=3D ret;
-        s->progress_bytes_callback(ret, s->progress_opaque);
-        ret =3D 0;
-    }
-
-    if (bounce_buffer) {
-        qemu_vfree(bounce_buffer);
-    }
-
-    return ret;
-}
-
 static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
 {
     BackupBlockJob *s =3D opaque;
diff --git a/block/block-copy.c b/block/block-copy.c
new file mode 100644
index 0000000000..3fc9152853
--- /dev/null
+++ b/block/block-copy.c
@@ -0,0 +1,333 @@
+/*
+ * block_copy API
+ *
+ * Copyright (C) 2013 Proxmox Server Solutions
+ * Copyright (c) 2019 Virtuozzo International GmbH.
+ *
+ * Authors:
+ *  Dietmar Maurer (dietmar@proxmox.com)
+ *  Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace.h"
+#include "qapi/error.h"
+#include "block/block-copy.h"
+#include "sysemu/block-backend.h"
+
+void block_copy_state_free(BlockCopyState *s)
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
+BlockCopyState *block_copy_state_new(
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
+/*
+ * Copy range to target with a bounce buffer and return the bytes copied=
. If
+ * error occurred, return a negative error number
+ */
+static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
+                                                      int64_t start,
+                                                      int64_t end,
+                                                      bool is_write_noti=
fier,
+                                                      bool *error_is_rea=
d,
+                                                      void **bounce_buff=
er)
+{
+    int ret;
+    int nbytes;
+    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
+    nbytes =3D MIN(s->cluster_size, s->len - start);
+    if (!*bounce_buffer) {
+        *bounce_buffer =3D blk_blockalign(s->source, s->cluster_size);
+    }
+
+    ret =3D blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_=
flags);
+    if (ret < 0) {
+        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
+        if (error_is_read) {
+            *error_is_read =3D true;
+        }
+        goto fail;
+    }
+
+    ret =3D blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+                        s->write_flags);
+    if (ret < 0) {
+        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
+        if (error_is_read) {
+            *error_is_read =3D false;
+        }
+        goto fail;
+    }
+
+    return nbytes;
+fail:
+    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
+    return ret;
+
+}
+
+/*
+ * Copy range to target and return the bytes copied. If error occurred, =
return a
+ * negative error number.
+ */
+static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
+                                                int64_t start,
+                                                int64_t end,
+                                                bool is_write_notifier)
+{
+    int ret;
+    int nr_clusters;
+    int nbytes;
+    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+
+    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    nbytes =3D MIN(s->copy_range_size, MIN(end, s->len) - start);
+    nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
+                            s->cluster_size * nr_clusters);
+    ret =3D blk_co_copy_range(s->source, start, s->target, start, nbytes=
,
+                            read_flags, s->write_flags);
+    if (ret < 0) {
+        trace_block_copy_with_offload_fail(s, start, ret);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
+                              s->cluster_size * nr_clusters);
+        return ret;
+    }
+
+    return nbytes;
+}
+
+/*
+ * Check if the cluster starting at offset is allocated or not.
+ * return via pnum the number of contiguous clusters sharing this alloca=
tion.
+ */
+static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t of=
fset,
+                                           int64_t *pnum)
+{
+    BlockDriverState *bs =3D blk_bs(s->source);
+    int64_t count, total_count =3D 0;
+    int64_t bytes =3D s->len - offset;
+    int ret;
+
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+
+    while (true) {
+        ret =3D bdrv_is_allocated(bs, offset, bytes, &count);
+        if (ret < 0) {
+            return ret;
+        }
+
+        total_count +=3D count;
+
+        if (ret || count =3D=3D 0) {
+            /*
+             * ret: partial segment(s) are considered allocated.
+             * otherwise: unallocated tail is treated as an entire segme=
nt.
+             */
+            *pnum =3D DIV_ROUND_UP(total_count, s->cluster_size);
+            return ret;
+        }
+
+        /* Unallocated segment(s) with uncertain following segment(s) */
+        if (total_count >=3D s->cluster_size) {
+            *pnum =3D total_count / s->cluster_size;
+            return 0;
+        }
+
+        offset +=3D count;
+        bytes -=3D count;
+    }
+}
+
+/*
+ * Reset bits in copy_bitmap starting at offset if they represent unallo=
cated
+ * data in the image. May reset subsequent contiguous bits.
+ * @return 0 when the cluster at @offset was unallocated,
+ *         1 otherwise, and -ret on error.
+ */
+int64_t block_copy_reset_unallocated(BlockCopyState *s,
+                                     int64_t offset, int64_t *count)
+{
+    int ret;
+    int64_t clusters, bytes;
+
+    ret =3D block_copy_is_cluster_allocated(s, offset, &clusters);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bytes =3D clusters * s->cluster_size;
+
+    if (!ret) {
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+        s->progress_reset_callback(s->progress_opaque);
+    }
+
+    *count =3D bytes;
+    return ret;
+}
+
+int coroutine_fn block_copy(BlockCopyState *s,
+                            int64_t start, uint64_t bytes,
+                            bool *error_is_read,
+                            bool is_write_notifier)
+{
+    int ret =3D 0;
+    int64_t end =3D bytes + start; /* bytes */
+    void *bounce_buffer =3D NULL;
+    int64_t status_bytes;
+
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
+
+    while (start < end) {
+        int64_t dirty_end;
+
+        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
+            trace_block_copy_skip(s, start);
+            start +=3D s->cluster_size;
+            continue; /* already copied */
+        }
+
+        dirty_end =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+                                                (end - start));
+        if (dirty_end < 0) {
+            dirty_end =3D end;
+        }
+
+        if (s->skip_unallocated) {
+            ret =3D block_copy_reset_unallocated(s, start, &status_bytes=
);
+            if (ret =3D=3D 0) {
+                trace_block_copy_skip_range(s, start, status_bytes);
+                start +=3D status_bytes;
+                continue;
+            }
+            /* Clamp to known allocated region */
+            dirty_end =3D MIN(dirty_end, start + status_bytes);
+        }
+
+        trace_block_copy_process(s, start);
+
+        if (s->use_copy_range) {
+            ret =3D block_copy_with_offload(s, start, dirty_end,
+                                          is_write_notifier);
+            if (ret < 0) {
+                s->use_copy_range =3D false;
+            }
+        }
+        if (!s->use_copy_range) {
+            ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
+                                                is_write_notifier,
+                                                error_is_read, &bounce_b=
uffer);
+        }
+        if (ret < 0) {
+            break;
+        }
+
+        start +=3D ret;
+        s->progress_bytes_callback(ret, s->progress_opaque);
+        ret =3D 0;
+    }
+
+    if (bounce_buffer) {
+        qemu_vfree(bounce_buffer);
+    }
+
+    return ret;
+}
diff --git a/block/trace-events b/block/trace-events
index cec8e40dba..b8d70f5242 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -40,6 +40,8 @@ mirror_yield_in_flight(void *s, int64_t offset, int in_=
flight) "s %p offset %" P
 # backup.c
 backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t b=
ytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
 backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret)=
 "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
+
+# block-copy.c
 block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p =
start %"PRId64" bytes %"PRId64
 block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
--=20
2.21.0


