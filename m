Received: from eggs.gnu.org ([2001:4830:134:3::10]:50486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBCF-0003Fe-7j
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBCC-0004u1-2b
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBCB-0004tO-QU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:43 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:31:06 +0200
Message-Id: <20170628113106.5248-15-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] exec: fix access to ram_list.dirty_memory
 when sync dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

In cpu_physical_memory_sync_dirty_bitmap(rb, start, ...), the 2nd
argument 'start' is relative to the start of the ramblock 'rb'. When
it's used to access the dirty memory bitmap of ram_list (i.e.
ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]->blocks[]), an offset to
the start of all RAM (i.e. rb->offset) should be added to it, which has
however been missed since c/s 6b6712efcc. For a ramblock of host memory
backend whose offset is not zero, cpu_physical_memory_sync_dirty_bitmap()
synchronizes the incorrect part of the dirty memory bitmap of ram_list
to the per ramblock dirty bitmap. As a result, a guest with host
memory backend may crash after migration.

Fix it by adding the offset of ramblock when accessing the dirty memory
bitmap of ram_list in cpu_physical_memory_sync_dirty_bitmap().

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-Id: <20170628083704.24997-1-haozhong.zhang@intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Juan Quintela <quintela@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/exec/ram_addr.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 73d1bea..c04f4f6 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -386,8 +386,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long idx = (page * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset = BIT_WORD((page * BITS_PER_LONG) %
+        unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
+        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
 
         rcu_read_lock();
@@ -414,9 +415,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
 
         rcu_read_unlock();
     } else {
+        ram_addr_t offset = rb->offset;
+
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
             if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr,
+                        start + addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
                 *real_dirty_pages += 1;
-- 
2.9.4
