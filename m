Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176M-0000sj-JX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176L-0004zo-61
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:38 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176K-0004zO-U4
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:37 -0400
Received: by mail-pl0-x244.google.com with SMTP id 9-v6so1196446ple.11
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:36 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:37 +0800
Message-Id: <20180327091043.30220-5-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 04/10] migration: detect compression and
 decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently the page being compressed is allowed to be updated by
the VM on the source QEMU, correspondingly the destination QEMU
just ignores the decompression error. However, we completely miss
the chance to catch real errors, then the VM is corrupted silently

To make the migration more robuster, we copy the page to a buffer
first to avoid it being written by VM, then detect and handle the
errors of both compression and decompression errors properly

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/qemu-file.c |  4 ++--
 migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e924cc23c5..a7614e8c28 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -710,9 +710,9 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
                               blen, p, size);
     if (blen < 0) {
-        error_report("Compress Failed!");
-        return 0;
+        return -1;
     }
+
     qemu_put_be32(f, blen);
     if (f->ops->writev_buffer) {
         add_to_iovec(f, f->buf + f->buf_index, blen, false);
diff --git a/migration/ram.c b/migration/ram.c
index 6b699650ca..e85191c1cb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -269,7 +269,10 @@ struct CompressParam {
     QemuCond cond;
     RAMBlock *block;
     ram_addr_t offset;
+
+    /* internally used fields */
     z_stream stream;
+    uint8_t *originbuf;
 };
 typedef struct CompressParam CompressParam;
 
@@ -278,6 +281,7 @@ struct DecompressParam {
     bool quit;
     QemuMutex mutex;
     QemuCond cond;
+    QEMUFile *file;
     void *des;
     uint8_t *compbuf;
     int len;
@@ -302,7 +306,7 @@ static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
 static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset);
+                                ram_addr_t offset, uint8_t *source_buf);
 
 static void *do_data_compress(void *opaque)
 {
@@ -318,7 +322,8 @@ static void *do_data_compress(void *opaque)
             param->block = NULL;
             qemu_mutex_unlock(&param->mutex);
 
-            do_compress_ram_page(param->file, &param->stream, block, offset);
+            do_compress_ram_page(param->file, &param->stream, block, offset,
+                                 param->originbuf);
 
             qemu_mutex_lock(&comp_done_lock);
             param->done = true;
@@ -372,6 +377,7 @@ static void compress_threads_save_cleanup(void)
         qemu_mutex_destroy(&comp_param[i].mutex);
         qemu_cond_destroy(&comp_param[i].cond);
         deflateEnd(&comp_param[i].stream);
+        g_free(comp_param[i].originbuf);
         comp_param[i].stream.opaque = NULL;
     }
     qemu_mutex_destroy(&comp_done_lock);
@@ -395,8 +401,14 @@ static int compress_threads_save_setup(void)
     qemu_cond_init(&comp_done_cond);
     qemu_mutex_init(&comp_done_lock);
     for (i = 0; i < thread_count; i++) {
+        comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
+        if (!comp_param[i].originbuf) {
+            goto exit;
+        }
+
         if (deflateInit(&comp_param[i].stream,
                            migrate_compress_level()) != Z_OK) {
+            g_free(comp_param[i].originbuf);
             goto exit;
         }
         comp_param[i].stream.opaque = &comp_param[i];
@@ -1055,7 +1067,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 }
 
 static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset)
+                                ram_addr_t offset, uint8_t *source_buf)
 {
     RAMState *rs = ram_state;
     int bytes_sent, blen;
@@ -1063,7 +1075,14 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
 
     bytes_sent = save_page_header(rs, f, block, offset |
                                   RAM_SAVE_FLAG_COMPRESS_PAGE);
-    blen = qemu_put_compression_data(f, stream, p, TARGET_PAGE_SIZE);
+
+    /*
+     * copy it to a internal buffer to avoid it being modified by VM
+     * so that we can catch up the error during compression and
+     * decompression
+     */
+    memcpy(source_buf, p, TARGET_PAGE_SIZE);
+    blen = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
     if (blen < 0) {
         bytes_sent = 0;
         qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
@@ -2557,7 +2576,7 @@ static void *do_data_decompress(void *opaque)
     DecompressParam *param = opaque;
     unsigned long pagesize;
     uint8_t *des;
-    int len;
+    int len, ret;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -2568,13 +2587,13 @@ static void *do_data_decompress(void *opaque)
             qemu_mutex_unlock(&param->mutex);
 
             pagesize = TARGET_PAGE_SIZE;
-            /* qemu_uncompress_data() will return failed in some case,
-             * especially when the page is dirtied when doing the compression,
-             * it's not a problem because the dirty page will be retransferred
-             * and uncompress() won't break the data in other pages.
-             */
-            qemu_uncompress_data(&param->stream, des, pagesize, param->compbuf,
-                                 len);
+
+            ret = qemu_uncompress_data(&param->stream, des, pagesize,
+                                       param->compbuf, len);
+            if (ret < 0) {
+                error_report("decompress data failed");
+                qemu_file_set_error(param->file, ret);
+            }
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2591,12 +2610,12 @@ static void *do_data_decompress(void *opaque)
     return NULL;
 }
 
-static void wait_for_decompress_done(void)
+static int wait_for_decompress_done(QEMUFile *f)
 {
     int idx, thread_count;
 
     if (!migrate_use_compression()) {
-        return;
+        return 0;
     }
 
     thread_count = migrate_decompress_threads();
@@ -2607,6 +2626,7 @@ static void wait_for_decompress_done(void)
         }
     }
     qemu_mutex_unlock(&decomp_done_lock);
+    return qemu_file_get_error(f);
 }
 
 static void compress_threads_load_cleanup(void)
@@ -2646,7 +2666,7 @@ static void compress_threads_load_cleanup(void)
     decomp_param = NULL;
 }
 
-static int compress_threads_load_setup(void)
+static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
 
@@ -2665,6 +2685,7 @@ static int compress_threads_load_setup(void)
         }
         decomp_param[i].stream.opaque = &decomp_param[i];
 
+        decomp_param[i].file = f;
         qemu_mutex_init(&decomp_param[i].mutex);
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
@@ -2719,7 +2740,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
-    if (compress_threads_load_setup()) {
+    if (compress_threads_load_setup(f)) {
         return -1;
     }
 
@@ -3074,7 +3095,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
-    wait_for_decompress_done();
+    ret |= wait_for_decompress_done(f);
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
     return ret;
-- 
2.14.3
