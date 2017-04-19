Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiR-0004bR-7r
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiN-0007JH-VU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wiN-0007J4-PR
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A53398123E
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:09 +0200
Message-Id: <20170419205923.8808-46-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 45/59] ram: Pass RAMBlock to bitmap_sync
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
