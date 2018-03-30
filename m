Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1oot-00022F-Qh
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1oos-0007fS-Sj
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:31 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1oos-0007fH-Md
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:30 -0400
Received: by mail-pg0-x242.google.com with SMTP id h3so605482pgq.7
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 00:51:30 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Fri, 30 Mar 2018 15:51:25 +0800
Message-Id: <20180330075128.26919-8-xiaoguangrong@tencent.com>
In-Reply-To: <20180330075128.26919-1-xiaoguangrong@tencent.com>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 07/10] migration: move calling
 control_save_page to the common place
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

The function is called by both ram_save_page and ram_save_target_page,
so move it to the common caller to cleanup the code

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
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
2.14.3
