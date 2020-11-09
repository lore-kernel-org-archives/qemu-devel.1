Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA16A20731
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA16A20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3EO-0008Li-LH
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3B0-0004Ut-HH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Aw-0006yv-U9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CV4tX5ZBWzhjCR;
 Mon,  9 Nov 2020 17:09:08 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:09:02 +0800
From: Zeyu Jin <jinzeyu@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 2/6] migration: Refactoring multi-thread compress migration
Date: Mon, 9 Nov 2020 17:08:46 +0800
Message-ID: <20201109090850.2424-3-jinzeyu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109090850.2424-1-jinzeyu@huawei.com>
References: <20201109090850.2424-1-jinzeyu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=jinzeyu@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:09:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 Zeyu Jin <jinzeyu@huawei.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code refactor for the compression procedure which includes:

1. Move qemu_compress_data and qemu_put_compression_data from qemu-file.c to
ram.c, for the reason that most part of the code logical has nothing to do
with qemu-file. Besides, the decompression code is located at ram.c only.

2. Simplify the function input arguments for compression and decompression.
Wrap the input into the param structure which already exists. This change also
makes the function much more flexible for other compression methods.

Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/qemu-file.c | 62 ++++++-------------------------
 migration/qemu-file.h |  4 +-
 migration/ram.c       | 86 ++++++++++++++++++++++++++++++-------------
 3 files changed, 75 insertions(+), 77 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index be21518c57..1efb667aa1 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -737,56 +737,6 @@ uint64_t qemu_get_be64(QEMUFile *f)
     return v;
 }
 
-/* return the size after compression, or negative value on error */
-static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                              const uint8_t *source, size_t source_len)
-{
-    int err;
-
-    err = deflateReset(stream);
-    if (err != Z_OK) {
-        return -1;
-    }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = deflate(stream, Z_FINISH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->next_out - dest;
-}
-
-/* Compress size bytes of data start at p and store the compressed
- * data to the buffer of f.
- *
- * Since the file is dummy file with empty_ops, return -1 if f has no space to
- * save the compressed data.
- */
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
-                                  const uint8_t *p, size_t size)
-{
-    ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
-
-    if (blen < compressBound(size)) {
-        return -1;
-    }
-
-    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
-                              blen, p, size);
-    if (blen < 0) {
-        return -1;
-    }
-
-    qemu_put_be32(f, blen);
-    add_buf_to_iovec(f, blen);
-    return blen + sizeof(int32_t);
-}
-
 /* Put the data in the buffer of f_src to the buffer of f_des, and
  * then reset the buf_index of f_src to 0.
  */
@@ -846,3 +796,15 @@ void qemu_file_set_blocking(QEMUFile *f, bool block)
         f->ops->set_blocking(f->opaque, block, NULL);
     }
 }
