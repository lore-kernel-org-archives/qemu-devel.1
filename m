Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3038C00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3F2186A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6KOv-0004fV-LC
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KMs-0002vw-Lf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KMr-0003O8-CL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6KMo-0003Jo-JK; Fri, 06 Sep 2019 15:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC75B30917AF;
 Fri,  6 Sep 2019 19:57:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9678560BF1;
 Fri,  6 Sep 2019 19:57:55 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 22:57:48 +0300
Message-Id: <20190906195750.17651-2-mlevitsk@redhat.com>
In-Reply-To: <20190906195750.17651-1-mlevitsk@redhat.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 06 Sep 2019 19:57:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/3] block/qcow2: refactoring of threaded
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

This commit tries to clarify few function arguments,
and add comments describing the encrypt/decrypt interface

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2-cluster.c | 10 +++----
 block/qcow2-threads.c | 61 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f09cc992af..1989b423da 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -463,8 +463,8 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
 }
 
 static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
-                                                uint64_t src_cluster_offset,
-                                                uint64_t cluster_offset,
+                                                uint64_t guest_cluster_offset,
+                                                uint64_t host_cluster_offset,
                                                 unsigned offset_in_cluster,
                                                 uint8_t *buffer,
                                                 unsigned bytes)
@@ -474,8 +474,8 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         assert(s->crypto);
-        if (qcow2_co_encrypt(bs, cluster_offset,
-                             src_cluster_offset + offset_in_cluster,
+        if (qcow2_co_encrypt(bs, host_cluster_offset,
+                             guest_cluster_offset + offset_in_cluster,
                              buffer, bytes) < 0) {
             return false;
         }
@@ -496,7 +496,7 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
     }
 
     ret = qcow2_pre_write_overlap_check(bs, 0,
-            cluster_offset + offset_in_cluster, qiov->size, true);
+              cluster_offset + offset_in_cluster, qiov->size, true);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3b1e63fe41..c3cda0c6a5 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
 }
 
 static int coroutine_fn
-qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
-                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
+qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
+                uint64_t guest_offset, void *buf, size_t len,
+                Qcow2EncDecFunc func)
 {
     BDRVQcow2State *s = bs->opaque;
+
+    uint64_t offset = s->crypt_physical_offset ?
+        host_cluster_offset + offset_into_cluster(s, guest_offset) :
+        guest_offset;
+
     Qcow2EncDecData arg = {
         .block = s->crypto,
-        .offset = s->crypt_physical_offset ?
-                      file_cluster_offset + offset_into_cluster(s, offset) :
-                      offset,
+        .offset = offset,
         .buf = buf,
         .len = len,
         .func = func,
@@ -251,18 +255,49 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
     return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
 }
 
+
+/*
+ * qcow2_co_encrypt()
+ *
+ * Encrypts one or more contiguous aligned sectors
+ *
+ * @host_cluster_offset - on disk offset of the first cluster in which
+ * the encrypted data will be written
+ * Used as an initialization vector for encryption
+ *
+ * @guest_offset - guest (virtual) offset of the first sector of the
+ * data to be encrypted
+ * Used as an initialization vector for older, qcow2 native encryption
+ *
+ * @buf - buffer with the data to encrypt
+ * @len - length of the buffer (in sector size multiplies)
+ *
+ * Note that the group of the sectors, don't have to be aligned
+ * on cluster boundary and can also cross a cluster boundary.
+ *
+ *
+ */
 int coroutine_fn
-qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len)
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
+                 uint64_t guest_offset, void *buf, size_t len)
 {
-    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
-                             qcrypto_block_encrypt);
+    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
+                           qcrypto_block_encrypt);
 }
 
+
+/*
+ * qcow2_co_decrypt()
+ *
+ * Decrypts one or more contiguous aligned sectors
+ * Same function as qcow2_co_encrypt
+ *
+ */
+
 int coroutine_fn
-qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
-                 uint64_t offset, void *buf, size_t len)
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
+                 uint64_t guest_offset, void *buf, size_t len)
 {
-    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
-                             qcrypto_block_decrypt);
+    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf, len,
+                           qcrypto_block_decrypt);
 }
-- 
2.17.2


