Received: from eggs.gnu.org ([2001:4830:134:3::10]:46647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmEI-0007wh-SE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmEF-0001N6-4z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:46 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:37681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmEE-0001Md-Rd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:43 -0400
Received: by mail-pg0-x232.google.com with SMTP id a13-v6so14249069pgu.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:42 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:20 +0800
Message-Id: <20180604095520.8563-13-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 12/12] migration: use lockless Multithread
 model for decompression
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

Adapt the compression code to the lockless multithread model

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 381 ++++++++++++++++++++++++++------------------------------
 1 file changed, 175 insertions(+), 206 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 58ecf5caa0..0a0ef0ee57 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -341,25 +341,9 @@ typedef struct PageSearchStatus PageSearchStatus;
 
 CompressionStats compression_counters;
 
-struct DecompressParam {
-    bool done;
-    bool quit;
-    QemuMutex mutex;
-    QemuCond cond;
-    void *des;
-    uint8_t *compbuf;
-    int len;
-    z_stream stream;
-};
-typedef struct DecompressParam DecompressParam;
-
 static const QEMUFileOps empty_ops = { };
 
 static QEMUFile *decomp_file;
-static DecompressParam *decomp_param;
-static QemuThread *decompress_threads;
-static QemuMutex decomp_done_lock;
-static QemuCond decomp_done_cond;
 
 /* Multiple fd's */
 
@@ -962,6 +946,178 @@ static int compress_threads_save_setup(void)
     return compress_threads ? 0 : -1;
 }
 
