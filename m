Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF80C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30C7206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30C7206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Xr5-0008FX-OF
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Xj3-0007P5-Qd
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Xj2-000162-I5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8Xiz-00012m-LA; Thu, 12 Sep 2019 18:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F149F8AC6F6;
 Thu, 12 Sep 2019 22:38:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6025D704;
 Thu, 12 Sep 2019 22:37:58 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:37:52 +0300
Message-Id: <20190912223754.875-2-mlevitsk@redhat.com>
In-Reply-To: <20190912223754.875-1-mlevitsk@redhat.com>
References: <20190912223754.875-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 22:38:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/3] block/qcow2: refactoring of threaded
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
 block/qcow2-cluster.c |  8 +++---
 block/qcow2-threads.c | 63 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f09cc992af..b95e64c237 100644
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
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3b1e63fe41..6da1838e95 100644
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
@@ -251,18 +255,51 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
     return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
 }
 
+
+/*
+ * qcow2_co_encrypt()
+ *
+ * Encrypts one or more contiguous aligned sectors
+ *
+ * @host_cluster_offset - underlying storage offset of the first cluster
+ * in which the encrypted data will be written
+ * Used as an initialization vector for encryption
+ *
+ * @guest_offset - guest (virtual) offset of the first sector of the
+ * data to be encrypted
+ * Used as an initialization vector for older, qcow2 native encryption
+ *
+ * @buf - buffer with the data to encrypt, that after encryption
+ *        will be written to the underlying storage device at
+ *        @host_cluster_offset
+ *
+ * @len - length of the buffer (in sector size multiplies)
+ *
+ * Note that the group of the sectors, don't have to be aligned
+ * on cluster boundary and can also cross a cluster boundary.
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
+ * Similar to qcow2_co_encrypt
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


