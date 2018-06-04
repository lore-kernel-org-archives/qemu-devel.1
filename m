Received: from eggs.gnu.org ([2001:4830:134:3::10]:46552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDw-0007bL-Km
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDv-0001CA-Og
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:24 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDv-0001Bs-Ir
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:23 -0400
Received: by mail-pl0-x243.google.com with SMTP id g20-v6so1601248plq.1
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:23 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:14 +0800
Message-Id: <20180604095520.8563-7-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 06/12] migration: do not detect zero page for
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Detecting zero page is not a light work, we can disable it
for compression that can handle all zero data very well

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 80914b747e..15b20d3f70 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1760,15 +1760,30 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
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
+    if (save_page_use_compression(rs)) {
+        /*
+         * When starting the process of a new block, the first page of
+         * the block should be sent out before other pages in the same
+         * block, and all the pages in last block should have been sent
+         * out, keeping this order is important, because the 'cont' flag
+         * is used to avoid resending the block name.
+         *
+         * We post the fist page as normal page as compression will take
+         * much CPU resource.
+         */
+        if (block != rs->last_sent_block) {
             flush_compressed_data(rs);
+        } else {
+            /*
+             * do not detect zero page as it can be handled very well
+             * for compression
+             */
+            res = compress_page_with_multi_thread(rs, block, offset);
+            if (res > 0) {
+                return res;
+            }
+            compression_counters.busy++;
+        }
     }
 
     res = save_zero_page(rs, block, offset);
@@ -1785,19 +1800,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         return res;
     }
 
-    /*
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
-    }
 
     return ram_save_page(rs, pss, last_stage);
 }
-- 
2.14.4
