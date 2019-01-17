Received: from eggs.gnu.org ([209.51.188.92]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk779-0005m0-KQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk777-00020Y-PH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gk777-0001sS-Dw
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:41 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu, 17 Jan 2019 20:49:01 +0800
Message-Id: <1547729344-3895-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v6 1/4] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philmd@redhat.com, zhijianx.li@intel.com, philip.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>

Some address/memory APIs have different type between
'hwaddr/target_ulong addr' and 'int len'. It is very unsafe, especially
some APIs will be passed a non-int len by caller which might cause
overflow quietly.
Below is an potential overflow case:
    dma_memory_read(uint32_t len)
      -> dma_memory_rw(uint32_t len)
        -> dma_memory_rw_relaxed(uint32_t len)
          -> address_space_rw(int len) # len overflow

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

---
V6: Fix "WARNING: line over 80 characters"
V5: Fix typo and Reviewed-tag (Stefano Garzarella)
V4: minor fix at commit message and add Reviewed-by tag
V3: use the same type between len and addr(Peter Maydell)
    rebase code basing on https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org/

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 exec.c                    | 47 +++++++++++++++++++++++------------------------
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h |  8 ++++----
 include/exec/memory.h     | 22 +++++++++++-----------
 4 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/exec.c b/exec.c
index 895449f..9697e63 100644
--- a/exec.c
+++ b/exec.c
@@ -2849,10 +2849,10 @@ static const MemoryRegionOps watch_mem_ops = {
 };
 
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                      MemTxAttrs attrs, uint8_t *buf, int len);
+                                 MemTxAttrs attrs, uint8_t *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len);
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+                                  const uint8_t *buf, hwaddr len);
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
 
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -3100,10 +3100,10 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, target_ulong len, int is_write)
 {
-    int l, flags;
-    target_ulong page;
+    int flags;
+    target_ulong l, page;
     void * p;
 
     while (len > 0) {
@@ -3216,7 +3216,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
                                            const uint8_t *buf,
-                                           int len, hwaddr addr1,
+                                           hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3261,7 +3261,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len)
+                                  const uint8_t *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3279,7 +3279,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
-                                   int len, hwaddr addr1, hwaddr l,
+                                   hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3322,7 +3322,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, int len)
+                                 MemTxAttrs attrs, uint8_t *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3335,7 +3335,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len)
+                                    MemTxAttrs attrs, uint8_t *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3352,7 +3352,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
 
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, int len)
+                                const uint8_t *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3368,7 +3368,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
 }
 
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+                             uint8_t *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
@@ -3378,7 +3378,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
 }
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
-                            int len, int is_write)
+                            hwaddr len, int is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                      buf, len, is_write);
@@ -3393,7 +3393,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
                                                            hwaddr addr,
                                                            MemTxAttrs attrs,
                                                            const uint8_t *buf,
-                                                           int len,
+                                                           hwaddr len,
                                                            enum write_rom_type type)
 {
     hwaddr l;
@@ -3433,13 +3433,13 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, int len)
+                                    const uint8_t *buf, hwaddr len)
 {
     return address_space_write_rom_internal(as, addr, attrs,
                                             buf, len, WRITE_DATA);
 }
 
-void cpu_flush_icache_range(hwaddr start, int len)
+void cpu_flush_icache_range(hwaddr start, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3542,7 +3542,7 @@ static void cpu_notify_map_clients(void)
     qemu_mutex_unlock(&map_client_list_lock);
 }
 
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
@@ -3565,7 +3565,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
-                                int len, bool is_write,
+                                hwaddr len, bool is_write,
                                 MemTxAttrs attrs)
 {
     FlatView *fv;
@@ -3818,7 +3818,7 @@ static inline MemoryRegion *address_space_translate_cached(
  */
 void
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                   void *buf, int len)
+                                   void *buf, hwaddr len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3836,7 +3836,7 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
  */
 void
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                    const void *buf, int len)
+                                    const void *buf, hwaddr len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3859,11 +3859,10 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, target_ulong len, int is_write)
 {
-    int l;
     hwaddr phys_addr;
-    target_ulong page;
+    target_ulong l, page;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 117d2fb..b16c9ec 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -367,7 +367,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write);
+                        uint8_t *buf, target_ulong len, int is_write);
 
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2ad2d6d..63ec1f9 100644
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
@@ -111,7 +111,7 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr);
  */
 void qemu_flush_coalesced_mmio_buffer(void);
 
-void cpu_flush_icache_range(hwaddr start, int len);
+void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
 extern struct MemoryRegion io_mem_rom;
 extern struct MemoryRegion io_mem_notdirty;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index cd2f209..5c307ce 100644
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
 
 /**
  * address_space_write_rom: write to address space, including ROM.
@@ -1816,7 +1816,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, int len);
+                                    const uint8_t *buf, hwaddr len);
 
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -2017,7 +2017,7 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len,
+bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
 /* address_space_map: map a physical memory region into a host virtual address
@@ -2054,19 +2054,19 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
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
@@ -2094,7 +2094,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, uint8_t *buf,
-                               int len)
+                               hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
@@ -2133,7 +2133,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  */
 static inline void
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                          void *buf, int len)
+                          void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
@@ -2153,7 +2153,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
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
