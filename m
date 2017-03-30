Received: from eggs.gnu.org ([2001:4830:134:3::10]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctU02-0005nl-My
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctTzy-0005d1-Rq
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctTzy-0005b0-Hg
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 08:55:29 +0200
Message-Id: <1490856931-21732-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 2/4] memory: add support getting and using
 a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

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
 exec.c                  | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/exec/memory.h   | 13 ++++++++
 include/exec/ram_addr.h |  8 +++++
 include/qemu/typedefs.h |  1 +
 memory.c                | 15 ++++++++++
 5 files changed, 116 insertions(+)

diff --git a/exec.c b/exec.c
index e57a8a2..57c5bc9 100644
--- a/exec.c
+++ b/exec.c
@@ -223,6 +223,12 @@ struct CPUAddressSpace {
     MemoryListener tcg_as_listener;
 };
 
+struct DirtyCopy {
+    ram_addr_t start;
+    ram_addr_t end;
+    unsigned long dirty[];
+};
+
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1061,6 +1067,79 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     return dirty;
 }
 
+DirtyCopy *cpu_physical_memory_copy_and_clear_dirty(ram_addr_t start,
+                                                    ram_addr_t length,
+                                                    unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long align = 1 << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
+    ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
+    ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
+    DirtyCopy *copy;
+    unsigned long page, end, dest;
+
+    copy = g_malloc0(sizeof(*copy) +
+                     ((last - first) >> (TARGET_PAGE_BITS + 3)));
+    copy->start = first;
+    copy->end   = last;
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
+        bitmap_copy(copy->dirty + dest,
+                    blocks->blocks[idx] + (offset >> BITS_PER_LEVEL),
+                    num);
+        bitmap_zero(blocks->blocks[idx] + (offset >> BITS_PER_LEVEL),
+                    num);
+
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
+    return copy;
+}
+
+bool cpu_physical_memory_copy_get_dirty(DirtyCopy *copy,
+                                        ram_addr_t start,
+                                        ram_addr_t length)
+{
+    unsigned long page, end;
+
+    assert(start > copy->start);
+    assert(start + length < copy->end);
+
+    end = TARGET_PAGE_ALIGN(start + length - copy->start) >> TARGET_PAGE_BITS;
+    page = (start - copy->start) >> TARGET_PAGE_BITS;
+
+    while (page < end) {
+        if (test_bit(page, copy->dirty)) {
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
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256a..f89cfa7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -871,6 +871,19 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
  */
 bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
                                         hwaddr size, unsigned client);
+
+/**
+ * memory_region_copy_and_clear_dirty: TODO
+ */
+DirtyCopy *memory_region_copy_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
+                                              hwaddr size, unsigned client);
+
+/**
+ * memory_region_copy_get_dirty: TODO
+ */
+bool memory_region_copy_get_dirty(MemoryRegion *mr, DirtyCopy *copy,
+                                  hwaddr addr, hwaddr size);
+
 /**
  * memory_region_sync_dirty_bitmap: Synchronize a region's dirty bitmap with
  *                                  any external TLBs (e.g. kvm)
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b05dc84..3886f0a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -343,6 +343,14 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
 
+DirtyCopy *cpu_physical_memory_copy_and_clear_dirty(ram_addr_t start,
+                                                    ram_addr_t length,
+                                                    unsigned client);
+
+bool cpu_physical_memory_copy_get_dirty(DirtyCopy *copy,
+                                        ram_addr_t start,
+                                        ram_addr_t length);
+
 static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
                                                          ram_addr_t length)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e95f28c..5344aee 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -23,6 +23,7 @@ typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUState CPUState;
 typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
+typedef struct DirtyCopy DirtyCopy;
 typedef struct DisplayChangeListener DisplayChangeListener;
 typedef struct DisplayState DisplayState;
 typedef struct DisplaySurface DisplaySurface;
diff --git a/memory.c b/memory.c
index 4c95aaf..7d75ca6 100644
--- a/memory.c
+++ b/memory.c
@@ -1716,6 +1716,21 @@ bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
                 memory_region_get_ram_addr(mr) + addr, size, client);
 }
 
+DirtyCopy *memory_region_copy_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
+                                              hwaddr size, unsigned client)
+{
+    assert(mr->ram_block);
+    return cpu_physical_memory_copy_and_clear_dirty(
+                memory_region_get_ram_addr(mr) + addr, size, client);
+}
+
+bool memory_region_copy_get_dirty(MemoryRegion *mr, DirtyCopy *copy,
+                                  hwaddr addr, hwaddr size)
+{
+    assert(mr->ram_block);
+    return cpu_physical_memory_copy_get_dirty(copy,
+                memory_region_get_ram_addr(mr) + addr, size);
+}
 
 void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
-- 
1.8.3.1
