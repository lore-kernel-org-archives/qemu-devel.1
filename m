Received: from eggs.gnu.org ([2001:4830:134:3::10]:42083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZI-0007xO-IW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZH-00061Z-NT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:16 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZH-00060u-Gg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:15 -0500
Received: by mail-wr0-x243.google.com with SMTP id d9so5043041wre.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:11 +0100
Message-Id: <1515756676-3860-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/52] find_ram_offset: Add comments and tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some comments so I can understand the various nested loops.
Add some tracing so I can see what they're doing.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180105170138.23357-2-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c       | 29 ++++++++++++++++++++++-------
 trace-events |  4 ++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index 4722e52..5e2fb55 100644
--- a/exec.c
+++ b/exec.c
@@ -1660,7 +1660,10 @@ static void *file_ram_alloc(RAMBlock *block,
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
@@ -1673,19 +1676,29 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
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
@@ -1694,6 +1707,8 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
         abort();
     }
 
+    trace_find_ram_offset(size, offset);
+
     return offset;
 }
 
diff --git a/trace-events b/trace-events
index 3695959..ec95e67 100644
--- a/trace-events
+++ b/trace-events
@@ -55,6 +55,10 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
+#  # exec.c
+find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
+find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
+
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-- 
1.8.3.1
