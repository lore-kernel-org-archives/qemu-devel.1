Received: from eggs.gnu.org ([2001:4830:134:3::10]:47589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOyaF-0005A2-Fm
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOyaB-0001Pc-3Q
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:23:51 -0500
Received: from ozlabs.ru ([107.173.13.209]:58814)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOyaA-0001PM-UA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:23:47 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 13 Dec 2017 15:23:12 +1100
Message-Id: <20171213042312.8781-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] kvm: Add kvm_set_user_memory tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds a tracepoint to trace the KVM_SET_USER_MEMORY_REGION ioctl
parameters which is quite useful for debugging VFIO memory regions
being actually registered with KVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 accel/kvm/kvm-all.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f48..b91fcb7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -235,6 +235,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
 {
     KVMState *s = kvm_state;
     struct kvm_userspace_memory_region mem;
+    int ret;
 
     mem.slot = slot->slot | (kml->as_id << 16);
     mem.guest_phys_addr = slot->start_addr;
@@ -248,7 +249,10 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
         kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
     }
     mem.memory_size = slot->memory_size;
-    return kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
+                              mem.memory_size, mem.userspace_addr, ret);
+    return ret;
 }
 
 int kvm_destroy_vcpu(CPUState *cpu)
-- 
2.11.0
