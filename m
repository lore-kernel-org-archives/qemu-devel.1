Received: from eggs.gnu.org ([2001:4830:134:3::10]:41679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4xz-0001xJ-KV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4xt-0008AG-Qr
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:59 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dp4xt-00089k-K4
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:53 -0400
Received: by mail-vk0-x242.google.com with SMTP id t10so716060vke.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 20:55:53 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Mon,  4 Sep 2017 22:54:55 -0500
Message-Id: <20170905035457.3753-13-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v3 12/14] hvf: implement vga dirty page tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This commit implements setting the tracking of dirty pages, using hvf's
interface to protect guest memory. It uses the MemoryListener callback
mechanism through .log_start/stop/sync

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 include/sysemu/hvf.h  |  5 ++++
 target/i386/hvf-all.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 944b014596..43b02be63c 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -34,11 +34,16 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif
 
+/* hvf_slot flags */
+#define HVF_SLOT_LOG (1 << 0)
+
 typedef struct hvf_slot {
     uint64_t start;
     uint64_t size;
     uint8_t *mem;
     int slot_id;
+    uint32_t flags;
+    MemoryRegion *region;
 } hvf_slot;
 
 struct hvf_vcpu_caps {
diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index be68c71ea0..5644fa8ae0 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -195,6 +195,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->size = int128_get64(section->size);
     mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
     mem->start = section->offset_within_address_space;
+    mem->region = area;
 
     if (do_hvf_set_memory(mem)) {
         error_report("Error registering new memory slot\n");
@@ -291,8 +292,7 @@ void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
     run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
-/* TODO: ept fault handlig */
-static bool ept_emulation_fault(uint64_t ept_qual)
+static bool ept_emulation_fault(hvf_slot *slot, addr_t gpa, uint64_t ept_qual)
 {
     int read, write;
 
@@ -308,6 +308,14 @@ static bool ept_emulation_fault(uint64_t ept_qual)
         return false;
     }
 
+    if (write && slot) {
+        if (slot->flags & HVF_SLOT_LOG) {
+            memory_region_set_dirty(slot->region, gpa - slot->start, 1);
+            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
+                          HV_MEMORY_READ | HV_MEMORY_WRITE);
+        }
+    }
+
     /*
      * The EPT violation must have been caused by accessing a
      * guest-physical address that is a translation of a guest-linear
@@ -318,7 +326,59 @@ static bool ept_emulation_fault(uint64_t ept_qual)
         return false;
     }
 
-    return true;
+    return !slot;
+}
+
+static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
+{
+    struct mac_slot *macslot;
+    hvf_slot *slot;
+
+    slot = hvf_find_overlap_slot(
+            section->offset_within_address_space,
+            section->offset_within_address_space + int128_get64(section->size));
+
+    /* protect region against writes; begin tracking it */
+    if (on) {
+        slot->flags |= HVF_SLOT_LOG;
+        hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
+                      HV_MEMORY_READ);
+    /* stop tracking region*/
+    } else {
+        slot->flags &= ~HVF_SLOT_LOG;
+        hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
+                      HV_MEMORY_READ | HV_MEMORY_WRITE);
+    }
+}
+
+static void hvf_log_start(MemoryListener *listener,
+                          MemoryRegionSection *section, int old, int new)
+{
+    if (old != 0) {
+        return;
+    }
+
+    hvf_set_dirty_tracking(section, 1);
+}
+
+static void hvf_log_stop(MemoryListener *listener,
+                         MemoryRegionSection *section, int old, int new)
+{
+    if (new != 0) {
+        return;
+    }
+
+    hvf_set_dirty_tracking(section, 0);
+}
+
+static void hvf_log_sync(MemoryListener *listener,
+                         MemoryRegionSection *section)
+{
+    /*
+     * sync of dirty pages is handled elsewhere; just make sure we keep
+     * tracking the region.
+     */
+    hvf_set_dirty_tracking(section, 1);
 }
 
 static void hvf_region_add(MemoryListener *listener,
@@ -337,6 +397,9 @@ static MemoryListener hvf_memory_listener = {
     .priority = 10,
     .region_add = hvf_region_add,
     .region_del = hvf_region_del,
+    .log_start = hvf_log_start,
+    .log_stop = hvf_log_stop,
+    .log_sync = hvf_log_sync,
 };
 
 void vmx_reset_vcpu(CPUState *cpu) {
@@ -609,7 +672,7 @@ int hvf_vcpu_exec(CPUState *cpu)
 
             slot = hvf_find_overlap_slot(gpa, gpa);
             /* mmio */
-            if (ept_emulation_fault(exit_qual) && !slot) {
+            if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
 
                 load_regs(cpu);
@@ -620,9 +683,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 store_regs(cpu);
                 break;
             }
-#ifdef DIRTY_VGA_TRACKING
-            /* TODO: handle dirty page tracking */
-#endif
             break;
         }
         case EXIT_REASON_INOUT:
-- 
2.14.1
