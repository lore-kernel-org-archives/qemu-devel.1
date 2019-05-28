Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A993C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E538C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E538C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdI3-00040O-7x
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:41:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdFj-0002QU-5w
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVdFX-0007tz-0b
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:38:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:46362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdFR-0006uA-PB; Tue, 28 May 2019 10:38:42 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVdEM-0004ye-6p; Tue, 28 May 2019 17:37:34 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 17:37:26 +0300
Message-Id: <20190528143727.10529-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type processing
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the patch, qcow2 is able to process image compression type
defined in the image header and choose the corresponding method
for clusters compressing.

Also, it rework the cluster compression code for adding more
compression types.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/qcow2.c | 103 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c4b5b93408..90f15cc3c9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -400,11 +400,39 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
 
         case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
+            /* Compression type always goes with the compression type bit set */
+            if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
+                error_setg(errp,
+                           "compression_type_ext: "
+                           "expect compression type bit set");
+                return -EINVAL;
+            }
+
+            ret = bdrv_pread(bs->file, offset, &s->compression_type, ext.len);
+            s->compression_type = be32_to_cpu(s->compression_type);
+
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "ERROR: Could not read compression type");
+                return ret;
+            }
+
             /*
-             * Setting compression type to BDRVQcow2State->compression_type
-             * from the image header is going to be here
+             * The default compression type is not allowed when the extension
+             * is present. ZLIB is used as the default compression type.
+             * When compression type extension header is present then
+             * compression_type should have a value different from the default.
              */
-             break;
+            if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
+                error_setg(errp,
+                           "compression_type_ext:"
+                           "invalid compression type %d",
+                           QCOW2_COMPRESSION_TYPE_ZLIB);
+            }
+#ifdef DEBUG_EXT
+            printf("Qcow2: image compression type %s\n", s->compression_type);
+#endif
+            break;
 
         case QCOW2_EXT_MAGIC_DATA_FILE:
         {
@@ -1492,6 +1520,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     QLIST_INIT(&s->cluster_allocs);
     QTAILQ_INIT(&s->discards);
 
+    /* Set default compression type */
+    s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
+
     /* read qcow2 extensions */
     if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
                               flags, &update_header, &local_err)) {
@@ -1500,6 +1531,34 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
+    /*
+     * The compression type is set on the extension header processing
+     * if the compression type extension header is present.
+     * When the compression type is different from ZLIB (default) there
+     * should be both the compression type bit and the compression
+     * type extension header set. When the ZLIB (default) compression
+     * type is used there should be neither the compression type bit nor
+     * the compression type extension header set.
+     */
+
+    if ((s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE) &
+        (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB)) {
+        error_setg(errp, "Illegal compression type setting");
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Check available compression types */
+    switch (s->compression_type) {
+    case QCOW2_COMPRESSION_TYPE_ZLIB:
+        break;
+
+    default:
+        error_setg(errp, "Unknown compression type");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* Open external data file */
     s->data_file = bdrv_open_child(NULL, options, "data-file", bs, &child_file,
                                    true, &local_err);
@@ -3970,7 +4029,7 @@ fail:
 }
 
 /*
- * qcow2_compress()
+ * zlib_compress()
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
@@ -3979,7 +4038,7 @@ fail:
  *          -1 destination buffer is not enough to store compressed data
  *          -2 on any other error
  */
-static ssize_t qcow2_compress(void *dest, size_t dest_size,
+static ssize_t zlib_compress(void *dest, size_t dest_size,
                               const void *src, size_t src_size)
 {
     ssize_t ret;
@@ -4013,7 +4072,7 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
 }
 
 /*
- * qcow2_decompress()
+ * zlib_decompress()
  *
  * Decompress some data (not more than @src_size bytes) to produce exactly
  * @dest_size bytes.
@@ -4024,7 +4083,7 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
  * Returns: 0 on success
  *          -1 on fail
  */
-static ssize_t qcow2_decompress(void *dest, size_t dest_size,
+static ssize_t zlib_decompress(void *dest, size_t dest_size,
                                 const void *src, size_t src_size)
 {
     int ret = 0;
@@ -4122,16 +4181,38 @@ static ssize_t coroutine_fn
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
+        fn = zlib_compress;
+        break;
+
+    default:
+        return -ENOTSUP;
+    }
+
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
 }
 
 static ssize_t coroutine_fn
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
+        fn = zlib_decompress;
+        break;
+
+    default:
+        return -ENOTSUP;
+    }
+
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn);
 }
 
 /* XXX: put compressed sectors first, then all the cluster aligned
-- 
2.17.0


