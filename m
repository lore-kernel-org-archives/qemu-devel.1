Received: from eggs.gnu.org ([209.51.188.92]:54457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj9-0005XH-22
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj7-000352-6N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:44784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hLJj5-00032B-AZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:39 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 30 Apr 2019 11:44:12 +0800
Message-Id: <20190430034412.12935-4-richardw.yang@linux.intel.com>
In-Reply-To: <20190430034412.12935-1-richardw.yang@linux.intel.com>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] ram: RAMBlock->offset is always aligned to
 a word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

RAMBlock->offset is calculated by find_ram_offset, which makes sure the
offset is aligned to a word.

This patch removes the alignment check on offset and unnecessary
variable *word*.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/exec/ram_addr.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3dfb2d52fb..a7c81bdb32 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -413,18 +413,21 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
-    unsigned long word = BIT_WORD(rb->offset >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
 
-    /* offset and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) == (rb->offset) &&
-        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+    /*
+     * Since RAMBlock->offset is guaranteed to be aligned to a word by
+     * find_ram_offset(), if length is aligned at the start of a word, go the
+     * fast path.
+     */
+    if (!(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
+        unsigned long idx = (rb->offset >> TARGET_PAGE_BITS) /
+                            DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = BIT_WORD((rb->offset >> TARGET_PAGE_BITS) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
 
         rcu_read_lock();
-- 
2.19.1
