Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4145BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1777E2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1777E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcZN-000184-Or
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNK-0004dJ-Qq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNJ-0001xg-KQ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:02 -0500
Received: from relay.sw.ru ([185.231.240.75]:47410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNG-0001rv-IL; Fri, 15 Nov 2019 09:14:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNC-0006WW-5k; Fri, 15 Nov 2019 17:14:54 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 18/24] block/block-copy: add block_copy_cancel
Date: Fri, 15 Nov 2019 17:14:38 +0300
Message-Id: <20191115141444.24155-19-vsementsov@virtuozzo.com>
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

Add function to cancel running async block-copy call. It will be used
in backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  7 +++++++
 block/block-copy.c         | 20 ++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 3f9cdc5eb2..fbbee094e6 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -67,6 +67,13 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
 void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
                           uint64_t speed);
 
+/*
+ * Cancel running block-copy call.
+ * Cancel leaves block-copy state valid: dirty bits are correct and you may use
+ * cancel + <run block_copy with same parameters> to emulate pause/resume.
+ */
+void block_copy_cancel(BlockCopyCallState *call_state);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 091bc044de..d11c744320 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -42,6 +42,8 @@ typedef struct BlockCopyCallState {
     bool failed;
     bool finished;
     QemuCoSleepState *sleep_state;
+    bool cancelled;
+    Coroutine *canceller;
 
     /* OUT parameters */
     bool error_is_read;
@@ -553,7 +555,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes && aio_task_pool_status(aio) == 0) {
+    while (bytes && aio_task_pool_status(aio) == 0 && !call_state->cancelled) {
         BlockCopyTask *task;
         int64_t status_bytes;
 
@@ -639,7 +641,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
     while (true) {
         ret = block_copy_dirty_clusters(call_state);
 
-        if (ret < 0) {
+        if (ret < 0 || call_state->cancelled) {
             /*
              * IO operation failed, which means the whole block_copy request
              * failed.
@@ -673,6 +675,11 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
                        call_state->s->progress_opaque);
     }
 
+    if (call_state->canceller) {
+        aio_co_wake(call_state->canceller);
+        call_state->canceller = NULL;
+    }
+
     call_state->finished = true;
 
     return ret;
@@ -731,6 +738,15 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
 
     return call_state;
 }
+
+void block_copy_cancel(BlockCopyCallState *call_state)
+{
+    call_state->cancelled = true;
+    call_state->canceller = qemu_coroutine_self();
+    block_copy_kick(call_state);
+    qemu_coroutine_yield();
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


