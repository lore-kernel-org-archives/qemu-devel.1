Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB2C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9B320B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9B320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi4g-0006zS-S1
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:47:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoB-0001dk-6r
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVho6-00023n-D0
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnX-0000N9-IR; Tue, 28 May 2019 15:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AFDAC05D419;
	Tue, 28 May 2019 19:29:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD215D6A9;
	Tue, 28 May 2019 19:29:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:34 +0200
Message-Id: <20190528192847.2730-9-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 28 May 2019 19:29:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/21] qcow2: do encryption in threads
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

Do encryption/decryption in threads, like it is already done for
compression. This improves asynchronous encrypted io.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190506142741.41731-9-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  8 ++++++
 block/qcow2-cluster.c |  7 ++---
 block/qcow2-threads.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.c         | 22 +++++----------
 4 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 637552e137..e873ae5d12 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -268,6 +268,8 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
=20
+#define QCOW2_MAX_THREADS 4
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -744,5 +746,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, =
size_t dest_size,
 ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size);
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
=20
 #endif
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a4c878398e..4a929900cf 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -471,13 +471,12 @@ static bool coroutine_fn do_perform_cow_encrypt(Blo=
ckDriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s =3D bs->opaque;
-        int64_t offset =3D (s->crypt_physical_offset ?
-                          (cluster_offset + offset_in_cluster) :
-                          (src_cluster_offset + offset_in_cluster));
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
         assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);
         assert(s->crypto);
-        if (qcrypto_block_encrypt(s->crypto, offset, buffer, bytes, NULL=
) < 0) {
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
=20
 #include "qcow2.h"
 #include "block/thread-pool.h"
-
-#define QCOW2_MAX_THREADS 4
+#include "crypto.h"
=20
 static int coroutine_fn
 qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
@@ -205,3 +204,65 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest=
, size_t dest_size,
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
+    Qcow2EncDecData *data =3D opaque;
+
+    return data->func(data->block, data->offset, data->buf, data->len, N=
ULL);
+}
+
+static int coroutine_fn
+qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
+                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFun=
c func)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    Qcow2EncDecData arg =3D {
+        .block =3D s->crypto,
+        .offset =3D s->crypt_physical_offset ?
+                      file_cluster_offset + offset_into_cluster(s, offse=
t) :
+                      offset,
+        .buf =3D buf,
+        .len =3D len,
+        .func =3D func,
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
index 4b4a0ce6e0..dea765b2f4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -297,7 +297,7 @@ static int qcow2_read_extensions(BlockDriverState *bs=
, uint64_t start_offset,
             }
             s->crypto =3D qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, 1, errp);
+                                           bs, cflags, QCOW2_MAX_THREADS=
, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1538,7 +1538,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
                 cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto =3D qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, 1, errp);
+                                           NULL, NULL, cflags,
+                                           QCOW2_MAX_THREADS, errp);
             if (!s->crypto) {
                 ret =3D -EINVAL;
                 goto fail;
@@ -2061,13 +2062,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDrive=
rState *bs, uint64_t offset,
                 assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-                if (qcrypto_block_decrypt(s->crypto,
-                                          (s->crypt_physical_offset ?
-                                           cluster_offset + offset_in_cl=
uster :
-                                           offset),
-                                          cluster_data,
-                                          cur_bytes,
-                                          NULL) < 0) {
+                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                                     cluster_data, cur_bytes) < 0) {
                     ret =3D -EIO;
                     goto fail;
                 }
@@ -2201,12 +2197,8 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriv=
erState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
=20
-            if (qcrypto_block_encrypt(s->crypto,
-                                      (s->crypt_physical_offset ?
-                                       cluster_offset + offset_in_cluste=
r :
-                                       offset),
-                                      cluster_data,
-                                      cur_bytes, NULL) < 0) {
+            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+                                 cluster_data, cur_bytes) < 0) {
                 ret =3D -EIO;
                 goto out_unlocked;
             }
--=20
2.21.0


