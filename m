Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij4-0004LK-Om
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij2-0002UP-H1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij2-0002TK-3b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:46 +0100
Message-Id: <20171220180358.29316-8-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/19] i386: hvf: implement vga dirty page
 tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch implements setting the tracking of dirty vga pages, using hvf's
interface to protect guest memory. It uses the MemoryListener callback
mechanism through .log_start/stop/sync

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-13-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h  |  5 ++++
 target/i386/hvf-all.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 614a2d203b..e4e43f6468 100644
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
 
 typedef struct hvf_vcpu_caps {
diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index cfd7de4f6a..d8c7981120 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -193,6 +193,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->size = int128_get64(section->size);
     mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
     mem->start = section->offset_within_address_space;
+    mem->region = area;
 
     if (do_hvf_set_memory(mem)) {
         error_report("Error registering new memory slot\n");
@@ -289,8 +290,7 @@ void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
     run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
-/* TODO: ept fault handlig */
-static bool ept_emulation_fault(uint64_t ept_qual)
+static bool ept_emulation_fault(hvf_slot *slot, addr_t gpa, uint64_t ept_qual)
 {
     int read, write;
 
@@ -306,6 +306,14 @@ static bool ept_emulation_fault(uint64_t ept_qual)
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
@@ -316,7 +324,58 @@ static bool ept_emulation_fault(uint64_t ept_qual)
         return false;
     }
 
-    return true;
+    return !slot;
+}
+
+static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
+{
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
@@ -335,6 +394,9 @@ static MemoryListener hvf_memory_listener = {
     .priority = 10,
     .region_add = hvf_region_add,
     .region_del = hvf_region_del,
+    .log_start = hvf_log_start,
+    .log_stop = hvf_log_stop,
+    .log_sync = hvf_log_sync,
 };
 
 void hvf_reset_vcpu(CPUState *cpu) {
@@ -605,7 +667,7 @@ int hvf_vcpu_exec(CPUState *cpu)
 
             slot = hvf_find_overlap_slot(gpa, gpa);
             /* mmio */
-            if (ept_emulation_fault(exit_qual) && !slot) {
+            if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
 
                 load_regs(cpu);
@@ -616,9 +678,6 @@ int hvf_vcpu_exec(CPUState *cpu)
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
2.14.3
