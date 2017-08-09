Received: from eggs.gnu.org ([2001:4830:134:3::10]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7U-0008TB-Cp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7T-0003RO-9v
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfR7T-0003Qs-0z
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Aug 2017 15:33:42 +0200
Message-Id: <20170809133346.30271-3-david@redhat.com>
In-Reply-To: <20170809133346.30271-1-david@redhat.com>
References: <20170809133346.30271-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/6] kvm: factor out alignment of memory
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, david@redhat.com

Factor it out, so we can reuse it later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 59 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eae61bb..f6ceeba 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -190,6 +190,36 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
 }
 
 /*
+ * Calculate and align the start address and the size of the section.
+ * Return the size. If the size is 0, the aligned section is empty.
+ */
+static hwaddr kvm_align_section(MemoryRegionSection *section,
+                                hwaddr *start)
+{
+    hwaddr size = int128_get64(section->size);
+    hwaddr delta;
+
+    *start = section->offset_within_address_space;
+
+    /* kvm works in page size chunks, but the function may be called
+       with sub-page size and unaligned start address. Pad the start
+       address to next and truncate size to previous page boundary. */
+    delta = qemu_real_host_page_size - (*start & ~qemu_real_host_page_mask);
+    delta &= ~qemu_real_host_page_mask;
+    *start += delta;
+    if (delta > size) {
+        return 0;
+    }
+    size -= delta;
+    size &= qemu_real_host_page_mask;
+    if (*start & ~qemu_real_host_page_mask) {
+        return 0;
+    }
+
+    return size;
+}
+
+/*
  * Find overlapping slot with lowest start address
  */
 static KVMSlot *kvm_lookup_overlapping_slot(KVMMemoryListener *kml,
@@ -700,25 +730,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
-    hwaddr start_addr = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    void *ram = NULL;
-    unsigned delta;
-
-    /* kvm works in page size chunks, but the function may be called
-       with sub-page size and unaligned start address. Pad the start
-       address to next and truncate size to previous page boundary. */
-    delta = qemu_real_host_page_size - (start_addr & ~qemu_real_host_page_mask);
-    delta &= ~qemu_real_host_page_mask;
-    if (delta > size) {
-        return;
-    }
-    start_addr += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask;
-    if (!size || (start_addr & ~qemu_real_host_page_mask)) {
-        return;
-    }
+    hwaddr start_addr, size;
+    void *ram;
 
     if (!memory_region_is_ram(mr)) {
         if (writeable || !kvm_readonly_mem_allowed) {
@@ -730,7 +743,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         }
     }
 
-    ram = memory_region_get_ram_ptr(mr) + section->offset_within_region + delta;
+    size = kvm_align_section(section, &start_addr);
+    if (!size) {
+        return;
+    }
+
+    ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
+          (section->offset_within_address_space - start_addr);
 
     while (1) {
         mem = kvm_lookup_overlapping_slot(kml, start_addr, start_addr + size);
-- 
2.9.4
