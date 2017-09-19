Received: from eggs.gnu.org ([2001:4830:134:3::10]:59980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfO-0004BR-9G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfN-0005Ve-5W
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:18 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfM-0005VC-Rz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:17 -0400
Received: by mail-wr0-x242.google.com with SMTP id p37so2134567wrb.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:18 +0200
Message-Id: <1505824179-21541-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/50] kvm: we never have overlapping slots in
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20170911174933.20789-5-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 68 +++++++++--------------------------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 88b0e63..b677d1b 100644
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
1.8.3.1
