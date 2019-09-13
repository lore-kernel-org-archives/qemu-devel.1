Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9272C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7B820693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7B820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nad-0007He-Gh
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nV4-0001UH-RX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nV3-0004ku-83
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8nUu-0004h8-A3; Fri, 13 Sep 2019 11:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76C79308FBA9;
 Fri, 13 Sep 2019 15:28:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA405B681;
 Fri, 13 Sep 2019 15:28:29 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 18:28:17 +0300
Message-Id: <20190913152818.17843-3-mlevitsk@redhat.com>
In-Reply-To: <20190913152818.17843-1-mlevitsk@redhat.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 13 Sep 2019 15:28:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 2/3] block/qcow2: refactor threaded
 encryption code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change do_perform_cow_encrypt and its callee qcow2_co_encrypt
to just receive full host and guest offsets and in pariticular
remove the offset_in_cluster parameter of do_perform_cow_encrypt,
since it is misleading, because that offset can be larger than
cluster size currently.

Also document the qcow2_co_encrypt arguments to prevent
that bug from happening again

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2-cluster.c | 30 ++++++++++++---------
 block/qcow2-threads.c | 62 ++++++++++++++++++++++++++++++++++---------
 block/qcow2.c         |  5 ++--
 block/qcow2.h         |  8 +++---
 4 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index bfeb0241d7..e87a4637fd 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -463,21 +463,21 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
 }
 
 static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
-                                                uint64_t src_cluster_offset,
-                                                uint64_t cluster_offset,
-                                                unsigned offset_in_cluster,
+                                                uint64_t guest_offset,
+                                                uint64_t host_offset,
                                                 uint8_t *buffer,
                                                 unsigned bytes)
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
-        assert((bytes & ~BDRV_SECTOR_MASK) == 0);
+
+        assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
         assert(s->crypto);
-        if (qcow2_co_encrypt(bs,
-                start_of_cluster(s, cluster_offset + offset_in_cluster),
-                src_cluster_offset + offset_in_cluster,
-                buffer, bytes) < 0) {
+
+        if (qcow2_co_encrypt(bs, host_offset, guest_offset,
+            buffer, bytes) < 0) {
             return false;
         }
     }
@@ -891,11 +891,15 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
 
     /* Encrypt the data if necessary before writing it */
     if (bs->encrypted) {
-        if (!do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    start->offset, start_buffer,
+        if (!do_perform_cow_encrypt(bs,
+                                    m->offset + start->offset,
+                                    m->alloc_offset + start->offset,
+                                    start_buffer,
                                     start->nb_bytes) ||
-            !do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    end->offset, end_buffer, end->nb_bytes)) {
+            !do_perform_cow_encrypt(bs,
+                                    m->offset + end->offset,
+                                    m->alloc_offset + end->offset,
+                                    end_buffer, end->nb_bytes)) {
             ret = -EIO;
             goto fail;
         }
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3b1e63fe41..9646243a9b 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -234,15 +234,15 @@ static int qcow2_encdec_pool_func(void *opaque)
 }
 
 static int coroutine_fn
-qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
-                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
+qcow2_co_encdec(BlockDriverState *bs, uint64_t host_offset,
+                uint64_t guest_offset, void *buf, size_t len,
+                Qcow2EncDecFunc func)
 {
     BDRVQcow2State *s = bs->opaque;
+
     Qcow2EncDecData arg = {
         .block = s->crypto,
-        .offset = s->crypt_physical_offset ?
-                      file_cluster_offset + offset_into_cluster(s, offset) :
-                      offset,
+        .offset = s->crypt_physical_offset ? host_offset : guest_offset,
         .buf = buf,
         .len = len,
         .func = func,
@@ -251,18 +251,54 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
     return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
 }
 
+
+/*
+ * qcow2_co_encrypt()
+ *
+ * Encrypts one or more contiguous aligned sectors
+ *
+ * @host_offset - underlying storage offset of the first sector of the
+ * data to be encrypted
+
+ * @guest_offset - guest (virtual) offset of the first sector of the
+ * data to be encrypted
+ *
+ * @buf - buffer with the data to encrypt, that after encryption
+ *        will be written to the underlying storage device at
+ *        @host_offset
+ *
+ * @len - length of the buffer (must be a BDRV_SECTOR_SIZE multiple)
+ *
+ * Depending on the encryption method, @host_cluster_offset and/or @guest_offset
+ * may be used for generating the initialization vector for
+ * encryption.
+ *
+ * Note that while the whole range must be aligned on sectors, it
+ * does not have to be aligned on clusters and can also cross cluster
+ * boundaries
+ *
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
 
+
+/*
+ * qcow2_co_decrypt()
+ *
+ * Decrypts one or more contiguous aligned sectors
+ * Similar to qcow2_co_encrypt
+ *
+ */
+
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
index 57734f20cf..ac768092bb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2069,7 +2069,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                if (qcow2_co_decrypt(bs, cluster_offset + offset_in_cluster,
+                                     offset,
                                      cluster_data, cur_bytes) < 0) {
                     ret = -EIO;
                     goto fail;
@@ -2288,7 +2289,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
             qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
                               cluster_data, cur_bytes);
 
-            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+            if (qcow2_co_encrypt(bs, cluster_offset + offset_in_cluster, offset,
                                  cluster_data, cur_bytes) < 0) {
                 ret = -EIO;
                 goto out_unlocked;
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
 
 #endif
-- 
2.17.2


