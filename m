Received: from eggs.gnu.org ([2001:4830:134:3::10]:53000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpM-0003nw-9v
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpL-0005iU-4H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxpK-0005h4-RU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:03 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:29 +0100
Message-Id: <20170824192730.8440-32-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 31/32] vhost: Don't break merged regions on
 small remove/non-adds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The previous patch merges hugepage regions with small gaps
back into one; this patch stops some of the cases that split
them up again.

vhost_set_memory avoids adding small regions that are being
dirty-monitored (typically VGA regions), but vhost_set_memory
does remove these regions from any region they overlap.

Avoid doing that removal if we'll just merge them again.

The typical case is where the VGA regions dynamically change
at run time after we've done the merge; although the merge works, the
result is that the memory is marked as having changed and
a set_mem_table message is transmitted.  By avoiding the split
we avoid the join and we avoid marking the regions as having
changed, and thus avoid sending the set_mem_table.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  2 ++
 hw/virtio/vhost.c      | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f98efb39fd..e22d2055b0 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -10,6 +10,8 @@ vhost_huge_page_stretch_and_merge_can(void) ""
 vhost_huge_page_stretch_and_merge_size_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
 vhost_huge_page_stretch_and_merge_start_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
+vhost_dev_would_remerge_no(uint64_t start_addr, uint64_t size) "0x%"PRIx64" + 0x%"PRIx64
+vhost_dev_would_remerge_yes(uint64_t start_addr, uint64_t size) "0x%"PRIx64" + 0x%"PRIx64
 
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_end_entry(void) ""
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fb506e747f..18714f6d03 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -564,6 +564,43 @@ static bool vhost_dev_cmp_memory(struct vhost_dev *dev,
     return uaddr != reg->userspace_addr + start_addr - reg->guest_phys_addr;
 }
 
+/* Called by vhost_set_memory on removal where start_addr/size have
+ * been found to correspond to an existing region (reg).
+ * Returns True iff removing the section would be undone later
+ * by merging (for hugepage) and thus there's no point in removing it.
+ */
+static bool vhost_dev_would_remerge(struct vhost_dev *dev,
+                                    struct vhost_memory_region *reg,
+                                    hwaddr start_addr, ram_addr_t size)
+{
+    uint64_t reglast = range_get_last(reg->guest_phys_addr, reg->memory_size);
+    uint64_t memlast = range_get_last(start_addr, size);
+    ram_addr_t offset;
+    RAMBlock *rb = qemu_ram_block_from_host((void *)reg->userspace_addr,
+                                            false, &offset);
+    size_t reg_pagesize = qemu_ram_pagesize(rb);
+
+    /* If the region being deleted hangs over the end of the existing
+     * region, it's not a case we're interested in.
+     * If it's just a normal sized page then there won't normally be any
+     * alignment merging going on.
+     * and if the hole being cut is larger than the pagesize of the
+     * region then assume it won't be remerged.
+     */
+    if (memlast > reglast || start_addr < reg->guest_phys_addr ||
+        reg_pagesize == getpagesize() ||
+        size >= reg_pagesize) {
+        trace_vhost_dev_would_remerge_no(start_addr, size);
+        return false;
+    }
+
+    /* This is a small chunk overlapping a big hugepage region,
+     * deleting it will get remerged
+     */
+    trace_vhost_dev_would_remerge_yes(start_addr, size);
+    return true;
+}
+
 static void vhost_set_memory(MemoryListener *listener,
                              MemoryRegionSection *section,
                              bool add)
@@ -594,7 +631,10 @@ static void vhost_set_memory(MemoryListener *listener,
             return;
         }
     } else {
-        if (!vhost_dev_find_reg(dev, start_addr, size)) {
+        struct vhost_memory_region *reg = vhost_dev_find_reg(dev,
+                                                             start_addr,
+                                                             size);
+        if (!reg || vhost_dev_would_remerge(dev, reg, start_addr, size)) {
             /* Removing region that we don't access. Nothing to do. */
             return;
         }
-- 
2.13.5
