Received: from eggs.gnu.org ([2001:4830:134:3::10]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgr6a-0003Aw-Le
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 07:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgr6X-0006cn-E9
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 07:30:52 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:59916 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dgr6W-0006al-R9
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 07:30:49 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Mon, 14 Aug 2017 03:42:52 +0800
Message-Id: <1502653372-115805-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [RFC PATCH V2] target-i386 : reduce rtc 0x70 access
 vm-exit time
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
 accel/kvm/kvm-all.c       | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 hw/timer/mc146818rtc.c    |  8 +++++++
 include/exec/memattrs.h   |  1 +
 include/exec/memory.h     |  6 +++++
 include/sysemu/kvm.h      |  8 +++++++
 linux-headers/linux/kvm.h |  5 +++--
 memory.c                  |  5 +++++
 7 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46ce479..d09fa83 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -122,6 +122,7 @@ bool kvm_vm_attributes_allowed;
 bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
+bool kvm_coalesced_pio_allowed;
 static bool kvm_immediate_exit;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -516,7 +517,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
     }
@@ -533,7 +534,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
     }
@@ -953,6 +954,45 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
     }
 }
 
+static void kvm_coalesce_io_add(MemoryListener *listener,
+                                MemoryRegionSection *section,
+                                hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (kvm_coalesced_pio_allowed) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pio = 1;
+       (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
+    }
+}
+
+static void kvm_coalesce_io_del(MemoryListener *listener,
+                                MemoryRegionSection *section,
+                                hwaddr start, hwaddr size)
+{
+    KVMState *s = kvm_state;
+
+    if (kvm_coalesced_pio_allowed) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pio = 1;
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
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id)
 {
@@ -1691,7 +1731,8 @@ static int kvm_init(MachineState *ms)
     }
 
     s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
-
+    kvm_coalesced_pio_allowed = s->coalesced_mmio &&
+                          kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
     s->broken_set_mem_region = 1;
     ret = kvm_check_extension(s, KVM_CAP_JOIN_MEMORY_REGIONS_WORKS);
     if (ret > 0) {
@@ -1762,6 +1803,8 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
+    memory_listener_register(&kvm_coalesced_io_listener,
+                             &address_space_io);
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
@@ -1841,8 +1884,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
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
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 82843ed..c7e4d7d 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -68,6 +68,7 @@ typedef struct RTCState {
     ISADevice parent_obj;
 
     MemoryRegion io;
+    MemoryRegion coalesced_io;
     uint8_t cmos_data[128];
     uint8_t cmos_index;
     int32_t base_year;
@@ -986,6 +987,13 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
     isa_register_ioport(isadev, &s->io, base);
 
+    if (memory_allow_coalesced_pio()) {
+        memory_region_set_flush_coalesced(&s->io);
+        memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
+                              s, "rtc1", 1);
+        isa_register_ioport(isadev, &s->coalesced_io, base);
+        memory_region_add_coalescing(&s->coalesced_io, 0, 1);
+    }
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
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 400dd44..15274a4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1254,6 +1254,12 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
 /**
+ * memory_allow_coalesced_pio: Check whether coalesced pio allowed.
+ *
+ */
+bool memory_allow_coalesced_pio(void);
+
+/**
  * memory_region_set_global_locking: Declares the access processing requires
  *                                   QEMU's global lock.
  *
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3a458f5..9d8874b 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -46,6 +46,7 @@ extern bool kvm_readonly_mem_allowed;
 extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
+extern bool kvm_coalesced_pio_allowed;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
@@ -168,6 +169,12 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
 
+/**
+ * kvm_coalesced_pio_enabled:
+ * Returns: true if KVM allow coalesced pio
+ */
+#define kvm_coalesced_pio_enabled() (kvm_coalesced_pio_allowed)
+
 #else
 
 #define kvm_enabled()           (0)
@@ -185,6 +192,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
+#define kvm_coalesced_pio_enabled() (false)
 
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7971a4f..fbe20c3 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -415,13 +415,13 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	__u32 pio;
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	__u32 pio;
 	__u8  data[8];
 };
 
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_COALESCED_PIO 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/memory.c b/memory.c
index c0adc35..89ebbcf 100644
--- a/memory.c
+++ b/memory.c
@@ -2023,6 +2023,11 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
+bool memory_allow_coalesced_pio(void)
+{
+    return kvm_enabled() && kvm_coalesced_pio_enabled();
+}
+
 void memory_region_set_global_locking(MemoryRegion *mr)
 {
     mr->global_locking = true;
-- 
1.8.3.1
