Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD0C47259
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA9D20836
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Maiyb5Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA9D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxIJ-000751-Bb
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAM-00022o-RP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAL-0001Jp-KM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsrwIJ/Flr1sv6EY55lTdvGYeHZHKszAYF5KUsMQUjI=;
 b=Maiyb5IqZSH6QQ9OFuS0MIMb/l2s5Ei/Wd2FASUvg5gwBHqrjlkRcphRpkexqXAQWWXttf
 v0X8g8LwLWbqFE/YeQuzypyXrK85iqbAVPHZ0UJ4Qcq3Wv05uS5IDO8ZH3fUkoSPb0fv6r
 9H3r6SJez9PCmGifRm3Df3Ly9KP+IGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-4YIJ62UQN8efgzfsB6SlLA-1; Tue, 05 May 2020 08:59:14 -0400
X-MC-Unique: 4YIJ62UQN8efgzfsB6SlLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B4B800687;
 Tue,  5 May 2020 12:59:13 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B13AD5C1D4;
 Tue,  5 May 2020 12:59:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/24] block/block-copy: rename in-flight requests to tasks
Date: Tue,  5 May 2020 14:58:22 +0200
Message-Id: <20200505125826.1001451-21-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

We are going to use aio-task-pool API and extend in-flight request
structure to be a successor of AioTask, so rename things appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429130847.28124-2-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 98 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 05227e18bf..bbb29366dc 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,12 +24,12 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
-typedef struct BlockCopyInFlightReq {
+typedef struct BlockCopyTask {
     int64_t offset;
     int64_t bytes;
-    QLIST_ENTRY(BlockCopyInFlightReq) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} BlockCopyInFlightReq;
+    QLIST_ENTRY(BlockCopyTask) list;
+    CoQueue wait_queue; /* coroutines blocked on this task */
+} BlockCopyTask;
=20
 typedef struct BlockCopyState {
     /*
@@ -45,7 +45,7 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_size;
     uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+    QLIST_HEAD(, BlockCopyTask) tasks;
=20
     BdrvRequestFlags write_flags;
=20
@@ -73,15 +73,14 @@ typedef struct BlockCopyState {
     SharedResource *mem;
 } BlockCopyState;
=20
-static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
-                                                           int64_t offset,
-                                                           int64_t bytes)
+static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
+                                            int64_t offset, int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyTask *t;
=20
-    QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (offset + bytes > req->offset && offset < req->offset + req->by=
tes) {
-            return req;
+    QLIST_FOREACH(t, &s->tasks, list) {
+        if (offset + bytes > t->offset && offset < t->offset + t->bytes) {
+            return t;
         }
     }
=20
@@ -89,73 +88,72 @@ static BlockCopyInFlightReq *find_conflicting_inflight_=
req(BlockCopyState *s,
 }
=20
 /*
- * If there are no intersecting requests return false. Otherwise, wait for=
 the
- * first found intersecting request to finish and return true.
+ * If there are no intersecting tasks return false. Otherwise, wait for th=
e
+ * first found intersecting tasks to finish and return true.
  */
 static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t of=
fset,
                                              int64_t bytes)
 {
-    BlockCopyInFlightReq *req =3D find_conflicting_inflight_req(s, offset,=
 bytes);
+    BlockCopyTask *task =3D find_conflicting_task(s, offset, bytes);
=20
-    if (!req) {
+    if (!task) {
         return false;
     }
=20
-    qemu_co_queue_wait(&req->wait_queue, NULL);
+    qemu_co_queue_wait(&task->wait_queue, NULL);
=20
     return true;
 }
=20
 /* Called only on full-dirty region */
-static void block_copy_inflight_req_begin(BlockCopyState *s,
-                                          BlockCopyInFlightReq *req,
-                                          int64_t offset, int64_t bytes)
+static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
+                                  int64_t offset, int64_t bytes)
 {
-    assert(!find_conflicting_inflight_req(s, offset, bytes));
+    assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes +=3D bytes;
=20
-    req->offset =3D offset;
-    req->bytes =3D bytes;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
+    task->offset =3D offset;
+    task->bytes =3D bytes;
+    qemu_co_queue_init(&task->wait_queue);
+    QLIST_INSERT_HEAD(&s->tasks, task, list);
 }
=20
 /*
- * block_copy_inflight_req_shrink
+ * block_copy_task_shrink
  *
- * Drop the tail of the request to be handled later. Set dirty bits back a=
nd
- * wake up all requests waiting for us (may be some of them are not inters=
ecting
- * with shrunk request)
+ * Drop the tail of the task to be handled later. Set dirty bits back and
+ * wake up all tasks waiting for us (may be some of them are not intersect=
ing
+ * with shrunk task)
  */
-static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
-        BlockCopyInFlightReq *req, int64_t new_bytes)
+static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
+                                                BlockCopyTask *task,
+                                                int64_t new_bytes)
 {
-    if (new_bytes =3D=3D req->bytes) {
+    if (new_bytes =3D=3D task->bytes) {
         return;
     }
=20
-    assert(new_bytes > 0 && new_bytes < req->bytes);
+    assert(new_bytes > 0 && new_bytes < task->bytes);
=20
-    s->in_flight_bytes -=3D req->bytes - new_bytes;
+    s->in_flight_bytes -=3D task->bytes - new_bytes;
     bdrv_set_dirty_bitmap(s->copy_bitmap,
-                          req->offset + new_bytes, req->bytes - new_bytes)=
;
+                          task->offset + new_bytes, task->bytes - new_byte=
s);
=20
-    req->bytes =3D new_bytes;
-    qemu_co_queue_restart_all(&req->wait_queue);
+    task->bytes =3D new_bytes;
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
-                                                     BlockCopyInFlightReq =
*req,
-                                                     int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyState *s,
+                                             BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -=3D req->bytes;
+    s->in_flight_bytes -=3D task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
     }
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
+    QLIST_REMOVE(task, list);
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
 void block_copy_state_free(BlockCopyState *s)
@@ -223,7 +221,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source,=
 BdrvChild *target,
         s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
=20
-    QLIST_INIT(&s->inflight_reqs);
+    QLIST_INIT(&s->tasks);
=20
     return s;
 }
@@ -474,7 +472,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
     while (bytes) {
-        BlockCopyInFlightReq req;
+        BlockCopyTask task;
         int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -495,14 +493,14 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
             cur_bytes =3D next_zero - offset;
         }
-        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
+        block_copy_task_begin(s, &task, offset, cur_bytes);
=20
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_inflight_req_shrink(s, &req, cur_bytes);
+        block_copy_task_shrink(s, &task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_inflight_req_end(s, &req, 0);
+            block_copy_task_end(s, &task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -518,7 +516,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_inflight_req_end(s, &req, ret);
+        block_copy_task_end(s, &task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.26.2


