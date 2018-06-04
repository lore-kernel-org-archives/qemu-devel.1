Received: from eggs.gnu.org ([2001:4830:134:3::10]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmED-0007sN-Op
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmEB-0001L1-Uk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:41 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:34075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmEB-0001Ke-Lr
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:39 -0400
Received: by mail-pl0-x236.google.com with SMTP id g20-v6so1601618plq.1
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:39 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:19 +0800
Message-Id: <20180604095520.8563-12-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 11/12] migration: use lockless Multithread
 model for compression
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
 migration/ram.c | 412 ++++++++++++++++++++++----------------------------------
 1 file changed, 161 insertions(+), 251 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0a38c1c61e..58ecf5caa0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -55,6 +55,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
 #include "savevm.h"
+#include "migration/threads.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -340,21 +341,6 @@ typedef struct PageSearchStatus PageSearchStatus;
 
 CompressionStats compression_counters;
 
-struct CompressParam {
-    bool done;
-    bool quit;
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
@@ -367,15 +353,6 @@ struct DecompressParam {
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
@@ -384,131 +361,6 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset, uint8_t *source_buf);
-
-static void *do_data_compress(void *opaque)
-{
-    CompressParam *param = opaque;
-    RAMBlock *block;
-    ram_addr_t offset;
-
-    qemu_mutex_lock(&param->mutex);
-    while (!param->quit) {
-        if (param->block) {
-            block = param->block;
-            offset = param->offset;
-            param->block = NULL;
-            qemu_mutex_unlock(&param->mutex);
-
-            do_compress_ram_page(param->file, &param->stream, block, offset,
-                                 param->originbuf);
-
-            qemu_mutex_lock(&comp_done_lock);
-            param->done = true;
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
-static inline void terminate_compression_threads(void)
-{
-    int idx, thread_count;
-
-    thread_count = migrate_compress_threads();
-
-    for (idx = 0; idx < thread_count; idx++) {
-        qemu_mutex_lock(&comp_param[idx].mutex);
-        comp_param[idx].quit = true;
-        qemu_cond_signal(&comp_param[idx].cond);
-        qemu_mutex_unlock(&comp_param[idx].mutex);
-    }
-}
-
-static void compress_threads_save_cleanup(void)
-{
-    int i, thread_count;
-
-    if (!migrate_use_compression()) {
-        return;
-    }
-    terminate_compression_threads();
-    thread_count = migrate_compress_threads();
-    for (i = 0; i < thread_count; i++) {
-        /*
-         * we use it as a indicator which shows if the thread is
-         * properly init'd or not
-         */
-        if (!comp_param[i].file) {
-            break;
-        }
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
@@ -965,6 +817,151 @@ static void mig_throttle_guest_down(void)
     }
 }
 
+static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
+{
+    if (!migrate_release_ram() || !migration_in_postcopy()) {
+        return;
+    }
+
+    ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
+}
+
+static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+                                ram_addr_t offset, uint8_t *source_buf)
+{
+    RAMState *rs = ram_state;
+    int bytes_sent, blen;
+    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
+
+    bytes_sent = save_page_header(rs, f, block, offset |
+                                  RAM_SAVE_FLAG_COMPRESS_PAGE);
+
+    /*
+     * copy it to a internal buffer to avoid it being modified by VM
+     * so that we can catch up the error during compression and
+     * decompression
+     */
+    memcpy(source_buf, p, TARGET_PAGE_SIZE);
+    blen = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
+    if (blen < 0) {
+        bytes_sent = 0;
+        qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
+        error_report("compressed data failed!");
+    } else {
+        bytes_sent += blen;
+        ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
+    }
+
+    return bytes_sent;
+}
+
+struct CompressData {
+    /* filled by migration thread.*/
+    RAMBlock *block;
+    ram_addr_t offset;
+
+    /* filled by compress thread. */
+    QEMUFile *file;
+    z_stream stream;
+    uint8_t *originbuf;
+
+    ThreadRequest request;
+};
+typedef struct CompressData CompressData;
+
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
+    do_compress_ram_page(cd->file, &cd->stream, cd->block, cd->offset,
+                         cd->originbuf);
+}
+
+static void compress_thread_data_done(ThreadRequest *request)
+{
+    CompressData *cd = container_of(request, CompressData, request);
+    RAMState *rs = ram_state;
+    int bytes_xmit;
+
+    bytes_xmit = qemu_put_qemu_file(rs->f, cd->file);
+    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE */
+    compression_counters.reduced_size += TARGET_PAGE_SIZE - bytes_xmit + 8;
+    compression_counters.pages++;
+    ram_counters.transferred += bytes_xmit;
+}
+
+static Threads *compress_threads;
+
+static void flush_compressed_data(void)
+{
+    if (!migrate_use_compression()) {
+        return;
+    }
+
+    threads_wait_done(compress_threads);
+}
+
+static void compress_threads_save_cleanup(void)
+{
+    if (!compress_threads) {
+        return;
+    }
+
+    threads_destroy(compress_threads);
+    compress_threads = NULL;
+}
+
+static int compress_threads_save_setup(void)
+{
+    if (!migrate_use_compression()) {
+        return 0;
+    }
+
+    compress_threads = threads_create(migrate_compress_threads(),
+                                      "compress",
+                                      compress_thread_data_init,
+                                      compress_thread_data_fini,
+                                      compress_thread_data_handler,
+                                      compress_thread_data_done);
+    return compress_threads ? 0 : -1;
+}
+
 /**
  * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
  *
@@ -1268,15 +1265,6 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
     return pages;
 }
 
-static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
-{
-    if (!migrate_release_ram() || !migration_in_postcopy()) {
-        return;
-    }
-
-    ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
-}
-
 /*
  * @pages: the number of pages written by the control path,
  *        < 0 - error
@@ -1391,99 +1379,22 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     return pages;
 }
 
-static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset, uint8_t *source_buf)
-{
-    RAMState *rs = ram_state;
-    int bytes_sent, blen;
-    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
-
-    bytes_sent = save_page_header(rs, f, block, offset |
-                                  RAM_SAVE_FLAG_COMPRESS_PAGE);
-
-    /*
-     * copy it to a internal buffer to avoid it being modified by VM
-     * so that we can catch up the error during compression and
-     * decompression
-     */
-    memcpy(source_buf, p, TARGET_PAGE_SIZE);
-    blen = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
-    if (blen < 0) {
-        bytes_sent = 0;
-        qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
-        error_report("compressed data failed!");
-    } else {
-        bytes_sent += blen;
-        ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
-    }
-
-    return bytes_sent;
-}
-
-static void flush_compressed_data(RAMState *rs)
-{
-    int idx, len, thread_count;
-
-    if (!migrate_use_compression()) {
-        return;
-    }
-    thread_count = migrate_compress_threads();
-
-    qemu_mutex_lock(&comp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        while (!comp_param[idx].done) {
-            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
-        }
-    }
-    qemu_mutex_unlock(&comp_done_lock);
-
-    for (idx = 0; idx < thread_count; idx++) {
-        qemu_mutex_lock(&comp_param[idx].mutex);
-        if (!comp_param[idx].quit) {
-            len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
-            compression_counters.pages++;
-            ram_counters.transferred += len;
-        }
-        qemu_mutex_unlock(&comp_param[idx].mutex);
-    }
-}
-
-static inline void set_compress_params(CompressParam *param, RAMBlock *block,
-                                       ram_addr_t offset)
-{
-    param->block = block;
-    param->offset = offset;
-}
-
 static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                                            ram_addr_t offset)
 {
-    int idx, thread_count, bytes_xmit = -1, pages = -1;
+    CompressData *cd;
+    ThreadRequest *request = threads_submit_request_prepare(compress_threads);
 
-    thread_count = migrate_compress_threads();
-    qemu_mutex_lock(&comp_done_lock);
-    for (idx = 0; idx < thread_count; idx++) {
-        if (comp_param[idx].done) {
-            comp_param[idx].done = false;
-            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            qemu_mutex_lock(&comp_param[idx].mutex);
-            set_compress_params(&comp_param[idx], block, offset);
-            qemu_cond_signal(&comp_param[idx].cond);
-            qemu_mutex_unlock(&comp_param[idx].mutex);
-            pages = 1;
-            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-            compression_counters.reduced_size += TARGET_PAGE_SIZE -
-                                                 bytes_xmit + 8;
-            compression_counters.pages++;
-            ram_counters.transferred += bytes_xmit;
-            break;
-        }
-    }
-    qemu_mutex_unlock(&comp_done_lock);
+    if (!request) {
+        compression_counters.busy++;
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
@@ -1522,7 +1433,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
                  */
-                flush_compressed_data(rs);
+                flush_compressed_data();
             }
         }
         /* Didn't find anything this time, but try again on the new block */
@@ -1776,7 +1687,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
          * much CPU resource.
          */
         if (block != rs->last_sent_block) {
-            flush_compressed_data(rs);
+            flush_compressed_data();
         } else {
             /*
              * do not detect zero page as it can be handled very well
@@ -1786,7 +1697,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
             if (res > 0) {
                 return res;
             }
-            compression_counters.busy++;
         }
     }
 
@@ -1994,7 +1904,7 @@ static void ram_save_cleanup(void *opaque)
     }
 
     xbzrle_cleanup();
-    flush_compressed_data(*rsp);
+    flush_compressed_data();
     compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
 }
@@ -2747,7 +2657,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    flush_compressed_data(rs);
+    flush_compressed_data();
     ram_control_after_iterate(f, RAM_CONTROL_FINISH);
 
     rcu_read_unlock();
-- 
2.14.4
