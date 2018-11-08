Received: from eggs.gnu.org ([2001:4830:134:3::10]:40132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhRu-0005CM-8n
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhIK-0000Fd-9o
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:53932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gKhII-0000CU-Bq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:12 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu,  8 Nov 2018 18:59:44 +0800
Message-Id: <1541674784-25936-4-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH 3/3] change int len to uin32_t len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Philip Li <philip.li@intel.com>

In order to support >= 2G initrd, we need to change len type from int to
uin32_t.

Below is the flow sample to show how qemu copy initrd from qemu
side to VM when using optionroms bootlinux_dma.bin:
dma_memory_read(uint32_t len)
  -> dma_memory_rw(uint32_t len)
    -> dma_memory_rw_relaxed(uint32_t len)
      -> address_space_rw(int len) # len overflow
        -> address_space_read_full(int len)

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Philip Li <philip.li@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 exec.c                    | 42 +++++++++++++++++++++---------------------
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h | 10 +++++-----
 include/exec/memory.h     | 20 ++++++++++----------
 4 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/exec.c b/exec.c
index bb6170d..0985f52 100644
--- a/exec.c
+++ b/exec.c
@@ -2719,7 +2719,7 @@ static const MemoryRegionOps notdirty_mem_ops = {
 };
 
 /* Generate a debug exception if a watchpoint has been hit.  */
-static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
+static void check_watchpoint(int offset, uint32_t len, MemTxAttrs attrs, int flags)
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -2848,10 +2848,10 @@ static const MemoryRegionOps watch_mem_ops = {
 };
 
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                      MemTxAttrs attrs, uint8_t *buf, int len);
+                                      MemTxAttrs attrs, uint8_t *buf, uint32_t len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len);
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+                                  const uint8_t *buf, uint32_t len);
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, uint32_t len,
                                   bool is_write, MemTxAttrs attrs);
 
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -3099,7 +3099,7 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, uint32_t len, int is_write)
 {
     int l, flags;
     target_ulong page;
@@ -3215,7 +3215,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
                                            const uint8_t *buf,
-                                           int len, hwaddr addr1,
+                                           uint32_t len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3260,7 +3260,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, int len)
+                                  const uint8_t *buf, uint32_t len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3278,7 +3278,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
-                                   int len, hwaddr addr1, hwaddr l,
+                                   uint32_t len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
     uint8_t *ptr;
@@ -3321,7 +3321,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, int len)
+                                 MemTxAttrs attrs, uint8_t *buf, uint32_t len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3334,7 +3334,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len)
+                                    MemTxAttrs attrs, uint8_t *buf, uint32_t len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3351,7 +3351,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
 
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, int len)
+                                const uint8_t *buf, uint32_t len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3367,7 +3367,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
 }
 
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+                             uint8_t *buf, uint32_t len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
@@ -3377,7 +3377,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
 }
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
-                            int len, int is_write)
+                            uint32_t len, int is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                      buf, len, is_write);
@@ -3389,7 +3389,7 @@ enum write_rom_type {
 };
 
 static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
-    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
+    hwaddr addr, const uint8_t *buf, uint32_t len, enum write_rom_type type)
 {
     hwaddr l;
     uint8_t *ptr;
@@ -3427,12 +3427,12 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
 
 /* used for ROM loading : can write in RAM and ROM */
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len)
+                                   const uint8_t *buf, uint32_t len)
 {
     cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
 }
 
-void cpu_flush_icache_range(hwaddr start, int len)
+void cpu_flush_icache_range(hwaddr start, uint32_t len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3534,7 +3534,7 @@ static void cpu_notify_map_clients(void)
     qemu_mutex_unlock(&map_client_list_lock);
 }
 
-static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, uint32_t len,
                                   bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
@@ -3557,7 +3557,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
-                                int len, bool is_write,
+                                uint32_t len, bool is_write,
                                 MemTxAttrs attrs)
 {
     FlatView *fv;
@@ -3810,7 +3810,7 @@ static inline MemoryRegion *address_space_translate_cached(
  */
 void
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                   void *buf, int len)
+                                   void *buf, uint32_t len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3828,7 +3828,7 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
  */
 void
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
-                                    const void *buf, int len)
+                                    const void *buf, uint32_t len)
 {
     hwaddr addr1, l;
     MemoryRegion *mr;
@@ -3851,7 +3851,7 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write)
+                        uint8_t *buf, uint32_t len, int is_write)
 {
     int l;
     hwaddr phys_addr;
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 117d2fb..635394c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -367,7 +367,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, int len, int is_write);
+                        uint8_t *buf, uint32_t len, int is_write);
 
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 18b40d6..bdbb620 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -83,14 +83,14 @@ size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
-                            int len, int is_write);
+                            uint32_t len, int is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, int len)
+                                            void *buf, uint32_t len)
 {
     cpu_physical_memory_rw(addr, buf, len, 0);
 }
 static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, int len)
+                                             const void *buf, uint32_t len)
 {
     cpu_physical_memory_rw(addr, (void *)buf, len, 1);
 }
@@ -112,8 +112,8 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr);
 void qemu_flush_coalesced_mmio_buffer(void);
 
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len);
-void cpu_flush_icache_range(hwaddr start, int len);
+                                   const uint8_t *buf, uint32_t len);
+void cpu_flush_icache_range(hwaddr start, uint32_t len);
 
 extern struct MemoryRegion io_mem_rom;
 extern struct MemoryRegion io_mem_notdirty;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 667466b..6c1ec75 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1748,7 +1748,7 @@ void address_space_destroy(AddressSpace *as);
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, uint8_t *buf,
-                             int len, bool is_write);
+                             uint32_t len, bool is_write);
 
 /**
  * address_space_write: write to address space.
@@ -1765,7 +1765,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, int len);
+                                const uint8_t *buf, uint32_t len);
 
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -1966,7 +1966,7 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len,
+bool address_space_access_valid(AddressSpace *as, hwaddr addr, uint32_t len,
                                 bool is_write, MemTxAttrs attrs);
 
 /* address_space_map: map a physical memory region into a host virtual address
@@ -2003,19 +2003,19 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len);
+                                    MemTxAttrs attrs, uint8_t *buf, uint32_t len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, uint8_t *buf,
-                                   int len, hwaddr addr1, hwaddr l,
+                                   uint32_t len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
 void address_space_read_cached_slow(MemoryRegionCache *cache,
-                                    hwaddr addr, void *buf, int len);
+                                    hwaddr addr, void *buf, uint32_t len);
 void address_space_write_cached_slow(MemoryRegionCache *cache,
-                                     hwaddr addr, const void *buf, int len);
+                                     hwaddr addr, const void *buf, uint32_t len);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
@@ -2043,7 +2043,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, uint8_t *buf,
-                               int len)
+                               uint32_t len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
@@ -2082,7 +2082,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  */
 static inline void
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
-                          void *buf, int len)
+                          void *buf, uint32_t len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
@@ -2102,7 +2102,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  */
 static inline void
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           void *buf, int len)
+                           void *buf, uint32_t len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
-- 
2.7.4
