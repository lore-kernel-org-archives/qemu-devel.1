Received: from eggs.gnu.org ([2001:4830:134:3::10]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVEZd-0001Zo-IU
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVEZa-00085U-Fq
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVEZa-00084q-7F
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:36:30 -0500
Date: Sun, 22 Jan 2017 17:36:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122093625.GD26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170122085118.GA26526@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Sun, Jan 22, 2017 at 04:51:18PM +0800, Peter Xu wrote:
> On Sun, Jan 22, 2017 at 03:56:10PM +0800, Jason Wang wrote:
> 
> [...]
> 
> > >+/**
> > >+ * vtd_page_walk_level - walk over specific level for IOVA range
> > >+ *
> > >+ * @addr: base GPA addr to start the walk
> > >+ * @start: IOVA range start address
> > >+ * @end: IOVA range end address (start <= addr < end)
> > >+ * @hook_fn: hook func to be called when detected page
> > >+ * @private: private data to be passed into hook func
> > >+ * @read: whether parent level has read permission
> > >+ * @write: whether parent level has write permission
> > >+ * @skipped: accumulated skipped ranges
> > 
> > What's the usage for this parameter? Looks like it was never used in this
> > series.
> 
> This was for debugging purpose before, and I kept it in case one day
> it can be used again, considering that will not affect much on the
> overall performance.
> 
> > 
> > >+ * @notify_unmap: whether we should notify invalid entries
> > >+ */
> > >+static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> > >+                               uint64_t end, vtd_page_walk_hook hook_fn,
> > >+                               void *private, uint32_t level,
> > >+                               bool read, bool write, uint64_t *skipped,
> > >+                               bool notify_unmap)
> > >+{
> > >+    bool read_cur, write_cur, entry_valid;
> > >+    uint32_t offset;
> > >+    uint64_t slpte;
> > >+    uint64_t subpage_size, subpage_mask;
> > >+    IOMMUTLBEntry entry;
> > >+    uint64_t iova = start;
> > >+    uint64_t iova_next;
> > >+    uint64_t skipped_local = 0;
> > >+    int ret = 0;
> > >+
> > >+    trace_vtd_page_walk_level(addr, level, start, end);
> > >+
> > >+    subpage_size = 1ULL << vtd_slpt_level_shift(level);
> > >+    subpage_mask = vtd_slpt_level_page_mask(level);
> > >+
> > >+    while (iova < end) {
> > >+        iova_next = (iova & subpage_mask) + subpage_size;
> > >+
> > >+        offset = vtd_iova_level_offset(iova, level);
> > >+        slpte = vtd_get_slpte(addr, offset);
> > >+
> > >+        /*
> > >+         * When one of the following case happens, we assume the whole
> > >+         * range is invalid:
> > >+         *
> > >+         * 1. read block failed
> > 
> > Don't get the meaning (and don't see any code relate to this comment).
> 
> I took above vtd_get_slpte() a "read", so I was trying to mean that we
> failed to read the SLPTE due to some reason, we assume the range is
> invalid.
> 
> > 
> > >+         * 3. reserved area non-zero
> > >+         * 2. both read & write flag are not set
> > 
> > Should be 1,2,3? And the above comment is conflict with the code at least
> > when notify_unmap is true.
> 
> Yes, okay I don't know why 3 jumped. :(
> 
> And yes, I should mention that "both read & write flag not set" only
> suites for page tables here.
> 
> > 
> > >+         */
> > >+
> > >+        if (slpte == (uint64_t)-1) {
> > 
> > If this is true, vtd_slpte_nonzero_rsvd(slpte) should be true too I think?
> 
> Yes, but we are doing two checks here:
> 
> - checking against -1 to make sure slpte read success
> - checking against nonzero reserved fields to make sure it follows spec
> 
> Imho we should not skip the first check here, only if one day removing
> this may really matter (e.g., for performance reason? I cannot think
> of one yet).
> 
> > 
> > >+            trace_vtd_page_walk_skip_read(iova, iova_next);
> > >+            skipped_local++;
> > >+            goto next;
> > >+        }
> > >+
> > >+        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> > >+            trace_vtd_page_walk_skip_reserve(iova, iova_next);
> > >+            skipped_local++;
> > >+            goto next;
> > >+        }
> > >+
> > >+        /* Permissions are stacked with parents' */
> > >+        read_cur = read && (slpte & VTD_SL_R);
> > >+        write_cur = write && (slpte & VTD_SL_W);
> > >+
> > >+        /*
> > >+         * As long as we have either read/write permission, this is
> > >+         * a valid entry. The rule works for both page or page tables.
> > >+         */
> > >+        entry_valid = read_cur | write_cur;
> > >+
> > >+        if (vtd_is_last_slpte(slpte, level)) {
> > >+            entry.target_as = &address_space_memory;
> > >+            entry.iova = iova & subpage_mask;
> > >+            /*
> > >+             * This might be meaningless addr if (!read_cur &&
> > >+             * !write_cur), but after all this field will be
> > >+             * meaningless in that case, so let's share the code to
> > >+             * generate the IOTLBs no matter it's an MAP or UNMAP
> > >+             */
> > >+            entry.translated_addr = vtd_get_slpte_addr(slpte);
> > >+            entry.addr_mask = ~subpage_mask;
> > >+            entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
> > >+            if (!entry_valid && !notify_unmap) {
> > >+                trace_vtd_page_walk_skip_perm(iova, iova_next);
> > >+                skipped_local++;
> > >+                goto next;
> > >+            }
> > 
> > Under which case should we care about unmap here (better with a comment I
> > think)?
> 
> When PSIs are for invalidation, rather than newly mapped entries. In
> that case, notify_unmap will be true, and here we need to notify
> IOMMU_NONE to do the cache flush or unmap.
> 
> (this page walk is not only for replaying, it is for cache flushing as
>  well)
> 
> Do you have suggestion on the comments?

Besides this one, I tried to fix the comments in this function as
below, hope this is better (I removed 1-3 thing since I think that's
clearer from below code):

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e958f53..f3fe8c4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -735,15 +735,6 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
         offset = vtd_iova_level_offset(iova, level);
         slpte = vtd_get_slpte(addr, offset);

-        /*
-         * When one of the following case happens, we assume the whole
-         * range is invalid:
-         *
-         * 1. read block failed
-         * 3. reserved area non-zero
-         * 2. both read & write flag are not set
-         */
-
         if (slpte == (uint64_t)-1) {
             trace_vtd_page_walk_skip_read(iova, iova_next);
             skipped_local++;
@@ -761,20 +752,16 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
         write_cur = write && (slpte & VTD_SL_W);

         /*
-         * As long as we have either read/write permission, this is
-         * a valid entry. The rule works for both page or page tables.
+         * As long as we have either read/write permission, this is a
+         * valid entry. The rule works for both page entries and page
+         * table entries.
          */
         entry_valid = read_cur | write_cur;

         if (vtd_is_last_slpte(slpte, level)) {
             entry.target_as = &address_space_memory;
             entry.iova = iova & subpage_mask;
-            /*
-             * This might be meaningless addr if (!read_cur &&
-             * !write_cur), but after all this field will be
-             * meaningless in that case, so let's share the code to
-             * generate the IOTLBs no matter it's an MAP or UNMAP
-             */
+            /* NOTE: this is only meaningful if entry_valid == true */
             entry.translated_addr = vtd_get_slpte_addr(slpte);
             entry.addr_mask = ~subpage_mask;
             entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);

Thanks,

-- peterx
