Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCj-000382-13
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCi-0007nR-7t
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XCi-0007nL-2K
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDE56A13E3
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:26 +0200
Message-Id: <20170421115646.15544-46-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 45/65] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

We change the meaning of start to be the offset from the beggining of
the block.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/ram_addr.h | 2 ++
 migration/ram.c         | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9aadc5c..8a1372c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -354,11 +354,13 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
 
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
+                                               RAMBlock *rb,
                                                ram_addr_t start,
                                                ram_addr_t length,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
+    start = rb->offset + start;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
 
diff --git a/migration/ram.c b/migration/ram.c
index fe01e7b..3f3842a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -646,13 +646,13 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
     return ret;
 }
 
-static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
-                                        ram_addr_t length)
+static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
+                                        ram_addr_t start, ram_addr_t length)
 {
     unsigned long *bitmap;
     bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     rs->migration_dirty_pages +=
-        cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length,
+        cpu_physical_memory_sync_dirty_bitmap(bitmap, rb, start, length,
                                               &rs->num_dirty_pages_period);
 }
 
@@ -699,7 +699,7 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        migration_bitmap_sync_range(rs, block->offset, block->used_length);
+        migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
-- 
2.9.3
