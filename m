Received: from eggs.gnu.org ([2001:4830:134:3::10]:44432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS1-0004C2-NY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS0-0004sU-RP
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:13 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS0-0004s6-KY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:12 -0500
Received: by mail-wr0-x241.google.com with SMTP id i56so30827489wra.7
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:19 +0100
Message-Id: <1517858941-5538-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/47] kvm: Add kvm_set_user_memory tracepoint
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds a tracepoint to trace the KVM_SET_USER_MEMORY_REGION ioctl
parameters which is quite useful for debugging VFIO memory regions
being actually registered with KVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20171215052326.21386-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 6 +++++-
 accel/kvm/trace-events | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

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
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index f89ba55..58e98ef 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -12,4 +12,5 @@ kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
+kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
 
-- 
1.8.3.1
