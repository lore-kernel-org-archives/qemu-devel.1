Received: from eggs.gnu.org ([2001:4830:134:3::10]:45725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fvXvE-0003dY-Aw
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 21:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fvXf4-0004hr-Ej
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:51:45 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38450 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fvXf4-0004h0-2s
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:51:42 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 31 Aug 2018 17:05:03 +0800
Message-Id: <1535706305-118115-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1535706305-118115-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535706305-118115-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V5 2/4]  target-i386:add coalesced_pio API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 accel/kvm/kvm-all.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/exec/memory.h |  4 ++--
 memory.c              |  4 ++--
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4a3909d..11d8d78 100644
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
@@ -559,6 +560,45 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
     }
 }
 
+static void kvm_coalesce_pio_add(MemoryListener *listener,
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
+static void kvm_coalesce_pio_del(MemoryListener *listener,
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
+static MemoryListener kvm_coalesced_pio_listener = {
+    .coalesced_io_add = kvm_coalesce_pio_add,
+    .coalesced_io_del = kvm_coalesce_pio_del,
+};
+
 int kvm_check_extension(KVMState *s, unsigned int extension)
 {
     int ret;
@@ -1615,6 +1655,8 @@ static int kvm_init(MachineState *ms)
     }
 
     s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
+    s->coalesced_pio = s->coalesced_mmio &&
+                       kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
 
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
@@ -1687,13 +1729,15 @@ static int kvm_init(MachineState *ms)
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
         s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
     }
-    s->memory_listener.listener.coalesced_mmio_add = kvm_coalesce_mmio_region;
-    s->memory_listener.listener.coalesced_mmio_del = kvm_uncoalesce_mmio_region;
+    s->memory_listener.listener.coalesced_io_add = kvm_coalesce_mmio_region;
+    s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
+    memory_listener_register(&kvm_coalesced_pio_listener,
+                             &address_space_io);
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
@@ -1775,8 +1819,13 @@ void kvm_flush_coalesced_mmio_buffer(void)
             struct kvm_coalesced_mmio *ent;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            if (ent->pio == 1) {
+                address_space_rw(&address_space_io, ent->phys_addr,
+                                 MEMTXATTRS_UNSPECIFIED, ent->data,
+                                 ent->len, true);
+            } else {
+                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            }
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 448d41a..4600fa3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -410,9 +410,9 @@ struct MemoryListener {
                         bool match_data, uint64_t data, EventNotifier *e);
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
-    void (*coalesced_mmio_add)(MemoryListener *listener, MemoryRegionSection *section,
+    void (*coalesced_io_add)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
-    void (*coalesced_mmio_del)(MemoryListener *listener, MemoryRegionSection *section,
+    void (*coalesced_io_del)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
     /* Lower = earlier (during add), later (during del) */
     unsigned priority;
diff --git a/memory.c b/memory.c
index e9cd446..8b0311e 100644
--- a/memory.c
+++ b/memory.c
@@ -2126,7 +2126,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
                 .size = fr->addr.size,
             };
 
-            MEMORY_LISTENER_CALL(as, coalesced_mmio_del, Reverse, &section,
+            MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section,
                                  int128_get64(fr->addr.start),
                                  int128_get64(fr->addr.size));
             QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
@@ -2137,7 +2137,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
                     continue;
                 }
                 tmp = addrrange_intersection(tmp, fr->addr);
-                MEMORY_LISTENER_CALL(as, coalesced_mmio_add, Forward, &section,
+                MEMORY_LISTENER_CALL(as, coalesced_io_add, Forward, &section,
                                      int128_get64(tmp.start),
                                      int128_get64(tmp.size));
             }
-- 
1.8.3.1
