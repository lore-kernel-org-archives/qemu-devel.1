Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NP-0000nV-F8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NO-0003H8-My
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e54NO-0003GT-GV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BAA51E328
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:32:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Oct 2017 14:32:00 +0800
Message-Id: <20171019063200.19048-5-peterx@redhat.com>
In-Reply-To: <20171019063200.19048-1-peterx@redhat.com>
References: <20171019063200.19048-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] migration: new ram_init_bitmaps()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Rearrange the bitmap initialization and the first sync.  Since at it,
make sure the locks are taken/released in correct order (I moved RCU
unlock upper - though it may not affect much).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 3df7715d63..0d24fc12f4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2099,30 +2099,15 @@ static int ram_state_init(RAMState **rsp)
     return 0;
 }
 
-static int ram_init_all(RAMState **rsp)
+static void ram_list_init_bitmaps(void)
 {
-    if (ram_state_init(rsp)) {
-        return -1;
-    }
-
-    if (xbzrle_init()) {
-        ram_state_cleanup(rsp);
-        return -1;
-    }
-
-    /* For memory_global_dirty_log_start below.  */
-    qemu_mutex_lock_iothread();
-
-    qemu_mutex_lock_ramlist();
-    rcu_read_lock();
+    RAMBlock *block;
+    unsigned long pages;
 
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        RAMBlock *block;
-
         QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-            unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
-
+            pages = block->max_length >> TARGET_PAGE_BITS;
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
             if (migrate_postcopy_ram()) {
@@ -2131,12 +2116,36 @@ static int ram_init_all(RAMState **rsp)
             }
         }
     }
+}
+
+static void ram_init_bitmaps(RAMState *rs)
+{
+    /* For memory_global_dirty_log_start below.  */
+    qemu_mutex_lock_iothread();
+    qemu_mutex_lock_ramlist();
+    rcu_read_lock();
 
+    ram_list_init_bitmaps();
     memory_global_dirty_log_start();
-    migration_bitmap_sync(*rsp);
+    migration_bitmap_sync(rs);
+
+    rcu_read_unlock();
     qemu_mutex_unlock_ramlist();
     qemu_mutex_unlock_iothread();
-    rcu_read_unlock();
+}
+
+static int ram_init_all(RAMState **rsp)
+{
+    if (ram_state_init(rsp)) {
+        return -1;
+    }
+
+    if (xbzrle_init()) {
+        ram_state_cleanup(rsp);
+        return -1;
+    }
+
+    ram_init_bitmaps(*rsp);
 
     return 0;
 }
-- 
2.13.5
