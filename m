Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR1nX-000673-D2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR1nS-0003KB-Ge
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:14:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eR1nS-0003Iy-2B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:13:58 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 18 Dec 2017 20:13:39 +0000
Message-Id: <20171218201340.27583-7-dgilbert@redhat.com>
In-Reply-To: <20171218201340.27583-1-dgilbert@redhat.com>
References: <20171218201340.27583-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 6/7] vhost: Clean out old vhost_set_memory
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Remove the old update mechanism, vhost_set_memory, and the functions
and flags it used.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c         | 245 ----------------------------------------------
 include/hw/virtio/vhost.h |   3 -
 2 files changed, 248 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4394ac0275..358ceb3033 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -156,160 +156,6 @@ static void vhost_log_sync_range(struct vhost_dev *dev,
     }
 }
 
-/* Assign/unassign. Keep an unsorted array of non-overlapping
- * memory regions in dev->mem. */
-static void vhost_dev_unassign_memory(struct vhost_dev *dev,
-                                      uint64_t start_addr,
-                                      uint64_t size)
-{
-    int from, to, n = dev->mem->nregions;
-    /* Track overlapping/split regions for sanity checking. */
-    int overlap_start = 0, overlap_end = 0, overlap_middle = 0, split = 0;
-
-    for (from = 0, to = 0; from < n; ++from, ++to) {
-        struct vhost_memory_region *reg = dev->mem->regions + to;
-        uint64_t reglast;
-        uint64_t memlast;
-        uint64_t change;
-
-        /* clone old region */
-        if (to != from) {
-            memcpy(reg, dev->mem->regions + from, sizeof *reg);
-        }
-
-        /* No overlap is simple */
-        if (!ranges_overlap(reg->guest_phys_addr, reg->memory_size,
-                            start_addr, size)) {
-            continue;
-        }
-
-        /* Split only happens if supplied region
-         * is in the middle of an existing one. Thus it can not
-         * overlap with any other existing region. */
-        assert(!split);
-
-        reglast = range_get_last(reg->guest_phys_addr, reg->memory_size);
-        memlast = range_get_last(start_addr, size);
-
-        /* Remove whole region */
-        if (start_addr <= reg->guest_phys_addr && memlast >= reglast) {
-            --dev->mem->nregions;
-            --to;
-            ++overlap_middle;
-            continue;
-        }
-
-        /* Shrink region */
-        if (memlast >= reglast) {
-            reg->memory_size = start_addr - reg->guest_phys_addr;
-            assert(reg->memory_size);
-            assert(!overlap_end);
-            ++overlap_end;
-            continue;
-        }
-
-        /* Shift region */
-        if (start_addr <= reg->guest_phys_addr) {
-            change = memlast + 1 - reg->guest_phys_addr;
-            reg->memory_size -= change;
-            reg->guest_phys_addr += change;
-            reg->userspace_addr += change;
-            assert(reg->memory_size);
-            assert(!overlap_start);
-            ++overlap_start;
-            continue;
-        }
-
-        /* This only happens if supplied region
-         * is in the middle of an existing one. Thus it can not
-         * overlap with any other existing region. */
-        assert(!overlap_start);
-        assert(!overlap_end);
-        assert(!overlap_middle);
-        /* Split region: shrink first part, shift second part. */
-        memcpy(dev->mem->regions + n, reg, sizeof *reg);
-        reg->memory_size = start_addr - reg->guest_phys_addr;
-        assert(reg->memory_size);
-        change = memlast + 1 - reg->guest_phys_addr;
-        reg = dev->mem->regions + n;
-        reg->memory_size -= change;
-        assert(reg->memory_size);
-        reg->guest_phys_addr += change;
-        reg->userspace_addr += change;
-        /* Never add more than 1 region */
-        assert(dev->mem->nregions == n);
-        ++dev->mem->nregions;
-        ++split;
-    }
-}
-
-/* Called after unassign, so no regions overlap the given range. */
-static void vhost_dev_assign_memory(struct vhost_dev *dev,
-                                    uint64_t start_addr,
-                                    uint64_t size,
-                                    uint64_t uaddr)
-{
-    int from, to;
-    struct vhost_memory_region *merged = NULL;
-    for (from = 0, to = 0; from < dev->mem->nregions; ++from, ++to) {
-        struct vhost_memory_region *reg = dev->mem->regions + to;
-        uint64_t prlast, urlast;
-        uint64_t pmlast, umlast;
-        uint64_t s, e, u;
-
-        /* clone old region */
-        if (to != from) {
-            memcpy(reg, dev->mem->regions + from, sizeof *reg);
-        }
-        prlast = range_get_last(reg->guest_phys_addr, reg->memory_size);
-        pmlast = range_get_last(start_addr, size);
-        urlast = range_get_last(reg->userspace_addr, reg->memory_size);
-        umlast = range_get_last(uaddr, size);
-
-        /* check for overlapping regions: should never happen. */
-        assert(prlast < start_addr || pmlast < reg->guest_phys_addr);
-        /* Not an adjacent or overlapping region - do not merge. */
-        if ((prlast + 1 != start_addr || urlast + 1 != uaddr) &&
-            (pmlast + 1 != reg->guest_phys_addr ||
-             umlast + 1 != reg->userspace_addr)) {
-            continue;
-        }
-
-        if (dev->vhost_ops->vhost_backend_can_merge &&
-            !dev->vhost_ops->vhost_backend_can_merge(dev, uaddr, size,
-                                                     reg->userspace_addr,
-                                                     reg->memory_size)) {
-            continue;
-        }
-
-        if (merged) {
-            --to;
-            assert(to >= 0);
-        } else {
-            merged = reg;
-        }
-        u = MIN(uaddr, reg->userspace_addr);
-        s = MIN(start_addr, reg->guest_phys_addr);
-        e = MAX(pmlast, prlast);
-        uaddr = merged->userspace_addr = u;
-        start_addr = merged->guest_phys_addr = s;
-        size = merged->memory_size = e - s + 1;
-        assert(merged->memory_size);
-    }
-
-    if (!merged) {
-        struct vhost_memory_region *reg = dev->mem->regions + to;
-        memset(reg, 0, sizeof *reg);
-        reg->memory_size = size;
-        assert(reg->memory_size);
-        reg->guest_phys_addr = start_addr;
-        reg->userspace_addr = uaddr;
-        ++to;
-    }
-    assert(to <= dev->mem->nregions + 1);
-    dev->mem->nregions = to;
-}
-
 static uint64_t vhost_get_log_size(struct vhost_dev *dev)
 {
     uint64_t log_size = 0;
@@ -526,89 +372,6 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     return r;
 }
 
