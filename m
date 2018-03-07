Received: from eggs.gnu.org ([2001:4830:134:3::10]:50175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHW-0004aU-Fw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHS-0008AT-BJ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:10 -0500
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com
	([104.47.38.81]:60768
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHS-00089n-6I
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:06 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:12 -0600
Message-Id: <20180307165038.88640-3-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 02/28] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

Currently, the guest memory access for the debug purpose is performed
using the memcpy(). Lets extend the 'struct MemoryRegion' to include
ram_debug_ops callbacks. The ram_debug_ops can be used to override
memcpy() with something else.

The feature can be used by encrypted guest -- which can register
callbacks to override memcpy() with memory encryption/decryption APIs.

a typical usage:

mem_read(uint8_t *dst, uint8_t *src, uint32_t len, MemTxAttrs *attrs);
mem_write(uint8_t *dst, uint8_t *src, uint32_t len, MemTxAttrs *attrs);

MemoryRegionRAMReadWriteOps ops;
ops.read = mem_read;
ops.write = mem_write;

memory_region_init_ram(mem, NULL, "memory", size, NULL);
memory_region_set_ram_debug_ops(mem, ops);

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 exec.c                | 43 ++++++++++++++++++++++++++++++++-----------
 include/exec/memory.h | 30 +++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/exec.c b/exec.c
index 4d8addb263a0..4408cd26c989 100644
--- a/exec.c
+++ b/exec.c
@@ -3054,7 +3054,11 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(ptr, buf, l);
+            if (attrs.debug && mr->ram_debug_ops) {
+                mr->ram_debug_ops->write(ptr, buf, l, attrs);
+            } else {
+                memcpy(ptr, buf, l);
+            }
             invalidate_and_set_dirty(mr, addr1, l);
         }
 
@@ -3152,7 +3156,11 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(buf, ptr, l);
+            if (attrs.debug && mr->ram_debug_ops) {
+                mr->ram_debug_ops->read(buf, ptr, l, attrs);
+            } else {
+                memcpy(buf, ptr, l);
+            }
         }
 
         if (release_lock) {
@@ -3226,7 +3234,8 @@ enum write_rom_type {
 };
 
 static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
-    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
+    hwaddr addr, const uint8_t *buf, int len, MemTxAttrs attrs,
+    enum write_rom_type type)
 {
     hwaddr l;
     uint8_t *ptr;
@@ -3246,7 +3255,11 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
             ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
             switch (type) {
             case WRITE_DATA:
-                memcpy(ptr, buf, l);
+                if (mr->ram_debug_ops) {
+                    mr->ram_debug_ops->write(ptr, buf, l, attrs);
+                } else {
+                    memcpy(ptr, buf, l);
+                }
                 invalidate_and_set_dirty(mr, addr1, l);
                 break;
             case FLUSH_CACHE:
@@ -3265,7 +3278,9 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
                                    const uint8_t *buf, int len)
 {
-    cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
+    cpu_physical_memory_write_rom_internal(as, addr, buf, len,
+                                           MEMTXATTRS_UNSPECIFIED,
+                                           WRITE_DATA);
 }
 
 void cpu_flush_icache_range(hwaddr start, int len)
@@ -3280,8 +3295,9 @@ void cpu_flush_icache_range(hwaddr start, int len)
         return;
     }
 
-    cpu_physical_memory_write_rom_internal(&address_space_memory,
-                                           start, NULL, len, FLUSH_CACHE);
+    cpu_physical_memory_write_rom_internal(&address_space_memory, start, NULL,
+                                           len, MEMTXATTRS_UNSPECIFIED,
+                                           FLUSH_CACHE);
 }
 
 typedef struct {
@@ -3596,6 +3612,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
         page = addr & TARGET_PAGE_MASK;
         phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
+
+        /* set debug attrs to indicate memory access is from the debugger */
+        attrs.debug = 1;
+
         /* if no physical page mapped, return an error */
         if (phys_addr == -1)
             return -1;
@@ -3604,13 +3624,14 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            cpu_physical_memory_write_rom(cpu->cpu_ases[asidx].as,
-                                          phys_addr, buf, l);
+            cpu_physical_memory_write_rom_internal(cpu->cpu_ases[asidx].as,
+                                                   phys_addr, buf, l, attrs,
+                                                   WRITE_DATA);
         } else {
             address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             MEMTXATTRS_UNSPECIFIED,
-                             buf, l, 0);
+                             attrs, buf, l, 0);
         }
+
         len -= l;
         buf += l;
         addr += l;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 15e81113bac9..4a18bb3b38ec 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -223,6 +223,18 @@ typedef struct IOMMUMemoryRegionClass {
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
+/* Memory Region RAM debug callback */
+typedef struct MemoryRegionRAMReadWriteOps MemoryRegionRAMReadWriteOps;
+
+struct MemoryRegionRAMReadWriteOps {
+    /* Write data into guest memory */
+    int (*write) (uint8_t *dest, const uint8_t *src,
+                  uint32_t len, MemTxAttrs attrs);
+    /* Read data from guest memory */
+    int (*read) (uint8_t *dest, const uint8_t *src,
+                 uint32_t len, MemTxAttrs attrs);
+};
+
 struct MemoryRegion {
     Object parent_obj;
 
@@ -262,6 +274,7 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
+    const MemoryRegionRAMReadWriteOps *ram_debug_ops;
 };
 
 struct IOMMUMemoryRegion {
@@ -655,6 +668,21 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              uint64_t size,
                                              Error **errp);
 
+/**
+ * memory_region_set_ram_debug_ops: Set debug access ops for a given memory
+ * region.
+ *
+ * @mr: the #MemoryRegion to be initialized
+ * @ops: a function that will be used for when accessing @target region during
+ *       debug
+ */
+static inline void
+memory_region_set_ram_debug_ops(MemoryRegion *mr,
+                                const MemoryRegionRAMReadWriteOps *ops)
+{
+    mr->ram_debug_ops = ops;
+}
+
 /**
  * memory_region_init_reservation: Initialize a memory region that reserves
  *                                 I/O space.
@@ -1938,7 +1966,7 @@ MemTxResult flatview_read(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
     void *ptr;
     MemoryRegion *mr;
 
-    if (__builtin_constant_p(len)) {
+    if (__builtin_constant_p(len) && !attrs.debug) {
         if (len) {
             rcu_read_lock();
             l = len;
-- 
2.14.3
