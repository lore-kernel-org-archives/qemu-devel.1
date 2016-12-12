Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdR-0004cx-NZ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdP-0000Pv-JM
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdP-0000PN-8Z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:07 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:50 +0100
Message-Id: <20161212111857.23399-5-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] exec: introduce MemoryRegionCache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Device models often have to perform multiple access to a single
memory region that is known in advance, but would to use "DMA-style"
functions instead of address_space_map/unmap.  This can happen
for example when the data has to undergo endianness conversion.
Introduce a new data structure to cache the result of
address_space_translate without forcing usage of a host address
like address_space_map does.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                  |  76 ++++++++++++++++++++++++
 include/exec/cpu-all.h  |  23 ++++++++
 include/exec/memory.h   | 151 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h |   1 +
 4 files changed, 251 insertions(+)

diff --git a/exec.c b/exec.c
index d4b3656..8d4bb0e 100644
--- a/exec.c
+++ b/exec.c
@@ -3077,6 +3077,82 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
 #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
 #include "memory_ldst.inc.c"
 
+int64_t address_space_cache_init(MemoryRegionCache *cache,
+                                 AddressSpace *as,
+                                 hwaddr addr,
+                                 hwaddr len,
+                                 bool is_write)
+{
+    hwaddr l, xlat;
+    MemoryRegion *mr;
+    void *ptr;
+
+    assert(len > 0);
+
+    l = len;
+    mr = address_space_translate(as, addr, &xlat, &l, is_write);
+    if (!memory_access_is_direct(mr, is_write)) {
+        return -EINVAL;
+    }
+
+    l = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
+    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, &l);
+
+    cache->xlat = xlat;
+    cache->is_write = is_write;
+    cache->mr = mr;
+    cache->ptr = ptr;
+    cache->len = l;
+    memory_region_ref(cache->mr);
+
+    return l;
+}
+
+void address_space_cache_invalidate(MemoryRegionCache *cache,
+                                    hwaddr addr,
+                                    hwaddr access_len)
+{
+    assert(cache->is_write);
+    invalidate_and_set_dirty(cache->mr, addr + cache->xlat, access_len);
+}
+
+void address_space_cache_destroy(MemoryRegionCache *cache)
+{
+    if (!cache->mr) {
+        return;
+    }
+
+    if (xen_enabled()) {
+        xen_invalidate_map_cache_entry(cache->ptr);
+    }
+    memory_region_unref(cache->mr);
+}
+
+/* Called from RCU critical section.  This function has the same
+ * semantics as address_space_translate, but it only works on a
+ * predefined range of a MemoryRegion that was mapped with
+ * address_space_cache_init.
+ */
+static inline MemoryRegion *address_space_translate_cached(
+    MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
+    hwaddr *plen, bool is_write)
+{
+    assert(addr < cache->len && *plen <= cache->len - addr);
+    *xlat = addr + cache->xlat;
+    return cache->mr;
+}
+
+#define ARG1_DECL                MemoryRegionCache *cache
+#define ARG1                     cache
+#define SUFFIX                   _cached
+#define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
+#define IS_DIRECT(mr, is_write)  true
+#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
+#define INVALIDATE(mr, ofs, len) ((void)0)
+#define RCU_READ_LOCK()          ((void)0)
+#define RCU_READ_UNLOCK()        ((void)0)
+#include "memory_ldst.inc.c"
+
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         uint8_t *buf, int len, int is_write)
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e9004e5..ffe43d5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -186,6 +186,29 @@ void address_space_stl(AddressSpace *as, hwaddr addr, uint32_t val,
                             MemTxAttrs attrs, MemTxResult *result);
 void address_space_stq(AddressSpace *as, hwaddr addr, uint64_t val,
                             MemTxAttrs attrs, MemTxResult *result);
