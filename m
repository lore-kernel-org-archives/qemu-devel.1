Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D3C28CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B9923C80
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B9923C80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0uH-0001Tv-Os
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:54:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0nA-0004VP-7c
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n7-00053i-V9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:43122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n7-00051q-Hy; Wed, 29 May 2019 11:47:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n2-0004iP-DV; Wed, 29 May 2019 18:46:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 18:46:51 +0300
Message-Id: <20190529154654.95870-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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

Backup-top filter does copy-before-write operation. It should be
inserted above active disk and has a target node for CBW, like the
following:

    +-------+
    | Guest |
    +-------+
        |r,w
        v
    +------------+  target   +---------------+
    | backup_top |---------->| target(qcow2) |
    +------------+   CBW     +---------------+
        |
backing |r,w
        v
    +-------------+
    | Active disk |
    +-------------+

The driver will be used in backup instead of write-notifiers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup-top.h  |  64 +++++++++
 block/backup-top.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs |   2 +
 3 files changed, 388 insertions(+)
 create mode 100644 block/backup-top.h
 create mode 100644 block/backup-top.c

diff --git a/block/backup-top.h b/block/backup-top.h
new file mode 100644
index 0000000000..788e18c358
--- /dev/null
+++ b/block/backup-top.h
@@ -0,0 +1,64 @@
+/*
+ * backup-top filter driver
+ *
+ * The driver performs Copy-Before-Write (CBW) operation: it is injected above
+ * some node, and before each write it copies _old_ data to the target node.
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BACKUP_TOP_H
+#define BACKUP_TOP_H
+
+#include "qemu/osdep.h"
+
+#include "block/block_int.h"
+
+typedef void (*BackupTopProgressCallback)(uint64_t done, void *opaque);
+typedef struct BDRVBackupTopState {
+    HBitmap *copy_bitmap; /* what should be copied to @target on guest write. */
+    BdrvChild *target;
+
+    BackupTopProgressCallback progress_cb;
+    void *progress_opaque;
+} BDRVBackupTopState;
+
+/*
+ * bdrv_backup_top_append
+ *
+ * Append backup_top filter node above @source node. @target node will receive
+ * the data backed up during CBE operations. New filter together with @target
+ * node are attached to @source aio context.
+ *
+ * The resulting filter node is implicit.
+ *
+ * @copy_bitmap selects regions which needs CBW. Furthermore, backup_top will
+ * use exactly this bitmap, so it may be used to control backup_top behavior
+ * dynamically. Caller should not release @copy_bitmap during life-time of
+ * backup_top. Progress is tracked by calling @progress_cb function.
+ */
+BlockDriverState *bdrv_backup_top_append(
+        BlockDriverState *source, BlockDriverState *target,
+        HBitmap *copy_bitmap, Error **errp);
+void bdrv_backup_top_set_progress_callback(
+        BlockDriverState *bs, BackupTopProgressCallback progress_cb,
+        void *progress_opaque);
+void bdrv_backup_top_drop(BlockDriverState *bs);
+
+#endif /* BACKUP_TOP_H */
diff --git a/block/backup-top.c b/block/backup-top.c
new file mode 100644
index 0000000000..1daa02f539
--- /dev/null
+++ b/block/backup-top.c
@@ -0,0 +1,322 @@
+/*
+ * backup-top filter driver
+ *
+ * The driver performs Copy-Before-Write (CBW) operation: it is injected above
+ * some node, and before each write it copies _old_ data to the target node.
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+
+#include "block/backup-top.h"
+
+static coroutine_fn int backup_top_co_preadv(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, int flags)
+{
+    /*
+     * Features to be implemented:
+     * F1. COR. save read data to fleecing target for fast access
+     *     (to reduce reads). This possibly may be done with use of copy-on-read
+     *     filter, but we need an ability to make COR requests optional: for
+     *     example, if target is a ram-cache, and if it is full now, we should
+     *     skip doing COR request, as it is actually not necessary.
+     *
+     * F2. Feature for guest: read from fleecing target if data is in ram-cache
+     *     and is unchanged
+     */
+
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes)
+{
+    int ret = 0;
+    BDRVBackupTopState *s = bs->opaque;
+    uint64_t gran = 1UL << hbitmap_granularity(s->copy_bitmap);
+    uint64_t end = QEMU_ALIGN_UP(offset + bytes, gran);
+    uint64_t off = QEMU_ALIGN_DOWN(offset, gran), len;
+    void *buf = qemu_blockalign(bs, end - off);
+
+    /*
+     * Features to be implemented:
+     * F3. parallelize copying loop
+     * F4. detect zeroes ? or, otherwise, drop detect zeroes from backup code
+     *     and just enable zeroes detecting on target
+     * F5. use block_status ?
+     * F6. don't copy clusters which are already cached by COR [see F1]
+     * F7. if target is ram-cache and it is full, there should be a possibility
+     *     to drop not necessary data (cached by COR [see F1]) to handle CBW
+     *     fast.
+     */
+
+    len = end - off;
+    while (hbitmap_next_dirty_area(s->copy_bitmap, &off, &len)) {
+        hbitmap_reset(s->copy_bitmap, off, len);
+
+        ret = bdrv_co_pread(bs->backing, off, len, buf,
+                            BDRV_REQ_NO_SERIALISING);
+        if (ret < 0) {
+            hbitmap_set(s->copy_bitmap, off, len);
+            goto out;
+        }
+
+        ret = bdrv_co_pwrite(s->target, off, len, buf, BDRV_REQ_SERIALISING);
+        if (ret < 0) {
+            hbitmap_set(s->copy_bitmap, off, len);
+            goto out;
+        }
+
+        if (s->progress_cb) {
+            s->progress_cb(len, s->progress_opaque);
+        }
+        off += len;
+        if (off >= end) {
+            break;
+        }
+        len = end - off;
+    }
+
+out:
+    qemu_vfree(buf);
+
+    /*
+     * F8. we fail guest request in case of error. We can alter it by
+     * possibility to fail copying process instead, or retry several times, or
+     * may be guest pause, etc.
+     */
+    return ret;
+}
+
+static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
+                                               int64_t offset, int bytes)
+{
+    int ret = backup_top_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Features to be implemented:
+     * F9. possibility of lazy discard: just defer the discard after fleecing
+     *     completion. If write (or new discard) occurs to the same area, just
+     *     drop deferred discard.
+     */
+
+    return bdrv_co_pdiscard(bs->backing, offset, bytes);
+}
+
+static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    int ret = backup_top_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+}
+
+static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
+                                              uint64_t offset,
+                                              uint64_t bytes,
+                                              QEMUIOVector *qiov, int flags)
+{
+    if (!(flags & BDRV_REQ_WRITE_UNCHANGED)) {
+        int ret = backup_top_cbw(bs, offset, bytes);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
+{
+    if (!bs->backing) {
+        return 0;
+    }
+
+    return bdrv_co_flush(bs->backing->bs);
+}
+
+static void backup_top_refresh_filename(BlockDriverState *bs)
+{
+    if (bs->backing == NULL) {
+        /*
+         * we can be here after failed bdrv_attach_child in
+         * bdrv_set_backing_hd
+         */
+        return;
+    }
+    bdrv_refresh_filename(bs->backing->bs);
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
+
+static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                  const BdrvChildRole *role,
+                                  BlockReopenQueue *reopen_queue,
+                                  uint64_t perm, uint64_t shared,
+                                  uint64_t *nperm, uint64_t *nshared)
+{
+    /*
+     * We have HBitmap in the state, its size is fixed, so we never allow
+     * resize.
+     */
+    uint64_t rw = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_WRITE;
+
+    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+                              nperm, nshared);
+
+    *nperm = *nperm & rw;
+    *nshared = *nshared & rw;
+
+    if (role == &child_file) {
+        /*
+         * Target child
+         *
+         * Share write to target (child_file), to not interfere
+         * with guest writes to its disk which may be in target backing chain.
+         */
+        if (perm & BLK_PERM_WRITE) {
+            *nshared = *nshared | BLK_PERM_WRITE;
+        }
+    } else {
+        /* Source child */
+        if (perm & BLK_PERM_WRITE) {
+            *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
+        }
+        *nshared =
+            *nshared & (BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED);
+    }
+}
+
+BlockDriver bdrv_backup_top_filter = {
+    .format_name = "backup-top",
+    .instance_size = sizeof(BDRVBackupTopState),
+
+    .bdrv_co_preadv             = backup_top_co_preadv,
+    .bdrv_co_pwritev            = backup_top_co_pwritev,
+    .bdrv_co_pwrite_zeroes      = backup_top_co_pwrite_zeroes,
+    .bdrv_co_pdiscard           = backup_top_co_pdiscard,
+    .bdrv_co_flush              = backup_top_co_flush,
+
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+
+    .bdrv_refresh_filename      = backup_top_refresh_filename,
+
+    .bdrv_child_perm            = backup_top_child_perm,
+
+    .is_filter = true,
+};
+
+BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
+                                         BlockDriverState *target,
+                                         HBitmap *copy_bitmap,
+                                         Error **errp)
+{
+    Error *local_err = NULL;
+    BDRVBackupTopState *state;
+    BlockDriverState *top = bdrv_new_open_driver(&bdrv_backup_top_filter,
+                                                 NULL, BDRV_O_RDWR, errp);
+
+    if (!top) {
+        return NULL;
+    }
+
+    top->implicit = true;
+    top->total_sectors = source->total_sectors;
+    top->bl.opt_mem_alignment = MAX(bdrv_opt_mem_align(source),
+                                    bdrv_opt_mem_align(target));
+    top->opaque = state = g_new0(BDRVBackupTopState, 1);
+    state->copy_bitmap = copy_bitmap;
+
+    bdrv_ref(target);
+    state->target = bdrv_attach_child(top, target, "target", &child_file, errp);
+    if (!state->target) {
+        bdrv_unref(target);
+        bdrv_unref(top);
+        return NULL;
+    }
+
+    bdrv_set_aio_context(top, bdrv_get_aio_context(source));
+    bdrv_set_aio_context(target, bdrv_get_aio_context(source));
+
+    bdrv_drained_begin(source);
+
+    bdrv_ref(top);
+    bdrv_append(top, source, &local_err);
+    if (local_err) {
+        error_prepend(&local_err, "Cannot append backup-top filter: ");
+    }
+
+    bdrv_drained_end(source);
+
+    if (local_err) {
+        bdrv_unref_child(top, state->target);
+        bdrv_unref(top);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return top;
+}
+
+void bdrv_backup_top_set_progress_callback(
+        BlockDriverState *bs, BackupTopProgressCallback progress_cb,
+        void *progress_opaque)
+{
+    BDRVBackupTopState *s = bs->opaque;
+
+    s->progress_cb = progress_cb;
+    s->progress_opaque = progress_opaque;
+}
+
+void bdrv_backup_top_drop(BlockDriverState *bs)
+{
+    BDRVBackupTopState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
+
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_begin(bs);
+
+    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
+    bdrv_set_backing_hd(bs, NULL, &error_abort);
+
+    bdrv_drained_end(bs);
+
+    if (s->target) {
+        bdrv_unref_child(bs, s->target);
+    }
+    bdrv_unref(bs);
+
+    aio_context_release(aio_context);
+}
diff --git a/block/Makefile.objs b/block/Makefile.objs
index ae11605c9f..dfbdfe6ab4 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -40,6 +40,8 @@ block-obj-y += throttle.o copy-on-read.o
 
 block-obj-y += crypto.o
 
+block-obj-y += backup-top.o
+
 common-obj-y += stream.o
 
 nfs.o-libs         := $(LIBNFS_LIBS)
-- 
2.18.0


