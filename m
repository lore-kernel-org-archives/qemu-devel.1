Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92355C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D28420757
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlxYbydW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D28420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxJx-0002Px-I1
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAO-00024q-6c
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAN-0001Ke-Bd
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+Sj31gR/RLHmlc21FjoAOJRNiclOU1V69F/XyE11vs=;
 b=LlxYbydWd+s0AcwGCo8Fm4dN5bNOrtQcUL8Qkce/EFBmaFZmzEAvPa58eDdQqFijmKLlQl
 3OB7R0Ed+OgQQ19fGv/kCoT/3VwAIz0xFED95Ha9NEtPnwjVfP8GhKUqFqQ6sUtSh/sAKg
 5GbivwLjM1mqMSZmHvpo+yS1KJ2mzKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-UnLzuQC4MOuhK-Xq_2VQCQ-1; Tue, 05 May 2020 08:59:16 -0400
X-MC-Unique: UnLzuQC4MOuhK-Xq_2VQCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6511981CBE3;
 Tue,  5 May 2020 12:59:15 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E0F7053E;
 Tue,  5 May 2020 12:59:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/24] block/block-copy: alloc task on each iteration
Date: Tue,  5 May 2020 14:58:23 +0200
Message-Id: <20200505125826.1001451-22-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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

We are going to use aio-task-pool API, so tasks will be handled in
parallel. We need therefore separate allocated task on each iteration.
Introduce this logic now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429130847.28124-3-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index bbb29366dc..8d1b9ab9f0 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -106,9 +106,11 @@ static bool coroutine_fn block_copy_wait_one(BlockCopy=
State *s, int64_t offset,
 }
=20
 /* Called only on full-dirty region */
-static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
-                                  int64_t offset, int64_t bytes)
+static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             int64_t offset, int64_t bytes=
)
 {
+    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
+
     assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
@@ -118,6 +120,8 @@ static void block_copy_task_begin(BlockCopyState *s, Bl=
ockCopyTask *task,
     task->bytes =3D bytes;
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
+
+    return task;
 }
=20
 /*
@@ -472,7 +476,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
     while (bytes) {
-        BlockCopyTask task;
+        g_autofree BlockCopyTask *task =3D NULL;
         int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -493,14 +497,14 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
             cur_bytes =3D next_zero - offset;
         }
-        block_copy_task_begin(s, &task, offset, cur_bytes);
+        task =3D block_copy_task_create(s, offset, cur_bytes);
=20
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
         assert(ret >=3D 0); /* never fail */
         cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, &task, cur_bytes);
+        block_copy_task_shrink(s, task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, &task, 0);
+            block_copy_task_end(s, task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -516,7 +520,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, &task, ret);
+        block_copy_task_end(s, task, ret);
         if (ret < 0) {
             return ret;
         }
--=20
2.26.2


