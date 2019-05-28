Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D204C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59508208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59508208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhsd-0004dB-I4
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:35:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnA-0000ry-NN
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhmz-0000v2-Bh
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhmT-00006X-P2; Tue, 28 May 2019 15:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D5EB307E04E;
	Tue, 28 May 2019 19:28:54 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FD11972B;
	Tue, 28 May 2019 19:28:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:28 +0200
Message-Id: <20190528192847.2730-3-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:28:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/21] qcow2: add separate file for threaded
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move compression-on-threads to separate file. Encryption will be in it
too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190506142741.41731-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs   |   2 +-
 block/qcow2.h         |   7 ++
 block/qcow2-threads.c | 201 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 169 -----------------------------------
 4 files changed, 209 insertions(+), 170 deletions(-)
 create mode 100644 block/qcow2-threads.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..ae11605c9f 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -6,7 +6,7 @@ block-obj-$(CONFIG_BOCHS) +=3D bochs.o
 block-obj-$(CONFIG_VVFAT) +=3D vvfat.o
 block-obj-$(CONFIG_DMG) +=3D dmg.o
=20
-block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot=
.o qcow2-cache.o qcow2-bitmap.o
+block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot=
.o qcow2-cache.o qcow2-bitmap.o qcow2-threads.o
 block-obj-$(CONFIG_QED) +=3D qed.o qed-l2-cache.o qed-table.o qed-cluste=
r.o
 block-obj-$(CONFIG_QED) +=3D qed-check.o
 block-obj-y +=3D vhdx.o vhdx-endian.o vhdx-log.o
diff --git a/block/qcow2.h b/block/qcow2.h
index c2b0e955eb..8207ed374e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -738,4 +738,11 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDrive=
rState *bs,
                                           const char *name,
                                           Error **errp);
=20
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
+ *          -ENOMEM destination buffer is not enough to store compressed=
 data
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
+    ret =3D deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
+                       -12, 9, Z_DEFAULT_STRATEGY);
+    if (ret !=3D Z_OK) {
+        return -EIO;
+    }
+
+    /*
+     * strm.next_in is not const in old zlib versions, such as those use=
d on
+     * OpenBSD/NetBSD, so cast the const away
+     */
+    strm.avail_in =3D src_size;
+    strm.next_in =3D (void *) src;
+    strm.avail_out =3D dest_size;
+    strm.next_out =3D dest;
+
+    ret =3D deflate(&strm, Z_FINISH);
+    if (ret =3D=3D Z_STREAM_END) {
+        ret =3D dest_size - strm.avail_out;
+    } else {
+        ret =3D (ret =3D=3D Z_OK ? -ENOMEM : -EIO);
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
+ * Decompress some data (not more than @src_size bytes) to produce exact=
ly
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
+    int ret =3D 0;
+    z_stream strm;
+
+    memset(&strm, 0, sizeof(strm));
+    strm.avail_in =3D src_size;
+    strm.next_in =3D (void *) src;
+    strm.avail_out =3D dest_size;
+    strm.next_out =3D dest;
+
+    ret =3D inflateInit2(&strm, -12);
+    if (ret !=3D Z_OK) {
+        return -1;
+    }
+
+    ret =3D inflate(&strm, Z_FINISH);
+    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) || strm.avail_ou=
t !=3D 0) {
+        /*
+         * We approve Z_BUF_ERROR because we need @dest buffer to be fil=
led, but
+         * @src buffer may be processed partly (because in qcow2 we know=
 size of
+         * compressed data with precision of one sector)
+         */
+        ret =3D -1;
+    }
+
+    inflateEnd(&strm);
+
+    return ret;
+}
+
+static int qcow2_compress_pool_func(void *opaque)
+{
+    Qcow2CompressData *data =3D opaque;
+
+    data->ret =3D data->func(data->dest, data->dest_size,
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
+                     const void *src, size_t src_size, Qcow2CompressFunc=
 func)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    BlockAIOCB *acb;
+    ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
+    Qcow2CompressData arg =3D {
+        .dest =3D dest,
+        .dest_size =3D dest_size,
+        .src =3D src,
+        .src_size =3D src_size,
+        .func =3D func,
+    };
+
+    while (s->nb_compress_threads >=3D MAX_COMPRESS_THREADS) {
+        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
+    }
+
+    s->nb_compress_threads++;
+    acb =3D thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
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
index 38bf729a1e..a8c4b11539 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -24,9 +24,6 @@
=20
 #include "qemu/osdep.h"
=20
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
=20
 /*
   Differences with QCOW:
@@ -3920,171 +3916,6 @@ fail:
     return ret;
 }
=20
-/*
- * qcow2_compress()
- *
- * @dest - destination buffer, @dest_size bytes
- * @src - source buffer, @src_size bytes
- *
- * Returns: compressed size on success
- *          -ENOMEM destination buffer is not enough to store compressed=
 data
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
-    ret =3D deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
-                       -12, 9, Z_DEFAULT_STRATEGY);
-    if (ret !=3D Z_OK) {
-        return -EIO;
-    }
-
-    /* strm.next_in is not const in old zlib versions, such as those use=
d on
-     * OpenBSD/NetBSD, so cast the const away */
-    strm.avail_in =3D src_size;
-    strm.next_in =3D (void *) src;
-    strm.avail_out =3D dest_size;
-    strm.next_out =3D dest;
-
-    ret =3D deflate(&strm, Z_FINISH);
-    if (ret =3D=3D Z_STREAM_END) {
-        ret =3D dest_size - strm.avail_out;
-    } else {
-        ret =3D (ret =3D=3D Z_OK ? -ENOMEM : -EIO);
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
- * Decompress some data (not more than @src_size bytes) to produce exact=
ly
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
-    int ret =3D 0;
-    z_stream strm;
-
-    memset(&strm, 0, sizeof(strm));
-    strm.avail_in =3D src_size;
-    strm.next_in =3D (void *) src;
-    strm.avail_out =3D dest_size;
-    strm.next_out =3D dest;
-
-    ret =3D inflateInit2(&strm, -12);
-    if (ret !=3D Z_OK) {
-        return -1;
-    }
-
-    ret =3D inflate(&strm, Z_FINISH);
-    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) || strm.avail_ou=
t !=3D 0) {
-        /* We approve Z_BUF_ERROR because we need @dest buffer to be fil=
led, but
-         * @src buffer may be processed partly (because in qcow2 we know=
 size of
-         * compressed data with precision of one sector) */
-        ret =3D -1;
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
-    Qcow2CompressData *data =3D opaque;
-
-    data->ret =3D data->func(data->dest, data->dest_size,
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
-                     const void *src, size_t src_size, Qcow2CompressFunc=
 func)
-{
-    BDRVQcow2State *s =3D bs->opaque;
-    BlockAIOCB *acb;
-    ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
-    Qcow2CompressData arg =3D {
-        .dest =3D dest,
-        .dest_size =3D dest_size,
-        .src =3D src,
-        .src_size =3D src_size,
-        .func =3D func,
-    };
-
-    while (s->nb_compress_threads >=3D MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
-    }
-
-    s->nb_compress_threads++;
-    acb =3D thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
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
--=20
2.21.0


