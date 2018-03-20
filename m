Received: from eggs.gnu.org ([2001:4830:134:3::10]:50939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mK-0006ic-Si
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mJ-0008CK-Ov
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mJ-0008C4-Io
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:35 -0400
Date: Tue, 20 Mar 2018 05:17:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-23-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/50] migrate: Update
 ram_block_discard_range for shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The choice of call to discard a block is getting more complicated
for other cases.   We use fallocate PUNCH_HOLE in any file cases;
it works for both hugepage and for tmpfs.
We use the DONTNEED for non-hugepage cases either where they're
anonymous or where they're private.

Care should be taken when trying other backing files.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 exec.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 trace-events |  3 ++-
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index a9181e6..34fdfd9 100644
--- a/exec.c
+++ b/exec.c
@@ -3721,6 +3721,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
     }
 
     if ((start + length) <= rb->used_length) {
+        bool need_madvise, need_fallocate;
         uint8_t *host_endaddr = host_startaddr + length;
         if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
             error_report("ram_block_discard_range: Unaligned end address: %p",
@@ -3730,29 +3731,60 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 
         errno = ENOTSUP; /* If we are missing MADVISE etc */
 
-        if (rb->page_size == qemu_host_page_size) {
-#if defined(CONFIG_MADVISE)
-            /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
-             * freeing the page.
-             */
-            ret = madvise(host_startaddr, length, MADV_DONTNEED);
-#endif
-        } else {
-            /* Huge page case  - unfortunately it can't do DONTNEED, but
-             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
-             * huge page file.
+        /* The logic here is messy;
+         *    madvise DONTNEED fails for hugepages
+         *    fallocate works on hugepages and shmem
+         */
+        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_fallocate = rb->fd != -1;
+        if (need_fallocate) {
+            /* For a file, this causes the area of the file to be zero'd
+             * if read, and for hugetlbfs also causes it to be unmapped
+             * so a userfault will trigger.
              */
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                             start, length);
+            if (ret) {
+                ret = -errno;
+                error_report("ram_block_discard_range: Failed to fallocate "
+                             "%s:%" PRIx64 " +%zx (%d)",
+                             rb->idstr, start, length, ret);
+                goto err;
+            }
+#else
+            ret = -ENOSYS;
+            error_report("ram_block_discard_range: fallocate not available/file"
+                         "%s:%" PRIx64 " +%zx (%d)",
+                         rb->idstr, start, length, ret);
+            goto err;
 #endif
         }
-        if (ret) {
-            ret = -errno;
-            error_report("ram_block_discard_range: Failed to discard range "
+        if (need_madvise) {
+            /* For normal RAM this causes it to be unmapped,
+             * for shared memory it causes the local mapping to disappear
+             * and to fall back on the file contents (which we just
+             * fallocate'd away).
+             */
+#if defined(CONFIG_MADVISE)
+            ret =  madvise(host_startaddr, length, MADV_DONTNEED);
+            if (ret) {
+                ret = -errno;
+                error_report("ram_block_discard_range: Failed to discard range "
+                             "%s:%" PRIx64 " +%zx (%d)",
+                             rb->idstr, start, length, ret);
+                goto err;
+            }
+#else
+            ret = -ENOSYS;
+            error_report("ram_block_discard_range: MADVISE not available"
                          "%s:%" PRIx64 " +%zx (%d)",
                          rb->idstr, start, length, ret);
+            goto err;
+#endif
         }
+        trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
+                                      need_madvise, need_fallocate, ret);
     } else {
         error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
                      "/%zx/" RAM_ADDR_FMT")",
diff --git a/trace-events b/trace-events
index 855b0ab..2c3e3d7 100644
--- a/trace-events
+++ b/trace-events
@@ -55,9 +55,10 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
-#  # exec.c
+# exec.c
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
+ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-- 
MST
