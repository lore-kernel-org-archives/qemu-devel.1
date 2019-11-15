Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17419C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05282072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05282072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcc0-0004Gv-En
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNL-0004e0-9O
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNJ-0001y1-T9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001rz-GR; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNB-0006WW-8E; Fri, 15 Nov 2019 17:14:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 15/24] block/block-copy: implement block_copy_async
Date: Fri, 15 Nov 2019 17:14:35 +0300
Message-Id: <20191115141444.24155-16-vsementsov@virtuozzo.com>
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

We'll need async block-copy invocation to use in backup directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 13 +++++++++++
 block/block-copy.c         | 48 +++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 753fa663ac..407de7e520 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -20,7 +20,10 @@
 
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*ProgressResetCallbackFunc)(void *opaque);
+typedef void (*BlockCopyAsyncCallbackFunc)(int ret, bool error_is_read,
+                                           void *opaque);
 typedef struct BlockCopyState BlockCopyState;
+typedef struct BlockCopyCallState BlockCopyCallState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size,
@@ -41,6 +44,16 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
                             bool *error_is_read);
 
+/*
+ * Run block-copy in a coroutine, return state pointer. If finished early
+ * returns NULL (@cb is called anyway).
+ */
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     bool ratelimit, int max_workers,
+                                     int64_t max_chunk,
+                                     BlockCopyAsyncCallbackFunc cb);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 4b1a0cecbd..0b41afd30d 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -32,9 +32,11 @@ typedef struct BlockCopyCallState {
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    BlockCopyAsyncCallbackFunc cb;
 
     /* State */
     bool failed;
+    bool finished;
 
     /* OUT parameters */
     bool error_is_read;
@@ -602,15 +604,17 @@ out:
 
 static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 {
+    int ret = 0;
+
     while (true) {
-        int ret = block_copy_dirty_clusters(call_state);
+        ret = block_copy_dirty_clusters(call_state);
 
         if (ret < 0) {
             /*
              * IO operation failed, which means the whole block_copy request
              * failed.
              */
-            return ret;
+            break;
         }
         if (ret) {
             /*
@@ -634,7 +638,14 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
         }
     }
 
-    return 0;
+    if (call_state->cb) {
+        call_state->cb(ret, call_state->error_is_read,
+                       call_state->s->progress_opaque);
+    }
+
+    call_state->finished = true;
+
+    return ret;
 }
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
@@ -655,6 +666,37 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
     return ret;
 }
 
+static void coroutine_fn block_copy_async_co_entry(void *opaque)
+{
+    block_copy_common(opaque);
+}
+
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     bool ratelimit, int max_workers,
+                                     int64_t max_chunk,
+                                     BlockCopyAsyncCallbackFunc cb)
+{
+    BlockCopyCallState *call_state = g_new(BlockCopyCallState, 1);
+    Coroutine *co = qemu_coroutine_create(block_copy_async_co_entry,
+                                          call_state);
+
+    *call_state = (BlockCopyCallState) {
+        .s = s,
+        .offset = offset,
+        .bytes = bytes,
+        .cb = cb,
+    };
+
+    qemu_coroutine_enter(co);
+
+    if (call_state->finished) {
+        g_free(call_state);
+        return NULL;
+    }
+
+    return call_state;
+}
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


