Received: from eggs.gnu.org ([2001:4830:134:3::10]:60109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgNTx-0005Jh-4k
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 23:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgNTt-0002nf-7L
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 23:53:01 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:60921 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgNTs-0002mo-K7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 23:52:57 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sat, 12 Aug 2017 20:05:05 +0800
Message-Id: <1502539505-80366-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target-i386: reduce rtc 0x70 access vm-exit
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

some versions of windows guest access rtc frequently because of
rtc as system tick.guest access rtc like this: write register index
to 0x70, then write or read data from 0x71. writing 0x70 port is
just as index and do nothing else. So we can use coalesced mmio to
handle this scene to reduce VM-EXIT time.
without my patch, get the vm-exit time of accessing rtc 0x70 using
perf tools: (guest OS : windows 7 64bit)
IO Port Access  Samples Samples%  Time%  Min Time  Max Time  Avg time
0x70:POUT        86     30.99%    74.59%   9us      29us    10.75us (+- 3.41%)

with my patch
IO Port Access  Samples Samples%  Time%   Min Time  Max Time   Avg time
 0x70:POUT       106    32.02%    29.47%    0us      10us     1.57us (+- 7.38%)

the patch is a part of optimizing rtc 0x70 port access. Another is in
kernel.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 accel/kvm/kvm-all.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 hw/timer/mc146818rtc.c  |  6 ++++++
 include/exec/memattrs.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46ce479..7aa9fca 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -953,6 +953,44 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
     }
 }
 
+static void kvm_coalesce_io_add(MemoryListener *listener, MemoryRegionSection *section,
+                               hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (s->coalesced_mmio) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pad = 1;
+       (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
+    }
+}
+
+static void kvm_coalesce_io_del(MemoryListener *listener, MemoryRegionSection *section,
+                               hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (s->coalesced_mmio) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pad = 1;
+
+        (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
+    }
+
+}
+
+static MemoryListener kvm_coalesced_io_listener = {
+    .coalesced_mmio_add = kvm_coalesce_io_add,
+    .coalesced_mmio_del = kvm_coalesce_io_del,
+    .priority = 10,
+};
+
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id)
 {
@@ -1762,6 +1800,8 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
+    memory_listener_register(&kvm_coalesced_io_listener,
+                             &address_space_io);
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
@@ -1841,8 +1881,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
             struct kvm_coalesced_mmio *ent;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            if (ent->pad == 1) {
+                address_space_rw(&address_space_io, ent->phys_addr,
+                                 MEMTXATTRS_NONE, ent->data, ent->len, true);
+            } else {
+                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            }
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 82843ed..c6c2e57 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -68,6 +68,7 @@ typedef struct RTCState {
     ISADevice parent_obj;
 
     MemoryRegion io;
+    MemoryRegion io_mm;
     uint8_t cmos_data[128];
     uint8_t cmos_index;
     int32_t base_year;
@@ -985,6 +986,11 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
     isa_register_ioport(isadev, &s->io, base);
+    memory_region_set_flush_coalesced(&s->io);
+
+    memory_region_init_io(&s->io_mm, OBJECT(s), &cmos_ops, s, "rtc1", 1);
+    isa_register_ioport(isadev, &s->io_mm, base);
+    memory_region_add_coalescing(&s->io_mm, 0, 1);
 
     qdev_set_legacy_instance_id(dev, base, 3);
     qemu_register_reset(rtc_reset, s);
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e601061..a628999 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -45,5 +45,6 @@ typedef struct MemTxAttrs {
  * from "didn't specify" if necessary).
  */
 #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
+#define MEMTXATTRS_NONE ((MemTxAttrs) { 0 })
 
 #endif
-- 
1.8.3.1
