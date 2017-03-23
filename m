Received: from eggs.gnu.org ([2001:4830:134:3::10]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9go-0003CF-9h
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9gm-0002FQ-IT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9gm-0002FH-AN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 184DC8B13F
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:50:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:50:25 +0100
Message-Id: <20170323205025.12113-3-quintela@redhat.com>
In-Reply-To: <20170323205025.12113-1-quintela@redhat.com>
References: <20170323205025.12113-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] ram: remove migration_bitmap_extend()
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
---
 exec.c                  |  1 -
 include/exec/ram_addr.h |  2 --
 migration/ram.c         | 34 ----------------------------------
 3 files changed, 37 deletions(-)

diff --git a/exec.c b/exec.c
index 2cae288..e51e1b1 100644
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
index bbbfc7d..c246b55 100644
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
index 4d62788..045b899 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1494,40 +1494,6 @@ static void ram_state_reset(RAMState *rs)
 
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
