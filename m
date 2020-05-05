Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3592FC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1952078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaDgt1ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1952078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxQT-0006tx-Uv
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAS-0002GA-9l
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAR-0001N8-Fm
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiYlbID0TC7g/mAytPhqN/bsf8MIyh0E9vM2SOuLYJ0=;
 b=TaDgt1ZNZisOvXx6WCpa1Bxhoc7oqH/WQblkyw2iyq/TCIxUqBhjzJ4CRx5y+3bJPboB9S
 UPFtNO36GJnZ7SdXGhbutacBhqr4myL+wNRUewHx6ZwjxXEldziLpYSiRRwNiKM+tAG+D+
 4PJ6UNFsWx/8tQKk8WZucNs+T55FfeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-aKVhQyHlNAyfRGnWJfxa1Q-1; Tue, 05 May 2020 08:59:18 -0400
X-MC-Unique: aKVhQyHlNAyfRGnWJfxa1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2C8461;
 Tue,  5 May 2020 12:59:17 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7E26918D;
 Tue,  5 May 2020 12:59:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 22/24] block/block-copy: add state pointer to BlockCopyTask
Date: Tue,  5 May 2020 14:58:24 +0200
Message-Id: <20200505125826.1001451-23-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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

We are going to use aio-task-pool API, so we'll need state pointer in
BlockCopyTask anyway. Add it now and use where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429130847.28124-4-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 8d1b9ab9f0..35ff9cc3ef 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,6 +25,7 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
 typedef struct BlockCopyTask {
+    BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyTask) list;
@@ -116,8 +117,11 @@ static BlockCopyTask *block_copy_task_create(BlockCopy=
State *s,
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes +=3D bytes;
=20
-    task->offset =3D offset;
-    task->bytes =3D bytes;
+    *task =3D (BlockCopyTask) {
+        .s =3D s,
+        .offset =3D offset,
+        .bytes =3D bytes,
+    };
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
=20
@@ -131,8 +135,7 @@ static BlockCopyTask *block_copy_task_create(BlockCopyS=
tate *s,
  * wake up all tasks waiting for us (may be some of them are not intersect=
ing
  * with shrunk task)
  */
-static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
-                                                BlockCopyTask *task,
+static void coroutine_fn block_copy_task_shrink(BlockCopyTask *task,
                                                 int64_t new_bytes)
 {
     if (new_bytes =3D=3D task->bytes) {
@@ -141,20 +144,19 @@ static void coroutine_fn block_copy_task_shrink(Block=
CopyState *s,
=20
     assert(new_bytes > 0 && new_bytes < task->bytes);
=20
-    s->in_flight_bytes -=3D task->bytes - new_bytes;
-    bdrv_set_dirty_bitmap(s->copy_bitmap,
+    task->s->in_flight_bytes -=3D task->bytes - new_bytes;
+    bdrv_set_dirty_bitmap(task->s->copy_bitmap,
                           task->offset + new_bytes, task->bytes - new_byte=
s);
=20
     task->bytes =3D new_bytes;
     qemu_co_queue_restart_all(&task->wait_queue);
 }
=20
-static void coroutine_fn block_copy_task_end(BlockCopyState *s,
-                                             BlockCopyTask *task, int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -=3D task->bytes;
+    task->s->in_flight_bytes -=3D task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
+        bdrv_set_dirty_bitmap(task->s->copy_bitmap, task->offset, task->by=
tes);
     }
     QLIST_REMOVE(task, list);
     qemu_co_queue_restart_all(&task->wait_queue);
@@ -502,9 +504,9 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, task, cur_bytes);
+        block_copy_task_shrink(task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, task, 0);
+            block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -520,7 +522,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, task, ret);
+        block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.26.2


