Received: from eggs.gnu.org ([2001:4830:134:3::10]:49853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtp-0005lk-AV
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtl-0002lt-VZ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:12716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gPHtk-0002ig-0w
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:48 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 10:06:02 +0800
Message-Id: <1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v2 1/5] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Some address/memory APIs have different type between 'hwaddr addr' and
'int len'. It is very unsafety, espcially some APIs will be passed a non-int
len by caller which might cause overflow quietly.
Below is an potential overflow case:
    dma_memory_read(uint32_t len)
      -> dma_memory_rw(uint32_t len)
        -> dma_memory_rw_relaxed(uint32_t len)
          -> address_space_rw(int len) # len overflow

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 exec.c                    | 49 ++++++++++++++++++++++++-----------------------
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h | 10 +++++-----
 include/exec/memory.h     | 20 +++++++++----------
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/exec.c b/exec.c
index bb6170d..05823ae 100644
--- a/exec.c
+++ b/exec.c
@@ -2719,7 +2719,8 @@ static const MemoryRegionOps notdirty_mem_ops = {
 };
 
 /* Generate a debug exception if a watchpoint has been hit.  */
-static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
+static void check_watchpoint(hwaddr offset,  unsigned len,
+                             MemTxAttrs attrs, int flags)
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -2848,10 +2849,10 @@ static const MemoryRegionOps watch_mem_ops = {
 };
 
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                      MemTxAttrs attrs, uint8_t *buf, int len);
+                                      MemTxAttrs attrs, uint8_t *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len);
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+                                  const uint8_t *buf, hwaddr len);
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
 
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -3099,9 +3100,10 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, hwaddr len, int is_write)
 {
-    int l, flags;
+    hwaddr l;
+    int flags;
     target_ulong page;
     void * p;
 
@@ -3215,7 +3217,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
                                            const uint8_t *buf,
-                                           int len, hwaddr addr1,
+                                           hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3260,7 +3262,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len)
+                                  const uint8_t *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3278,7 +3280,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
-                                   int len, hwaddr addr1, hwaddr l,
+                                   hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3321,7 +3323,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, int len)
+                                 MemTxAttrs attrs, uint8_t *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3334,7 +3336,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len)
+                                    MemTxAttrs attrs, uint8_t *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3351,7 +3353,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
 
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, int len)
+                                const uint8_t *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3367,7 +3369,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
 }
 
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+                             uint8_t *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
@@ -3377,7 +3379,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
 }
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
-                            int len, int is_write)
+                            hwaddr len, int is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                      buf, len, is_write);
@@ -3389,7 +3391,7 @@ enum write_rom_type {
 };
 
 static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
-    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
+    hwaddr addr, const uint8_t *buf, hwaddr len, enum write_rom_type type)
 {
     hwaddr l;
     uint8_t *ptr;
@@ -3427,12 +3429,12 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 
 /* used for ROM loading : can write in RAM and ROM */
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len)
+                                   const uint8_t *buf, hwaddr len)
 {
     cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
 }
 
-void cpu_flush_icache_range(hwaddr start, int len)
+void cpu_flush_icache_range(hwaddr start, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3534,7 +3536,7 @@ static void cpu_notify_map_clients(void)
     qemu_mutex_unlock(&map_client_list_lock);
 }
 
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
@@ -3557,7 +3559,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
-                                int len, bool is_write,
+                                hwaddr len, bool is_write,
                                 MemTxAttrs attrs)
 {
     FlatView *fv;
@@ -3810,7 +3812,7 @@ static inline MemoryRegion *address_space_translate_cached(
  */
 void
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                   void *buf, int len)
+                                   void *buf, hwaddr len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3828,7 +3830,7 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
  */
 void
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                    const void *buf, int len)
+                                    const void *buf, hwaddr len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3851,10 +3853,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, hwaddr len, int is_write)
 {
-    int l;
-    hwaddr phys_addr;
+    hwaddr l, phys_addr;
     target_ulong page;
 
     cpu_synchronize_state(cpu);
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 117d2fb..4b56672 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -367,7 +367,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write);
+                        uint8_t *buf, hwaddr len, int is_write);
 
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 18b40d6..44b3554 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -83,14 +83,14 @@ size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
-                            int len, int is_write);
+                            hwaddr len, int is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, int len)
+                                            void *buf, hwaddr len)
 {
     cpu_physical_memory_rw(addr, buf, len, 0);
 }
 static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, int len)
+                                             const void *buf, hwaddr len)
 {
     cpu_physical_memory_rw(addr, (void *)buf, len, 1);
 }
@@ -112,8 +112,8 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr);
 void qemu_flush_coalesced_mmio_buffer(void);
 
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len);
-void cpu_flush_icache_range(hwaddr start, int len);
+                                   const uint8_t *buf, hwaddr len);
+void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
 extern struct MemoryRegion io_mem_rom;
 extern struct MemoryRegion io_mem_notdirty;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8e61450..841fa6f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1773,7 +1773,7 @@ void address_space_destroy(AddressSpace *as);
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, uint8_t *buf,
-                             int len, bool is_write);
+                             hwaddr len, bool is_write);
 
 /**
  * address_space_write: write to address space.
@@ -1790,7 +1790,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, int len);
+                                const uint8_t *buf, hwaddr len);
 
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -1991,7 +1991,7 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len,
+bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
 /* address_space_map: map a physical memory region into a host virtual address
@@ -2028,19 +2028,19 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len);
+                                    MemTxAttrs attrs, uint8_t *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
-                                   int len, hwaddr addr1, hwaddr l,
+                                   hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
 void address_space_read_cached_slow(MemoryRegionCache *cache,
-                                    hwaddr addr, void *buf, int len);
+                                    hwaddr addr, void *buf, hwaddr len);
 void address_space_write_cached_slow(MemoryRegionCache *cache,
-                                     hwaddr addr, const void *buf, int len);
+                                     hwaddr addr, const void *buf, hwaddr len);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
@@ -2068,7 +2068,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, uint8_t *buf,
-                               int len)
+                               hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
@@ -2107,7 +2107,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  */
 static inline void
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                          void *buf, int len)
+                          void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
@@ -2127,7 +2127,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  */
 static inline void
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           void *buf, int len)
+                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
-- 
2.7.4
