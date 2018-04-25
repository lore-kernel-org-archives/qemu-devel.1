Received: from eggs.gnu.org ([2001:4830:134:3::10]:45357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdo-0003fF-20
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdn-00035X-5s
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdn-00035M-18
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:23 +0100
Message-Id: <20180425200326.72337-14-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 13/16] migration: move calling control_save_page
 to the common place
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

The function is called by both ram_save_page and ram_save_target_page,
so move it to the common caller to cleanup the code

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180330075128.26919-8-xiaoguangrong@tencent.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c3628b020e..e0caf7182b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1037,10 +1037,6 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     p = block->host + offset;
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
-    if (control_save_page(rs, block, offset, &pages)) {
-        return pages;
-    }
-
     XBZRLE_cache_lock();
     pages = save_zero_page(rs, block, offset);
     if (pages > 0) {
@@ -1198,10 +1194,6 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
 
     p = block->host + offset;
 
-    if (control_save_page(rs, block, offset, &pages)) {
-        return pages;
-    }
-
     /* When starting the process of a new block, the first page of
      * the block should be sent out before other pages in the same
      * block, and all the pages in last block should have been sent
@@ -1489,6 +1481,14 @@ err:
 static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
                                 bool last_stage)
 {
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
+    int res;
+
+    if (control_save_page(rs, block, offset, &res)) {
+        return res;
+    }
+
     /*
      * If xbzrle is on, stop using the data compression after first
      * round of migration even if compression is enabled. In theory,
-- 
2.17.0