+
+ssize_t qemu_put_compress_start(QEMUFile *f, uint8_t **dest_ptr)
+{
+    *dest_ptr = f->buf + f->buf_index + sizeof(int32_t);
+    return IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
+}
+
+void qemu_put_compress_end(QEMUFile *f, unsigned int v)
+{
+    qemu_put_be32(f, v);
+    add_buf_to_iovec(f, v);
+}
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a9b6d6ccb7..1ac1566460 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -138,8 +138,6 @@ bool qemu_file_is_writable(QEMUFile *f);
 
 size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset);
 size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size);
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
-                                  const uint8_t *p, size_t size);
 int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
 
 /*
@@ -166,6 +164,8 @@ void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
 
+ssize_t qemu_put_compress_start(QEMUFile *f, uint8_t **dest_ptr);
+void qemu_put_compress_end(QEMUFile *f, unsigned int v);
 /* Whenever this is found in the data stream, the flags
  * will be passed to ram_control_load_hook in the incoming-migration
  * side. This lets before_ram_iterate/after_ram_iterate add
diff --git a/migration/ram.c b/migration/ram.c
index 2da2b622ab..75504540c9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -453,27 +453,22 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                 ram_addr_t offset, uint8_t *source_buf);
+static bool do_compress_ram_page(CompressParam *param, RAMBlock *block);
 
 static void *do_data_compress(void *opaque)
 {
     CompressParam *param = opaque;
     RAMBlock *block;
-    ram_addr_t offset;
     bool zero_page;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
         if (param->block) {
             block = param->block;
-            offset = param->offset;
             param->block = NULL;
             qemu_mutex_unlock(&param->mutex);
 
-            zero_page = do_compress_ram_page(param->file, &param->stream,
-                                             block, offset, param->originbuf);
-
+            zero_page = do_compress_ram_page(param, block);
             qemu_mutex_lock(&comp_done_lock);
             param->done = true;
             param->zero_page = zero_page;
@@ -1214,28 +1209,73 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
     return 1;
 }
 
-static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                 ram_addr_t offset, uint8_t *source_buf)
+/*
+ * Compress size bytes of data start at p and store the compressed
+ * data to the buffer of f.
+ *
+ * Since the file is dummy file with empty_ops, return -1 if f has no space to
+ * save the compressed data.
+ */
+static ssize_t qemu_put_compression_data(CompressParam *param, size_t size)
+{
+    int err;
+    uint8_t *dest = NULL;
+    z_stream *stream = &param->stream;
+    uint8_t *p = param->originbuf;
+    QEMUFile *f = f = param->file;
+    ssize_t blen = qemu_put_compress_start(f, &dest);
+
+    if (blen < compressBound(size)) {
+        return -1;
+    }
+
+    err = deflateReset(stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = size;
+    stream->next_in = p;
+    stream->avail_out = blen;
+    stream->next_out = dest;
+
+    err = deflate(stream, Z_FINISH);
+    if (err != Z_STREAM_END) {
+        return -1;
+    }
+
+    blen = stream->next_out - dest;
+    if (blen < 0) {
+        return -1;
+    }
+
+    qemu_put_compress_end(f, blen);
+    return blen + sizeof(int32_t);
+}
+
+static bool do_compress_ram_page(CompressParam *param, RAMBlock *block)
 {
     RAMState *rs = ram_state;
+    ram_addr_t offset = param->offset;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
     bool zero_page = false;
     int ret;
 
-    if (save_zero_page_to_file(rs, f, block, offset)) {
+    if (save_zero_page_to_file(rs, param->file, block, offset)) {
         zero_page = true;
         goto exit;
     }
 
-    save_page_header(rs, f, block, offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
+    save_page_header(rs, param->file, block,
+                         offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
 
     /*
      * copy it to a internal buffer to avoid it being modified by VM
      * so that we can catch up the error during compression and
      * decompression
      */
-    memcpy(source_buf, p, TARGET_PAGE_SIZE);
-    ret = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
+    memcpy(param->originbuf, p, TARGET_PAGE_SIZE);
+    ret = qemu_put_compression_data(param, TARGET_PAGE_SIZE);
     if (ret < 0) {
         qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
         error_report("compressed data failed!");
@@ -2826,19 +2866,20 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
 
 /* return the size after decompression, or negative value on error */
 static int
-qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                     const uint8_t *source, size_t source_len)
+qemu_uncompress_data(DecompressParam *param, uint8_t *dest, size_t pagesize)
 {
     int err;
 
+    z_stream *stream = &param->stream;
+
     err = inflateReset(stream);
     if (err != Z_OK) {
         return -1;
     }
 
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
+    stream->avail_in = param->len;
+    stream->next_in = param->compbuf;
+    stream->avail_out = pagesize;
     stream->next_out = dest;
 
     err = inflate(stream, Z_NO_FLUSH);
@@ -2852,22 +2893,17 @@ qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
 static void *do_data_decompress(void *opaque)
 {
     DecompressParam *param = opaque;
-    unsigned long pagesize;
     uint8_t *des;
-    int len, ret;
+    int ret;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
         if (param->des) {
             des = param->des;
-            len = param->len;
             param->des = 0;
             qemu_mutex_unlock(&param->mutex);
 
-            pagesize = TARGET_PAGE_SIZE;
-
-            ret = qemu_uncompress_data(&param->stream, des, pagesize,
-                                       param->compbuf, len);
+            ret = qemu_uncompress_data(param, des, TARGET_PAGE_SIZE);
             if (ret < 0 && migrate_get_current()->decompress_error_check) {
                 error_report("decompress data failed");
                 qemu_file_set_error(decomp_file, ret);
-- 
2.23.0


