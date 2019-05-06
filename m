Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8332C04AAE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0F0214C6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0F0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNejG-00058P-0n
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:36:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNear-0006PY-1r
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeao-0000d4-Tz
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:45588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeao-0000bb-El; Mon, 06 May 2019 10:27:46 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeak-000444-8E; Mon, 06 May 2019 17:27:42 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  6 May 2019 17:27:35 +0300
Message-Id: <20190506142741.41731-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 2/8] qcow2: add separate file for threaded
 data processing functions
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

Move compression-on-threads to separate file. Encryption will be in it
too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |   7 ++
 block/qcow2-threads.c | 201 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 169 -----------------------------------
 block/Makefile.objs   |   2 +-
 4 files changed, 209 insertions(+), 170 deletions(-)
 create mode 100644 block/qcow2-threads.c

diff --git a/block/qcow2.h b/block/qcow2.h
index ecb026e19a..61079f7ee8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -735,4 +735,11 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           const char *name,
                                           Error **errp);
 
+ssize_t coroutine_fn
+qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
+                  const void *src, size_t src_size);
+ssize_t coroutine_fn
+qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
+                    const void *src, size_t src_size);
+
 #endif
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
new file mode 100644
index 0000000000..85b8034fd2
--- /dev/null
+++ b/block/qcow2-threads.c
@@ -0,0 +1,201 @@
+/*
+ * Threaded data processing for Qcow2: compression, encryption
+ *
+ * Copyright (c) 2004-2006 Fabrice Bellard
+ * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
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
+
+#define ZLIB_CONST
+#include <zlib.h>
+
+#include "qcow2.h"
+#include "block/thread-pool.h"
+
+#define MAX_COMPRESS_THREADS 4
+
+typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size);
+typedef struct Qcow2CompressData {
+    void *dest;
+    size_t dest_size;
+    const void *src;
+    size_t src_size;
+    ssize_t ret;
+
+    Qcow2CompressFunc func;
+} Qcow2CompressData;
+
+/*
+ * qcow2_compress()
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: compressed size on success
+ *          -ENOMEM destination buffer is not enough to store compressed data
+ *          -EIO    on any other error
+ */
+static ssize_t qcow2_compress(void *dest, size_t dest_size,
+                              const void *src, size_t src_size)
+{
+    ssize_t ret;
+    z_stream strm;
+
+    /* best compression, small window, no zlib header */
+    memset(&strm, 0, sizeof(strm));
+    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
+                       -12, 9, Z_DEFAULT_STRATEGY);
+    if (ret != Z_OK) {
+        return -EIO;
+    }
+
+    /*
+     * strm.next_in is not const in old zlib versions, such as those used on
+     * OpenBSD/NetBSD, so cast the const away
+     */
+    strm.avail_in = src_size;
+    strm.next_in = (void *) src;
+    strm.avail_out = dest_size;
+    strm.next_out = dest;
+
+    ret = deflate(&strm, Z_FINISH);
+    if (ret == Z_STREAM_END) {
+        ret = dest_size - strm.avail_out;
+    } else {
+        ret = (ret == Z_OK ? -ENOMEM : -EIO);
+    }
+
+    deflateEnd(&strm);
+
+    return ret;
+}
+
+/*
+ * qcow2_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exactly
+ * @dest_size bytes.
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: 0 on success
+ *          -1 on fail
+ */
+static ssize_t qcow2_decompress(void *dest, size_t dest_size,
+                                const void *src, size_t src_size)
+{
+    int ret = 0;
+    z_stream strm;
+
+    memset(&strm, 0, sizeof(strm));
+    strm.avail_in = src_size;
+    strm.next_in = (void *) src;
+    strm.avail_out = dest_size;
+    strm.next_out = dest;
+
+    ret = inflateInit2(&strm, -12);
+    if (ret != Z_OK) {
+        return -1;
+    }
+
+    ret = inflate(&strm, Z_FINISH);
+    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) || strm.avail_out != 0) {
+        /*
+         * We approve Z_BUF_ERROR because we need @dest buffer to be filled, but
+         * @src buffer may be processed partly (because in qcow2 we know size of
+         * compressed data with precision of one sector)
+         */
+        ret = -1;
+    }
+
+    inflateEnd(&strm);
+
+    return ret;
+}
+
+static int qcow2_compress_pool_func(void *opaque)
+{
+    Qcow2CompressData *data = opaque;
+
+    data->ret = data->func(data->dest, data->dest_size,
+                           data->src, data->src_size);
+
+    return 0;
+}
+
+static void qcow2_compress_complete(void *opaque, int ret)
+{
+    qemu_coroutine_enter(opaque);
+}
+
+static ssize_t coroutine_fn
+qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
+                     const void *src, size_t src_size, Qcow2CompressFunc func)
+{
+    BDRVQcow2State *s = bs->opaque;
+    BlockAIOCB *acb;
+    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+    Qcow2CompressData arg = {
+        .dest = dest,
+        .dest_size = dest_size,
+        .src = src,
+        .src_size = src_size,
+        .func = func,
+    };
+
+    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
+        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
+    }
+
+    s->nb_compress_threads++;
+    acb = thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
+                                 qcow2_compress_complete,
+                                 qemu_coroutine_self());
+
+    if (!acb) {
+        s->nb_compress_threads--;
+        return -EINVAL;
+    }
+    qemu_coroutine_yield();
+    s->nb_compress_threads--;
+    qemu_co_queue_next(&s->compress_wait_queue);
+
+    return arg.ret;
+}
+
+ssize_t coroutine_fn
+qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
+                  const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_compress);
+}
+
+ssize_t coroutine_fn
+qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
+                    const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_decompress);
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index ab231cbfe7..facf8ab993 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -24,9 +24,6 @@
 
 #include "qemu/osdep.h"
 
