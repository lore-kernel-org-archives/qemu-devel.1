Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhc-0002a6-SF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhZ-0004vb-Ru
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:19560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhZ-0004uM-GX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:13 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:40 +0800
Message-Id: <1484124524-481-3-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 2/6] virtio-balloon: speed up inflating
 & deflating process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

The implementation of the current virtio-balloon is not very
efficient, the time spends on different stages of inflating
the balloon to 7GB of a 8GB idle guest:

a. allocating pages (6.5%)
b. sending PFNs to host (68.3%)
c. address translation (6.1%)
d. madvise (19%)

It takes about 4126ms for the inflating process to complete.
Debugging shows that the bottle neck are the stage b and stage d.

If using {pfn|length} arrays to send the page info instead of the
PFNs, we can reduce the overhead in stage b quite a lot. Furthermore,
we can do address translation and call madvise() with a bulk of
RAM pages, instead of the current page per page way, the overhead
of stage c and stage d can also be reduced a lot.

This patch is the kernel side implementation which is intended to
speed up the inflating & deflating process by adding a new feature
to the virtio-balloon device. With this new feature, inflating the
balloon to 7GB of a 8GB idle guest only takes 590ms, the
performance improvement is about 85%.

TODO: optimize stage a by allocating/freeing a chunk of pages
instead of a single page at a time.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 142 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 25 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a705e0e..4ab65ba 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,6 +31,7 @@
 #include "hw/virtio/virtio-access.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
+#define BALLOON_NR_PFN_MASK ((1 << VIRTIO_BALLOON_NR_PFN_BITS) - 1)
 
 static void balloon_page(void *addr, int deflate)
 {
@@ -52,6 +53,69 @@ static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_NR] = NULL
 };
 
+static void do_balloon_bulk_pages(ram_addr_t base_pfn,
+                                  ram_addr_t size, bool deflate)
+{
+    ram_addr_t processed, chunk, base;
+    MemoryRegionSection section = {.mr = NULL};
+
+    base = base_pfn * TARGET_PAGE_SIZE;
+
+    for (processed = 0; processed < size; processed += chunk) {
+        chunk = size - processed;
+        while (chunk >= TARGET_PAGE_SIZE) {
+            section = memory_region_find(get_system_memory(),
+                                         base + processed, chunk);
+            if (!section.mr) {
+                chunk = QEMU_ALIGN_DOWN(chunk / 2, TARGET_PAGE_SIZE);
+            } else {
+                break;
+            }
+        }
+
+        if (!section.mr || !int128_nz(section.size) ||
+            !memory_region_is_ram(section.mr) ||
+            memory_region_is_rom(section.mr) ||
+            memory_region_is_romd(section.mr)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid guest RAM range [0x%lx, 0x%lx]\n",
+                          base + processed, chunk);
+            chunk = TARGET_PAGE_SIZE;
+        } else {
+            void *addr = section.offset_within_region +
+                   memory_region_get_ram_ptr(section.mr);
+
+            qemu_madvise(addr, chunk,
+                         deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
+        }
+    }
+}
+
+static void balloon_bulk_pages(struct virtio_balloon_resp_hdr *hdr,
+                               uint64_t *pages, bool deflate)
+{
+    ram_addr_t base_pfn;
+    unsigned long current = 0, nr_pfn, len = hdr->data_len;
+    uint64_t *range;
+
+    if (!qemu_balloon_is_inhibited() && (!kvm_enabled() ||
+                                         kvm_has_sync_mmu())) {
+        while (current < len / sizeof(uint64_t)) {
+            range = pages + current;
+            base_pfn = *range >> VIRTIO_BALLOON_NR_PFN_BITS;
+            nr_pfn = *range & BALLOON_NR_PFN_MASK;
+            current++;
+            if (nr_pfn == 0) {
+                nr_pfn = *(range + 1);
+                current++;
+            }
+
+            do_balloon_bulk_pages(base_pfn, nr_pfn * TARGET_PAGE_SIZE,
+                                  deflate);
+        }
+    }
+}
+
 /*
  * reset_stats - Mark all items in the stats array as unset
  *
@@ -72,6 +136,13 @@ static bool balloon_stats_supported(const VirtIOBalloon *s)
     return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_STATS_VQ);
 }
 
+static bool balloon_page_ranges_supported(const VirtIOBalloon *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_RANGE);
+}
+
 static bool balloon_stats_enabled(const VirtIOBalloon *s)
 {
     return s->stats_poll_interval > 0;
@@ -218,32 +289,51 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
 
-        while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
-            ram_addr_t pa;
-            ram_addr_t addr;
-            int p = virtio_ldl_p(vdev, &pfn);
-
-            pa = (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
-            offset += 4;
-
-            /* FIXME: remove get_system_memory(), but how? */
-            section = memory_region_find(get_system_memory(), pa, 1);
-            if (!int128_nz(section.size) ||
-                !memory_region_is_ram(section.mr) ||
-                memory_region_is_rom(section.mr) ||
-                memory_region_is_romd(section.mr)) {
-                trace_virtio_balloon_bad_addr(pa);
-                continue;
-            }
+        if (balloon_page_ranges_supported(s)) {
+            struct virtio_balloon_resp_hdr hdr;
+            uint32_t data_len;
+
+            iov_to_buf(elem->out_sg, elem->out_num, offset, &hdr, sizeof(hdr));
+            offset += sizeof(hdr);
+
+            data_len = hdr.data_len;
+            if (data_len > 0) {
+                uint64_t *ranges = g_malloc(data_len);
 
-            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
-                                               pa);
-            /* Using memory_region_get_ram_ptr is bending the rules a bit, but
-               should be OK because we only want a single page.  */
-            addr = section.offset_within_region;
-            balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
-                         !!(vq == s->dvq));
-            memory_region_unref(section.mr);
+                iov_to_buf(elem->out_sg, elem->out_num, offset, ranges,
+                           data_len);
+
+                balloon_bulk_pages(&hdr, ranges, !!(vq == s->dvq));
+                g_free(ranges);
+            }
+        } else {
+            while (iov_to_buf(elem->out_sg, elem->out_num, offset,
+                              &pfn, 4) == 4) {
+                ram_addr_t pa;
+                ram_addr_t addr;
+                int p = virtio_ldl_p(vdev, &pfn);
+
+                pa = (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
+                offset += 4;
+
+                /* FIXME: remove get_system_memory(), but how? */
+                section = memory_region_find(get_system_memory(), pa, 1);
+                if (!int128_nz(section.size) ||
+                    !memory_region_is_ram(section.mr) ||
+                    memory_region_is_rom(section.mr) ||
+                    memory_region_is_romd(section.mr)) {
+                    trace_virtio_balloon_bad_addr(pa);
+                    continue;
+                }
+                trace_virtio_balloon_handle_output(memory_region_name(
+                                                            section.mr), pa);
+                /* Using memory_region_get_ram_ptr is bending the rules a bit,
+                 * but should be OK because we only want a single page.  */
+                addr = section.offset_within_region;
+                balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
+                             !!(vq == s->dvq));
+                memory_region_unref(section.mr);
+            }
         }
 
         virtqueue_push(vq, elem, offset);
@@ -505,6 +595,8 @@ static const VMStateDescription vmstate_virtio_balloon = {
 static Property virtio_balloon_properties[] = {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
+    DEFINE_PROP_BIT("page-ranges", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_RANGE, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.9.1