-static struct vhost_memory_region *vhost_dev_find_reg(struct vhost_dev *dev,
-						      uint64_t start_addr,
-						      uint64_t size)
-{
-    int i, n = dev->mem->nregions;
-    for (i = 0; i < n; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        if (ranges_overlap(reg->guest_phys_addr, reg->memory_size,
-                           start_addr, size)) {
-            return reg;
-        }
-    }
-    return NULL;
-}
-
-static bool vhost_dev_cmp_memory(struct vhost_dev *dev,
-                                 uint64_t start_addr,
-                                 uint64_t size,
-                                 uint64_t uaddr)
-{
-    struct vhost_memory_region *reg = vhost_dev_find_reg(dev, start_addr, size);
-    uint64_t reglast;
-    uint64_t memlast;
-
-    if (!reg) {
-        return true;
-    }
-
-    reglast = range_get_last(reg->guest_phys_addr, reg->memory_size);
-    memlast = range_get_last(start_addr, size);
-
-    /* Need to extend region? */
-    if (start_addr < reg->guest_phys_addr || memlast > reglast) {
-        return true;
-    }
-    /* userspace_addr changed? */
-    return uaddr != reg->userspace_addr + start_addr - reg->guest_phys_addr;
-}
-
-static void vhost_set_memory(MemoryListener *listener,
-                             MemoryRegionSection *section,
-                             bool add)
-{
-    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
-                                         memory_listener);
-    hwaddr start_addr = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    int s = offsetof(struct vhost_memory, regions) +
-        (dev->mem->nregions + 1) * sizeof dev->mem->regions[0];
-    void *ram;
-
-    dev->mem = g_realloc(dev->mem, s);
-
-    assert(size);
-
-    /* Optimize no-change case. At least cirrus_vga does this a lot at this time. */
-    ram = memory_region_get_ram_ptr(section->mr) + section->offset_within_region;
-    if (add) {
-        if (!vhost_dev_cmp_memory(dev, start_addr, size, (uintptr_t)ram)) {
-            /* Region exists with same address. Nothing to do. */
-            return;
-        }
-    } else {
-        if (!vhost_dev_find_reg(dev, start_addr, size)) {
-            /* Removing region that we don't access. Nothing to do. */
-            return;
-        }
-    }
-
-    vhost_dev_unassign_memory(dev, start_addr, size);
-    if (add) {
-        /* Add given mapping, merging adjacent regions if any */
-        vhost_dev_assign_memory(dev, start_addr, size, (uintptr_t)ram);
-    } else {
-        /* Remove old mapping for this memory, if any. */
-        vhost_dev_unassign_memory(dev, start_addr, size);
-    }
-    dev->mem_changed_start_addr = MIN(dev->mem_changed_start_addr, start_addr);
-    dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr, start_addr + size - 1);
-    dev->memory_changed = true;
-    used_memslots = dev->mem->nregions;
-}
-
 static bool vhost_section(MemoryRegionSection *section)
 {
     bool result;
@@ -630,8 +393,6 @@ static void vhost_begin(MemoryListener *listener)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
-    dev->mem_changed_end_addr = 0;
-    dev->mem_changed_start_addr = -1;
     dev->tmp_sections = NULL;
     dev->n_tmp_sections = 0;
 }
@@ -702,7 +463,6 @@ static void vhost_commit(MemoryListener *listener)
         if (r < 0) {
             VHOST_OPS_DEBUG("vhost_set_mem_table failed");
         }
-        dev->memory_changed = false;
         goto out;
     }
     log_size = vhost_get_log_size(dev);
@@ -721,7 +481,6 @@ static void vhost_commit(MemoryListener *listener)
     if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
         vhost_dev_log_resize(dev, log_size);
     }
-    dev->memory_changed = false;
 
 out:
     /* Deref the old list of sections, this must happen _after_ the
@@ -806,8 +565,6 @@ static void vhost_region_add(MemoryListener *listener,
         return;
     }
     vhost_region_add_section(dev, section);
-
-    vhost_set_memory(listener, section, true);
 }
 
 /* Called on regions that have not changed */
@@ -831,7 +588,6 @@ static void vhost_region_del(MemoryListener *listener,
         return;
     }
 
-    vhost_set_memory(listener, section, false);
 }
 
 static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -1446,7 +1202,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_size = 0;
     hdev->log_enabled = false;
     hdev->started = false;
-    hdev->memory_changed = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 21f3022499..b64732420a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -69,9 +69,6 @@ struct vhost_dev {
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
-    bool memory_changed;
-    hwaddr mem_changed_start_addr;
-    hwaddr mem_changed_end_addr;
     const VhostOps *vhost_ops;
     void *opaque;
     struct vhost_log *log;
-- 
2.14.3
