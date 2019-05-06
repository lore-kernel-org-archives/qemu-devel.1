Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EAC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC14021479
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC14021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNehF-0003Nz-80
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:34:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeaq-0006P5-9W
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNeao-0000cS-OC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:27:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:45614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeao-0000bh-Ek; Mon, 06 May 2019 10:27:46 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hNeal-000444-Kd; Mon, 06 May 2019 17:27:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  6 May 2019 17:27:41 +0300
Message-Id: <20190506142741.41731-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190506142741.41731-1-vsementsov@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 8/8] qcow2: do encryption in threads
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

Do encryption/decryption in threads, like it is already done for
compression. This improves asynchronous encrypted io.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  8 ++++++
 block/qcow2-cluster.c |  7 ++---
 block/qcow2-threads.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.c         | 22 +++++----------
 4 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 3089e9a68b..5169c0d8ab 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -264,6 +264,8 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+#define QCOW2_MAX_THREADS 4
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -741,5 +743,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
 ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size);
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
 
 #endif
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index c4965479f6..e6624c6e4e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -471,13 +471,12 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        int64_t offset = (s->crypt_physical_offset ?
-                          (cluster_offset + offset_in_cluster) :
-                          (src_cluster_offset + offset_in_cluster));
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         assert(s->crypto);
-        if (qcrypto_block_encrypt(s->crypto, offset, buffer, bytes, NULL) < 0) {
+        if (qcow2_co_encrypt(bs, cluster_offset,
+                             src_cluster_offset + offset_in_cluster,
+                             buffer, bytes) < 0) {
             return false;
         }
     }
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 650aa2ed19..3b1e63fe41 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -30,8 +30,7 @@
 
 #include "qcow2.h"
 #include "block/thread-pool.h"
-
-#define QCOW2_MAX_THREADS 4
+#include "crypto.h"
 
 static int coroutine_fn
 qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
@@ -205,3 +204,65 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
     return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
                                 qcow2_decompress);
 }
+
+
+/*
+ * Cryptography
+ */
+
+/*
+ * Qcow2EncDecFunc: common prototype of qcrypto_block_encrypt() and
+ * qcrypto_block_decrypt() functions.
+ */
+typedef int (*Qcow2EncDecFunc)(QCryptoBlock *block, uint64_t offset,
+                               uint8_t *buf, size_t len, Error **errp);
+
+typedef struct Qcow2EncDecData {
+    QCryptoBlock *block;
+    uint64_t offset;
+    uint8_t *buf;
+    size_t len;
+
+    Qcow2EncDecFunc func;
+} Qcow2EncDecData;
+
+static int qcow2_encdec_pool_func(void *opaque)
+{
+    Qcow2EncDecData *data = opaque;
+
+    return data->func(data->block, data->offset, data->buf, data->len, NULL);
+}
+
+static int coroutine_fn
+qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
+                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2EncDecData arg = {
+        .block = s->crypto,
+        .offset = s->crypt_physical_offset ?
+                      file_cluster_offset + offset_into_cluster(s, offset) :
+                      offset,
+        .buf = buf,
+        .len = len,
+        .func = func,
+    };
+
+    return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
+}
+
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_encrypt);
+}
+
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_decrypt);
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index cba2328005..dee3b8cca3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -297,7 +297,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, 1, errp);
+                                           bs, cflags, QCOW2_MAX_THREADS, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1539,7 +1539,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, 1, errp);
+                                           NULL, NULL, cflags,
+                                           QCOW2_MAX_THREADS, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
@@ -2062,13 +2063,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcrypto_block_decrypt(s->crypto,
-                                          (s->crypt_physical_offset ?
-                                           cluster_offset + offset_in_cluster :
-                                           offset),
-                                          cluster_data,
-                                          cur_bytes,
-                                          NULL) < 0) {
+                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                                     cluster_data, cur_bytes) < 0) {
                     ret = -EIO;
                     goto fail;
                 }
@@ -2202,12 +2198,8 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
-            if (qcrypto_block_encrypt(s->crypto,
-                                      (s->crypt_physical_offset ?
-                                       cluster_offset + offset_in_cluster :
-                                       offset),
-                                      cluster_data,
-                                      cur_bytes, NULL) < 0) {
+            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+                                 cluster_data, cur_bytes) < 0) {
                 ret = -EIO;
                 goto out_unlocked;
             }
-- 
2.18.0


