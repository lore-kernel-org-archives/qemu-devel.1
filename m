Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13E022DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13E022DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xXC-0002Gk-Gi
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i2xVb-0000rC-0C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i2xVZ-0000gR-4s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:57:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:44822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i2xVY-0000fC-QF; Wed, 28 Aug 2019 08:57:04 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i2xVV-0006aK-PI; Wed, 28 Aug 2019 15:57:02 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 15:56:53 +0300
Message-Id: <20190828125654.10544-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190828125654.10544-1-dplotnikov@virtuozzo.com>
References: <20190828125654.10544-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 2/3] qcow2: rework the cluster compression
 routine
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch allow to process image compression type defined
in the image header and choose an appropriate method for
image clusters (de)compression.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2-threads.c | 78 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3b1e63fe41..14b5bd76fb 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -73,8 +73,11 @@ typedef struct Qcow2CompressData {
     Qcow2CompressFunc func;
 } Qcow2CompressData;
 
+
 /*
- * qcow2_compress()
+ * qcow2_zlib_compress()
+ *
+ * Compress @src_size bytes of data using zlib compression method
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
@@ -83,8 +86,8 @@ typedef struct Qcow2CompressData {
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
@@ -119,19 +122,19 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
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
  *
  * Returns: 0 on success
- *          -1 on fail
+ *          -EIO on fail
  */
-static ssize_t qcow2_decompress(void *dest, size_t dest_size,
-                                const void *src, size_t src_size)
+static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size)
 {
     int ret = 0;
     z_stream strm;
@@ -144,7 +147,7 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
 
     ret = inflateInit2(&strm, -12);
     if (ret != Z_OK) {
-        return -1;
+        return -EIO;
     }
 
     ret = inflate(&strm, Z_FINISH);
@@ -154,7 +157,7 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
          * @src buffer may be processed partly (because in qcow2 we know size of
          * compressed data with precision of one sector)
          */
-        ret = -1;
+        ret = -EIO;
     }
 
     inflateEnd(&strm);
@@ -189,20 +192,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
+ * Returns: 0 on success
+ *          a negative error code on fail
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
+        return -ENOTSUP;
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
+ *          a negative error code on fail
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
+        return -ENOTSUP;
+    }
+
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
 }
 
 
-- 
2.17.0


