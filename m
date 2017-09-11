Received: from eggs.gnu.org ([2001:4830:134:3::10]:49221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqI-0000tr-Dg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqF-0008KV-5q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drSqE-0008JJ-Si
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:51 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 19:49:33 +0200
Message-Id: <20170911174933.20789-7-david@redhat.com>
In-Reply-To: <20170911174933.20789-1-david@redhat.com>
References: <20170911174933.20789-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/6] kvm: kvm_log_sync() is only called with
 known memory sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, david@redhat.com

Flatview will make sure that we can only end up in this function with
memory sections that correspond to exactly one slot. So we don't
have to iterate multiple times. There won't be overlapping slots but
only matching slots.

Properly align the section and look up the corresponding slot. This
heavily simplifies this function.

We can now get rid of kvm_lookup_overlapping_slot().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 61 +++++++++++------------------------------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2ae459453d..a8083e80be 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -218,34 +218,6 @@ static hwaddr kvm_align_section(MemoryRegionSection *section,
     return size;
 }
 
-/*
- * Find overlapping slot with lowest start address
- */
-static KVMSlot *kvm_lookup_overlapping_slot(KVMMemoryListener *kml,
-                                            hwaddr start_addr,
-                                            hwaddr end_addr)
-{
-    KVMState *s = kvm_state;
-    KVMSlot *found = NULL;
-    int i;
-
-    for (i = 0; i < s->nr_slots; i++) {
-        KVMSlot *mem = &kml->slots[i];
-
-        if (mem->memory_size == 0 ||
-            (found && found->start_addr < mem->start_addr)) {
-            continue;
-        }
-
-        if (end_addr > mem->start_addr &&
-            start_addr < mem->start_addr + mem->memory_size) {
-            found = mem;
-        }
-    }
-
-    return found;
-}
-
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
                                        hwaddr *phys_addr)
 {
@@ -489,18 +461,16 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
                                           MemoryRegionSection *section)
 {
     KVMState *s = kvm_state;
-    unsigned long size, allocated_size = 0;
     struct kvm_dirty_log d = {};
     KVMSlot *mem;
-    int ret = 0;
-    hwaddr start_addr = section->offset_within_address_space;
-    hwaddr end_addr = start_addr + int128_get64(section->size);
+    hwaddr start_addr, size;
 
-    d.dirty_bitmap = NULL;
-    while (start_addr < end_addr) {
-        mem = kvm_lookup_overlapping_slot(kml, start_addr, end_addr);
-        if (mem == NULL) {
-            break;
+    size = kvm_align_section(section, &start_addr);
+    if (size) {
+        mem = kvm_lookup_matching_slot(kml, start_addr, size);
+        if (!mem) {
+            fprintf(stderr, "%s: error finding slot\n", __func__);
+            abort();
         }
 
         /* XXX bad kernel interface alert
@@ -517,27 +487,20 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
          */
         size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                      /*HOST_LONG_BITS*/ 64) / 8;
-        if (!d.dirty_bitmap) {
-            d.dirty_bitmap = g_malloc(size);
-        } else if (size > allocated_size) {
-            d.dirty_bitmap = g_realloc(d.dirty_bitmap, size);
-        }
-        allocated_size = size;
-        memset(d.dirty_bitmap, 0, allocated_size);
+        d.dirty_bitmap = g_malloc0(size);
 
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            ret = -1;
-            break;
+            g_free(d.dirty_bitmap);
+            return -1;
         }
 
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
-        start_addr = mem->start_addr + mem->memory_size;
+        g_free(d.dirty_bitmap);
     }
-    g_free(d.dirty_bitmap);
 
-    return ret;
+    return 0;
 }
 
 static void kvm_coalesce_mmio_region(MemoryListener *listener,
-- 
2.13.5
