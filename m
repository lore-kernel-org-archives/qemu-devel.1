Received: from eggs.gnu.org ([2001:4830:134:3::10]:43401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Lk-0002uy-3q
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Li-0001vu-Oq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:52 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gK0Li-0001tj-Gm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:50 -0500
Received: by mail-pf1-x444.google.com with SMTP id v68-v6so2453476pfk.0
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:20:50 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Tue,  6 Nov 2018 20:20:24 +0800
Message-Id: <20181106122025.3487-5-xiaoguangrong@tencent.com>
In-Reply-To: <20181106122025.3487-1-xiaoguangrong@tencent.com>
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 4/5] migration: use threaded workqueue for
 decompression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Adapt the compression code to the threaded workqueue

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 225 ++++++++++++++++++++------------------------------------
 1 file changed, 81 insertions(+), 144 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index acca842aff..834198f11c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -350,25 +350,9 @@ typedef struct PageSearchStatus PageSearchStatus;
 
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
 
@@ -3404,6 +3388,7 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
     }
 }
 
+
 /* return the size after decompression, or negative value on error */
 static int
 qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
@@ -3429,166 +3414,118 @@ qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
     return stream->total_out;
 }
 
-static void *do_data_decompress(void *opaque)
+struct DecompressData {
+    /* filled by migration thread.*/
+    void *des;
+    uint8_t *compbuf;
+    size_t len;
+
+    z_stream stream;
+};
+typedef struct DecompressData DecompressData;
+
+static Threads *decompress_threads;
+
+static int decompress_thread_get_data_size(void)
 {
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
-            if (ret < 0 && migrate_get_current()->decompress_error_check) {
-                error_report("decompress data failed");
-                qemu_file_set_error(decomp_file, ret);
-            }
+    return sizeof(DecompressData);
+}
 
-            qemu_mutex_lock(&decomp_done_lock);
-            param->done = true;
-            qemu_cond_signal(&decomp_done_cond);
-            qemu_mutex_unlock(&decomp_done_lock);
+static int decompress_thread_data_init(void *request)
+{
+    DecompressData *dd = request;
 
-            qemu_mutex_lock(&param->mutex);
-        } else {
-            qemu_cond_wait(&param->cond, &param->mutex);
-        }
+    if (inflateInit(&dd->stream) != Z_OK) {
+        return -1;
     }
-    qemu_mutex_unlock(&param->mutex);
 
-    return NULL;
+    dd->compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
+    return 0;
 }
 
-static int wait_for_decompress_done(void)
+static void decompress_thread_data_fini(void *request)
 {
-    int idx, thread_count;
+    DecompressData *dd = request;
 
-    if (!migrate_use_compression()) {
-        return 0;
-    }
+    inflateEnd(&dd->stream);
+    g_free(dd->compbuf);
+}
 
-    thread_count = migrate_decompress_threads();
-    qemu_mutex_lock(&decomp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!decomp_param[idx].done) {
-            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-        }
+static void decompress_thread_data_handler(void *request)
+{
+    DecompressData *dd = request;
+    unsigned long pagesize = TARGET_PAGE_SIZE;
+    int ret;
+
+    ret = qemu_uncompress_data(&dd->stream, dd->des, pagesize,
+                               dd->compbuf, dd->len);
+    if (ret < 0 && migrate_get_current()->decompress_error_check) {
+        error_report("decompress data failed");
+        qemu_file_set_error(decomp_file, ret);
     }
-    qemu_mutex_unlock(&decomp_done_lock);
-    return qemu_file_get_error(decomp_file);
 }
 
-static void compress_threads_load_cleanup(void)
+static void decompress_thread_data_done(void *request)
 {
-    int i, thread_count;
+}
+
+static ThreadedWorkqueueOps decompress_ops = {
+    .thread_get_request_size = decompress_thread_get_data_size,
+    .thread_request_init = decompress_thread_data_init,
+    .thread_request_uninit = decompress_thread_data_fini,
+    .thread_request_handler = decompress_thread_data_handler,
+    .thread_request_done = decompress_thread_data_done,
+};
 
+static int decompress_init(QEMUFile *f)
+{
     if (!migrate_use_compression()) {
-        return;
+        return 0;
     }
-    thread_count = migrate_decompress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
 
-        qemu_mutex_lock(&decomp_param[i].mutex);
-        decomp_param[i].quit = true;
-        qemu_cond_signal(&decomp_param[i].cond);
-        qemu_mutex_unlock(&decomp_param[i].mutex);
-    }
-    for (i = 0; i < thread_count; i++) {
-        if (!decomp_param[i].compbuf) {
-            break;
-        }
+    decomp_file = f;
+    decompress_threads = threaded_workqueue_create("decompress",
+                                migrate_decompress_threads(),
+                                DEFAULT_THREAD_REQUEST_NR, &decompress_ops);
+    return decompress_threads ? 0 : -1;
+}
 
-        qemu_thread_join(decompress_threads + i);
-        qemu_mutex_destroy(&decomp_param[i].mutex);
-        qemu_cond_destroy(&decomp_param[i].cond);
-        inflateEnd(&decomp_param[i].stream);
-        g_free(decomp_param[i].compbuf);
-        decomp_param[i].compbuf = NULL;
+static void decompress_fini(void)
+{
+    if (!decompress_threads) {
+        return;
     }
-    g_free(decompress_threads);
-    g_free(decomp_param);
+
+    threaded_workqueue_destroy(decompress_threads);
     decompress_threads = NULL;
-    decomp_param = NULL;
     decomp_file = NULL;
 }
 
-static int compress_threads_load_setup(QEMUFile *f)
+static int flush_decompressed_data(void)
 {
-    int i, thread_count;
-
     if (!migrate_use_compression()) {
         return 0;
     }
 
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
+    threaded_workqueue_wait_for_requests(decompress_threads);
+    return qemu_file_get_error(decomp_file);
 }
 
 static void decompress_data_with_multi_threads(QEMUFile *f,
-                                               void *host, int len)
+                                               void *host, size_t len)
 {
-    int idx, thread_count;
+    DecompressData *dd;
 
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
+retry:
+    dd = threaded_workqueue_get_request(decompress_threads);
+    if (!dd) {
+        goto retry;
     }
-    qemu_mutex_unlock(&decomp_done_lock);
+
+    dd->des = host;
+    dd->len = len;
+    qemu_get_buffer(f, dd->compbuf, len);
+    threaded_workqueue_submit_request(decompress_threads, dd);
 }
 
 /*
@@ -3683,7 +3620,7 @@ void colo_release_ram_cache(void)
  */
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
-    if (compress_threads_load_setup(f)) {
+    if (decompress_init(f)) {
         return -1;
     }
 
@@ -3704,7 +3641,7 @@ static int ram_load_cleanup(void *opaque)
     }
 
     xbzrle_load_cleanup();
-    compress_threads_load_cleanup();
+    decompress_fini();
 
     RAMBLOCK_FOREACH_MIGRATABLE(rb) {
         g_free(rb->receivedmap);
@@ -4106,7 +4043,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
-    ret |= wait_for_decompress_done();
+    ret |= flush_decompressed_data();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
 
-- 
2.14.5
