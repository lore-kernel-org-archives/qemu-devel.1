Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD59FC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F79D206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F79D206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQP3-0006VL-9F
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTQNd-0004ea-Ds
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTQNZ-0007Ex-8U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:34:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:53530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTQNY-0007Dd-0H; Tue, 28 Apr 2020 09:34:28 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTQNN-0005fy-WD; Tue, 28 Apr 2020 16:34:18 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v21 2/4] qcow2: rework the cluster compression routine
Date: Tue, 28 Apr 2020 16:34:05 +0300
Message-Id: <20200428133407.10657-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200428133407.10657-1-dplotnikov@virtuozzo.com>
References: <20200428133407.10657-1-dplotnikov@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=dplotnikov@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:34:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch enables processing the image compression type defined
for the image and chooses an appropriate method for image clusters
(de)compression.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-threads.c | 71 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index a68126f291..7dbaf53489 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -74,7 +74,9 @@ typedef struct Qcow2CompressData {
 } Qcow2CompressData;
 
 /*
- * qcow2_compress()
+ * qcow2_zlib_compress()
+ *
+ * Compress @src_size bytes of data using zlib compression method
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
@@ -83,8 +85,8 @@ typedef struct Qcow2CompressData {
  *          -ENOMEM destination buffer is not enough to store compressed data
  *          -EIO    on any other error
  */
-static ssize_t qcow2_compress(void *dest, size_t dest_size,
-                              const void *src, size_t src_size)
+static ssize_t qcow2_zlib_compress(void *dest, size_t dest_size,
+                                   const void *src, size_t src_size)
 {
     ssize_t ret;
     z_stream strm;
@@ -119,10 +121,10 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
 }
 
 /*
- * qcow2_decompress()
+ * qcow2_zlib_decompress()
  *
  * Decompress some data (not more than @src_size bytes) to produce exactly
- * @dest_size bytes.
+ * @dest_size bytes using zlib compression method
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
@@ -130,8 +132,8 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
  * Returns: 0 on success
  *          -EIO on fail
  */
-static ssize_t qcow2_decompress(void *dest, size_t dest_size,
-                                const void *src, size_t src_size)
+static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size)
 {
     int ret;
     z_stream strm;
@@ -191,20 +193,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
     return arg.ret;
 }
 
+/*
+ * qcow2_co_compress()
+ *
+ * Compress @src_size bytes of data using the compression
+ * method defined by the image compression type
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: compressed size on success
+ *          a negative error code on failure
+ */
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                   const void *src, size_t src_size)
 {
-    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
-                                qcow2_compress);
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2CompressFunc fn;
+
+    switch (s->compression_type) {
+    case QCOW2_COMPRESSION_TYPE_ZLIB:
+        fn = qcow2_zlib_compress;
+        break;
+
+    default:
+        abort();
+    }
+
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
 }
 
+/*
+ * qcow2_co_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exactly
+ * @dest_size bytes using the compression method defined by the image
+ * compression type
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: 0 on success
+ *          a negative error code on failure
+ */
 ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size)
 {
-    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
-                                qcow2_decompress);
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2CompressFunc fn;
+
+    switch (s->compression_type) {
+    case QCOW2_COMPRESSION_TYPE_ZLIB:
+        fn = qcow2_zlib_decompress;
+        break;
+
+    default:
+        abort();
+    }
+
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
 }
 
 
-- 
2.17.0


