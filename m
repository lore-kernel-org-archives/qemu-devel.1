Received: from eggs.gnu.org ([2001:4830:134:3::10]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpX-00070L-DX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpU-0000HN-6X
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpR-0000Fq-JH
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:38 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:49 +0200
Message-Id: <20180822120050.12694-20-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 19/20] migration: move handle of zero page to
 the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Detecting zero page is not a light work, moving it to the thread to
speed the main thread up, btw, handling ram_release_pages() for the
zero page is moved to the thread as well

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 96 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 11066df881..40013e68a1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -341,6 +341,7 @@ typedef struct PageSearchStatus PageSearchStatus;
 struct CompressParam {
     bool done;
     bool quit;
+    bool zero_page;
     QEMUFile *file;
     QemuMutex mutex;
     QemuCond cond;
@@ -382,7 +383,7 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                  ram_addr_t offset, uint8_t *source_buf);
 
 static void *do_data_compress(void *opaque)
@@ -390,6 +391,7 @@ static void *do_data_compress(void *opaque)
     CompressParam *param = opaque;
     RAMBlock *block;
     ram_addr_t offset;
+    bool zero_page;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -399,11 +401,12 @@ static void *do_data_compress(void *opaque)
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
 
@@ -1849,13 +1852,19 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
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
@@ -1868,10 +1877,21 @@ static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
     if (ret < 0) {
         qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
         error_report("compressed data failed!");
-        return;
+        return false;
     }
 
+exit:
     ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
+    return zero_page;
+}
+
+static void
+update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
+{
+    if (param->zero_page) {
+        ram_counters.duplicate++;
+    }
+    ram_counters.transferred += bytes_xmit;
 }
 
 static void flush_compressed_data(RAMState *rs)
@@ -1895,7 +1915,12 @@ static void flush_compressed_data(RAMState *rs)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            ram_counters.transferred += len;
+            /*
+             * it's safe to fetch zero_page without holding comp_done_lock
+             * as there is no further request submitted to the thread,
+             * i.e, the thread should be waiting for a request at this point.
+             */
+            update_compress_thread_counts(&comp_param[idx], len);
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
     }
@@ -1926,7 +1951,7 @@ retry:
             qemu_cond_signal(&comp_param[idx].cond);
             qemu_mutex_unlock(&comp_param[idx].mutex);
             pages = 1;
-            ram_counters.transferred += bytes_xmit;
+            update_compress_thread_counts(&comp_param[idx], bytes_xmit);
             break;
         }
     }
@@ -2200,6 +2225,39 @@ static bool save_page_use_compression(RAMState *rs)
     return false;
 }
 
+/*
+ * try to compress the page before posting it out, return true if the page
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
+    return false;
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -2220,15 +2278,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
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
@@ -2246,17 +2297,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
     }
 
     /*
-     * Make sure the first page is sent out before other pages.
-     *
-     * we post it as normal page as compression will take much
-     * CPU resource.
+     * do not use multifd for compression as the first page in the new
+     * block should be posted out before sending the compressed page
      */
-    if (block == rs->last_sent_block && save_page_use_compression(rs)) {
-        res = compress_page_with_multi_thread(rs, block, offset);
-        if (res > 0) {
-            return res;
-        }
-    } else if (migrate_use_multifd()) {
+    if (!save_page_use_compression(rs) && migrate_use_multifd()) {
         return ram_save_multifd_page(rs, block, offset);
     }
 
-- 
2.17.1
