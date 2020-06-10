Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5702072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5702072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj60b-0008D2-JQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jj5yB-0005uw-Mi; Wed, 10 Jun 2020 15:01:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:42690 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jj5yA-0005Pf-7Z; Wed, 10 Jun 2020 15:01:03 -0400
Received: from [192.168.15.9] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jj5y6-0007vZ-Ff; Wed, 10 Jun 2020 22:00:58 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] qcow2: improve savevm performance
Date: Wed, 10 Jun 2020 22:00:58 +0300
Message-Id: <20200610190058.10781-3-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610190058.10781-1-den@openvz.org>
References: <20200610190058.10781-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:58:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch does 2 standard basic things:
- it creates intermediate buffer for all writes from QEMU migration code
  to QCOW2 image,
- this buffer is sent to disk asynchronously, allowing several writes to
  run in parallel.

In general, migration code is fantastically inefficent (by observation),
buffers are not aligned and sent with arbitrary pieces, a lot of time
less than 100 bytes at a chunk, which results in read-modify-write
operations with non-cached operations. It should also be noted that all
operations are performed into unallocated image blocks, which also suffer
due to partial writes to such new clusters.

Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
                original     fixed
cached:          1.79s       1.27s
non-cached:      3.29s       0.81s

The difference over HDD would be more significant :)

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
 block/qcow2.h |   4 ++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..e6232f32e2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4797,11 +4797,43 @@ static int qcow2_make_empty(BlockDriverState *bs)
     return ret;
 }
 
+
+typedef struct Qcow2VMStateTask {
+    AioTask task;
+
+    BlockDriverState *bs;
+    int64_t offset;
+    void *buf;
+    size_t bytes;
+} Qcow2VMStateTask;
+
+typedef struct Qcow2SaveVMState {
+    AioTaskPool *pool;
+    Qcow2VMStateTask *t;
+} Qcow2SaveVMState;
+
 static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
+    Qcow2SaveVMState *state = s->savevm_state;
     int ret;
 
+    if (state != NULL) {
+        aio_task_pool_start_task(state->pool, &state->t->task);
+
+        aio_task_pool_wait_all(state->pool);
+        ret = aio_task_pool_status(state->pool);
+
+        aio_task_pool_free(state->pool);
+        g_free(state);
+
+        s->savevm_state = NULL;
+
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     qemu_co_mutex_lock(&s->lock);
     ret = qcow2_write_caches(bs);
     qemu_co_mutex_unlock(&s->lock);
@@ -5098,14 +5130,89 @@ static int qcow2_has_zero_init(BlockDriverState *bs)
     }
 }
 
+
+static coroutine_fn int qcow2_co_vmstate_task_entry(AioTask *task)
+{
+    int err = 0;
+    Qcow2VMStateTask *t = container_of(task, Qcow2VMStateTask, task);
+
+    if (t->bytes != 0) {
+        QEMUIOVector local_qiov;
+        qemu_iovec_init_buf(&local_qiov, t->buf, t->bytes);
+        err = t->bs->drv->bdrv_co_pwritev_part(t->bs, t->offset, t->bytes,
+                                               &local_qiov, 0, 0);
+    }
+
+    qemu_vfree(t->buf);
+    return err;
+}
+
+static Qcow2VMStateTask *qcow2_vmstate_task_create(BlockDriverState *bs,
+                                                    int64_t pos, size_t size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2VMStateTask *t = g_new(Qcow2VMStateTask, 1);
+
+    *t = (Qcow2VMStateTask) {
+        .task.func = qcow2_co_vmstate_task_entry,
+        .buf = qemu_blockalign(bs, size),
+        .offset = qcow2_vm_state_offset(s) + pos,
+        .bs = bs,
+    };
+
+    return t;
+}
+
 static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
     BDRVQcow2State *s = bs->opaque;
+    Qcow2SaveVMState *state = s->savevm_state;
+    Qcow2VMStateTask *t;
+    size_t buf_size = MAX(s->cluster_size, 1 * MiB);
+    size_t to_copy;
+    size_t off;
 
     BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
-    return bs->drv->bdrv_co_pwritev_part(bs, qcow2_vm_state_offset(s) + pos,
-                                         qiov->size, qiov, 0, 0);
+
+    if (state == NULL) {
+        state = g_new(Qcow2SaveVMState, 1);
+        *state = (Qcow2SaveVMState) {
+            .pool = aio_task_pool_new(QCOW2_MAX_WORKERS),
+            .t = qcow2_vmstate_task_create(bs, pos, buf_size),
+        };
+
+        s->savevm_state = state;
+    }
+
+    if (aio_task_pool_status(state->pool) != 0) {
+        return aio_task_pool_status(state->pool);
+    }
+
+    t = state->t;
+    if (t->offset + t->bytes != qcow2_vm_state_offset(s) + pos) {
+        /* Normally this branch is not reachable from migration */
+        return bs->drv->bdrv_co_pwritev_part(bs,
+                qcow2_vm_state_offset(s) + pos, qiov->size, qiov, 0, 0);
+    }
+
+    off = 0;
+    while (1) {
+        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
+        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
+        t->bytes += to_copy;
+        if (t->bytes < buf_size) {
+            return 0;
+        }
+
+        aio_task_pool_start_task(state->pool, &t->task);
+
+        pos += to_copy;
+        off += to_copy;
+        state->t = t = qcow2_vmstate_task_create(bs, pos, buf_size);
+    }
+
+    return 0;
 }
 
 static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
diff --git a/block/qcow2.h b/block/qcow2.h
index 7ce2c23bdb..146cfed739 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -291,6 +291,8 @@ typedef struct Qcow2BitmapHeaderExt {
 
 #define QCOW2_MAX_THREADS 4
 
+typedef struct Qcow2SaveVMState Qcow2SaveVMState;
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -384,6 +386,8 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    Qcow2SaveVMState *savevm_state;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
-- 
2.17.1