+
+uint32_t lduw_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint32_t ldl_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint64_t ldq_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+void stl_phys_notdirty_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stw_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stl_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stq_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
+
+uint32_t address_space_lduw_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint32_t address_space_ldl_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint64_t address_space_ldq_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stl_notdirty_cached(MemoryRegionCache *cache, hwaddr addr,
+                            uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+void address_space_stw_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stl_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stq_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
 #endif
 
 /* page related stuff */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index f35b612..64560f6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1419,6 +1419,125 @@ void stl_be_phys(AddressSpace *as, hwaddr addr, uint32_t val);
 void stq_le_phys(AddressSpace *as, hwaddr addr, uint64_t val);
 void stq_be_phys(AddressSpace *as, hwaddr addr, uint64_t val);
 
+struct MemoryRegionCache {
+    hwaddr xlat;
+    void *ptr;
+    hwaddr len;
+    MemoryRegion *mr;
+    bool is_write;
+};
+
+/* address_space_cache_init: prepare for repeated access to a physical
+ * memory region
+ *
+ * @cache: #MemoryRegionCache to be filled
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: length of buffer
+ * @is_write: indicates the transfer direction
+ *
+ * Will only work with RAM, and may map a subset of the requested range by
+ * returning a value that is less than @len.  On failure, return a negative
+ * errno value.
+ *
+ * Because it only works with RAM, this function can be used for
+ * read-modify-write operations.  In this case, is_write should be %true.
+ *
+ * Note that addresses passed to the address_space_*_cached functions
+ * are relative to @addr.
+ */
+int64_t address_space_cache_init(MemoryRegionCache *cache,
+                                 AddressSpace *as,
+                                 hwaddr addr,
+                                 hwaddr len,
+                                 bool is_write);
+
+/**
+ * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ * @addr: The first physical address that was written, relative to the
+ * address that was passed to @address_space_cache_init.
+ * @access_len: The number of bytes that were written starting at @addr.
+ */
+void address_space_cache_invalidate(MemoryRegionCache *cache,
+                                    hwaddr addr,
+                                    hwaddr access_len);
+
+/**
+ * address_space_cache_destroy: free a #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache whose memory should be released.
+ */
+void address_space_cache_destroy(MemoryRegionCache *cache);
+
+/* address_space_ld*_cached: load from a cached #MemoryRegion
+ * address_space_st*_cached: store into a cached #MemoryRegion
+ *
+ * These functions perform a load or store of the byte, word,
+ * longword or quad to the specified address.  The address is
+ * a physical address in the AddressSpace, but it must lie within
+ * a #MemoryRegion that was mapped with address_space_cache_init.
+ *
+ * The _le suffixed functions treat the data as little endian;
+ * _be indicates big endian; no suffix indicates "same endianness
+ * as guest CPU".
+ *
+ * The "guest CPU endianness" accessors are deprecated for use outside
+ * target-* code; devices should be CPU-agnostic and use either the LE
+ * or the BE accessors.
+ *
+ * @cache: previously initialized #MemoryRegionCache to be accessed
+ * @addr: address within the address space
+ * @val: data value, for stores
+ * @attrs: memory transaction attributes
+ * @result: location to write the success/failure of the transaction;
+ *   if NULL, this information is discarded
+ */
+uint32_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint32_t address_space_lduw_le_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint32_t address_space_lduw_be_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint32_t address_space_ldl_le_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint32_t address_space_ldl_be_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint64_t address_space_ldq_le_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+uint64_t address_space_ldq_be_cached(MemoryRegionCache *cache, hwaddr addr,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stb_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stw_le_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stw_be_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stl_le_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stl_be_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stq_le_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+void address_space_stq_be_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val,
+                            MemTxAttrs attrs, MemTxResult *result);
+
+uint32_t ldub_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint32_t lduw_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint32_t lduw_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint32_t ldl_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint32_t ldl_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint64_t ldq_le_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+uint64_t ldq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr);
+void stb_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stw_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stw_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stl_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stl_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
+void stq_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
+void stq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
+
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
  * called from an RCU critical section, to avoid that the last reference
@@ -1544,6 +1663,38 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     return result;
 }
 
+/**
+ * address_space_read_cached: read from a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline void
+address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
+                          void *buf, int len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    memcpy(buf, cache->ptr + addr, len);
+}
+
+/**
+ * address_space_write_cached: write to a cached RAM region
+ *
+ * @cache: Cached region to be addressed
+ * @addr: address relative to the base of the RAM region
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline void
+address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
+                           void *buf, int len)
+{
+    assert(addr < cache->len && len <= cache->len - addr);
+    memcpy(cache->ptr + addr, buf, len);
+}
+
 #endif
 
 #endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 1b8c30a..9a8bcbd 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -45,6 +45,7 @@ typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
 typedef struct MemoryMappingList MemoryMappingList;
 typedef struct MemoryRegion MemoryRegion;
+typedef struct MemoryRegionCache MemoryRegionCache;
 typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationParams MigrationParams;
-- 
1.8.3.1
