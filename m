Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BB4206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BB4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHu0-0001Ck-Ia
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jnHtB-0000hb-Mz; Mon, 22 Jun 2020 04:33:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:33786 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jnHt8-0000wN-T3; Mon, 22 Jun 2020 04:33:13 -0400
Received: from [192.168.15.40] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jnHst-0007Fy-RR; Mon, 22 Jun 2020 11:32:55 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/6] block/io: improve loadvm performance
Date: Mon, 22 Jun 2020 11:33:03 +0300
Message-Id: <20200622083303.18665-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619100708.30440-1-den@openvz.org>
References: <20200619100708.30440-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 04:33:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch creates intermediate buffer for reading from block driver
state and performs read-ahead to this buffer. Snapshot code performs
reads sequentially and thus we know what offsets will be required
and when they will become not needed.

Results are fantastic. Switch to snapshot times of 2GB Fedora 31 VM
over NVME storage are the following:
                original     fixed
cached:          1.84s       1.16s
non-cached:     12.74s       1.27s

The difference over HDD would be more significant :)

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---

 block/io.c                | 225 +++++++++++++++++++++++++++++++++++++-
 include/block/block_int.h |   3 +
 2 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 71a696deb7..bb06f750d8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2739,6 +2739,180 @@ static int bdrv_co_do_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
     }
 }
 
+
+typedef struct BdrvLoadVMChunk {
+    void *buf;
+    uint64_t offset;
+    ssize_t bytes;
+
+    QLIST_ENTRY(BdrvLoadVMChunk) list;
+} BdrvLoadVMChunk;
+
+typedef struct BdrvLoadVMState {
+    AioTaskPool *pool;
+
+    int64_t offset;
+    int64_t last_loaded;
+
+    int chunk_count;
+    QLIST_HEAD(, BdrvLoadVMChunk) chunks;
+    QLIST_HEAD(, BdrvLoadVMChunk) loading;
+    CoMutex lock;
+    CoQueue waiters;
+} BdrvLoadVMState;
+
+typedef struct BdrvLoadVMStateTask {
+    AioTask task;
+
+    BlockDriverState *bs;
+    BdrvLoadVMChunk *chunk;
+} BdrvLoadVMStateTask;
+
+static BdrvLoadVMChunk *bdrv_co_find_loadvmstate_chunk(int64_t pos,
+                                                       BdrvLoadVMChunk *c)
+{
+    for (; c != NULL; c = QLIST_NEXT(c, list)) {
+        if (c->offset <= pos && c->offset + c->bytes > pos) {
+            return c;
+        }
+    }
+
+    return NULL;
+}
+
+static void bdrv_free_loadvm_chunk(BdrvLoadVMChunk *c)
+{
+    qemu_vfree(c->buf);
+    g_free(c);
+}
+
+static coroutine_fn int bdrv_co_vmstate_load_task_entry(AioTask *task)
+{
+    int err = 0;
+    BdrvLoadVMStateTask *t = container_of(task, BdrvLoadVMStateTask, task);
+    BdrvLoadVMChunk *c = t->chunk;
+    BdrvLoadVMState *state = t->bs->loadvm_state;
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, c->buf, c->bytes);
+
+    bdrv_inc_in_flight(t->bs);
+    err = t->bs->drv->bdrv_load_vmstate(t->bs, &qiov, c->offset);
+    bdrv_dec_in_flight(t->bs);
+
+    qemu_co_mutex_lock(&state->lock);
+    QLIST_REMOVE(c, list);
+    if (err == 0) {
+        QLIST_INSERT_HEAD(&state->chunks, c, list);
+    } else {
+        bdrv_free_loadvm_chunk(c);
+    }
+    qemu_co_mutex_unlock(&state->lock);
+    qemu_co_queue_restart_all(&state->waiters);
+
+    return err;
+}
+
+static void bdrv_co_start_loadvmstate(BlockDriverState *bs,
+                                      BdrvLoadVMState *state)
+{
+    int i;
+    size_t buf_size = MAX(bdrv_get_cluster_size(bs), 1 * MiB);
+
+    qemu_co_mutex_assert_locked(&state->lock);
+    for (i = state->chunk_count; i < BDRV_VMSTATE_WORKERS_MAX; i++) {
+        BdrvLoadVMStateTask *t = g_new(BdrvLoadVMStateTask, 1);
+
+        *t = (BdrvLoadVMStateTask) {
+            .task.func = bdrv_co_vmstate_load_task_entry,
+            .bs = bs,
+            .chunk = g_new(BdrvLoadVMChunk, 1),
+        };
+
+        *t->chunk = (BdrvLoadVMChunk) {
+            .buf = qemu_blockalign(bs, buf_size),
+            .offset = state->last_loaded,
+            .bytes = buf_size,
+        };
+        /* FIXME: tail of stream */
+
+        QLIST_INSERT_HEAD(&state->loading, t->chunk, list);
+        state->chunk_count++;
+        state->last_loaded += buf_size;
+
+        qemu_co_mutex_unlock(&state->lock);
+        aio_task_pool_start_task(state->pool, &t->task);
+        qemu_co_mutex_lock(&state->lock);
+    }
+}
+
+static int bdrv_co_do_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
+                                   int64_t pos)
+{
+    BdrvLoadVMState *state = bs->loadvm_state;
+    BdrvLoadVMChunk *c;
+    size_t off;
+
+    if (state == NULL) {
+        if (pos != 0) {
+            /* Normally this branch is not reachable from migration */
+            return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
+        }
+
+        state = g_new(BdrvLoadVMState, 1);
+        *state = (BdrvLoadVMState) {
+            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
+            .chunks = QLIST_HEAD_INITIALIZER(state->chunks),
+            .loading = QLIST_HEAD_INITIALIZER(state->loading),
+        };
+        qemu_co_mutex_init(&state->lock);
+        qemu_co_queue_init(&state->waiters);
+
+        bs->loadvm_state = state;
+    }
+
+    if (state->offset != pos) {
+        /* Normally this branch is not reachable from migration */
+        return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
+    }
+
+    off = 0;
+    qemu_co_mutex_lock(&state->lock);
+    bdrv_co_start_loadvmstate(bs, state);
+
+    while (off < qiov->size && aio_task_pool_status(state->pool) == 0) {
+        c = bdrv_co_find_loadvmstate_chunk(pos, QLIST_FIRST(&state->chunks));
+        if (c != NULL) {
+            ssize_t chunk_off = pos - c->offset;
+            ssize_t to_copy = MIN(qiov->size - off, c->bytes - chunk_off);
+
+            qemu_iovec_from_buf(qiov, off, c->buf + chunk_off, to_copy);
+
+            off += to_copy;
+            pos += to_copy;
+
+            if (pos == c->offset + c->bytes) {
+                state->chunk_count--;
+                /* End of buffer, discard it from the list */
+                QLIST_REMOVE(c, list);
+                bdrv_free_loadvm_chunk(c);
+            }
+
+            state->offset += to_copy;
+            continue;
+        }
+
+        c = bdrv_co_find_loadvmstate_chunk(pos, QLIST_FIRST(&state->loading));
+        if (c != NULL) {
+            qemu_co_queue_wait(&state->waiters, &state->lock);
+            continue;
+        }
+
+        bdrv_co_start_loadvmstate(bs, state);
+    }
+    qemu_co_mutex_unlock(&state->lock);
+
+    return aio_task_pool_status(state->pool);
+}
+
 static int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
