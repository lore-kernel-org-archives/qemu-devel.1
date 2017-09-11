Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqB-0000oE-UF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqA-0008Dl-Tw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drSqA-0008DH-Lu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:46 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 19:49:31 +0200
Message-Id: <20170911174933.20789-5-david@redhat.com>
In-Reply-To: <20170911174933.20789-1-david@redhat.com>
References: <20170911174933.20789-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/6] kvm: we never have overlapping slots in
 kvm_set_phys_mem()
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

The way flatview handles memory sections, we will never have overlapping
memory sections in kvm.

address_space_update_topology_pass() will make sure that we will only
get called for

a) an existing memory section for which we only update parameters
(log_start, log_stop).
b) an existing memory section we want to delete (region_del)
c) a brand new memory section we want to add (region_add)

We cannot have overlapping memory sections in kvm as we will first remove
the overlapping sections and then add the ones without conflicts.

Therefore we can remove the complexity for handling prefix and suffix
slots.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 68 +++++++++--------------------------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 88b0e631bd..b677d1b13e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -725,7 +725,7 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
 {
-    KVMSlot *mem, old;
+    KVMSlot *mem;
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
@@ -750,28 +750,17 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
           (section->offset_within_address_space - start_addr);
 
-    while (1) {
-        mem = kvm_lookup_overlapping_slot(kml, start_addr, start_addr + size);
+    mem = kvm_lookup_matching_slot(kml, start_addr, size);
+    if (!add) {
         if (!mem) {
-            break;
-        }
-
-        if (add && start_addr >= mem->start_addr &&
-            (start_addr + size <= mem->start_addr + mem->memory_size) &&
-            (ram - start_addr == mem->ram - mem->start_addr)) {
-            /* The new slot fits into the existing one and comes with
-             * identical parameters - update flags and done. */
-            kvm_slot_update_flags(kml, mem, mr);
+            g_assert(!memory_region_is_ram(mr) && !writeable && !mr->romd_mode);
             return;
         }
-
-        old = *mem;
-
         if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_physical_sync_dirty_bitmap(kml, section);
         }
 
-        /* unregister the overlapping slot */
+        /* unregister the slot */
         mem->memory_size = 0;
         err = kvm_set_user_memory_region(kml, mem);
         if (err) {
@@ -779,51 +768,16 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     __func__, strerror(-err));
             abort();
         }
-
-        /* register prefix slot */
-        if (old.start_addr < start_addr) {
-            mem = kvm_alloc_slot(kml);
-            mem->memory_size = start_addr - old.start_addr;
-            mem->start_addr = old.start_addr;
-            mem->ram = old.ram;
-            mem->flags =  kvm_mem_flags(mr);
-
-            err = kvm_set_user_memory_region(kml, mem);
-            if (err) {
-                fprintf(stderr, "%s: error registering prefix slot: %s\n",
-                        __func__, strerror(-err));
-#ifdef TARGET_PPC
-                fprintf(stderr, "%s: This is probably because your kernel's " \
-                                "PAGE_SIZE is too big. Please try to use 4k " \
-                                "PAGE_SIZE!\n", __func__);
-#endif
-                abort();
-            }
-        }
-
-        /* register suffix slot */
-        if (old.start_addr + old.memory_size > start_addr + size) {
-            ram_addr_t size_delta;
-
-            mem = kvm_alloc_slot(kml);
-            mem->start_addr = start_addr + size;
-            size_delta = mem->start_addr - old.start_addr;
-            mem->memory_size = old.memory_size - size_delta;
-            mem->ram = old.ram + size_delta;
-            mem->flags = kvm_mem_flags(mr);
-
-            err = kvm_set_user_memory_region(kml, mem);
-            if (err) {
-                fprintf(stderr, "%s: error registering suffix slot: %s\n",
-                        __func__, strerror(-err));
-                abort();
-            }
-        }
+        return;
     }
 
-    if (!add) {
+    if (mem) {
+        /* update the slot */
+        kvm_slot_update_flags(kml, mem, mr);
         return;
     }
+
+    /* register the new slot */
     mem = kvm_alloc_slot(kml);
     mem->memory_size = size;
     mem->start_addr = start_addr;
-- 
2.13.5
