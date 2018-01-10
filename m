Received: from eggs.gnu.org ([2001:4830:134:3::10]:53780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJq-0003j5-GQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJn-0000Zp-2k
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZHJm-0000Z7-LE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBEA14E907
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:25:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jan 2018 15:25:14 +0100
Message-Id: <20180110142515.13242-2-pbonzini@redhat.com>
In-Reply-To: <20180110142515.13242-1-pbonzini@redhat.com>
References: <20180110142515.13242-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] find_ram_offset: Add comments and tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some comments and rename the "end" variable so I can understand the
various nested loops.  Add some tracing so I can see what they're doing.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180105170138.23357-2-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c       | 29 ++++++++++++++++++++++-------
 trace-events |  4 ++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index ff31e7165f..829f9d8d1a 100644
--- a/exec.c
+++ b/exec.c
@@ -1661,7 +1661,10 @@ static void *file_ram_alloc(RAMBlock *block,
 }
 #endif
 
-/* Called with the ramlist lock held.  */
+/* Allocate space within the ram_addr_t space that governs the
+ * dirty bitmaps.
+ * Called with the ramlist lock held.
+ */
 static ram_addr_t find_ram_offset(ram_addr_t size)
 {
     RAMBlock *block, *next_block;
@@ -1674,19 +1677,29 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     }
 
     RAMBLOCK_FOREACH(block) {
-        ram_addr_t end, next = RAM_ADDR_MAX;
+        ram_addr_t candidate, next = RAM_ADDR_MAX;
 
-        end = block->offset + block->max_length;
+        candidate = block->offset + block->max_length;
 
+        /* Search for the closest following block
+         * and find the gap.
+         */
         RAMBLOCK_FOREACH(next_block) {
-            if (next_block->offset >= end) {
+            if (next_block->offset >= candidate) {
                 next = MIN(next, next_block->offset);
             }
         }
-        if (next - end >= size && next - end < mingap) {
-            offset = end;
-            mingap = next - end;
+
+        /* If it fits remember our place and remember the size
+         * of gap, but keep going so that we might find a smaller
+         * gap to fill so avoiding fragmentation.
+         */
+        if (next - candidate >= size && next - candidate < mingap) {
+            offset = candidate;
+            mingap = next - candidate;
         }
+
+        trace_find_ram_offset_loop(size, candidate, offset, next, mingap);
     }
 
     if (offset == RAM_ADDR_MAX) {
@@ -1695,6 +1708,8 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
         abort();
     }
 
+    trace_find_ram_offset(size, offset);
+
     return offset;
 }
 
diff --git a/trace-events b/trace-events
index 3695959d0a..a676b02a20 100644
--- a/trace-events
+++ b/trace-events
@@ -55,6 +55,10 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
+#  # exec.c
+find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%"PRIx64 " @ 0x%"PRIx64
+find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%"PRIx64 " @ 0x%"PRIx64 ," offset: 0x%"PRIx64" next: 0x%"PRIx64 " mingap: 0x%"PRIx64
+
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-- 
2.14.3