@@ -2752,7 +2926,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         ret = -ENOMEDIUM;
     } else if (drv->bdrv_load_vmstate) {
         if (is_read) {
-            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
+            ret = bdrv_co_do_load_vmstate(bs, qiov, pos);
         } else {
             ret = bdrv_co_do_save_vmstate(bs, qiov, pos);
         }
@@ -2823,13 +2997,13 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
     return bdrv_rw_vmstate(bs, qiov, pos, true);
 }
 
-static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
+static int coroutine_fn bdrv_co_finalize_save_vmstate(BlockDriverState *bs)
 {
     int err;
     BdrvSaveVMState *state = bs->savevm_state;
 
     if (bs->drv->bdrv_save_vmstate == NULL && bs->file != NULL) {
-        return bdrv_co_finalize_vmstate(bs->file->bs);
+        return bdrv_co_finalize_save_vmstate(bs->file->bs);
     }
     if (state == NULL) {
         return 0;
@@ -2851,6 +3025,51 @@ static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
     return err;
 }
 
+static int coroutine_fn bdrv_co_finalize_load_vmstate(BlockDriverState *bs)
+{
+    int err;
+    BdrvLoadVMState *state = bs->loadvm_state;
+    BdrvLoadVMChunk *c, *tmp;
+
+    if (bs->drv->bdrv_load_vmstate == NULL && bs->file != NULL) {
+        return bdrv_co_finalize_load_vmstate(bs->file->bs);
+    }
+    if (state == NULL) {
+        return 0;
+    }
+
+    aio_task_pool_wait_all(state->pool);
+    err = aio_task_pool_status(state->pool);
+    aio_task_pool_free(state->pool);
+
+    QLIST_FOREACH(c, &state->loading, list) {
+        assert(1);  /* this list must be empty as all tasks are committed */
+    }
+    QLIST_FOREACH_SAFE(c, &state->chunks, list, tmp) {
+        QLIST_REMOVE(c, list);
+        bdrv_free_loadvm_chunk(c);
+    }
+
+    g_free(state);
+
+    bs->loadvm_state = NULL;
+
+    return err;
+}
+
+static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
+{
+    int err1 = bdrv_co_finalize_save_vmstate(bs);
+    int err2 = bdrv_co_finalize_load_vmstate(bs);
+    if (err1 < 0) {
+        return err1;
+    }
+    if (err2 < 0) {
+        return err2;
+    }
+    return 0;
+}
+
 static int coroutine_fn bdrv_finalize_vmstate_co_entry(void *opaque)
 {
     return bdrv_co_finalize_vmstate(opaque);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f90f0e8b6a..0942578a74 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -788,6 +788,7 @@ struct BdrvChild {
 
 
 typedef struct BdrvSaveVMState BdrvSaveVMState;
+typedef struct BdrvLoadVMState BdrvLoadVMState;
 
 /*
  * Note: the function bdrv_append() copies and swaps contents of
@@ -955,6 +956,8 @@ struct BlockDriverState {
 
     /* Intermediate buffer for VM state saving from snapshot creation code */
     BdrvSaveVMState *savevm_state;
+    /* Intermediate buffer for VM state loading */
+    BdrvLoadVMState *loadvm_state;
 };
 
 struct BlockBackendRootState {
-- 
2.17.1


