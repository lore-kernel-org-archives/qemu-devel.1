Received: from eggs.gnu.org ([2001:4830:134:3::10]:42944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveoq-0002to-LB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveoo-0007SQ-IY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:00 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eveoo-0007RO-9G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:57:58 -0400
Received: by mail-pf0-x241.google.com with SMTP id a16so5531585pfn.9
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 00:57:58 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 13 Mar 2018 15:57:33 +0800
Message-Id: <20180313075739.11194-3-xiaoguangrong@tencent.com>
In-Reply-To: <20180313075739.11194-1-xiaoguangrong@tencent.com>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Current code uses compress2()/uncompress() to compress/decompress
memory, these two function manager memory allocation and release
internally, that causes huge memory is allocated and freed very
frequently

More worse, frequently returning memory to kernel will flush TLBs
and trigger invalidation callbacks on mmu-notification which
interacts with KVM MMU, that dramatically reduce the performance
of VM

So, we maintain the memory by ourselves and reuse it for each
compression and decompression

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/qemu-file.c |  34 ++++++++++--
 migration/qemu-file.h |   6 ++-
 migration/ram.c       | 142 +++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 140 insertions(+), 42 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf362d..1ff33a1ffb 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -658,6 +658,30 @@ uint64_t qemu_get_be64(QEMUFile *f)
     return v;
 }
 
+/* return the size after compression, or negative value on error */
+static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
+                              const uint8_t *source, size_t source_len)
+{
+    int err;
+
+    err = deflateReset(stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = source_len;
+    stream->next_in = (uint8_t *)source;
+    stream->avail_out = dest_len;
+    stream->next_out = dest;
+
+    err = deflate(stream, Z_FINISH);
+    if (err != Z_STREAM_END) {
+        return -1;
+    }
+
+    return stream->next_out - dest;
+}
+
 /* Compress size bytes of data start at p with specific compression
  * level and store the compressed data to the buffer of f.
  *
@@ -668,8 +692,8 @@ uint64_t qemu_get_be64(QEMUFile *f)
  * data, return -1.
  */
 
-ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
-                                  int level)
+ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
+                                  const uint8_t *p, size_t size)
 {
     ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
 
@@ -683,8 +707,10 @@ ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
             return -1;
         }
     }
-    if (compress2(f->buf + f->buf_index + sizeof(int32_t), (uLongf *)&blen,
-                  (Bytef *)p, size, level) != Z_OK) {
+
+    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
+                              blen, p, size);
+    if (blen < 0) {
         error_report("Compress Failed!");
         return 0;
     }
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index aae4e5ed36..d123b21ca8 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -25,6 +25,8 @@
 #ifndef MIGRATION_QEMU_FILE_H
 #define MIGRATION_QEMU_FILE_H
 
+#include <zlib.h>
+
 /* Read a chunk of data from a file at the given position.  The pos argument
  * can be ignored if the file is only be used for streaming.  The number of
  * bytes actually read should be returned.
@@ -132,8 +134,8 @@ bool qemu_file_is_writable(QEMUFile *f);
 
 size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset);
 size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size);
-ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
-                                  int level);
+ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
+                                  const uint8_t *p, size_t size);
 int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
 
 /*
diff --git a/migration/ram.c b/migration/ram.c
index 615693f180..fff3f31e90 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -264,6 +264,7 @@ struct CompressParam {
     QemuCond cond;
     RAMBlock *block;
     ram_addr_t offset;
+    z_stream stream;
 };
 typedef struct CompressParam CompressParam;
 
@@ -275,6 +276,7 @@ struct DecompressParam {
     void *des;
     uint8_t *compbuf;
     int len;
+    z_stream stream;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -294,7 +296,7 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
+static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                 ram_addr_t offset);
 
 static void *do_data_compress(void *opaque)
@@ -311,7 +313,7 @@ static void *do_data_compress(void *opaque)
             param->block = NULL;
             qemu_mutex_unlock(&param->mutex);
 
-            do_compress_ram_page(param->file, block, offset);
+            do_compress_ram_page(param->file, &param->stream, block, offset);
 
             qemu_mutex_lock(&comp_done_lock);
             param->done = true;
@@ -352,10 +354,17 @@ static void compress_threads_save_cleanup(void)
     terminate_compression_threads();
     thread_count = migrate_compress_threads();
     for (i = 0; i < thread_count; i++) {
+        /* something in compress_threads_save_setup() is wrong. */
+        if (!comp_param[i].stream.opaque) {
+            break;
+        }
+
         qemu_thread_join(compress_threads + i);
         qemu_fclose(comp_param[i].file);
         qemu_mutex_destroy(&comp_param[i].mutex);
         qemu_cond_destroy(&comp_param[i].cond);
