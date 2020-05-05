Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE2C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A292078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6hi3LrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A292078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxNX-0001Vl-56
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAS-0002Gv-IJ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAR-0001Nk-HG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeuWiltkI1rpgdxq90Zxb5Zl+jCv5+GW6Q5mC7k1S+k=;
 b=X6hi3LrHEASpzY8W54TlFQg10PXvRQSWYe0ojOmUaKz7nDfvz/QqARVXnmllzVPJlhUP84
 WcTV9K7GbFwOG3XP2fqca9PSaDq7bgcW7muNnU8o+1NnwZ6JMXFoGP6CwZoqB7cVbDHlTR
 w8TDVVC5B5FFPMwbtNNS9Hw6niu8EAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-nlY7tz6vN3ixPNE9C5vMXQ-1; Tue, 05 May 2020 08:59:20 -0400
X-MC-Unique: nlY7tz6vN3ixPNE9C5vMXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C05AD800687;
 Tue,  5 May 2020 12:59:19 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B73410021B3;
 Tue,  5 May 2020 12:59:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/24] block/block-copy: refactor task creation
Date: Tue,  5 May 2020 14:58:25 +0200
Message-Id: <20200505125826.1001451-24-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Instead of just relying on the comment "Called only on full-dirty
region" in block_copy_task_create() let's move initial dirty area
search directly to block_copy_task_create(). Let's also use effective
bdrv_dirty_bitmap_next_dirty_area instead of looping through all
non-dirty clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429130847.28124-5-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 80 ++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 35ff9cc3ef..f560338647 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -32,6 +32,11 @@ typedef struct BlockCopyTask {
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
=20
+static int64_t task_end(BlockCopyTask *task)
+{
+    return task->offset + task->bytes;
+}
+
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -106,17 +111,29 @@ static bool coroutine_fn block_copy_wait_one(BlockCop=
yState *s, int64_t offset,
     return true;
 }
=20
-/* Called only on full-dirty region */
+/*
+ * Search for the first dirty area in offset/bytes range and create task a=
t
+ * the beginning of it.
+ */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes=
)
 {
-    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
+    BlockCopyTask *task;
=20
+    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
+                                           offset, offset + bytes,
+                                           s->copy_size, &offset, &bytes))
+    {
+        return NULL;
+    }
+
+    /* region is dirty, so no existent tasks possible in it */
     assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes +=3D bytes;
=20
+    task =3D g_new(BlockCopyTask, 1);
     *task =3D (BlockCopyTask) {
         .s =3D s,
         .offset =3D offset,
@@ -466,6 +483,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
 {
     int ret =3D 0;
     bool found_dirty =3D false;
+    int64_t end =3D offset + bytes;
=20
     /*
      * block_copy() user is responsible for keeping source and target in s=
ame
@@ -479,58 +497,52 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
=20
     while (bytes) {
         g_autofree BlockCopyTask *task =3D NULL;
-        int64_t next_zero, cur_bytes, status_bytes;
+        int64_t status_bytes;
=20
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
-            trace_block_copy_skip(s, offset);
-            offset +=3D s->cluster_size;
-            bytes -=3D s->cluster_size;
-            continue; /* already copied */
+        task =3D block_copy_task_create(s, offset, bytes);
+        if (!task) {
+            /* No more dirty bits in the bitmap */
+            trace_block_copy_skip_range(s, offset, bytes);
+            break;
+        }
+        if (task->offset > offset) {
+            trace_block_copy_skip_range(s, offset, task->offset - offset);
         }
=20
         found_dirty =3D true;
=20
-        cur_bytes =3D MIN(bytes, s->copy_size);
-
-        next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
-                                                cur_bytes);
-        if (next_zero >=3D 0) {
-            assert(next_zero > offset); /* offset is dirty */
-            assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
-            cur_bytes =3D next_zero - offset;
-        }
-        task =3D block_copy_task_create(s, offset, cur_bytes);
-
-        ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
+        ret =3D block_copy_block_status(s, task->offset, task->bytes,
+                                      &status_bytes);
         assert(ret >=3D 0); /* never fail */
-        cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(task, cur_bytes);
+        if (status_bytes < task->bytes) {
+            block_copy_task_shrink(task, status_bytes);
+        }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
-            trace_block_copy_skip_range(s, offset, status_bytes);
-            offset +=3D status_bytes;
-            bytes -=3D status_bytes;
+            trace_block_copy_skip_range(s, task->offset, task->bytes);
+            offset =3D task_end(task);
+            bytes =3D end - offset;
             continue;
         }
=20
-        trace_block_copy_process(s, offset);
+        trace_block_copy_process(s, task->offset);
=20
-        co_get_from_shres(s->mem, cur_bytes);
-        ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
-                                 error_is_read);
-        co_put_to_shres(s->mem, cur_bytes);
+        co_get_from_shres(s->mem, task->bytes);
+        ret =3D block_copy_do_copy(s, task->offset, task->bytes,
+                                 ret & BDRV_BLOCK_ZERO, error_is_read);
+        co_put_to_shres(s->mem, task->bytes);
         block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
=20
-        progress_work_done(s->progress, cur_bytes);
-        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        offset +=3D cur_bytes;
-        bytes -=3D cur_bytes;
+        progress_work_done(s->progress, task->bytes);
+        s->progress_bytes_callback(task->bytes, s->progress_opaque);
+        offset =3D task_end(task);
+        bytes =3D end - offset;
     }
=20
     return found_dirty;
--=20
2.26.2


