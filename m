Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F53C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1949220730
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1949220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39823 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcTM-0001jb-3N
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNK-0004cw-E9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNJ-0001x2-7C
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:02 -0500
Received: from relay.sw.ru ([185.231.240.75]:47428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001rq-II; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNB-0006WW-EG; Fri, 15 Nov 2019 17:14:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 16/24] block/block-copy: add max_chunk and max_workers paramters
Date: Fri, 15 Nov 2019 17:14:36 +0300
Message-Id: <20191115141444.24155-17-vsementsov@virtuozzo.com>
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

They will be used for backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 5 +++++
 block/block-copy.c         | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 407de7e520..8fc27156b3 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -47,6 +47,11 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
 /*
  * Run block-copy in a coroutine, return state pointer. If finished early
  * returns NULL (@cb is called anyway).
+ *
+ * @max_workers means maximum of parallel coroutines to execute sub-requests,
+ * must be > 0.
+ *
+ * @max_chunk means maximum length for one IO operation. Zero means unlimited.
  */
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
diff --git a/block/block-copy.c b/block/block-copy.c
index 0b41afd30d..f28f3b8b6c 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -32,6 +32,8 @@ typedef struct BlockCopyCallState {
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    int max_workers;
+    int64_t max_chunk;
     BlockCopyAsyncCallbackFunc cb;
 
     /* State */
@@ -393,7 +395,7 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
 
     assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
 
-    bytes = MIN(bytes, s->copy_size);
+    bytes = MIN(bytes, MIN_NON_ZERO(s->copy_size, call_state->max_chunk));
     next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, bytes);
     if (next_zero >= 0) {
         assert(next_zero > offset); /* offset is dirty */
@@ -578,7 +580,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         co_get_from_shres(s->mem, task->bytes);
 
         if (!aio && task->bytes != bytes) {
-            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+            aio = aio_task_pool_new(call_state->max_workers);
         }
 
         offset += task->bytes;
@@ -655,6 +657,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
         .s = s,
         .offset = start,
         .bytes = bytes,
+        .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
     int ret = block_copy_common(&call_state);
@@ -686,6 +689,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .offset = offset,
         .bytes = bytes,
         .cb = cb,
+        .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
+        .max_chunk = max_chunk,
     };
 
     qemu_coroutine_enter(co);
-- 
2.21.0


