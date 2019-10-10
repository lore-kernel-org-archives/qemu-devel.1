Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE01C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8717520673
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8717520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXIV-0004oy-C1
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWqh-0006DN-0A
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqf-000841-96
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqb-00081r-O7; Thu, 10 Oct 2019 07:43:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49BE883F3D;
 Thu, 10 Oct 2019 11:43:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA18710013A1;
 Thu, 10 Oct 2019 11:43:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/36] block: introduce aio task pool
Date: Thu, 10 Oct 2019 13:42:26 +0200
Message-Id: <20191010114300.7746-3-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 10 Oct 2019 11:43:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Common interface for aio task loops. To be used for improving
performance of synchronous io loops in qcow2, block-stream,
copy-on-read, and may be other places.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190916175324.18478-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs      |   2 +
 include/block/aio_task.h |  54 +++++++++++++++++
 block/aio_task.c         | 124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 include/block/aio_task.h
 create mode 100644 block/aio_task.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 35f3bca4d9..c2eb8c8769 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -40,6 +40,8 @@ block-obj-y +=3D throttle.o copy-on-read.o
=20
 block-obj-y +=3D crypto.o
=20
+block-obj-y +=3D aio_task.o
+
 common-obj-y +=3D stream.o
=20
 nfs.o-libs         :=3D $(LIBNFS_LIBS)
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
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
+/* User provides filled @task, however task->pool will be set automatica=
lly */
+void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *t=
ask);
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
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
+    AioTask *task =3D opaque;
+    AioTaskPool *pool =3D task->pool;
+
+    assert(pool->busy_tasks < pool->max_busy_tasks);
+    pool->busy_tasks++;
+
+    task->ret =3D task->func(task);
+
+    pool->busy_tasks--;
+
+    if (task->ret < 0 && pool->status =3D=3D 0) {
+        pool->status =3D task->ret;
+    }
+
+    g_free(task);
+
+    if (pool->waiting) {
+        pool->waiting =3D false;
+        aio_co_wake(pool->main_co);
+    }
+}
+
+void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
+{
+    assert(pool->busy_tasks > 0);
+    assert(qemu_coroutine_self() =3D=3D pool->main_co);
+
+    pool->waiting =3D true;
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
+void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *t=
ask)
+{
+    aio_task_pool_wait_slot(pool);
+
+    task->pool =3D pool;
+    qemu_coroutine_enter(qemu_coroutine_create(aio_task_co, task));
+}
+
+AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
+{
+    AioTaskPool *pool =3D g_new0(AioTaskPool, 1);
+
+    pool->main_co =3D qemu_coroutine_self();
+    pool->max_busy_tasks =3D max_busy_tasks;
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
+    return pool->busy_tasks =3D=3D 0;
+}
--=20
2.21.0


