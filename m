Received: from eggs.gnu.org ([2001:4830:134:3::10]:35485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY7-0001vv-Fg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY4-0000rM-6U
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:59 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45406 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fskY3-0000mf-Rm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:56 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 24 Aug 2018 00:14:47 +0800
Message-Id: <1535040889-52782-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V3 2/4] target-i386:add coalesced_pio API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 accel/kvm/kvm-all.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/exec/memattrs.h |  2 +-
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eb7db92..830745e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -78,6 +78,7 @@ struct KVMState
     int fd;
     int vmfd;
     int coalesced_mmio;
+    int coalesced_pio;
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
@@ -536,7 +537,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
     }
@@ -553,12 +554,51 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
     }
 }
 
+static void kvm_coalesce_io_add(MemoryListener *listener,
+                                MemoryRegionSection *section,
+                                hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (s->coalesced_pio) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pio = 1;
+
+        (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
+    }
+}
+
+static void kvm_coalesce_io_del(MemoryListener *listener,
+                                MemoryRegionSection *section,
+                                hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (s->coalesced_pio) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pio = 1;
+
+        (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
+     }
+}
+
+static MemoryListener kvm_coalesced_io_listener = {
+    .coalesced_mmio_add = kvm_coalesce_io_add,
+    .coalesced_mmio_del = kvm_coalesce_io_del,
+};
+
 int kvm_check_extension(KVMState *s, unsigned int extension)
 {
     int ret;
@@ -1615,7 +1655,8 @@ static int kvm_init(MachineState *ms)
     }
 
     s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
-
+    s->coalesced_pio = s->coalesced_mmio &&
+                       kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
@@ -1694,7 +1735,8 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
-
+    memory_listener_register(&kvm_coalesced_io_listener,
+                             &address_space_io);
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
@@ -1775,8 +1817,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
             struct kvm_coalesced_mmio *ent;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            if (ent->pio == 1) {
+                address_space_rw(&address_space_io, ent->phys_addr,
+                                 MEMTXATTRS_NONE, ent->data, ent->len, true);
+            } else {
+                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            }
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a1642..12fd64f 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -45,7 +45,7 @@ typedef struct MemTxAttrs {
  * from "didn't specify" if necessary).
  */
 #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
-
+#define MEMTXATTRS_NONE ((MemTxAttrs) { 0 })
 /* New-style MMIO accessors can indicate that the transaction failed.
  * A zero (MEMTX_OK) response means success; anything else is a failure
  * of some kind. The memory subsystem will bitwise-OR together results
-- 
1.8.3.1