-#define ZLIB_CONST
-#include <zlib.h>
-
 #include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
@@ -43,7 +40,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto.h"
-#include "block/thread-pool.h"
 
 /*
   Differences with QCOW:
@@ -3921,171 +3917,6 @@ fail:
     return ret;
 }
 
-/*
- * qcow2_compress()
- *
- * @dest - destination buffer, @dest_size bytes
- * @src - source buffer, @src_size bytes
- *
- * Returns: compressed size on success
- *          -ENOMEM destination buffer is not enough to store compressed data
- *          -EIO    on any other error
- */
-static ssize_t qcow2_compress(void *dest, size_t dest_size,
-                              const void *src, size_t src_size)
-{
-    ssize_t ret;
-    z_stream strm;
-
-    /* best compression, small window, no zlib header */
-    memset(&strm, 0, sizeof(strm));
-    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
-                       -12, 9, Z_DEFAULT_STRATEGY);
-    if (ret != Z_OK) {
-        return -EIO;
-    }
-
-    /* strm.next_in is not const in old zlib versions, such as those used on
-     * OpenBSD/NetBSD, so cast the const away */
-    strm.avail_in = src_size;
-    strm.next_in = (void *) src;
-    strm.avail_out = dest_size;
-    strm.next_out = dest;
-
-    ret = deflate(&strm, Z_FINISH);
-    if (ret == Z_STREAM_END) {
-        ret = dest_size - strm.avail_out;
-    } else {
-        ret = (ret == Z_OK ? -ENOMEM : -EIO);
-    }
-
-    deflateEnd(&strm);
-
-    return ret;
-}
-
-/*
- * qcow2_decompress()
- *
- * Decompress some data (not more than @src_size bytes) to produce exactly
- * @dest_size bytes.
- *
- * @dest - destination buffer, @dest_size bytes
- * @src - source buffer, @src_size bytes
- *
- * Returns: 0 on success
- *          -1 on fail
- */
-static ssize_t qcow2_decompress(void *dest, size_t dest_size,
-                                const void *src, size_t src_size)
-{
-    int ret = 0;
-    z_stream strm;
-
-    memset(&strm, 0, sizeof(strm));
-    strm.avail_in = src_size;
-    strm.next_in = (void *) src;
-    strm.avail_out = dest_size;
-    strm.next_out = dest;
-
-    ret = inflateInit2(&strm, -12);
-    if (ret != Z_OK) {
-        return -1;
-    }
-
-    ret = inflate(&strm, Z_FINISH);
-    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) || strm.avail_out != 0) {
-        /* We approve Z_BUF_ERROR because we need @dest buffer to be filled, but
-         * @src buffer may be processed partly (because in qcow2 we know size of
-         * compressed data with precision of one sector) */
-        ret = -1;
-    }
-
-    inflateEnd(&strm);
-
-    return ret;
-}
-
-#define MAX_COMPRESS_THREADS 4
-
-typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
-                                     const void *src, size_t src_size);
-typedef struct Qcow2CompressData {
-    void *dest;
-    size_t dest_size;
-    const void *src;
-    size_t src_size;
-    ssize_t ret;
-
-    Qcow2CompressFunc func;
-} Qcow2CompressData;
-
-static int qcow2_compress_pool_func(void *opaque)
-{
-    Qcow2CompressData *data = opaque;
-
-    data->ret = data->func(data->dest, data->dest_size,
-                           data->src, data->src_size);
-
-    return 0;
-}
-
-static void qcow2_compress_complete(void *opaque, int ret)
-{
-    qemu_coroutine_enter(opaque);
-}
-
-static ssize_t coroutine_fn
-qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
-                     const void *src, size_t src_size, Qcow2CompressFunc func)
-{
-    BDRVQcow2State *s = bs->opaque;
-    BlockAIOCB *acb;
-    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
-    Qcow2CompressData arg = {
-        .dest = dest,
-        .dest_size = dest_size,
-        .src = src,
-        .src_size = src_size,
-        .func = func,
-    };
-
-    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
-    }
-
-    s->nb_compress_threads++;
-    acb = thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
-                                 qcow2_compress_complete,
-                                 qemu_coroutine_self());
-
-    if (!acb) {
-        s->nb_compress_threads--;
-        return -EINVAL;
-    }
-    qemu_coroutine_yield();
-    s->nb_compress_threads--;
-    qemu_co_queue_next(&s->compress_wait_queue);
-
-    return arg.ret;
-}
-
-static ssize_t coroutine_fn
-qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
-                  const void *src, size_t src_size)
-{
-    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
-                                qcow2_compress);
-}
-
-static ssize_t coroutine_fn
-qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
-                    const void *src, size_t src_size)
-{
-    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
-                                qcow2_decompress);
-}
-
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..ae11605c9f 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -6,7 +6,7 @@ block-obj-$(CONFIG_BOCHS) += bochs.o
 block-obj-$(CONFIG_VVFAT) += vvfat.o
 block-obj-$(CONFIG_DMG) += dmg.o
 
-block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o
+block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o qcow2-threads.o
 block-obj-$(CONFIG_QED) += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
 block-obj-$(CONFIG_QED) += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
-- 
2.18.0


