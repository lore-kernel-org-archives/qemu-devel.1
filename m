Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D443C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8492078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhE4R+5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8492078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxP7-00051l-IJ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAW-0002Sl-MZ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAV-0001To-PB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sqx+AKD2vYUF8SPf8E3CW3TO8V+h79wEyvIM7fcPfUY=;
 b=NhE4R+5I2LWtd0psYicQrxnb9hpZ2qEkwGPlqPwlS3wkUwEBLowzB0DKZLhBZ1zhQGTZnX
 2kd2bsinRM/FwF5sV24OqeCU2iu5Dy/Rmdcm+pPBLO5d8VydNalQTyWFnRYhZhIJsr21/u
 mcVHLFWoaMsE1amLmaPNFUuk0RWt/rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-FuAYeasDMDKI3A6WS5eCTA-1; Tue, 05 May 2020 08:59:23 -0400
X-MC-Unique: FuAYeasDMDKI3A6WS5eCTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 176AE1899520;
 Tue,  5 May 2020 12:59:22 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82CF360CC0;
 Tue,  5 May 2020 12:59:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/24] block/block-copy: use aio-task-pool API
Date: Tue,  5 May 2020 14:58:26 +0200
Message-Id: <20200505125826.1001451-25-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Run block_copy iterations in parallel in aio tasks.

Changes:
  - BlockCopyTask becomes aio task structure. Add zeroes field to pass
    it to block_copy_do_copy
  - add call state - it's a state of one call of block_copy(), shared
    between parallel tasks. For now used only to keep information about
    first error: is it read or not.
  - convert block_copy_dirty_clusters to aio-task loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200429130847.28124-6-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 119 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index f560338647..03500680f7 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,15 +19,29 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
 #include "qemu/units.h"
+#include "qemu/coroutine.h"
+#include "block/aio_task.h"
=20
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
+#define BLOCK_COPY_MAX_WORKERS 64
+
+static coroutine_fn int block_copy_task_entry(AioTask *task);
+
+typedef struct BlockCopyCallState {
+    bool failed;
+    bool error_is_read;
+} BlockCopyCallState;
=20
 typedef struct BlockCopyTask {
+    AioTask task;
+
     BlockCopyState *s;
+    BlockCopyCallState *call_state;
     int64_t offset;
     int64_t bytes;
+    bool zeroes;
     QLIST_ENTRY(BlockCopyTask) list;
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
@@ -116,6 +130,7 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyS=
tate *s, int64_t offset,
  * the beginning of it.
  */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             BlockCopyCallState *call_stat=
e,
                                              int64_t offset, int64_t bytes=
)
 {
     BlockCopyTask *task;
@@ -135,7 +150,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyS=
tate *s,
=20
     task =3D g_new(BlockCopyTask, 1);
     *task =3D (BlockCopyTask) {
+        .task.func =3D block_copy_task_entry,
         .s =3D s,
+        .call_state =3D call_state,
         .offset =3D offset,
         .bytes =3D bytes,
     };
@@ -263,6 +280,38 @@ void block_copy_set_progress_meter(BlockCopyState *s, =
ProgressMeter *pm)
     s->progress =3D pm;
 }
=20
+/*
+ * Takes ownership of @task
+ *
+ * If pool is NULL directly run the task, otherwise schedule it into the p=
ool.
+ *
+ * Returns: task.func return code if pool is NULL
+ *          otherwise -ECANCELED if pool status is bad
+ *          otherwise 0 (successfully scheduled)
+ */
+static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
+                                            BlockCopyTask *task)
+{
+    if (!pool) {
+        int ret =3D task->task.func(&task->task);
+
+        g_free(task);
+        return ret;
+    }
+
+    aio_task_pool_wait_slot(pool);
+    if (aio_task_pool_status(pool) < 0) {
+        co_put_to_shres(task->s->mem, task->bytes);
+        block_copy_task_end(task, -ECANCELED);
+        g_free(task);
+        return -ECANCELED;
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -366,6 +415,27 @@ out:
     return ret;
 }
=20
+static coroutine_fn int block_copy_task_entry(AioTask *task)
+{
+    BlockCopyTask *t =3D container_of(task, BlockCopyTask, task);
+    bool error_is_read;
+    int ret;
+
+    ret =3D block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
+                             &error_is_read);
+    if (ret < 0 && !t->call_state->failed) {
+        t->call_state->failed =3D true;
+        t->call_state->error_is_read =3D error_is_read;
+    } else {
+        progress_work_done(t->s->progress, t->bytes);
+        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+    }
+    co_put_to_shres(t->s->mem, t->bytes);
+    block_copy_task_end(t, ret);
+
+    return ret;
+}
+
 static int block_copy_block_status(BlockCopyState *s, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
@@ -484,6 +554,8 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     int ret =3D 0;
     bool found_dirty =3D false;
     int64_t end =3D offset + bytes;
+    AioTaskPool *aio =3D NULL;
+    BlockCopyCallState call_state =3D {false, false};
=20
     /*
      * block_copy() user is responsible for keeping source and target in s=
ame
@@ -495,11 +567,11 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
-    while (bytes) {
-        g_autofree BlockCopyTask *task =3D NULL;
+    while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
+        BlockCopyTask *task;
         int64_t status_bytes;
=20
-        task =3D block_copy_task_create(s, offset, bytes);
+        task =3D block_copy_task_create(s, &call_state, offset, bytes);
         if (!task) {
             /* No more dirty bits in the bitmap */
             trace_block_copy_skip_range(s, offset, bytes);
@@ -519,6 +591,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
+            g_free(task);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -527,25 +600,45 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             bytes =3D end - offset;
             continue;
         }
+        task->zeroes =3D ret & BDRV_BLOCK_ZERO;
=20
         trace_block_copy_process(s, task->offset);
=20
         co_get_from_shres(s->mem, task->bytes);
-        ret =3D block_copy_do_copy(s, task->offset, task->bytes,
-                                 ret & BDRV_BLOCK_ZERO, error_is_read);
-        co_put_to_shres(s->mem, task->bytes);
-        block_copy_task_end(task, ret);
-        if (ret < 0) {
-            return ret;
-        }
=20
-        progress_work_done(s->progress, task->bytes);
-        s->progress_bytes_callback(task->bytes, s->progress_opaque);
         offset =3D task_end(task);
         bytes =3D end - offset;
+
+        if (!aio && bytes) {
+            aio =3D aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+        }
+
+        ret =3D block_copy_task_run(aio, task);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+
+        /*
+         * We are not really interested in -ECANCELED returned from
+         * block_copy_task_run. If it fails, it means some task already fa=
iled
+         * for real reason, let's return first failure.
+         * Still, assert that we don't rewrite failure by success.
+         */
+        assert(ret =3D=3D 0 || aio_task_pool_status(aio) < 0);
+        ret =3D aio_task_pool_status(aio);
+
+        aio_task_pool_free(aio);
+    }
+    if (error_is_read && ret < 0) {
+        *error_is_read =3D call_state.error_is_read;
     }
=20
-    return found_dirty;
+    return ret < 0 ? ret : found_dirty;
 }
=20
 /*
--=20
2.26.2


