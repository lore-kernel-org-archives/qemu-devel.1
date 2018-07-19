Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qr-0002FR-40
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qk-0005WT-RM
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:09 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:33069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fg7qk-0005VL-JL
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:02 -0400
Received: by mail-pg1-x529.google.com with SMTP id r5-v6so3591486pgv.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:16:02 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 19 Jul 2018 20:15:18 +0800
Message-Id: <20180719121520.30026-7-xiaoguangrong@tencent.com>
In-Reply-To: <20180719121520.30026-1-xiaoguangrong@tencent.com>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 6/8] migration: move handle of zero page to
 the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Detecting zero page is not a light work, moving it to the thread to
speed the main thread up

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 112 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 34 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5aa624b3b9..e1909502da 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -351,6 +351,7 @@ CompressionStats compression_counters;
 struct CompressParam {
     bool done;
     bool quit;
+    bool zero_page;
     QEMUFile *file;
     QemuMutex mutex;
     QemuCond cond;
@@ -392,7 +393,7 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                  ram_addr_t offset, uint8_t *source_buf);
 
 static void *do_data_compress(void *opaque)
@@ -400,6 +401,7 @@ static void *do_data_compress(void *opaque)
     CompressParam *param = opaque;
     RAMBlock *block;
     ram_addr_t offset;
+    bool zero_page;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -409,11 +411,12 @@ static void *do_data_compress(void *opaque)
             param->block = NULL;
             qemu_mutex_unlock(&param->mutex);
 
-            do_compress_ram_page(param->file, &param->stream, block, offset,
-                                 param->originbuf);
+            zero_page = do_compress_ram_page(param->file, &param->stream,
+                                             block, offset, param->originbuf);
 
             qemu_mutex_lock(&comp_done_lock);
             param->done = true;
+            param->zero_page = zero_page;
             qemu_cond_signal(&comp_done_cond);
             qemu_mutex_unlock(&comp_done_lock);
 
@@ -1871,13 +1874,19 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
     return 1;
 }
 
-static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                  ram_addr_t offset, uint8_t *source_buf)
 {
     RAMState *rs = ram_state;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
+    bool zero_page = false;
     int ret;
 
+    if (save_zero_page_to_file(rs, f, block, offset)) {
+        zero_page = true;
+        goto exit;
+    }
+
     save_page_header(rs, f, block, offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
 
     /*
@@ -1890,10 +1899,12 @@ static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
     if (ret < 0) {
         qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
         error_report("compressed data failed!");
-        return;
+        return false;
     }
 
+exit:
     ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
+    return zero_page;
 }
 
 static void flush_compressed_data(RAMState *rs)
@@ -1917,10 +1928,20 @@ static void flush_compressed_data(RAMState *rs)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
-            compression_counters.pages++;
             ram_counters.transferred += len;
+
+            /*
+             * it's safe to fetch zero_page without holding comp_done_lock
+             * as there is no further request submitted to the thread,
+             * i.e, the thread should be waiting for a request at this point.
+             */
+            if (comp_param[idx].zero_page) {
+                ram_counters.duplicate++;
+            } else {
+                /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+                compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
+                compression_counters.pages++;
+            }
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
     }
@@ -1950,12 +1971,16 @@ retry:
             set_compress_params(&comp_param[idx], block, offset);
             qemu_cond_signal(&comp_param[idx].cond);
             qemu_mutex_unlock(&comp_param[idx].mutex);
-            pages = 1;
-            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-            compression_counters.reduced_size += TARGET_PAGE_SIZE -
-                                                 bytes_xmit + 8;
-            compression_counters.pages++;
             ram_counters.transferred += bytes_xmit;
+            pages = 1;
+            if (comp_param[idx].zero_page) {
+                ram_counters.duplicate++;
+            } else {
+                /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+                compression_counters.reduced_size += TARGET_PAGE_SIZE -
+                                                     bytes_xmit + 8;
+                compression_counters.pages++;
+            }
             break;
         }
     }
@@ -2229,6 +2254,40 @@ static bool save_page_use_compression(RAMState *rs)
     return false;
 }
 
+/*
+ * try to compress the page before post it out, return true if the page
+ * has been properly handled by compression, otherwise needs other
+ * paths to handle it
+ */
+static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
+{
+    if (!save_page_use_compression(rs)) {
+        return false;
+    }
+
+    /*
+     * When starting the process of a new block, the first page of
+     * the block should be sent out before other pages in the same
+     * block, and all the pages in last block should have been sent
+     * out, keeping this order is important, because the 'cont' flag
+     * is used to avoid resending the block name.
+     *
+     * We post the fist page as normal page as compression will take
+     * much CPU resource.
+     */
+    if (block != rs->last_sent_block) {
+        flush_compressed_data(rs);
+        return false;
+    }
+
+    if (compress_page_with_multi_thread(rs, block, offset) > 0) {
+        return true;
+    }
+
+    compression_counters.busy++;
+    return false;
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -2249,15 +2308,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         return res;
     }
 
-    /*
-     * When starting the process of a new block, the first page of
-     * the block should be sent out before other pages in the same
-     * block, and all the pages in last block should have been sent
-     * out, keeping this order is important, because the 'cont' flag
-     * is used to avoid resending the block name.
-     */
-    if (block != rs->last_sent_block && save_page_use_compression(rs)) {
-            flush_compressed_data(rs);
+    if (save_compress_page(rs, block, offset)) {
+        return 1;
     }
 
     res = save_zero_page(rs, block, offset);
@@ -2275,18 +2327,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
     }
 
     /*
-     * Make sure the first page is sent out before other pages.
-     *
-     * we post it as normal page as compression will take much
-     * CPU resource.
-     */
-    if (block == rs->last_sent_block && save_page_use_compression(rs)) {
-        res = compress_page_with_multi_thread(rs, block, offset);
-        if (res > 0) {
-            return res;
-        }
-        compression_counters.busy++;
-    } else if (migrate_use_multifd()) {
+    * do not use multifd for compression as the first page in the new
+    * block should be posted out before sending the compressed page
+    */
+    if (!save_page_use_compression(rs) && migrate_use_multifd()) {
         return ram_save_multifd_page(rs, block, offset);
     }
 
-- 
2.14.4