+/* return the size after decompression, or negative value on error */
+static int
+qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
+                     const uint8_t *source, size_t source_len)
+{
+    int err;
+
+    err = inflateReset(stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = source_len;
+    stream->next_in = (uint8_t *)source;
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
+struct DecompressData {
+    /* filled by migration thread.*/
+    void *des;
+    uint8_t *compbuf;
+    size_t len;
+
+    z_stream stream;
+    ThreadRequest request;
+};
+typedef struct DecompressData DecompressData;
+
+static ThreadRequest *decompress_thread_data_init(void)
+{
+    DecompressData *dd = g_new0(DecompressData, 1);
+
+    if (inflateInit(&dd->stream) != Z_OK) {
+        g_free(dd);
+        return NULL;
+    }
+
+    dd->compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
+    return &dd->request;
+}
+
+static void decompress_thread_data_fini(ThreadRequest *request)
+{
+    DecompressData *dd = container_of(request, DecompressData, request);
+
+    inflateEnd(&dd->stream);
+    g_free(dd->compbuf);
+    g_free(dd);
+}
+
+static void decompress_thread_data_handler(ThreadRequest *request)
+{
+    DecompressData *dd = container_of(request, DecompressData, request);
+    unsigned long pagesize = TARGET_PAGE_SIZE;
+    int ret;
+
+    ret = qemu_uncompress_data(&dd->stream, dd->des, pagesize,
+                               dd->compbuf, dd->len);
+    if (ret < 0) {
+        error_report("decompress data failed");
+        qemu_file_set_error(decomp_file, ret);
+    }
+}
+
+static void decompress_thread_data_done(ThreadRequest *data)
+{
+}
+
+struct CompressLoad {
+    Threads *decompress_threads;
+
+    /*
+     * used to decompress data in migration thread if
+     * decompress threads are busy.
+     */
+    z_stream stream;
+    uint8_t *compbuf;
+};
+typedef struct CompressLoad CompressLoad;
+
+static CompressLoad compress_load;
+
+static int decompress_init(QEMUFile *f)
+{
+    Threads *threads;
+
+    threads = threads_create(migrate_decompress_threads(), "decompress",
+                             decompress_thread_data_init,
+                             decompress_thread_data_fini,
+                             decompress_thread_data_handler,
+                             decompress_thread_data_done);
+    if (!threads) {
+        return -1;
+    }
+
+    if (inflateInit(&compress_load.stream) != Z_OK) {
+        threads_destroy(threads);
+        return -1;
+    }
+
+    compress_load.decompress_threads = threads;
+    compress_load.compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
+    decomp_file = f;
+    return 0;
+}
+
+static void decompress_fini(void)
+{
+    if (!compress_load.compbuf) {
+        return;
+    }
+
+    threads_destroy(compress_load.decompress_threads);
+    compress_load.decompress_threads = NULL;
+    g_free(compress_load.compbuf);
+    compress_load.compbuf = NULL;
+    inflateEnd(&compress_load.stream);
+    decomp_file = NULL;
+}
+
+static int flush_decompressed_data(void)
+{
+    if (!migrate_use_compression()) {
+        return 0;
+    }
+
+    threads_wait_done(compress_load.decompress_threads);
+    return qemu_file_get_error(decomp_file);
+}
+
+static void decompress_data_with_multi_threads(QEMUFile *f,
+                                               void *host, size_t len)
+{
+    ThreadRequest *request;
+    Threads *threads = compress_load.decompress_threads;
+    unsigned long pagesize = TARGET_PAGE_SIZE;
+    uint8_t *compbuf = compress_load.compbuf;
+    int ret;
+
+    request = threads_submit_request_prepare(threads);
+    if (request) {
+        DecompressData *dd;
+
+        dd = container_of(request, DecompressData, request);
+        dd->des = host;
+        dd->len = len;
+        qemu_get_buffer(f, dd->compbuf, len);
+        threads_submit_request_commit(threads, request);
+        return;
+    }
+
+    /* load data and decompress in the main thread */
+
+    /* it can change compbuf to point to an internal buffer */
+    qemu_get_buffer_in_place(f, &compbuf, len);
+
+    ret = qemu_uncompress_data(&compress_load.stream, host, pagesize,
+                               compbuf, len);
+    if (ret < 0) {
+        error_report("decompress data failed");
+        qemu_file_set_error(decomp_file, ret);
+    }
+}
+
 /**
  * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
  *
@@ -2794,193 +2950,6 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
     }
 }
 
-/* return the size after decompression, or negative value on error */
-static int
-qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                     const uint8_t *source, size_t source_len)
-{
-    int err;
-
-    err = inflateReset(stream);
-    if (err != Z_OK) {
-        return -1;
-    }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = inflate(stream, Z_NO_FLUSH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->total_out;
-}
-
-static void *do_data_decompress(void *opaque)
-{
-    DecompressParam *param = opaque;
-    unsigned long pagesize;
-    uint8_t *des;
-    int len, ret;
-
-    qemu_mutex_lock(&param->mutex);
-    while (!param->quit) {
-        if (param->des) {
-            des = param->des;
-            len = param->len;
-            param->des = 0;
-            qemu_mutex_unlock(&param->mutex);
-
-            pagesize = TARGET_PAGE_SIZE;
-
-            ret = qemu_uncompress_data(&param->stream, des, pagesize,
-                                       param->compbuf, len);
-            if (ret < 0) {
-                error_report("decompress data failed");
-                qemu_file_set_error(decomp_file, ret);
-            }
-
-            qemu_mutex_lock(&decomp_done_lock);
-            param->done = true;
-            qemu_cond_signal(&decomp_done_cond);
-            qemu_mutex_unlock(&decomp_done_lock);
-
-            qemu_mutex_lock(&param->mutex);
-        } else {
-            qemu_cond_wait(&param->cond, &param->mutex);
-        }
-    }
-    qemu_mutex_unlock(&param->mutex);
-
-    return NULL;
-}
-
-static int wait_for_decompress_done(void)
-{
-    int idx, thread_count;
-
-    if (!migrate_use_compression()) {
-        return 0;
-    }
-
-    thread_count = migrate_decompress_threads();
-    qemu_mutex_lock(&decomp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!decomp_param[idx].done) {
-            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&decomp_done_lock);
-    return qemu_file_get_error(decomp_file);
-}
-
-static void compress_threads_load_cleanup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression()) {
-        return;
-    }
-    thread_count = migrate_decompress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
-
-        qemu_mutex_lock(&decomp_param[i].mutex);
-        decomp_param[i].quit = true;
-        qemu_cond_signal(&decomp_param[i].cond);
-        qemu_mutex_unlock(&decomp_param[i].mutex);
-    }
-    for (i = 0; i < thread_count; i++) {
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
-
-        qemu_thread_join(decompress_threads + i);
-        qemu_mutex_destroy(&decomp_param[i].mutex);
-        qemu_cond_destroy(&decomp_param[i].cond);
-        inflateEnd(&decomp_param[i].stream);
-        g_free(decomp_param[i].compbuf);
-        decomp_param[i].compbuf = NULL;
-    }
-    g_free(decompress_threads);
-    g_free(decomp_param);
-    decompress_threads = NULL;
-    decomp_param = NULL;
-    decomp_file = NULL;
-}
-
-static int compress_threads_load_setup(QEMUFile *f)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression()) {
-        return 0;
-    }
-
-    thread_count = migrate_decompress_threads();
-    decompress_threads = g_new0(QemuThread, thread_count);
-    decomp_param = g_new0(DecompressParam, thread_count);
-    qemu_mutex_init(&decomp_done_lock);
-    qemu_cond_init(&decomp_done_cond);
-    decomp_file = f;
-    for (i = 0; i < thread_count; i++) {
-        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
-            goto exit;
-        }
-
-        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
-        qemu_mutex_init(&decomp_param[i].mutex);
-        qemu_cond_init(&decomp_param[i].cond);
-        decomp_param[i].done = true;
-        decomp_param[i].quit = false;
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
-    }
-    return 0;
-exit:
-    compress_threads_load_cleanup();
-    return -1;
-}
-
-static void decompress_data_with_multi_threads(QEMUFile *f,
-                                               void *host, int len)
-{
-    int idx, thread_count;
-
-    thread_count = migrate_decompress_threads();
-    qemu_mutex_lock(&decomp_done_lock);
-    while (true) {
-        for (idx = 0; idx < thread_count; idx++) {
-            if (decomp_param[idx].done) {
-                decomp_param[idx].done = false;
-                qemu_mutex_lock(&decomp_param[idx].mutex);
-                qemu_get_buffer(f, decomp_param[idx].compbuf, len);
-                decomp_param[idx].des = host;
-                decomp_param[idx].len = len;
-                qemu_cond_signal(&decomp_param[idx].cond);
-                qemu_mutex_unlock(&decomp_param[idx].mutex);
-                break;
-            }
-        }
-        if (idx < thread_count) {
-            break;
-        } else {
-            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&decomp_done_lock);
-}
-
 /**
  * ram_load_setup: Setup RAM for migration incoming side
  *
@@ -2991,7 +2960,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
-    if (compress_threads_load_setup(f)) {
+    if (decompress_init(f)) {
         return -1;
     }
 
@@ -3004,7 +2973,7 @@ static int ram_load_cleanup(void *opaque)
 {
     RAMBlock *rb;
     xbzrle_load_cleanup();
-    compress_threads_load_cleanup();
+    decompress_fini();
 
     RAMBLOCK_FOREACH(rb) {
         g_free(rb->receivedmap);
@@ -3346,7 +3315,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
-    ret |= wait_for_decompress_done();
+    ret |= flush_decompressed_data();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
     return ret;
-- 
2.14.4
