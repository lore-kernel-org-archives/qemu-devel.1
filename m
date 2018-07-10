Received: from eggs.gnu.org ([2001:4830:134:3::10]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fcpN5-00023g-B7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fcpN2-0002p6-67
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:55:47 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1fcpN1-0002oU-PJ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:55:44 -0400
Received: by mail-pg1-x543.google.com with SMTP id r5-v6so1863380pgv.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 02:55:43 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 10 Jul 2018 17:55:38 +0800
Message-Id: <1531216538-19674-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: coalesced PIO support for RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Windows I/O, such as the real-time clock. The address register (port
0x70 in the RTC case) can use coalesced I/O, cutting the number of
userspace exits by half when reading or writing the RTC.

Guest access rtc like this: write register index to 0x70, then write or 
read data from 0x71. writing 0x70 port is just as index and do nothing 
else. So we can use coalesced mmio to handle this scene to reduce VM-EXIT 
time.

In our environment, 12 windows guest running on a Skylake server:

Before patch:

IO Port Access  Samples  Samples%   Time%    Avg time

0x70:POUT        20675    46.04%    92.72%   67.15us ( +-   7.93% )

After patch:

IO Port Access  Samples  Samples%   Time%    Avg time

0x70:POUT        17509    45.42%    42.08%   6.37us ( +-  20.37% )

Thanks to Peng Hao's initial patch.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 accel/kvm/kvm-all.c       | 56 +++++++++++++++++++++++++++++++++++++++++++----
 hw/timer/mc146818rtc.c    |  8 +++++++
 include/exec/memattrs.h   |  1 +
 include/exec/memory.h     |  5 +++++
 include/sysemu/kvm.h      |  8 +++++++
 linux-headers/linux/kvm.h |  5 +++--
 memory.c                  |  5 +++++
 7 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eb7db92..7a12341 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -128,6 +128,7 @@ bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 static bool kvm_immediate_exit;
+bool kvm_coalesced_pio_allowed;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
@@ -536,7 +537,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
     }
@@ -553,7 +554,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
     }
@@ -877,6 +878,45 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
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
+    if (kvm_coalesced_pio_allowed) {
+        struct kvm_coalesced_mmio_zone zone;
+
+        zone.addr = start;
+        zone.size = size;
+        zone.pio = 1;
+
+        (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
+    }
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
@@ -1615,6 +1655,8 @@ static int kvm_init(MachineState *ms)
     }
 
     s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
+    kvm_coalesced_pio_allowed = s->coalesced_mmio &&
+                        kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
 
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
@@ -1694,6 +1736,8 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
+    memory_listener_register(&kvm_coalesced_io_listener,
+                             &address_space_io);
 
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
@@ -1775,8 +1819,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
             struct kvm_coalesced_mmio *ent;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            if (ent->pio) {
+                address_space_rw(&address_space_io, ent->phys_addr,
+                                 MEMTXATTRS_NONE, ent->data, ent->len, true);
+            } else {
+                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+            }
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..8bd8682 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -70,6 +70,7 @@ typedef struct RTCState {
     ISADevice parent_obj;
 
     MemoryRegion io;
+    MemoryRegion coalesced_io;
     uint8_t cmos_data[128];
     uint8_t cmos_index;
     int32_t base_year;
@@ -990,6 +991,13 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
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
index d4a1642..97884d8 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -45,6 +45,7 @@ typedef struct MemTxAttrs {
  * from "didn't specify" if necessary).
  */
 #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
+#define MEMTXATTRS_NONE ((MemTxAttrs) { 0 })
 
 /* New-style MMIO accessors can indicate that the transaction failed.
  * A zero (MEMTX_OK) response means success; anything else is a failure
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 448d41a..2854907 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1405,6 +1405,11 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
 /**
+ * memory_allow_coalesced_pio: Check whether coalesced pio allowed.
+ */
+bool memory_allow_coalesced_pio(void);
+
+/**
  * memory_region_clear_global_locking: Declares that access processing does
  *                                     not depend on the QEMU global lock.
  *
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 0b64b8e..08366b2 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -45,6 +45,7 @@ extern bool kvm_readonly_mem_allowed;
 extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
+extern bool kvm_coalesced_pio_allowed;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
@@ -167,6 +168,12 @@ extern bool kvm_msi_use_devid;
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
@@ -184,6 +191,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
+#define kvm_coalesced_pio_enabled() (false)
 
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a..747b473 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -420,13 +420,13 @@ struct kvm_run {
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
 
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_COALESCED_PIO 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/memory.c b/memory.c
index e9cd446..4a32817 100644
--- a/memory.c
+++ b/memory.c
@@ -2211,6 +2211,11 @@ void memory_region_clear_global_locking(MemoryRegion *mr)
     mr->global_locking = false;
 }
 
+bool memory_allow_coalesced_pio(void)
+{
+    return kvm_enabled() && kvm_coalesced_pio_enabled();
+}
+
 static bool userspace_eventfd_warning;
 
 void memory_region_add_eventfd(MemoryRegion *mr,
-- 
2.7.4
