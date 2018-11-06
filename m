Received: from eggs.gnu.org ([2001:4830:134:3::10]:43383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Li-0002tR-1h
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gK0Le-0001oJ-M9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:50 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gK0Le-0001nV-Dd
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:20:46 -0500
Received: by mail-pg1-x542.google.com with SMTP id i4-v6so5749943pgq.9
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:20:46 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Tue,  6 Nov 2018 20:20:23 +0800
Message-Id: <20181106122025.3487-4-xiaoguangrong@tencent.com>
In-Reply-To: <20181106122025.3487-1-xiaoguangrong@tencent.com>
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 3/5] migration: use threaded workqueue for
 compression
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
 migration/ram.c | 313 +++++++++++++++++++++-----------------------------------
 1 file changed, 115 insertions(+), 198 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec4d8..acca842aff 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,7 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "qemu/threaded-workqueue.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -349,22 +350,6 @@ typedef struct PageSearchStatus PageSearchStatus;
 
 CompressionStats compression_counters;
 
-struct CompressParam {
-    bool done;
-    bool quit;
-    bool zero_page;
-    QEMUFile *file;
-    QemuMutex mutex;
-    QemuCond cond;
-    RAMBlock *block;
-    ram_addr_t offset;
-
-    /* internally used fields */
-    z_stream stream;
-    uint8_t *originbuf;
-};
-typedef struct CompressParam CompressParam;
-
 struct DecompressParam {
     bool done;
     bool quit;
@@ -377,15 +362,6 @@ struct DecompressParam {
 };
 typedef struct DecompressParam DecompressParam;
 
-static CompressParam *comp_param;
-static QemuThread *compress_threads;
-/* comp_done_cond is used to wake up the migration thread when
- * one of the compression threads has finished the compression.
- * comp_done_lock is used to co-work with comp_done_cond.
- */
-static QemuMutex comp_done_lock;
-static QemuCond comp_done_cond;
-/* The empty QEMUFileOps will be used by file in CompressParam */
 static const QEMUFileOps empty_ops = { };
 
 static QEMUFile *decomp_file;
@@ -394,125 +370,6 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                 ram_addr_t offset, uint8_t *source_buf);
-
-static void *do_data_compress(void *opaque)
-{
-    CompressParam *param = opaque;
-    RAMBlock *block;
-    ram_addr_t offset;
-    bool zero_page;
-
-    qemu_mutex_lock(&param->mutex);
-    while (!param->quit) {
-        if (param->block) {
-            block = param->block;
-            offset = param->offset;
-            param->block = NULL;
-            qemu_mutex_unlock(&param->mutex);
-
-            zero_page = do_compress_ram_page(param->file, &param->stream,
-                                             block, offset, param->originbuf);
-
-            qemu_mutex_lock(&comp_done_lock);
-            param->done = true;
-            param->zero_page = zero_page;
-            qemu_cond_signal(&comp_done_cond);
-            qemu_mutex_unlock(&comp_done_lock);
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
-static void compress_threads_save_cleanup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression() || !comp_param) {
-        return;
-    }
-
-    thread_count = migrate_compress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!comp_param[i].file) {
-            break;
-        }
-
-        qemu_mutex_lock(&comp_param[i].mutex);
-        comp_param[i].quit = true;
-        qemu_cond_signal(&comp_param[i].cond);
-        qemu_mutex_unlock(&comp_param[i].mutex);
-
-        qemu_thread_join(compress_threads + i);
-        qemu_mutex_destroy(&comp_param[i].mutex);
-        qemu_cond_destroy(&comp_param[i].cond);
-        deflateEnd(&comp_param[i].stream);
-        g_free(comp_param[i].originbuf);
-        qemu_fclose(comp_param[i].file);
-        comp_param[i].file = NULL;
-    }
-    qemu_mutex_destroy(&comp_done_lock);
-    qemu_cond_destroy(&comp_done_cond);
-    g_free(compress_threads);
-    g_free(comp_param);
-    compress_threads = NULL;
-    comp_param = NULL;
-}
-
-static int compress_threads_save_setup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression()) {
-        return 0;
-    }
-    thread_count = migrate_compress_threads();
-    compress_threads = g_new0(QemuThread, thread_count);
-    comp_param = g_new0(CompressParam, thread_count);
-    qemu_cond_init(&comp_done_cond);
-    qemu_mutex_init(&comp_done_lock);
-    for (i = 0; i < thread_count; i++) {
-        comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
-        if (!comp_param[i].originbuf) {
-            goto exit;
-        }
-
-        if (deflateInit(&comp_param[i].stream,
-                        migrate_compress_level()) != Z_OK) {
-            g_free(comp_param[i].originbuf);
-            goto exit;
-        }
-
-        /* comp_param[i].file is just used as a dummy buffer to save data,
-         * set its ops to empty.
-         */
-        comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
-        comp_param[i].done = true;
-        comp_param[i].quit = false;
-        qemu_mutex_init(&comp_param[i].mutex);
-        qemu_cond_init(&comp_param[i].cond);
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
-    }
-    return 0;
-
-exit:
-    compress_threads_save_cleanup();
-    return -1;
-}
-
 /* Multiple fd's */
 
 #define MULTIFD_MAGIC 0x11223344U
@@ -1909,12 +1766,25 @@ exit:
     return zero_page;
 }
 
+struct CompressData {
+    /* filled by migration thread.*/
+    RAMBlock *block;
+    ram_addr_t offset;
+
+    /* filled by compress thread. */
+    QEMUFile *file;
+    z_stream stream;
+    uint8_t *originbuf;
+    bool zero_page;
+};
+typedef struct CompressData CompressData;
+
 static void
