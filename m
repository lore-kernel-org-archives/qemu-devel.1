Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CDD2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CDD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcVC-0003jR-0a
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNf-00058e-Li
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNe-0002Bs-7m
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNb-0001tB-0w; Fri, 15 Nov 2019 09:15:19 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcN5-0006WW-78; Fri, 15 Nov 2019 17:14:47 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 11/24] block/block-copy: move task size initial calculation to
 _task_create
Date: Fri, 15 Nov 2019 17:14:31 +0300
Message-Id: <20191115141444.24155-12-vsementsov@virtuozzo.com>
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

Comment "Called only on full-dirty region" without corresponding
assertion is a very unsafe thing. Adding assertion means call
bdrv_dirty_bitmap_next_zero twice. Instead, let's move
bdrv_dirty_bitmap_next_zero call to block_copy_task_create. It also
allows to drop cur_bytes variable which partly duplicate task->bytes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7652b4afc5..0525a9fcd5 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -111,12 +111,23 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t start,
     return true;
 }
 
-/* Called only on full-dirty region */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes)
 {
+    int64_t next_zero;
     BlockCopyTask *task = g_new(BlockCopyTask, 1);
 
+    assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
+
+    bytes = MIN(bytes, s->copy_size);
+    next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, bytes);
+    if (next_zero >= 0) {
+        assert(next_zero > offset); /* offset is dirty */
+        assert(next_zero < offset + bytes); /* no need to do MIN() */
+        bytes = next_zero - offset;
+    }
+
+    /* region is dirty, so no existent tasks possible in it */
     assert(!block_copy_find_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
@@ -461,7 +472,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
     while (bytes) {
         g_autofree BlockCopyTask *task = NULL;
-        int64_t next_zero, cur_bytes, status_bytes;
+        int64_t status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
             trace_block_copy_skip(s, offset);
@@ -472,18 +483,9 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
         found_dirty = true;
 
-        cur_bytes = MIN(bytes, s->copy_size);
+        task = block_copy_task_create(s, offset, bytes);
 
-        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
-                                                cur_bytes);
-        if (next_zero >= 0) {
-            assert(next_zero > offset); /* offset is dirty */
-            assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
-            cur_bytes = next_zero - offset;
-        }
-        task = block_copy_task_create(s, offset, cur_bytes);
-
-        ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
+        ret = block_copy_block_status(s, offset, task->bytes, &status_bytes);
         block_copy_task_shrink(task, status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
@@ -494,22 +496,20 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             continue;
         }
 
-        cur_bytes = MIN(cur_bytes, status_bytes);
-
         trace_block_copy_process(s, offset);
 
-        co_get_from_shres(s->mem, cur_bytes);
-        ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
+        co_get_from_shres(s->mem, task->bytes);
+        ret = block_copy_do_copy(s, offset, task->bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
-        co_put_to_shres(s->mem, cur_bytes);
+        co_put_to_shres(s->mem, task->bytes);
         block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
 
-        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        offset += cur_bytes;
-        bytes -= cur_bytes;
+        s->progress_bytes_callback(task->bytes, s->progress_opaque);
+        offset += task->bytes;
+        bytes -= task->bytes;
     }
 
     return found_dirty;
-- 
2.21.0


