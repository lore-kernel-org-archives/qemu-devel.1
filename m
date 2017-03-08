Received: from eggs.gnu.org ([2001:4830:134:3::10]:52034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5g-0005ms-2y
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5c-0005XT-Qj
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:48 -0500
Received: from mail-co1nam03on0052.outbound.protection.outlook.com
	([104.47.40.52]:18368
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj5c-0005Wx-Du
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:44 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:39 -0500
Message-ID: <148900629935.27090.5801290878346986411.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 03/20] exec: add guest RAM read and
 write ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

In current implementation, read and write of the guest RAM is
performed using using memcpy(). The patch adds support to register
a callback which can override the memcpy() with something else.

This feature will be used in Secure Encrypted Virtualization (SEV)
guests in which read and write of guest memory should be performed
using the SEV commands.

a typical usage:

mem_read(uint8_t *dst, uint8_t *src, uint32_t len, MemTxAttrs *attrs);
mem_write(uint8_t *dst, uint8_t *src, uint32_t len, MemTxAttrs *attrs);

MemoryRegionRAMReadWriteOps ops;
ops.read = mem_read;
ops.write = mem_write;

memory_region_init_ram(mem, NULL, "memory", size, NULL);
memory_region_set_ram_debug_ops(mem, ops);

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 exec.c                |   55 ++++++++++++++++++++++++++++++++++++-------------
 include/exec/memory.h |   25 ++++++++++++++++++++++
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index aabb035..48ae29c 100644
--- a/exec.c
+++ b/exec.c
@@ -2913,11 +2913,13 @@ void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
 
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
@@ -2931,13 +2933,33 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 
         if (!(memory_region_is_ram(mr) ||
               memory_region_is_romd(mr))) {
-            l = memory_access_size(mr, l, addr1);
+            /* Pass MMIO down to address address_space_rw */
+            switch (type) {
+            case READ_DATA:
+            case WRITE_DATA:
+                address_space_rw(as, addr, attrs, buf, l,
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
@@ -2956,7 +2978,8 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
                                    const uint8_t *buf, int len)
 {
-    cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
+    cpu_physical_memory_rw_debug_internal(as, addr, (uint8_t *)buf, len,
+            MEMTXATTRS_UNSPECIFIED, WRITE_DATA);
 }
 
 void cpu_flush_icache_range(hwaddr start, int len)
@@ -2971,8 +2994,10 @@ void cpu_flush_icache_range(hwaddr start, int len)
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
@@ -3308,6 +3333,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
     int l;
     hwaddr phys_addr;
     target_ulong page;
+    int type = is_write ? WRITE_DATA : READ_DATA;
 
     while (len > 0) {
         int asidx;
@@ -3316,6 +3342,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
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
@@ -3323,14 +3353,9 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
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
index 6911023..e1d21cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -163,6 +163,18 @@ struct MemoryRegionOps {
     const MemoryRegionMmio old_mmio;
 };
 
+/* Memory Region RAM callback */
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
 typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
 
 struct MemoryRegionIOMMUOps {
@@ -220,6 +232,7 @@ struct MemoryRegion {
     MemoryRegionIoeventfd *ioeventfds;
     QLIST_HEAD(, IOMMUNotifier) iommu_notify;
     IOMMUNotifierFlag iommu_notify_flags;
+    const MemoryRegionRAMReadWriteOps *ram_debug_ops;
 };
 
 /**
@@ -526,6 +539,18 @@ void memory_region_init_rom_device(MemoryRegion *mr,
                                    Error **errp);
 
 /**
+ * memory_region_set_ram_ops: Set the Read/Write ops for accessing the RAM
+ *
+ * @mr: the #MemoryRegion to be initialized
+ * @ops: a function that will be used to read/write @target region
+ */
+static inline void memory_region_set_ram_debug_ops(MemoryRegion *mr,
+                               const MemoryRegionRAMReadWriteOps *ops)
+{
+    mr->ram_debug_ops = ops;
+}
+
+/**
  * memory_region_init_reservation: Initialize a memory region that reserves
  *                                 I/O space.
  *
