Received: from eggs.gnu.org ([2001:4830:134:3::10]:54134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026k-Ko
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Ce-KZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-00029o-Aq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:07 +0200
Message-Id: <20170404102315.24923-3-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] memory: add support getting and using a
 dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This patch adds support for getting and using a local copy of the dirty
bitmap.

memory_region_copy_and_clear_dirty() will create a copy of the dirty
bitmap for the specified range, clear the dirty bitmap and return the
copy.  The returned bitmap can be a bit larger than requested, the range
is expanded so the code can copy unsigned longs from the bitmap and
avoid atomic bit update operations.

memory_region_copy_get_dirty() will return the dirty status of pages,
pretty much like memory_region_get_dirty(), but using the copy returned
by memory_region_copy_and_clear_dirty().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/exec/memory.h   | 47 +++++++++++++++++++++++++++++++
 include/exec/ram_addr.h |  7 +++++
 include/qemu/typedefs.h |  1 +
 exec.c                  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 memory.c                | 17 +++++++++++
 5 files changed, 147 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256a..2d82983 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -871,6 +871,53 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
  */
 bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
                                         hwaddr size, unsigned client);
+
+/**
+ * memory_region_snapshot_and_clear_dirty: Get a snapshot of the dirty
+ *                                         bitmap and clear it.
+ *
+ * Creates a snapshot of the dirty bitmap, clears the dirty bitmap and
+ * returns the snapshot.  The snapshot can then be used to query dirty
+ * status, using memory_region_snapshot_get_dirty.  Unlike
+ * memory_region_test_and_clear_dirty this allows to query the same
+ * page multiple times, which is especially useful for display updates
+ * where the scanlines often are not page aligned.
+ *
+ * The dirty bitmap region which gets copyed into the snapshot (and
+ * cleared afterwards) can be larger than requested.  The boundaries
+ * are rounded up/down so complete bitmap longs (covering 64 pages on
+ * 64bit hosts) can be copied over into the bitmap snapshot.  Which
+ * isn't a problem for display updates as the extra pages are outside
+ * the visible area, and in case the visible area changes a full
+ * display redraw is due anyway.  Should other use cases for this
+ * function emerge we might have to revisit this implementation
+ * detail.
+ *
+ * Use g_free to release DirtyBitmapSnapshot.
+ *
+ * @mr: the memory region being queried.
+ * @addr: the address (relative to the start of the region) being queried.
+ * @size: the size of the range being queried.
+ * @client: the user of the logging information; typically %DIRTY_MEMORY_VGA.
+ */
+DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
+                                                            hwaddr addr,
+                                                            hwaddr size,
+                                                            unsigned client);
+
+/**
+ * memory_region_snapshot_get_dirty: Check whether a range of bytes is dirty
+ *                                   in the specified dirty bitmap snapshot.
+ *
+ * @mr: the memory region being queried.
+ * @snap: the dirty bitmap snapshot
+ * @addr: the address (relative to the start of the region) being queried.
+ * @size: the size of the range being queried.
+ */
+bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
+                                      DirtyBitmapSnapshot *snap,
+                                      hwaddr addr, hwaddr size);
+
 /**
  * memory_region_sync_dirty_bitmap: Synchronize a region's dirty bitmap with
  *                                  any external TLBs (e.g. kvm)
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b05dc84..2b63d7f 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -343,6 +343,13 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
 
+DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
+    (ram_addr_t start, ram_addr_t length, unsigned client);
+
+bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+                                            ram_addr_t start,
+                                            ram_addr_t length);
+
 static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
                                                          ram_addr_t length)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e95f28c..f08d327 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -23,6 +23,7 @@ typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUState CPUState;
 typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
+typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisplayChangeListener DisplayChangeListener;
 typedef struct DisplayState DisplayState;
 typedef struct DisplaySurface DisplaySurface;
diff --git a/exec.c b/exec.c
index e57a8a2..0b654b2 100644
--- a/exec.c
+++ b/exec.c
@@ -223,6 +223,12 @@ struct CPUAddressSpace {
     MemoryListener tcg_as_listener;
 };
 
+struct DirtyBitmapSnapshot {
+    ram_addr_t start;
+    ram_addr_t end;
+    unsigned long dirty[];
+};
+
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1061,6 +1067,75 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     return dirty;
 }
 
+DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
+     (ram_addr_t start, ram_addr_t length, unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
+    ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
+    ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
+    DirtyBitmapSnapshot *snap;
+    unsigned long page, end, dest;
+
+    snap = g_malloc0(sizeof(*snap) +
+                     ((last - first) >> (TARGET_PAGE_BITS + 3)));
+    snap->start = first;
+    snap->end   = last;
+
+    page = first >> TARGET_PAGE_BITS;
+    end  = last  >> TARGET_PAGE_BITS;
+    dest = 0;
+
+    rcu_read_lock();
+
+    blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    while (page < end) {
+        unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long num = MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - offset);
+
+        assert(QEMU_IS_ALIGNED(offset, (1 << BITS_PER_LEVEL)));
+        assert(QEMU_IS_ALIGNED(num,    (1 << BITS_PER_LEVEL)));
+        offset >>= BITS_PER_LEVEL;
+
+        bitmap_copy_and_clear_atomic(snap->dirty + dest,
+                                     blocks->blocks[idx] + offset,
+                                     num);
+        page += num;
+        dest += num >> BITS_PER_LEVEL;
+    }
+
+    rcu_read_unlock();
+
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+
+    return snap;
+}
+
+bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+                                            ram_addr_t start,
+                                            ram_addr_t length)
+{
+    unsigned long page, end;
+
+    assert(start >= snap->start);
+    assert(start + length <= snap->end);
+
+    end = TARGET_PAGE_ALIGN(start + length - snap->start) >> TARGET_PAGE_BITS;
+    page = (start - snap->start) >> TARGET_PAGE_BITS;
+
+    while (page < end) {
+        if (test_bit(page, snap->dirty)) {
+            return true;
+        }
+        page++;
+    }
+    return false;
+}
+
 /* Called from RCU critical section */
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        MemoryRegionSection *section,
diff --git a/memory.c b/memory.c
index 4c95aaf..8a06485 100644
--- a/memory.c
+++ b/memory.c
@@ -1716,6 +1716,23 @@ bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
                 memory_region_get_ram_addr(mr) + addr, size, client);
 }
 
+DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
+                                                            hwaddr addr,
+                                                            hwaddr size,
+                                                            unsigned client)
+{
+    assert(mr->ram_block);
+    return cpu_physical_memory_snapshot_and_clear_dirty(
+                memory_region_get_ram_addr(mr) + addr, size, client);
+}
+
+bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
+                                      hwaddr addr, hwaddr size)
+{
+    assert(mr->ram_block);
+    return cpu_physical_memory_snapshot_get_dirty(snap,
+                memory_region_get_ram_addr(mr) + addr, size);
+}
 
 void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
-- 
2.9.3
