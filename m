Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F872073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F872073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVch0-0001Kj-8T
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNL-0004e8-9w
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNJ-0001xn-NR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001rr-Db; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNB-0006WW-0n; Fri, 15 Nov 2019 17:14:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 14/24] block/block-copy: More explicit call_state
Date: Fri, 15 Nov 2019 17:14:34 +0300
Message-Id: <20191115141444.24155-15-vsementsov@virtuozzo.com>
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

Refactor common path to use BlockCopyCallState pointer as parameter, to
prepare it for use in asynchronous block-copy (at least, we'll need to
run block-copy in a coroutine, passing the whole parameters as one
pointer).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 50 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index b2e7825b53..4b1a0cecbd 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -28,7 +28,15 @@
 #define BLOCK_COPY_MAX_WORKERS 64
 
 typedef struct BlockCopyCallState {
+    /* IN parameters */
+    BlockCopyState *s;
+    int64_t offset;
+    int64_t bytes;
+
+    /* State */
     bool failed;
+
+    /* OUT parameters */
     bool error_is_read;
 } BlockCopyCallState;
 
@@ -514,14 +522,16 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
  * Returns 1 if dirty clusters found and successfully copied, 0 if no dirty
  * clusters found and -errno on failure.
  */
-static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
-                                                  int64_t offset, int64_t bytes,
-                                                  bool *error_is_read)
+static int coroutine_fn
+block_copy_dirty_clusters(BlockCopyCallState *call_state)
 {
+    BlockCopyState *s = call_state->s;
+    int64_t offset = call_state->offset;
+    int64_t bytes = call_state->bytes;
+
     int ret = 0;
     bool found_dirty = false;
     AioTaskPool *aio = NULL;
-    BlockCopyCallState call_state = {false, false};
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -546,7 +556,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
         found_dirty = true;
 
-        task = block_copy_task_create(s, &call_state, offset, bytes);
+        task = block_copy_task_create(s, call_state, offset, bytes);
 
         ret = block_copy_block_status(s, offset, task->bytes, &status_bytes);
         block_copy_task_shrink(task, status_bytes);
@@ -586,18 +596,14 @@ out:
         }
         g_free(aio);
     }
-    if (error_is_read && ret < 0) {
-        *error_is_read = call_state.error_is_read;
-    }
 
     return ret < 0 ? ret : found_dirty;
 }
 
-int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
-                            bool *error_is_read)
+static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 {
     while (true) {
-        int ret = block_copy_dirty_clusters(s, start, bytes, error_is_read);
+        int ret = block_copy_dirty_clusters(call_state);
 
         if (ret < 0) {
             /*
@@ -620,7 +626,9 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
          * requested region.
          */
 
-        if (!block_copy_wait_one(s, start, bytes)) {
+        if (!block_copy_wait_one(call_state->s, call_state->offset,
+                                 call_state->bytes))
+        {
             /* No dirty bits and nothing to wait: the whole request is done */
             break;
         }
@@ -629,6 +637,24 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
     return 0;
 }
 
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
+                            bool *error_is_read)
+{
+    BlockCopyCallState call_state = {
+        .s = s,
+        .offset = start,
+        .bytes = bytes,
+    };
+
+    int ret = block_copy_common(&call_state);
+
+    if (error_is_read && ret < 0) {
+        *error_is_read = call_state.error_is_read;
+    }
+
+    return ret;
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