-update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
+update_compress_thread_counts(CompressData *cd, int bytes_xmit)
 {
     ram_counters.transferred += bytes_xmit;
 
-    if (param->zero_page) {
+    if (cd->zero_page) {
         ram_counters.duplicate++;
         return;
     }
@@ -1924,81 +1794,128 @@ update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
+static int compress_thread_get_data_size(void)
+{
+    return sizeof(CompressData);
+}
+
+static int compress_thread_data_init(void *request)
+{
+    CompressData *cd = request;
+
+    cd->originbuf = g_try_malloc(TARGET_PAGE_SIZE);
+    if (!cd->originbuf) {
+        return -1;
+    }
+
+    if (deflateInit(&cd->stream, migrate_compress_level()) != Z_OK) {
+        g_free(cd->originbuf);
+        return -1;
+    }
+
+    cd->file = qemu_fopen_ops(NULL, &empty_ops);
+    return 0;
+}
+
+static void compress_thread_data_fini(void *request)
+{
+    CompressData *cd = request;
+
+    qemu_fclose(cd->file);
+    deflateEnd(&cd->stream);
+    g_free(cd->originbuf);
+}
+
+static void compress_thread_data_handler(void *request)
+{
+    CompressData *cd = request;
+
+    /*
+     * if compression fails, it will be indicated by
+     * migrate_get_current()->to_dst_file.
+     */
+    cd->zero_page = do_compress_ram_page(cd->file, &cd->stream, cd->block,
+                                         cd->offset, cd->originbuf);
+}
+
+static void compress_thread_data_done(void *request)
+{
+    CompressData *cd = request;
+    RAMState *rs = ram_state;
+    int bytes_xmit;
+
+    bytes_xmit = qemu_put_qemu_file(rs->f, cd->file);
+    update_compress_thread_counts(cd, bytes_xmit);
+}
+
+static ThreadedWorkqueueOps compress_ops = {
+    .thread_get_request_size = compress_thread_get_data_size,
+    .thread_request_init = compress_thread_data_init,
+    .thread_request_uninit = compress_thread_data_fini,
+    .thread_request_handler = compress_thread_data_handler,
+    .thread_request_done = compress_thread_data_done,
+};
+
+static Threads *compress_threads;
+
 static bool save_page_use_compression(RAMState *rs);
 
 static void flush_compressed_data(RAMState *rs)
 {
-    int idx, len, thread_count;
-
     if (!save_page_use_compression(rs)) {
         return;
     }
-    thread_count = migrate_compress_threads();
 
-    qemu_mutex_lock(&comp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!comp_param[idx].done) {
-            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&comp_done_lock);
+    threaded_workqueue_wait_for_requests(compress_threads);
+}
 
-    for (idx = 0; idx < thread_count; idx++) {
-        qemu_mutex_lock(&comp_param[idx].mutex);
-        if (!comp_param[idx].quit) {
-            len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            /*
-             * it's safe to fetch zero_page without holding comp_done_lock
-             * as there is no further request submitted to the thread,
-             * i.e, the thread should be waiting for a request at this point.
-             */
-            update_compress_thread_counts(&comp_param[idx], len);
-        }
-        qemu_mutex_unlock(&comp_param[idx].mutex);
+static void compress_threads_save_cleanup(void)
+{
+    if (!compress_threads) {
+        return;
     }
+
+    threaded_workqueue_destroy(compress_threads);
+    compress_threads = NULL;
 }
 
-static inline void set_compress_params(CompressParam *param, RAMBlock *block,
-                                       ram_addr_t offset)
+static int compress_threads_save_setup(void)
 {
-    param->block = block;
-    param->offset = offset;
+    if (!migrate_use_compression()) {
+        return 0;
+    }
+
+    compress_threads = threaded_workqueue_create("compress",
+                                migrate_compress_threads(),
+                                DEFAULT_THREAD_REQUEST_NR, &compress_ops);
+    return compress_threads ? 0 : -1;
 }
 
 static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                                            ram_addr_t offset)
 {
-    int idx, thread_count, bytes_xmit = -1, pages = -1;
+    CompressData *cd;
     bool wait = migrate_compress_wait_thread();
 
-    thread_count = migrate_compress_threads();
-    qemu_mutex_lock(&comp_done_lock);
 retry:
-    for (idx = 0; idx < thread_count; idx++) {
-        if (comp_param[idx].done) {
-            comp_param[idx].done = false;
-            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            qemu_mutex_lock(&comp_param[idx].mutex);
-            set_compress_params(&comp_param[idx], block, offset);
-            qemu_cond_signal(&comp_param[idx].cond);
-            qemu_mutex_unlock(&comp_param[idx].mutex);
-            pages = 1;
-            update_compress_thread_counts(&comp_param[idx], bytes_xmit);
-            break;
+    cd = threaded_workqueue_get_request(compress_threads);
+    if (!cd) {
+        /*
+         * wait for the free thread if the user specifies
+         * 'compress-wait-thread', otherwise we will post
+         *  the page out in the main thread as normal page.
+         */
+        if (wait) {
+            cpu_relax();
+            goto retry;
         }
-    }
 
-    /*
-     * wait for the free thread if the user specifies 'compress-wait-thread',
-     * otherwise we will post the page out in the main thread as normal page.
-     */
-    if (pages < 0 && wait) {
-        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-        goto retry;
-    }
-    qemu_mutex_unlock(&comp_done_lock);
-
-    return pages;
+        return -1;
+     }
+    cd->block = block;
+    cd->offset = offset;
+    threaded_workqueue_submit_request(compress_threads, cd);
+    return 1;
 }
 
 /**
-- 
2.14.5
