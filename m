Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DEC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1C5204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1C5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNeeJ-00010N-8v
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:31:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeaq-0006Ow-3j
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeao-0000cg-Qg
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeao-0000bg-Go; Mon, 06 May 2019 10:27:46 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeak-000444-W9; Mon, 06 May 2019 17:27:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  6 May 2019 17:27:38 +0300
Message-Id: <20190506142741.41731-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 5/8] qcow2-threads: split out generic path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move generic part out of qcow2_co_do_compress, to reuse it for
encryption and rename things that would be shared with encryption path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  4 ++--
 block/qcow2-threads.c | 47 ++++++++++++++++++++++++++++---------------
 block/qcow2.c         |  2 +-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 61079f7ee8..3089e9a68b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -347,8 +347,8 @@ typedef struct BDRVQcow2State {
     char *image_backing_format;
     char *image_data_file;
 
-    CoQueue compress_wait_queue;
-    int nb_compress_threads;
+    CoQueue thread_task_queue;
+    int nb_threads;
 
     BdrvChild *data_file;
 } BDRVQcow2State;
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 50a9fdeec5..650aa2ed19 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,7 +31,36 @@
 #include "qcow2.h"
 #include "block/thread-pool.h"
 
-#define MAX_COMPRESS_THREADS 4
+#define QCOW2_MAX_THREADS 4
+
+static int coroutine_fn
+qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+
+    qemu_co_mutex_lock(&s->lock);
+    while (s->nb_threads >= QCOW2_MAX_THREADS) {
+        qemu_co_queue_wait(&s->thread_task_queue, &s->lock);
+    }
+    s->nb_threads++;
+    qemu_co_mutex_unlock(&s->lock);
+
+    ret = thread_pool_submit_co(pool, func, arg);
+
+    qemu_co_mutex_lock(&s->lock);
+    s->nb_threads--;
+    qemu_co_queue_next(&s->thread_task_queue);
+    qemu_co_mutex_unlock(&s->lock);
+
+    return ret;
+}
+
+
+/*
+ * Compression
+ */
 
 typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
                                      const void *src, size_t src_size);
@@ -148,8 +177,6 @@ static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
-    BDRVQcow2State *s = bs->opaque;
-    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
         .dest_size = dest_size,
@@ -158,19 +185,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
-    qemu_co_mutex_lock(&s->lock);
-    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, &s->lock);
-    }
-    s->nb_compress_threads++;
-    qemu_co_mutex_unlock(&s->lock);
-
-    thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-
-    qemu_co_mutex_lock(&s->lock);
-    s->nb_compress_threads--;
-    qemu_co_queue_next(&s->compress_wait_queue);
-    qemu_co_mutex_unlock(&s->lock);
+    qcow2_co_process(bs, qcow2_compress_pool_func, &arg);
 
     return arg.ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index facf8ab993..7970d0992a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1694,7 +1694,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    qemu_co_queue_init(&s->compress_wait_queue);
+    qemu_co_queue_init(&s->thread_task_queue);
 
     return ret;
 
-- 
2.18.0


