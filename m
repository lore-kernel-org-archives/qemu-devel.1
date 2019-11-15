Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD4C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC15F2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC15F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcbC-0003K4-Qb
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNL-0004eJ-HY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNK-0001yD-0s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001ry-J3; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNB-0006WW-NH; Fri, 15 Nov 2019 17:14:54 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 17/24] block/block-copy: add ratelimit to block-copy
Date: Fri, 15 Nov 2019 17:14:37 +0300
Message-Id: <20191115141444.24155-18-vsementsov@virtuozzo.com>
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

We are going to directly use one async block-copy operation for backup
job, so we need rate limitator.

We want to maintain current backup behavior: only background copying is
limited and copy-before-write operations only participate in limit
calculation. Therefore we need one rate limitator for block-copy state
and boolean flag for block-copy call state for actual limitation.

Note, that we can't just calculate each chunk in limitator after
successful copying: it will not restring starting a lot of async
sub-requests which will exceed limit too much. Instead let's use the
following scheme on sub-request creation:
1. If at the moment limit is not exceeded, create the request and
account it immediately.
2. If at the moment limit is already exceeded, drop create sub-request
and handle limit instead (by sleep).
With this approach we'll never exceed the limit more than by one
sub-request (which pretty much matches current backup behavior).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  8 +++++++
 block/block-copy.c         | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 8fc27156b3..3f9cdc5eb2 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -59,6 +59,14 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t max_chunk,
                                      BlockCopyAsyncCallbackFunc cb);
 
+/*
+ * Set speed limit for block-copy instance. All block-copy operations related to
+ * this BlockCopyState will participate in speed calculation, but only
+ * block_copy_async calls with @ratelimit=true will be actually limited.
+ */
+void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
+                          uint64_t speed);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index f28f3b8b6c..091bc044de 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -26,6 +26,7 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 #define BLOCK_COPY_MAX_WORKERS 64
+#define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
 
 typedef struct BlockCopyCallState {
     /* IN parameters */
@@ -34,11 +35,13 @@ typedef struct BlockCopyCallState {
     int64_t bytes;
     int max_workers;
     int64_t max_chunk;
+    bool ratelimit;
     BlockCopyAsyncCallbackFunc cb;
 
     /* State */
     bool failed;
     bool finished;
+    QemuCoSleepState *sleep_state;
 
     /* OUT parameters */
     bool error_is_read;
@@ -101,6 +104,9 @@ typedef struct BlockCopyState {
     void *progress_opaque;
 
     SharedResource *mem;
+
+    uint64_t speed;
+    RateLimit rate_limit;
 } BlockCopyState;
 
 static BlockCopyTask *block_copy_find_task(BlockCopyState *s,
@@ -575,6 +581,21 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         }
         task->zeroes = ret & BDRV_BLOCK_ZERO;
 
+        if (s->speed) {
+            if (call_state->ratelimit) {
+                uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
+                if (ns > 0) {
+                    block_copy_task_end(task, -EAGAIN);
+                    g_free(task);
+                    qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, ns,
+                                              &call_state->sleep_state);
+                    continue;
+                }
+            }
+
+            ratelimit_calculate_delay(&s->rate_limit, task->bytes);
+        }
+
         trace_block_copy_process(s, offset);
 
         co_get_from_shres(s->mem, task->bytes);
@@ -604,6 +625,13 @@ out:
     return ret < 0 ? ret : found_dirty;
 }
 
+static void block_copy_kick(BlockCopyCallState *call_state)
+{
+    if (call_state->sleep_state) {
+        qemu_co_sleep_wake(call_state->sleep_state);
+    }
+}
+
 static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 {
     int ret = 0;
@@ -688,6 +716,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .s = s,
         .offset = offset,
         .bytes = bytes,
+        .ratelimit = ratelimit,
         .cb = cb,
         .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
         .max_chunk = max_chunk,
@@ -711,3 +740,18 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
 {
     s->skip_unallocated = skip;
 }
+
+void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
+                          uint64_t speed)
+{
+    uint64_t old_speed = s->speed;
+
+    s->speed = speed;
+    if (speed > 0) {
+        ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
+    }
+
+    if (call_state && old_speed && (speed > old_speed || speed == 0)) {
+        block_copy_kick(call_state);
+    }
+}
-- 
2.21.0


