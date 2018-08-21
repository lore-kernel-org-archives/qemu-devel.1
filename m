Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1ks-000409-MB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kr-0004lD-Ko
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:10 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:36713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1kr-0004jb-Ay
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:09 -0400
Received: by mail-pl0-x236.google.com with SMTP id e11-v6so8444796plb.3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:11:09 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:26 +0800
Message-Id: <20180821081029.26121-8-xiaoguangrong@tencent.com>
In-Reply-To: <20180821081029.26121-1-xiaoguangrong@tencent.com>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 07/10] migration: do not
 flush_compressed_data at the end of each iteration
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

flush_compressed_data() needs to wait all compression threads to
finish their work, after that all threads are free until the
migration feeds new request to them, reducing its call can improve
the throughput and use CPU resource more effectively

We do not need to flush all threads at the end of iteration, the
data can be kept locally until the memory block is changed or
memory migration starts over in that case we will meet a dirtied
page which may still exists in compression threads's ring

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 90 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 99ecf9b315..1d54285501 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1602,6 +1602,47 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
     }
 }
 
+static void
+update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
+{
+    if (param->zero_page) {
+        ram_counters.duplicate++;
+    }
+    ram_counters.transferred += bytes_xmit;
+}
+
+static void flush_compressed_data(RAMState *rs)
+{
+    int idx, len, thread_count;
+
+    if (!migrate_use_compression()) {
+        return;
+    }
+    thread_count = migrate_compress_threads();
+
+    qemu_mutex_lock(&comp_done_lock);
+    for (idx = 0; idx < thread_count; idx++) {
+        while (!comp_param[idx].done) {
+            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
+        }
+    }
+    qemu_mutex_unlock(&comp_done_lock);
+
+    for (idx = 0; idx < thread_count; idx++) {
+        qemu_mutex_lock(&comp_param[idx].mutex);
+        if (!comp_param[idx].quit) {
+            len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
+            /*
+             * it's safe to fetch zero_page without holding comp_done_lock
+             * as there is no further request submitted to the thread,
+             * i.e, the thread should be waiting for a request at this point.
+             */
+            update_compress_thread_counts(&comp_param[idx], len);
+        }
+        qemu_mutex_unlock(&comp_param[idx].mutex);
+    }
+}
+
 static void migration_bitmap_sync(RAMState *rs)
 {
     RAMBlock *block;
@@ -1610,6 +1651,14 @@ static void migration_bitmap_sync(RAMState *rs)
 
     ram_counters.dirty_sync_count++;
 
+    /*
+     * if memory migration starts over, we will meet a dirtied page which
+     * may still exists in compression threads's ring, so we should flush
+     * the compressed data to make sure the new page is not overwritten by
+     * the old one in the destination.
+     */
+    flush_compressed_data(rs);
+
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     }
@@ -1878,47 +1927,6 @@ exit:
     return zero_page;
 }
 
-static void
-update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
-{
-    if (param->zero_page) {
-        ram_counters.duplicate++;
-    }
-    ram_counters.transferred += bytes_xmit;
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
-            /*
-             * it's safe to fetch zero_page without holding comp_done_lock
-             * as there is no further request submitted to the thread,
-             * i.e, the thread should be waiting for a request at this point.
-             */
-            update_compress_thread_counts(&comp_param[idx], len);
-        }
-        qemu_mutex_unlock(&comp_param[idx].mutex);
-    }
-}
-
 static inline void set_compress_params(CompressParam *param, RAMBlock *block,
                                        ram_addr_t offset)
 {
-- 
2.14.4
