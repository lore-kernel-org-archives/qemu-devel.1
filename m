Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A544206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A544206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9svc-0002IA-JT
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9rut-0003pD-Im
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9rur-00011T-LE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9run-000103-GX; Mon, 16 Sep 2019 10:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9BD6300D21D;
 Mon, 16 Sep 2019 14:23:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAFC600F8;
 Mon, 16 Sep 2019 14:23:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:45 +0200
Message-Id: <20190916142246.31474-16-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 16 Sep 2019 14:23:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/16] block/qcow2: refactor encryption code
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

From: Maxim Levitsky <mlevitsk@redhat.com>

* Change the qcow2_co_{encrypt|decrypt} to just receive full host and
  guest offsets and use this function directly instead of calling
  do_perform_cow_encrypt (which is removed by that patch).

* Adjust qcow2_co_encdec to take full host and guest offsets as well.

* Document the qcow2_co_{encrypt|decrypt} arguments
  to prevent the bug fixed in former commit from hopefully
  happening again.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190915203655.21638-3-mlevitsk@redhat.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[mreitz: Let perform_cow() return the error value returned by
         qcow2_co_encrypt(), as proposed by Vladimir]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  8 +++---
 block/qcow2-cluster.c | 41 +++++++++-------------------
 block/qcow2-threads.c | 63 +++++++++++++++++++++++++++++++++----------
 block/qcow2.c         |  5 ++--
 4 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 998bcdaef1..a488d761ff 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -758,10 +758,10 @@ ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size);
 int coroutine_fn
-qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len);
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_offset,
+                 uint64_t guest_offset, void *buf, size_t len);
 int coroutine_fn
-qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len);
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_offset,
+                 uint64_t guest_offset, void *buf, size_t len);
=20
 #endif
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cac0b6c7ba..8d5fa1539c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -462,28 +462,6 @@ static int coroutine_fn do_perform_cow_read(BlockDri=
verState *bs,
     return 0;
 }
=20
-static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
-                                                uint64_t src_cluster_off=
set,
-                                                uint64_t cluster_offset,
-                                                unsigned offset_in_clust=
er,
-                                                uint8_t *buffer,
-                                                unsigned bytes)
-{
-    if (bytes && bs->encrypted) {
-        BDRVQcow2State *s =3D bs->opaque;
-        assert(QEMU_IS_ALIGNED(offset_in_cluster, BDRV_SECTOR_SIZE));
-        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
-        assert(s->crypto);
-        if (qcow2_co_encrypt(bs,
-                start_of_cluster(s, cluster_offset + offset_in_cluster),
-                src_cluster_offset + offset_in_cluster,
-                buffer, bytes) < 0) {
-            return false;
-        }
-    }
-    return true;
-}
-
 static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
                                              uint64_t cluster_offset,
                                              unsigned offset_in_cluster,
@@ -891,12 +869,19 @@ static int perform_cow(BlockDriverState *bs, QCowL2=
Meta *m)
=20
     /* Encrypt the data if necessary before writing it */
     if (bs->encrypted) {
-        if (!do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    start->offset, start_buffer,
-                                    start->nb_bytes) ||
-            !do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    end->offset, end_buffer, end->nb_byt=
es)) {
-            ret =3D -EIO;
+        ret =3D qcow2_co_encrypt(bs,
+                               m->alloc_offset + start->offset,
+                               m->offset + start->offset,
+                               start_buffer, start->nb_bytes);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        ret =3D qcow2_co_encrypt(bs,
+                               m->alloc_offset + end->offset,
+                               m->offset + end->offset,
+                               end_buffer, end->nb_bytes);
+        if (ret < 0) {
             goto fail;
         }
     }
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3b1e63fe41..8f5a0d1ebe 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -234,35 +234,70 @@ static int qcow2_encdec_pool_func(void *opaque)
 }
=20
 static int coroutine_fn
-qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
-                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFun=
c func)
+qcow2_co_encdec(BlockDriverState *bs, uint64_t host_offset,
+                uint64_t guest_offset, void *buf, size_t len,
+                Qcow2EncDecFunc func)
 {
     BDRVQcow2State *s =3D bs->opaque;
     Qcow2EncDecData arg =3D {
         .block =3D s->crypto,
-        .offset =3D s->crypt_physical_offset ?
-                      file_cluster_offset + offset_into_cluster(s, offse=
t) :
-                      offset,
+        .offset =3D s->crypt_physical_offset ? host_offset : guest_offse=
t,
         .buf =3D buf,
         .len =3D len,
         .func =3D func,
     };
=20
-    return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
+    assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(len, BDRV_SECTOR_SIZE));
+    assert(s->crypto);
+
+    return len =3D=3D 0 ? 0 : qcow2_co_process(bs, qcow2_encdec_pool_fun=
c, &arg);
 }
=20
+/*
+ * qcow2_co_encrypt()
+ *
+ * Encrypts one or more contiguous aligned sectors
+ *
+ * @host_offset - underlying storage offset of the first sector of the
+ * data to be encrypted
+ *
+ * @guest_offset - guest (virtual) offset of the first sector of the
+ * data to be encrypted
+ *
+ * @buf - buffer with the data to encrypt, that after encryption
+ *        will be written to the underlying storage device at
+ *        @host_offset
+ *
+ * @len - length of the buffer (must be a BDRV_SECTOR_SIZE multiple)
+ *
+ * Depending on the encryption method, @host_offset and/or @guest_offset
+ * may be used for generating the initialization vector for
+ * encryption.
+ *
+ * Note that while the whole range must be aligned on sectors, it
+ * does not have to be aligned on clusters and can also cross cluster
+ * boundaries
+ */
 int coroutine_fn
-qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len)
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_offset,
+                 uint64_t guest_offset, void *buf, size_t len)
 {
-    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
-                             qcrypto_block_encrypt);
+    return qcow2_co_encdec(bs, host_offset, guest_offset, buf, len,
+                           qcrypto_block_encrypt);
 }
=20
+/*
+ * qcow2_co_decrypt()
+ *
+ * Decrypts one or more contiguous aligned sectors
+ * Similar to qcow2_co_encrypt
+ */
 int coroutine_fn
-qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len)
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_offset,
+                 uint64_t guest_offset, void *buf, size_t len)
 {
-    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
-                             qcrypto_block_decrypt);
+    return qcow2_co_encdec(bs, host_offset, guest_offset, buf, len,
+                           qcrypto_block_decrypt);
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index cac18f0ba2..4d16393e61 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2069,7 +2069,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockD=
riverState *bs,
=20
                 assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
                 assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
-                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                if (qcow2_co_decrypt(bs, cluster_offset + offset_in_clus=
ter,
+                                     offset,
                                      cluster_data, cur_bytes) < 0) {
                     ret =3D -EIO;
                     goto fail;
@@ -2288,7 +2289,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
             qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
                               cluster_data, cur_bytes);
=20
-            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+            if (qcow2_co_encrypt(bs, cluster_offset + offset_in_cluster,=
 offset,
                                  cluster_data, cur_bytes) < 0) {
                 ret =3D -EIO;
                 goto out_unlocked;
--=20
2.21.0


