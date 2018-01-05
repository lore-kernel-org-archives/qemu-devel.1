Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXVNN-0002u5-79
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXVNM-0000R3-9o
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXVNL-0000QA-WD
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32DE376545
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:02:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  5 Jan 2018 17:01:37 +0000
Message-Id: <20180105170138.23357-2-dgilbert@redhat.com>
In-Reply-To: <20180105170138.23357-1-dgilbert@redhat.com>
References: <20180105170138.23357-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] find_ram_offset: Add comments and tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some comments so I can understand the various nested loops.
Add some tracing so I can see what they're doing.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c       | 17 ++++++++++++++++-
 trace-events |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5973c666c8..7966570231 100644
--- a/exec.c
+++ b/exec.c
@@ -1665,7 +1665,10 @@ static void *file_ram_alloc(RAMBlock *block,
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
@@ -1682,15 +1685,25 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
 
         end = block->offset + block->max_length;
 
+        /* Search for the closest following block
+         * and find the gap.
+         */
         RAMBLOCK_FOREACH(next_block) {
             if (next_block->offset >= end) {
                 next = MIN(next, next_block->offset);
             }
         }
+
+        /* If it fits remember our place and remember the size
+         * of gap, but keep going so that we might find a smaller
+         * gap to fill so avoiding fragmentation.
+         */
         if (next - end >= size && next - end < mingap) {
             offset = end;
             mingap = next - end;
         }
+
+        trace_find_ram_offset_loop(size, offset, end, next, mingap);
     }
 
     if (offset == RAM_ADDR_MAX) {
@@ -1699,6 +1712,8 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
         abort();
     }
 
+    trace_find_ram_offset(size, offset);
+
     return offset;
 }
 
diff --git a/trace-events b/trace-events
index a8861bd800..23bc036aa1 100644
--- a/trace-events
+++ b/trace-events
@@ -56,6 +56,9 @@ dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
 # exec.c
+find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%"PRIx64 " @ 0x%"PRIx64
+find_ram_offset_loop(uint64_t size, uint64_t offset, uint64_t end, uint64_t next, uint64_t mingap) "size: 0x%"PRIx64 " @ 0x%"PRIx64 " end: 0x%"PRIx64" next: 0x%"PRIx64 " mingap: 0x%"PRIx64
+
 ram_block_discard_range(const char *rbname, void *hva, bool need_madvise, bool need_fallocate, int ret) "%s@%p: madvise: %d fallocate: %d ret: %d"
 
 # memory.c
-- 
2.14.3
