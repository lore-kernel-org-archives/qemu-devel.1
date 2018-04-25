Received: from eggs.gnu.org ([2001:4830:134:3::10]:45409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdr-0003iL-Pf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdq-00037V-NT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdq-00037E-Ip
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:26 +0100
Message-Id: <20180425200326.72337-17-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 16/16] migration: remove
 ram_save_compressed_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Now, we can reuse the path in ram_save_page() to post the page out
as normal, then the only thing remained in ram_save_compressed_page()
is compression that we can move it out to the caller

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180330075128.26919-11-xiaoguangrong@tencent.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2eb4c0bf49..912810c18e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1184,41 +1184,6 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
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
@@ -1518,8 +1483,14 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
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
2.17.0