+        deflateEnd(&comp_param[i].stream);
+        comp_param[i].stream.opaque = NULL;
     }
     qemu_mutex_destroy(&comp_done_lock);
     qemu_cond_destroy(&comp_done_cond);
@@ -365,12 +374,12 @@ static void compress_threads_save_cleanup(void)
     comp_param = NULL;
 }
 
-static void compress_threads_save_setup(void)
+static int compress_threads_save_setup(void)
 {
     int i, thread_count;
 
     if (!migrate_use_compression()) {
-        return;
+        return 0;
     }
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
@@ -378,6 +387,12 @@ static void compress_threads_save_setup(void)
     qemu_cond_init(&comp_done_cond);
     qemu_mutex_init(&comp_done_lock);
     for (i = 0; i < thread_count; i++) {
+        if (deflateInit(&comp_param[i].stream,
+                           migrate_compress_level()) != Z_OK) {
+            goto exit;
+        }
+        comp_param[i].stream.opaque = &comp_param[i];
+
         /* comp_param[i].file is just used as a dummy buffer to save data,
          * set its ops to empty.
          */
@@ -390,6 +405,11 @@ static void compress_threads_save_setup(void)
                            do_data_compress, comp_param + i,
                            QEMU_THREAD_JOINABLE);
     }
+    return 0;
+
+exit:
+    compress_threads_save_cleanup();
+    return -1;
 }
 
 /* Multiple fd's */
@@ -1026,7 +1046,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     return pages;
 }
 
-static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
+static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                 ram_addr_t offset)
 {
     RAMState *rs = ram_state;
@@ -1035,8 +1055,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
 
     bytes_sent = save_page_header(rs, f, block, offset |
                                   RAM_SAVE_FLAG_COMPRESS_PAGE);
-    blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
-                                     migrate_compress_level());
+    blen = qemu_put_compression_data(f, stream, p, TARGET_PAGE_SIZE);
     if (blen < 0) {
         bytes_sent = 0;
         qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
@@ -2209,9 +2228,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
+    if (compress_threads_save_setup()) {
+        return -1;
+    }
+
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
+            compress_threads_save_cleanup();
             return -1;
         }
     }
@@ -2231,7 +2255,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     rcu_read_unlock();
-    compress_threads_save_setup();
 
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
@@ -2495,6 +2518,30 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
     }
 }
 
