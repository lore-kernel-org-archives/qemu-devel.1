Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfva-0005k7-81
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvW-0002Mh-PQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:22 -0500
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com
	([104.47.32.83]:38343
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvW-0002MW-Gh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:18 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:25 -0600
Message-Id: <20171206200346.116537-3-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 02/23] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
 exec.c                | 65 ++++++++++++++++++++++++++++++++++++++-------------
 include/exec/memory.h | 27 +++++++++++++++++++++
 2 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/exec.c b/exec.c
index 03238a3449d9..9b0ab1648945 100644
--- a/exec.c
+++ b/exec.c
@@ -2981,7 +2981,11 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
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
 
@@ -3079,7 +3083,10 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(buf, ptr, l);
+            if (attrs.debug && mr->ram_debug_ops)
+                mr->ram_debug_ops->read(buf, ptr, l, attrs);
+            else
+                memcpy(buf, ptr, l);
         }
 
         if (release_lock) {
@@ -3149,11 +3156,13 @@ void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
 
 enum write_rom_type {
     WRITE_DATA,
+    READ_DATA,
     FLUSH_CACHE,
 };
 
-static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
-    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
+static inline void cpu_physical_memory_rw_debug_internal(AddressSpace *as,
+    hwaddr addr, uint8_t *buf, int len, MemTxAttrs attrs,
+    enum write_rom_type type)
 {
     hwaddr l;
     uint8_t *ptr;
@@ -3168,12 +3177,33 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
         if (!(memory_region_is_ram(mr) ||
               memory_region_is_romd(mr))) {
             l = memory_access_size(mr, l, addr1);
+            /* Pass MMIO down to address address_space_rw */
+            switch (type) {
+            case READ_DATA:
+            case WRITE_DATA:
+                address_space_rw(as, addr1, attrs, buf, l,
+                                 type == WRITE_DATA);
+                break;
+            case FLUSH_CACHE:
+                break;
+            }
         } else {
             /* ROM/RAM case */
             ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
             switch (type) {
+            case READ_DATA:
+                if (mr->ram_debug_ops) {
+                    mr->ram_debug_ops->read(buf, ptr, l, attrs);
+                } else {
+                    memcpy(buf, ptr, l);
+                }
+                break;
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
@@ -3192,7 +3222,8 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
                                    const uint8_t *buf, int len)
 {
-    cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
+    cpu_physical_memory_rw_debug_internal(as, addr, (uint8_t *)buf, len,
+            MEMTXATTRS_UNSPECIFIED, WRITE_DATA);
 }
 
 void cpu_flush_icache_range(hwaddr start, int len)
@@ -3207,8 +3238,10 @@ void cpu_flush_icache_range(hwaddr start, int len)
         return;
     }
 
-    cpu_physical_memory_write_rom_internal(&address_space_memory,
-                                           start, NULL, len, FLUSH_CACHE);
+    cpu_physical_memory_rw_debug_internal(&address_space_memory,
+                                           start, NULL, len,
+                                           MEMTXATTRS_UNSPECIFIED,
+                                           FLUSH_CACHE);
 }
 
 typedef struct {
@@ -3514,6 +3547,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
     int l;
     hwaddr phys_addr;
     target_ulong page;
+    int type = is_write ? WRITE_DATA : READ_DATA;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
@@ -3523,6 +3557,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
         page = addr & TARGET_PAGE_MASK;
         phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
+
+        /* set debug attribute */
+        attrs.debug = 1;
+
         /* if no physical page mapped, return an error */
         if (phys_addr == -1)
             return -1;
@@ -3530,14 +3568,9 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
         if (l > len)
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
-        if (is_write) {
-            cpu_physical_memory_write_rom(cpu->cpu_ases[asidx].as,
-                                          phys_addr, buf, l);
-        } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             MEMTXATTRS_UNSPECIFIED,
-                             buf, l, 0);
-        }
+        cpu_physical_memory_rw_debug_internal(cpu->cpu_ases[asidx].as,
+                                               phys_addr, buf, l, attrs,
+                                               type);
         len -= l;
         buf += l;
         addr += l;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f877d..546a67bf0dac 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -215,6 +215,18 @@ typedef struct IOMMUMemoryRegionClass {
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
 
@@ -254,6 +266,7 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
+    const MemoryRegionRAMReadWriteOps *ram_debug_ops;
 };
 
 struct IOMMUMemoryRegion {
@@ -621,6 +634,20 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Error **errp);
 
 /**
+ * memory_region_set_ram_debug_ops: Set debug access ops for a given memory region
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
+/**
  * memory_region_init_reservation: Initialize a memory region that reserves
  *                                 I/O space.
  *
-- 
2.9.5
