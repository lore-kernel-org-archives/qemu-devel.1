Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0FC20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0FC20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEMc-000191-S3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKP-00051s-7a; Tue, 16 Jun 2020 12:20:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:43698 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKJ-0006a1-7J; Tue, 16 Jun 2020 12:20:48 -0400
Received: from [192.168.15.172] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jlEK1-0003Pf-Ai; Tue, 16 Jun 2020 19:20:25 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] block/aio_task: drop aio_task_pool_wait_one() helper
Date: Tue, 16 Jun 2020 19:20:33 +0300
Message-Id: <20200616162035.29857-4-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616162035.29857-1-den@openvz.org>
References: <20200616162035.29857-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 12:20:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not used outside the module.

Actually there are 2 kind of waiters:
- for a slot and
- for all tasks to finish
This patch limits external API to listed types.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/aio_task.c         | 13 ++-----------
 include/block/aio_task.h |  1 -
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/block/aio_task.c b/block/aio_task.c
index cf62e5c58b..7ba15ff41f 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -54,26 +54,17 @@ static void coroutine_fn aio_task_co(void *opaque)
     qemu_co_queue_restart_all(&pool->waiters);
 }
 
-void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
-{
-    assert(pool->busy_tasks > 0);
-
-    qemu_co_queue_wait(&pool->waiters, NULL);
-
-    assert(pool->busy_tasks < pool->max_busy_tasks);
-}
-
 void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool)
 {
     while (pool->busy_tasks >= pool->max_busy_tasks) {
-        aio_task_pool_wait_one(pool);
+        qemu_co_queue_wait(&pool->waiters, NULL);
     }
 }
 
 void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool)
 {
     while (pool->busy_tasks > 0) {
-        aio_task_pool_wait_one(pool);
+        qemu_co_queue_wait(&pool->waiters, NULL);
     }
 }
 
diff --git a/include/block/aio_task.h b/include/block/aio_task.h
index 50bc1e1817..50b1c036c5 100644
--- a/include/block/aio_task.h
+++ b/include/block/aio_task.h
@@ -48,7 +48,6 @@ bool aio_task_pool_empty(AioTaskPool *pool);
 void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *task);
 
 void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool);
-void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool);
 void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool);
 
 #endif /* BLOCK_AIO_TASK_H */
-- 
2.17.1


