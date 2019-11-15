Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05310C33C99
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF1520740
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF1520740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVceE-0006VZ-MM
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNf-00058a-KZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNe-0002Ba-30
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNa-0001t8-WE; Fri, 15 Nov 2019 09:15:19 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcN5-0006WW-1h; Fri, 15 Nov 2019 17:14:47 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 10/24] block/block-copy: add state pointer to BlockCopyTask
Date: Fri, 15 Nov 2019 17:14:30 +0300
Message-Id: <20191115141444.24155-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115141444.24155-1-vsementsov@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use aio-task-pool API, so we'll need state pointer in
BlockCopyTask anyway. Add it now and use where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 956b4b55e7..7652b4afc5 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,6 +25,7 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
 typedef struct BlockCopyTask {
+    BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyTask) list;
@@ -120,16 +121,18 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
 
-    task->offset = offset;
-    task->bytes = bytes;
+    *task = (BlockCopyTask) {
+        .s = s,
+        .offset = offset,
+        .bytes = bytes,
+    };
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
 
     return task;
 }
 
-static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
-                                                BlockCopyTask *task,
+static void coroutine_fn block_copy_task_shrink(BlockCopyTask *task,
                                                 int64_t new_bytes)
 {
     if (new_bytes == task->bytes) {
@@ -138,18 +141,17 @@ static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
 
     assert(new_bytes > 0 && new_bytes < task->bytes);
 
-    bdrv_set_dirty_bitmap(s->copy_bitmap,
+    bdrv_set_dirty_bitmap(task->s->copy_bitmap,
                           task->offset + new_bytes, task->bytes - new_bytes);
 
     task->bytes = new_bytes;
     qemu_co_queue_restart_all(&task->wait_queue);
 }
 
-static void coroutine_fn block_copy_task_end(BlockCopyState *s,
-                                             BlockCopyTask *task, int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyTask *task, int ret)
 {
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
+        bdrv_set_dirty_bitmap(task->s->copy_bitmap, task->offset, task->bytes);
     }
     QLIST_REMOVE(task, list);
     qemu_co_queue_restart_all(&task->wait_queue);
@@ -482,9 +484,9 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         task = block_copy_task_create(s, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
-        block_copy_task_shrink(s, task, status_bytes);
+        block_copy_task_shrink(task, status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, task, 0);
+            block_copy_task_end(task, 0);
             s->progress_reset_callback(s->progress_opaque);
             trace_block_copy_skip_range(s, offset, status_bytes);
             offset += status_bytes;
@@ -500,7 +502,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, task, ret);
+        block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
-- 
2.21.0


