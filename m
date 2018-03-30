Received: from eggs.gnu.org ([2001:4830:134:3::10]:56291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ook-0001wU-La
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ooj-0007dI-Hk
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:22 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1ooj-0007d8-9g
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:21 -0400
Received: by mail-pg0-x244.google.com with SMTP id y16so4127107pgv.1
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 00:51:21 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Fri, 30 Mar 2018 15:51:22 +0800
Message-Id: <20180330075128.26919-5-xiaoguangrong@tencent.com>
In-Reply-To: <20180330075128.26919-1-xiaoguangrong@tencent.com>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 04/10] migration: detect compression and
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/qemu-file.c |  4 ++--
 migration/ram.c       | 56 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index bafe3a0c0d..0463f4c321 100644
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
index fb24b2f32f..72cb8dfb66 100644
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
 
@@ -296,13 +299,14 @@ static QemuCond comp_done_cond;
 /* The empty QEMUFileOps will be used by file in CompressParam */
 static const QEMUFileOps empty_ops = { };
 
+static QEMUFile *decomp_file;
 static DecompressParam *decomp_param;
 static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
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
@@ -370,6 +375,7 @@ static void compress_threads_save_cleanup(void)
         qemu_mutex_destroy(&comp_param[i].mutex);
         qemu_cond_destroy(&comp_param[i].cond);
         deflateEnd(&comp_param[i].stream);
+        g_free(comp_param[i].originbuf);
         qemu_fclose(comp_param[i].file);
         comp_param[i].file = NULL;
     }
@@ -394,8 +400,14 @@ static int compress_threads_save_setup(void)
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
 
@@ -1053,7 +1065,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 }
 
 static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset)
+                                ram_addr_t offset, uint8_t *source_buf)
 {
     RAMState *rs = ram_state;
     int bytes_sent, blen;
@@ -1061,7 +1073,14 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
 
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
@@ -2555,7 +2574,7 @@ static void *do_data_decompress(void *opaque)
     DecompressParam *param = opaque;
     unsigned long pagesize;
     uint8_t *des;
-    int len;
+    int len, ret;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -2566,13 +2585,13 @@ static void *do_data_decompress(void *opaque)
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
+                qemu_file_set_error(decomp_file, ret);
+            }
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2589,12 +2608,12 @@ static void *do_data_decompress(void *opaque)
     return NULL;
 }
 
-static void wait_for_decompress_done(void)
+static int wait_for_decompress_done(void)
 {
     int idx, thread_count;
 
     if (!migrate_use_compression()) {
-        return;
+        return 0;
     }
 
     thread_count = migrate_decompress_threads();
@@ -2605,6 +2624,7 @@ static void wait_for_decompress_done(void)
         }
     }
     qemu_mutex_unlock(&decomp_done_lock);
+    return qemu_file_get_error(decomp_file);
 }
 
 static void compress_threads_load_cleanup(void)
@@ -2645,9 +2665,10 @@ static void compress_threads_load_cleanup(void)
     g_free(decomp_param);
     decompress_threads = NULL;
     decomp_param = NULL;
+    decomp_file = NULL;
 }
 
-static int compress_threads_load_setup(void)
+static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
 
@@ -2660,6 +2681,7 @@ static int compress_threads_load_setup(void)
     decomp_param = g_new0(DecompressParam, thread_count);
     qemu_mutex_init(&decomp_done_lock);
     qemu_cond_init(&decomp_done_cond);
+    decomp_file = f;
     for (i = 0; i < thread_count; i++) {
         if (inflateInit(&decomp_param[i].stream) != Z_OK) {
             goto exit;
@@ -2719,7 +2741,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
-    if (compress_threads_load_setup()) {
+    if (compress_threads_load_setup(f)) {
         return -1;
     }
 
@@ -3074,7 +3096,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
-    wait_for_decompress_done();
+    ret |= wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
     return ret;
-- 
2.14.3
