Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD7-0003WE-3v
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD6-0007ty-6l
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XD5-0007tn-UA
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D131D83F45
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:40 +0200
Message-Id: <20170421115646.15544-60-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 59/65] ram: Remove migration_bitmap_extend()
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

We have disabled memory hotplug, so we don't need to handle
migration_bitamp there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 exec.c                  |  1 -
 include/exec/ram_addr.h |  2 --
 migration/ram.c         | 34 ----------------------------------
 3 files changed, 37 deletions(-)

diff --git a/exec.c b/exec.c
index de843f4..c2def9e 100644
--- a/exec.c
+++ b/exec.c
@@ -1758,7 +1758,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     new_ram_size = MAX(old_ram_size,
               (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
     if (new_ram_size > old_ram_size) {
-        migration_bitmap_extend(old_ram_size, new_ram_size);
         dirty_memory_extend(old_ram_size, new_ram_size);
     }
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index a8411c7..c9ddcd0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -413,7 +413,5 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
 
     return num_dirty;
 }
-
-void migration_bitmap_extend(ram_addr_t old, ram_addr_t new);
 #endif
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 2af8080..f48664e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1496,40 +1496,6 @@ static void ram_state_reset(RAMState *rs)
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
 
-void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
-{
-    RAMState *rs = &ram_state;
-
-    /* called in qemu main thread, so there is
-     * no writing race against this migration_bitmap
-     */
-    if (rs->ram_bitmap) {
-        RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
-        bitmap = g_new(RAMBitmap, 1);
-        bitmap->bmap = bitmap_new(new);
-
-        /* prevent migration_bitmap content from being set bit
-         * by migration_bitmap_sync_range() at the same time.
-         * it is safe to migration if migration_bitmap is cleared bit
-         * at the same time.
-         */
-        qemu_mutex_lock(&rs->bitmap_mutex);
-        bitmap_copy(bitmap->bmap, old_bitmap->bmap, old);
-        bitmap_set(bitmap->bmap, old, new - old);
-
-        /* We don't have a way to safely extend the sentmap
-         * with RCU; so mark it as missing, entry to postcopy
-         * will fail.
-         */
-        bitmap->unsentmap = NULL;
-
-        atomic_rcu_set(&rs->ram_bitmap, bitmap);
-        qemu_mutex_unlock(&rs->bitmap_mutex);
-        rs->migration_dirty_pages += new - old;
-        call_rcu(old_bitmap, migration_bitmap_free, rcu);
-    }
-}
-
 /*
  * 'expected' is the value you expect the bitmap mostly to be full
  * of; it won't bother printing lines that are all this value.
-- 
2.9.3
