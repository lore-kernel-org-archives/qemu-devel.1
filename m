Received: from eggs.gnu.org ([2001:4830:134:3::10]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176f-00016a-Ch
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176e-0005Dv-CY
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:57 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176e-0005Dc-5z
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:56 -0400
Received: by mail-pl0-x244.google.com with SMTP id g20-v6so1197323plo.9
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:56 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:43 +0800
Message-Id: <20180327091043.30220-11-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 10/10] migration: remove
 ram_save_compressed_page()
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

Now, we can reuse the path in ram_save_page() to post the page out
as normal, then the only thing remained in ram_save_compressed_page()
is compression that we can move it out to the caller

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e71a9aee11..5187455a93 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1186,41 +1186,6 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
     return pages;
 }
 
-/**
- * ram_save_compressed_page: compress the given page and send it to the stream
- *
- * Returns the number of pages written.
- *
- * @rs: current RAM state
- * @block: block that contains the page we want to send
- * @offset: offset inside the block for the page
- * @last_stage: if we are at the completion stage
- */
-static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
-                                    bool last_stage)
-{
-    int pages = -1;
-    uint8_t *p;
-    RAMBlock *block = pss->block;
-    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
-
-    p = block->host + offset;
-
-    if (block != rs->last_sent_block) {
-        /*
-         * Make sure the first page is sent out before other pages.
-         *
-         * we post it as normal page as compression will take much
-         * CPU resource.
-         */
-        pages = save_normal_page(rs, block, offset, p, true);
-    } else {
-        pages = compress_page_with_multi_thread(rs, block, offset);
-    }
-
-    return pages;
-}
-
 /**
  * find_dirty_block: find the next dirty page and update any state
  * associated with the search process.
@@ -1520,8 +1485,14 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         return res;
     }
 
-    if (save_page_use_compression(rs)) {
-        return ram_save_compressed_page(rs, pss, last_stage);
+    /*
+     * Make sure the first page is sent out before other pages.
+     *
+     * we post it as normal page as compression will take much
+     * CPU resource.
+     */
+    if (block == rs->last_sent_block && save_page_use_compression(rs)) {
+        res = compress_page_with_multi_thread(rs, block, offset);
     }
 
     return ram_save_page(rs, pss, last_stage);
-- 
2.14.3
