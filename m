Received: from eggs.gnu.org ([2001:4830:134:3::10]:46459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDh-0007QU-RF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDf-00014f-OZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:09 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDf-000140-IN
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:07 -0400
Received: by mail-pg0-x232.google.com with SMTP id e11-v6so5057011pgq.0
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:07 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:09 +0800
Message-Id: <20180604095520.8563-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 01/12] migration: do not wait if no free thread
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

Instead of putting the main thread to sleep state to wait for
free compression thread, we can directly post it out as normal
page that reduces the latency and uses CPUs more efficiently

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5bcbf7a9f9..0caf32ab0a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1423,25 +1423,18 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
-    while (true) {
-        for (idx = 0; idx < thread_count; idx++) {
-            if (comp_param[idx].done) {
-                comp_param[idx].done = false;
-                bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-                qemu_mutex_lock(&comp_param[idx].mutex);
-                set_compress_params(&comp_param[idx], block, offset);
-                qemu_cond_signal(&comp_param[idx].cond);
-                qemu_mutex_unlock(&comp_param[idx].mutex);
-                pages = 1;
-                ram_counters.normal++;
-                ram_counters.transferred += bytes_xmit;
-                break;
-            }
-        }
-        if (pages > 0) {
+    for (idx = 0; idx < thread_count; idx++) {
+        if (comp_param[idx].done) {
+            comp_param[idx].done = false;
+            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
+            qemu_mutex_lock(&comp_param[idx].mutex);
+            set_compress_params(&comp_param[idx], block, offset);
+            qemu_cond_signal(&comp_param[idx].cond);
+            qemu_mutex_unlock(&comp_param[idx].mutex);
+            pages = 1;
+            ram_counters.normal++;
+            ram_counters.transferred += bytes_xmit;
             break;
-        } else {
-            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
         }
     }
     qemu_mutex_unlock(&comp_done_lock);
@@ -1755,7 +1748,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
      * CPU resource.
      */
     if (block == rs->last_sent_block && save_page_use_compression(rs)) {
-        return compress_page_with_multi_thread(rs, block, offset);
+        res = compress_page_with_multi_thread(rs, block, offset);
+        if (res > 0) {
+            return res;
+        }
     }
 
     return ram_save_page(rs, pss, last_stage);
-- 
2.14.4
