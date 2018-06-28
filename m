Received: from eggs.gnu.org ([2001:4830:134:3::10]:37889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAW-00079Y-87
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAT-0000Fu-VZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAT-0000EY-GJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id e18-v6so6690684wrs.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:20 +0200
Message-Id: <1530216310-52873-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/60] kvm: Delete the slot if and only if the
 KVM_MEM_READONLY flag is changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <zhaoshenglong@huawei.com>

From: Shannon Zhao <zhaoshenglong@huawei.com>

According to KVM commit 75d61fbc, it needs to delete the slot before
changing the KVM_MEM_READONLY flag. But QEMU commit 235e8982 only check
whether KVM_MEM_READONLY flag is set instead of changing. It doesn't
need to delete the slot if the KVM_MEM_READONLY flag is not changed.

This fixes a issue that migrating a VM at the OVMF startup stage and
VM is executing the codes in rom. Between the deleting and adding the
slot in kvm_set_user_memory_region, there is a chance that guest access
rom and trap to KVM, then KVM can't find the corresponding memslot.
While KVM (on ARM) injects an abort to guest due to the broken hva, then
guest will get stuck.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Message-Id: <1526462314-19720-1-git-send-email-zhaoshenglong@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 17 ++++++++---------
 include/sysemu/kvm_int.h |  1 +
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ffee68e..eb7db92 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -256,7 +256,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     return 0;
 }
 
-static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
+static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
     struct kvm_userspace_memory_region mem;
@@ -267,7 +267,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
 
-    if (slot->memory_size && mem.flags & KVM_MEM_READONLY) {
+    if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
@@ -275,6 +275,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     }
     mem.memory_size = slot->memory_size;
     ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    slot->old_flags = mem.flags;
     trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
                               mem.memory_size, mem.userspace_addr, ret);
     return ret;
@@ -391,17 +392,14 @@ static int kvm_mem_flags(MemoryRegion *mr)
 static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
                                  MemoryRegion *mr)
 {
-    int old_flags;
-
-    old_flags = mem->flags;
     mem->flags = kvm_mem_flags(mr);
 
     /* If nothing changed effectively, no need to issue ioctl */
-    if (mem->flags == old_flags) {
+    if (mem->flags == mem->old_flags) {
         return 0;
     }
 
-    return kvm_set_user_memory_region(kml, mem);
+    return kvm_set_user_memory_region(kml, mem, false);
 }
 
 static int kvm_section_update_flags(KVMMemoryListener *kml,
@@ -755,7 +753,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
 
         /* unregister the slot */
         mem->memory_size = 0;
-        err = kvm_set_user_memory_region(kml, mem);
+        mem->flags = 0;
+        err = kvm_set_user_memory_region(kml, mem, false);
         if (err) {
             fprintf(stderr, "%s: error unregistering slot: %s\n",
                     __func__, strerror(-err));
@@ -771,7 +770,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     mem->ram = ram;
     mem->flags = kvm_mem_flags(mr);
 
-    err = kvm_set_user_memory_region(kml, mem);
+    err = kvm_set_user_memory_region(kml, mem, true);
     if (err) {
         fprintf(stderr, "%s: error registering slot: %s\n", __func__,
                 strerror(-err));
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 888557a..f838412 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -20,6 +20,7 @@ typedef struct KVMSlot
     void *ram;
     int slot;
     int flags;
+    int old_flags;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
-- 
1.8.3.1
