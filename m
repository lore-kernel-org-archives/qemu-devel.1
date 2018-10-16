Received: from eggs.gnu.org ([2001:4830:134:3::10]:36763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gCNFI-0000X0-1R
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gCNFD-000314-Uf
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gCNFD-0002ln-En
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:10:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so10685614pgu.11
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 04:10:28 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 16 Oct 2018 19:10:05 +0800
Message-Id: <20181016111006.629-4-xiaoguangrong@tencent.com>
In-Reply-To: <20181016111006.629-1-xiaoguangrong@tencent.com>
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 3/4] migration: use lockless Multithread model
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Adapt the compression code to the lockless multithread model

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 312 +++++++++++++++++++++-----------------------------------
 1 file changed, 115 insertions(+), 197 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index bc38d98cc3..2356bc255c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,7 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "qemu/lockless-threads.h"
 
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
@@ -1909,12 +1766,27 @@ exit:
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
+
+    ThreadRequest request;
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
@@ -1924,81 +1796,127 @@ update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
+static ThreadRequest *compress_thread_data_init(void)
+{
+    CompressData *cd = g_new0(CompressData, 1);
+
+    cd->originbuf = g_try_malloc(TARGET_PAGE_SIZE);
+    if (!cd->originbuf) {
+        goto exit;
+    }
+
+    if (deflateInit(&cd->stream, migrate_compress_level()) != Z_OK) {
+        g_free(cd->originbuf);
+        goto exit;
+    }
+
+    cd->file = qemu_fopen_ops(NULL, &empty_ops);
+    return &cd->request;
+
+exit:
+    g_free(cd);
+    return NULL;
+}
+
+static void compress_thread_data_fini(ThreadRequest *request)
+{
+    CompressData *cd = container_of(request, CompressData, request);
+
+    qemu_fclose(cd->file);
+    deflateEnd(&cd->stream);
+    g_free(cd->originbuf);
+    g_free(cd);
+}
+
+static void compress_thread_data_handler(ThreadRequest *request)
+{
+    CompressData *cd = container_of(request, CompressData, request);
+
+    /*
+     * if compression fails, it will be indicated by
+     * migrate_get_current()->to_dst_file.
+     */
+    cd->zero_page = do_compress_ram_page(cd->file, &cd->stream, cd->block,
+                                         cd->offset, cd->originbuf);
+}
+
+static void compress_thread_data_done(ThreadRequest *request)
+{
+    CompressData *cd = container_of(request, CompressData, request);
+    RAMState *rs = ram_state;
+    int bytes_xmit;
+
+    bytes_xmit = qemu_put_qemu_file(rs->f, cd->file);
+    update_compress_thread_counts(cd, bytes_xmit);
+}
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
+    threads_wait_done(compress_threads);
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
+    threads_destroy(compress_threads);
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
+    compress_threads = threads_create(migrate_compress_threads(),
+                                      "compress",
+                                      DEFAULT_THREAD_RING_SIZE,
+                                      compress_thread_data_init,
+                                      compress_thread_data_fini,
+                                      compress_thread_data_handler,
+                                      compress_thread_data_done);
+    return compress_threads ? 0 : -1;
 }
 
 static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                                            ram_addr_t offset)
 {
-    int idx, thread_count, bytes_xmit = -1, pages = -1;
+    CompressData *cd;
+    ThreadRequest *request;
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
+    request = threads_submit_request_prepare(compress_threads);
+    if (!request) {
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
+        return -1;
+     }
 
-    return pages;
+    cd = container_of(request, CompressData, request);
+    cd->block = block;
+    cd->offset = offset;
+    threads_submit_request_commit(compress_threads, request);
+    return 1;
 }
 
 /**
-- 
2.14.4
