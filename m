Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F752074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F752074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5xE-0004VK-LT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jj5vx-0003An-BC; Wed, 10 Jun 2020 14:58:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:42058 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jj5vq-0004re-M9; Wed, 10 Jun 2020 14:58:44 -0400
Received: from [192.168.15.9] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jj5vk-0007uZ-W8; Wed, 10 Jun 2020 21:58:33 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] aio: allow to wait for coroutine pool from different
 coroutine
Date: Wed, 10 Jun 2020 21:58:32 +0300
Message-Id: <20200610185833.10665-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:58:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch preserves the constraint that the only waiter is allowed.

The patch renames AioTaskPool->main_co to wake_co and removes
AioTaskPool->waiting flag. wake_co keeps coroutine, which is
waiting for wakeup on worker completion. Thus 'waiting' flag
in this semantics is equivalent to 'wake_co != NULL'.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/aio_task.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/aio_task.c b/block/aio_task.c
index 88989fa248..5183b0729d 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -27,11 +27,10 @@
 #include "block/aio_task.h"
 
 struct AioTaskPool {
-    Coroutine *main_co;
+    Coroutine *wake_co;
     int status;
     int max_busy_tasks;
     int busy_tasks;
-    bool waiting;
 };
 
 static void coroutine_fn aio_task_co(void *opaque)
@@ -52,21 +51,21 @@ static void coroutine_fn aio_task_co(void *opaque)
 
     g_free(task);
 
-    if (pool->waiting) {
-        pool->waiting = false;
-        aio_co_wake(pool->main_co);
+    if (pool->wake_co != NULL) {
+        aio_co_wake(pool->wake_co);
+        pool->wake_co = NULL;
     }
 }
 
 void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
 {
     assert(pool->busy_tasks > 0);
-    assert(qemu_coroutine_self() == pool->main_co);
+    assert(pool->wake_co == NULL);
 
-    pool->waiting = true;
+    pool->wake_co = qemu_coroutine_self();
     qemu_coroutine_yield();
 
-    assert(!pool->waiting);
+    assert(pool->wake_co == NULL);
     assert(pool->busy_tasks < pool->max_busy_tasks);
 }
 
@@ -98,7 +97,7 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
 {
     AioTaskPool *pool = g_new0(AioTaskPool, 1);
 
-    pool->main_co = qemu_coroutine_self();
+    pool->wake_co = NULL;
     pool->max_busy_tasks = max_busy_tasks;
 
     return pool;
-- 
2.17.1


