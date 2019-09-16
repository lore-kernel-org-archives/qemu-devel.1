Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81DDC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9301520830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9301520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9vEX-0008TM-Jp
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC4-0006SY-1q
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC0-0004tP-Hj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:36822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBp-0004ng-RN; Mon, 16 Sep 2019 13:53:30 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBm-0004Nc-CN; Mon, 16 Sep 2019 20:53:26 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 20:53:21 +0300
Message-Id: <20190916175324.18478-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916175324.18478-1-vsementsov@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 2/5] block: introduce aio task pool
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common interface for aio task loops. To be used for improving
performance of synchronous io loops in qcow2, block-stream,
copy-on-read, and may be other places.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/aio_task.h |  54 +++++++++++++++++
 block/aio_task.c         | 124 +++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs      |   2 +
 3 files changed, 180 insertions(+)
 create mode 100644 include/block/aio_task.h
 create mode 100644 block/aio_task.c

diff --git a/include/block/aio_task.h b/include/block/aio_task.h
new file mode 100644
index 0000000000..50bc1e1817
--- /dev/null
+++ b/include/block/aio_task.h
@@ -0,0 +1,54 @@
+/*
+ * Aio tasks loops
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef BLOCK_AIO_TASK_H
+#define BLOCK_AIO_TASK_H
+
+#include "qemu/coroutine.h"
+
+typedef struct AioTaskPool AioTaskPool;
+typedef struct AioTask AioTask;
+typedef int coroutine_fn (*AioTaskFunc)(AioTask *task);
+struct AioTask {
+    AioTaskPool *pool;
+    AioTaskFunc func;
+    int ret;
+};
+
+AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks);
+void aio_task_pool_free(AioTaskPool *);
+
+/* error code of failed task or 0 if all is OK */
+int aio_task_pool_status(AioTaskPool *pool);
+
+bool aio_task_pool_empty(AioTaskPool *pool);
+
+/* User provides filled @task, however task->pool will be set automatically */
+void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *task);
+
+void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool);
+void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool);
+void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool);
+
+#endif /* BLOCK_AIO_TASK_H */
diff --git a/block/aio_task.c b/block/aio_task.c
new file mode 100644
index 0000000000..88989fa248
--- /dev/null
+++ b/block/aio_task.c
@@ -0,0 +1,124 @@
+/*
+ * Aio tasks loops
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "block/aio_task.h"
+
+struct AioTaskPool {
+    Coroutine *main_co;
+    int status;
+    int max_busy_tasks;
+    int busy_tasks;
+    bool waiting;
+};
+
+static void coroutine_fn aio_task_co(void *opaque)
+{
+    AioTask *task = opaque;
+    AioTaskPool *pool = task->pool;
+
+    assert(pool->busy_tasks < pool->max_busy_tasks);
+    pool->busy_tasks++;
+
+    task->ret = task->func(task);
+
+    pool->busy_tasks--;
+
+    if (task->ret < 0 && pool->status == 0) {
+        pool->status = task->ret;
+    }
+
+    g_free(task);
+
+    if (pool->waiting) {
+        pool->waiting = false;
+        aio_co_wake(pool->main_co);
+    }
+}
+
+void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
+{
+    assert(pool->busy_tasks > 0);
+    assert(qemu_coroutine_self() == pool->main_co);
+
+    pool->waiting = true;
+    qemu_coroutine_yield();
+
+    assert(!pool->waiting);
+    assert(pool->busy_tasks < pool->max_busy_tasks);
+}
+
+void coroutine_fn aio_task_pool_wait_slot(AioTaskPool *pool)
+{
+    if (pool->busy_tasks < pool->max_busy_tasks) {
+        return;
+    }
+
+    aio_task_pool_wait_one(pool);
+}
+
+void coroutine_fn aio_task_pool_wait_all(AioTaskPool *pool)
+{
+    while (pool->busy_tasks > 0) {
+        aio_task_pool_wait_one(pool);
+    }
+}
+
+void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *task)
+{
+    aio_task_pool_wait_slot(pool);
+
+    task->pool = pool;
+    qemu_coroutine_enter(qemu_coroutine_create(aio_task_co, task));
+}
+
+AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
+{
+    AioTaskPool *pool = g_new0(AioTaskPool, 1);
+
+    pool->main_co = qemu_coroutine_self();
+    pool->max_busy_tasks = max_busy_tasks;
+
+    return pool;
+}
+
+void aio_task_pool_free(AioTaskPool *pool)
+{
+    g_free(pool);
+}
+
+int aio_task_pool_status(AioTaskPool *pool)
+{
+    if (!pool) {
+        return 0; /* Sugar for lazy allocation of aio pool */
+    }
+
+    return pool->status;
+}
+
+bool aio_task_pool_empty(AioTaskPool *pool)
+{
+    return pool->busy_tasks == 0;
+}
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 35f3bca4d9..c2eb8c8769 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -40,6 +40,8 @@ block-obj-y += throttle.o copy-on-read.o
 
 block-obj-y += crypto.o
 
+block-obj-y += aio_task.o
+
 common-obj-y += stream.o
 
 nfs.o-libs         := $(LIBNFS_LIBS)
-- 
2.21.0


