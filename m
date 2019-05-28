Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCA8C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8866208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8866208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhpb-0002OB-4s
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:32:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnA-0000rt-KJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhmy-0000uD-JR
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhmT-0000EQ-3L; Tue, 28 May 2019 15:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C325F307D986;
	Tue, 28 May 2019 19:29:01 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5937F1972B;
	Tue, 28 May 2019 19:29:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:31 +0200
Message-Id: <20190528192847.2730-6-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 28 May 2019 19:29:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/21] qcow2-threads: split out generic path
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move generic part out of qcow2_co_do_compress, to reuse it for
encryption and rename things that would be shared with encryption path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190506142741.41731-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  4 ++--
 block/qcow2-threads.c | 47 ++++++++++++++++++++++++++++---------------
 block/qcow2.c         |  2 +-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8207ed374e..637552e137 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -350,8 +350,8 @@ typedef struct BDRVQcow2State {
     char *image_backing_format;
     char *image_data_file;
=20
-    CoQueue compress_wait_queue;
-    int nb_compress_threads;
+    CoQueue thread_task_queue;
+    int nb_threads;
=20
     BdrvChild *data_file;
 } BDRVQcow2State;
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 50a9fdeec5..650aa2ed19 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,7 +31,36 @@
 #include "qcow2.h"
 #include "block/thread-pool.h"
=20
-#define MAX_COMPRESS_THREADS 4
+#define QCOW2_MAX_THREADS 4
+
+static int coroutine_fn
+qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
+{
+    int ret;
+    BDRVQcow2State *s =3D bs->opaque;
+    ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
+
+    qemu_co_mutex_lock(&s->lock);
+    while (s->nb_threads >=3D QCOW2_MAX_THREADS) {
+        qemu_co_queue_wait(&s->thread_task_queue, &s->lock);
+    }
+    s->nb_threads++;
+    qemu_co_mutex_unlock(&s->lock);
+
+    ret =3D thread_pool_submit_co(pool, func, arg);
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
=20
 typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
                                      const void *src, size_t src_size);
@@ -148,8 +177,6 @@ static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc=
 func)
 {
-    BDRVQcow2State *s =3D bs->opaque;
-    ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg =3D {
         .dest =3D dest,
         .dest_size =3D dest_size,
@@ -158,19 +185,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *des=
t, size_t dest_size,
         .func =3D func,
     };
=20
-    qemu_co_mutex_lock(&s->lock);
-    while (s->nb_compress_threads >=3D MAX_COMPRESS_THREADS) {
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
=20
     return arg.ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index a8c4b11539..1413df1389 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1693,7 +1693,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     }
 #endif
=20
-    qemu_co_queue_init(&s->compress_wait_queue);
+    qemu_co_queue_init(&s->thread_task_queue);
=20
     return ret;
=20
--=20
2.21.0


