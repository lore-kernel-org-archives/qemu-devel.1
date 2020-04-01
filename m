Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC9C2D0F3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD652078C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD652078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeVn-0005ZD-OT
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJeUp-0004B3-Rv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJeUo-0005gm-DT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:37:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:44978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJeUo-0005df-68; Wed, 01 Apr 2020 10:37:34 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJeUg-0005CS-Ac; Wed, 01 Apr 2020 17:37:26 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v16 2/4] qcow2: rework the cluster compression routine
Date: Wed,  1 Apr 2020 17:37:17 +0300
Message-Id: <20200401143719.21639-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
References: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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


