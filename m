Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveoz-0002yi-Pa
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eveoy-0007f5-Un
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:09 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eveoy-0007eP-Ou
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:08 -0400
Received: by mail-pf0-x22d.google.com with SMTP id j20so5540949pfi.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 00:58:08 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 13 Mar 2018 15:57:36 +0800
Message-Id: <20180313075739.11194-6-xiaoguangrong@tencent.com>
In-Reply-To: <20180313075739.11194-1-xiaoguangrong@tencent.com>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 5/8] migration: move calling control_save_page
 to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

The function is called by both ram_save_page and ram_save_target_page,
so move it to the common caller to cleanup the code

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e7b8b14c3c..839665d866 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1020,10 +1020,6 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     p = block->host + offset;
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
-    if (control_save_page(rs, block, offset, &pages)) {
-        return pages;
-    }
-
     XBZRLE_cache_lock();
     pages = save_zero_page(rs, block, offset);
     if (pages > 0) {
@@ -1176,10 +1172,6 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
 
     p = block->host + offset;
 
-    if (control_save_page(rs, block, offset, &pages)) {
-        return pages;
-    }
-
     /* When starting the process of a new block, the first page of
      * the block should be sent out before other pages in the same
      * block, and all the pages in last block should have been sent
@@ -1472,6 +1464,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
 
     /* Check the pages is dirty and if it is send it */
     if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
+        RAMBlock *block = pss->block;
+        ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
+
+        if (control_save_page(rs, block, offset, &res)) {
+            goto page_saved;
+        }
+
         /*
          * If xbzrle is on, stop using the data compression after first
          * round of migration even if compression is enabled. In theory,
@@ -1484,6 +1483,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
             res = ram_save_page(rs, pss, last_stage);
         }
 
+page_saved:
         if (res < 0) {
             return res;
         }
-- 
2.14.3
