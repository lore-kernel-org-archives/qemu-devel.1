Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ooj-0001vP-6I
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1oog-0007cS-2z
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:21 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1oof-0007bw-QZ
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:18 -0400
Received: by mail-pg0-x242.google.com with SMTP id b9so4667317pgf.6
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 00:51:17 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Fri, 30 Mar 2018 15:51:21 +0800
Message-Id: <20180330075128.26919-4-xiaoguangrong@tencent.com>
In-Reply-To: <20180330075128.26919-1-xiaoguangrong@tencent.com>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 03/10] migration: stop decompression to
 allocate and free memory frequently
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

Current code uses uncompress() to decompress memory which manages
memory internally, that causes huge memory is allocated and freed
very frequently, more worse, frequently returning memory to kernel
will flush TLBs

So, we maintain the memory by ourselves and reuse it for each
decompression

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 112 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a21514a469..fb24b2f32f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -281,6 +281,7 @@ struct DecompressParam {
     void *des;
     uint8_t *compbuf;
     int len;
+    z_stream stream;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -2524,6 +2525,31 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
     }
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
 static void *do_data_decompress(void *opaque)
 {
     DecompressParam *param = opaque;
@@ -2540,13 +2566,13 @@ static void *do_data_decompress(void *opaque)
             qemu_mutex_unlock(&param->mutex);
 
             pagesize = TARGET_PAGE_SIZE;
-            /* uncompress() will return failed in some case, especially
-             * when the page is dirted when doing the compression, it's
-             * not a problem because the dirty page will be retransferred
+            /* qemu_uncompress_data() will return failed in some case,
+             * especially when the page is dirtied when doing the compression,
+             * it's not a problem because the dirty page will be retransferred
              * and uncompress() won't break the data in other pages.
              */
-            uncompress((Bytef *)des, &pagesize,
-                       (const Bytef *)param->compbuf, len);
+            qemu_uncompress_data(&param->stream, des, pagesize, param->compbuf,
+                                 len);
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2581,30 +2607,6 @@ static void wait_for_decompress_done(void)
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
@@ -2614,16 +2616,30 @@ static void compress_threads_load_cleanup(void)
     }
     thread_count = migrate_decompress_threads();
     for (i = 0; i < thread_count; i++) {
+        /*
+         * we use it as a indicator which shows if the thread is
+         * properly init'd or not
+         */
+        if (!decomp_param[i].compbuf) {
+            break;
+        }
+
         qemu_mutex_lock(&decomp_param[i].mutex);
         decomp_param[i].quit = true;
         qemu_cond_signal(&decomp_param[i].cond);
         qemu_mutex_unlock(&decomp_param[i].mutex);
     }
     for (i = 0; i < thread_count; i++) {
+        if (!decomp_param[i].compbuf) {
+            break;
+        }
+
         qemu_thread_join(decompress_threads + i);
         qemu_mutex_destroy(&decomp_param[i].mutex);
         qemu_cond_destroy(&decomp_param[i].cond);
+        inflateEnd(&decomp_param[i].stream);
         g_free(decomp_param[i].compbuf);
+        decomp_param[i].compbuf = NULL;
     }
     g_free(decompress_threads);
     g_free(decomp_param);
@@ -2631,6 +2647,39 @@ static void compress_threads_load_cleanup(void)
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
+
+        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
+        qemu_mutex_init(&decomp_param[i].mutex);
+        qemu_cond_init(&decomp_param[i].cond);
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
@@ -2670,8 +2719,11 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
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