+/* return the size after decompression, or negative value on error */
+static int qemu_uncompress(z_stream *stream, uint8_t *dest, size_t dest_len,
+                           uint8_t *source, size_t source_len)
+{
+    int err;
+
+    err = inflateReset(stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = source_len;
+    stream->next_in = source;
+    stream->avail_out = dest_len;
+    stream->next_out = dest;
+
+    err = inflate(stream, Z_NO_FLUSH);
+    if (err != Z_STREAM_END) {
+        return -1;
+    }
+
+    return stream->total_out;
+}
+
 static void *do_data_decompress(void *opaque)
 {
     DecompressParam *param = opaque;
@@ -2511,13 +2558,13 @@ static void *do_data_decompress(void *opaque)
             qemu_mutex_unlock(&param->mutex);
 
             pagesize = TARGET_PAGE_SIZE;
-            /* uncompress() will return failed in some case, especially
+            /* qemu_uncompress() will return failed in some case, especially
              * when the page is dirted when doing the compression, it's
              * not a problem because the dirty page will be retransferred
              * and uncompress() won't break the data in other pages.
              */
-            uncompress((Bytef *)des, &pagesize,
-                       (const Bytef *)param->compbuf, len);
+            qemu_uncompress(&param->stream, des, pagesize,
+                            param->compbuf, len);
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2552,30 +2599,6 @@ static void wait_for_decompress_done(void)
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
-static void compress_threads_load_setup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression()) {
-        return;
-    }
-    thread_count = migrate_decompress_threads();
-    decompress_threads = g_new0(QemuThread, thread_count);
-    decomp_param = g_new0(DecompressParam, thread_count);
-    qemu_mutex_init(&decomp_done_lock);
-    qemu_cond_init(&decomp_done_cond);
-    for (i = 0; i < thread_count; i++) {
-        qemu_mutex_init(&decomp_param[i].mutex);
-        qemu_cond_init(&decomp_param[i].cond);
-        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
-        decomp_param[i].done = true;
-        decomp_param[i].quit = false;
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
-    }
-}
-
 static void compress_threads_load_cleanup(void)
 {
     int i, thread_count;
@@ -2585,16 +2608,26 @@ static void compress_threads_load_cleanup(void)
     }
     thread_count = migrate_decompress_threads();
     for (i = 0; i < thread_count; i++) {
+        if (!decomp_param[i].stream.opaque) {
+            break;
+        }
+
         qemu_mutex_lock(&decomp_param[i].mutex);
         decomp_param[i].quit = true;
         qemu_cond_signal(&decomp_param[i].cond);
         qemu_mutex_unlock(&decomp_param[i].mutex);
     }
     for (i = 0; i < thread_count; i++) {
+        if (!decomp_param[i].stream.opaque) {
+            break;
+        }
+
         qemu_thread_join(decompress_threads + i);
         qemu_mutex_destroy(&decomp_param[i].mutex);
         qemu_cond_destroy(&decomp_param[i].cond);
         g_free(decomp_param[i].compbuf);
+        inflateEnd(&decomp_param[i].stream);
+        decomp_param[i].stream.opaque = NULL;
     }
     g_free(decompress_threads);
     g_free(decomp_param);
@@ -2602,6 +2635,40 @@ static void compress_threads_load_cleanup(void)
     decomp_param = NULL;
 }
 
+static int compress_threads_load_setup(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_compression()) {
+        return 0;
+    }
+
+    thread_count = migrate_decompress_threads();
+    decompress_threads = g_new0(QemuThread, thread_count);
+    decomp_param = g_new0(DecompressParam, thread_count);
+    qemu_mutex_init(&decomp_done_lock);
+    qemu_cond_init(&decomp_done_cond);
+    for (i = 0; i < thread_count; i++) {
+        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
+            goto exit;
+        }
+        decomp_param[i].stream.opaque = &decomp_param[i];
+
+        qemu_mutex_init(&decomp_param[i].mutex);
+        qemu_cond_init(&decomp_param[i].cond);
+        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
+        decomp_param[i].done = true;
+        decomp_param[i].quit = false;
+        qemu_thread_create(decompress_threads + i, "decompress",
+                           do_data_decompress, decomp_param + i,
+                           QEMU_THREAD_JOINABLE);
+    }
+    return 0;
+exit:
+    compress_threads_load_cleanup();
+    return -1;
+}
+
 static void decompress_data_with_multi_threads(QEMUFile *f,
                                                void *host, int len)
 {
@@ -2641,8 +2708,11 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
+    if (compress_threads_load_setup()) {
+        return -1;
+    }
+
     xbzrle_load_setup();
-    compress_threads_load_setup();
     ramblock_recv_map_init();
     return 0;
 }
-- 
2.14.3
