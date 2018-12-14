Received: from eggs.gnu.org ([2001:4830:134:3::10]:38249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofX-0008Me-Rx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofW-0004GQ-EG
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofW-0004Eq-74
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id a18so6060893wmj.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:55 +0000
Message-Id: <20181214144214.1260-4-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/22] Rename cpu_physical_memory_write_rom() to
 address_space_write_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The API of cpu_physical_memory_write_rom() is odd, because it
takes an AddressSpace, unlike all the other cpu_physical_memory_*
access functions. Rename it to address_space_write_rom(), and
bring its API into line with address_space_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20181122133507.30950-3-peter.maydell@linaro.org
---
 include/exec/cpu-common.h   |  2 --
 include/exec/memory.h       | 26 ++++++++++++++++++++++++++
 exec.c                      | 14 ++++++++------
 hw/core/loader.c            |  4 ++--
 hw/intc/apic.c              |  7 ++++---
 hw/misc/tz-mpc.c            |  2 +-
 hw/sparc/sun4m.c            |  5 +++--
 docs/devel/loads-stores.rst | 35 ++++++++++++++++-------------------
 8 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 18b40d6145c..2ad2d6d86bb 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -111,8 +111,6 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr);
  */
 void qemu_flush_coalesced_mmio_buffer(void);
 
-void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len);
 void cpu_flush_icache_range(hwaddr start, int len);
 
 extern struct MemoryRegion io_mem_rom;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8e61450de32..ffd23ed8d8d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1792,6 +1792,32 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const uint8_t *buf, int len);
 
+/**
+ * address_space_write_rom: write to address space, including ROM.
+ *
+ * This function writes to the specified address space, but will
+ * write data to both ROM and RAM. This is used for non-guest
+ * writes like writes from the gdb debug stub or initial loading
+ * of ROM contents.
+ *
+ * Note that portions of the write which attempt to write data to
+ * a device will be silently ignored -- only real RAM and ROM will
+ * be written to.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @attrs: memory transaction attributes
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
+                                    MemTxAttrs attrs,
+                                    const uint8_t *buf, int len);
+
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
  *
diff --git a/exec.c b/exec.c
index 92679508ba3..6e875f0640a 100644
--- a/exec.c
+++ b/exec.c
@@ -3430,11 +3430,12 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
-                                   const uint8_t *buf, int len)
+MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
+                                    MemTxAttrs attrs,
+                                    const uint8_t *buf, int len)
 {
-    address_space_write_rom_internal(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                     buf, len, WRITE_DATA);
+    return address_space_write_rom_internal(as, addr, attrs,
+                                            buf, len, WRITE_DATA);
 }
 
 void cpu_flush_icache_range(hwaddr start, int len)
@@ -3879,8 +3880,9 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            cpu_physical_memory_write_rom(cpu->cpu_ases[asidx].as,
-                                          phys_addr, buf, l);
+            address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
+                                    MEMTXATTRS_UNSPECIFIED,
+                                    buf, l);
         } else {
             address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
                              MEMTXATTRS_UNSPECIFIED,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc8679..66a616608af 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1103,8 +1103,8 @@ static void rom_reset(void *unused)
             void *host = memory_region_get_ram_ptr(rom->mr);
             memcpy(host, rom->data, rom->datasize);
         } else {
-            cpu_physical_memory_write_rom(rom->as, rom->addr, rom->data,
-                                          rom->datasize);
+            address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
+                                    rom->data, rom->datasize);
         }
         if (rom->isrom) {
             /* rom needs to be written only once */
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 97ffdd820f2..c9dd65b3a03 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -122,9 +122,10 @@ static void apic_sync_vapic(APICCommonState *s, int sync_type)
         }
         vapic_state.irr = vector & 0xff;
 
-        cpu_physical_memory_write_rom(&address_space_memory,
-                                      s->vapic_paddr + start,
-                                      ((void *)&vapic_state) + start, length);
+        address_space_write_rom(&address_space_memory,
+                                s->vapic_paddr + start,
+                                MEMTXATTRS_UNSPECIFIED,
+                                ((void *)&vapic_state) + start, length);
     }
 }
 
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index e0c58ba37ec..fb48a1540b9 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -448,7 +448,7 @@ static int tz_mpc_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
 {
     /* We treat unspecified attributes like secure. Transactions with
      * unspecified attributes come from places like
-     * cpu_physical_memory_write_rom() for initial image load, and we want
+     * rom_reset() for initial image load, and we want
      * those to pass through the from-reset "everything is secure" config.
      * All the real during-emulation transactions from the CPU will
      * specify attributes.
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 3c29b68e67f..639906cca30 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -559,8 +559,9 @@ static void idreg_init(hwaddr addr)
     s = SYS_BUS_DEVICE(dev);
 
     sysbus_mmio_map(s, 0, addr);
-    cpu_physical_memory_write_rom(&address_space_memory,
-                                  addr, idreg_data, sizeof(idreg_data));
+    address_space_write_rom(&address_space_memory, addr,
+                            MEMTXATTRS_UNSPECIFIED,
+                            idreg_data, sizeof(idreg_data));
 }
 
 #define MACIO_ID_REGISTER(obj) \
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 57d8c524bfe..c74cd090e64 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -253,6 +253,22 @@ Regexes for git grep
  - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
  - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
 
+``address_space_write_rom``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This function performs a write by physical address like
+``address_space_write``, except that if the write is to a ROM then
+the ROM contents will be modified, even though a write by the guest
+CPU to the ROM would be ignored. This is used for non-guest writes
+like writes from the gdb debug stub or initial loading of ROM contents.
+
+Note that portions of the write which attempt to write data to a
+device will be silently ignored -- only real RAM and ROM will
+be written to.
+
+Regexes for git grep
+ - ``address_space_write_rom``
+
 ``{ld,st}*_phys``
 ~~~~~~~~~~~~~~~~~
 
@@ -315,25 +331,6 @@ For new code they are better avoided:
 Regexes for git grep
  - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
 
-``cpu_physical_memory_write_rom``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-This function performs a write by physical address like
-``address_space_write``, except that if the write is to a ROM then
-the ROM contents will be modified, even though a write by the guest
-CPU to the ROM would be ignored.
-
-Note that unlike ``cpu_physical_memory_write()`` this function takes
-an AddressSpace argument, but unlike ``address_space_write()`` this
-function does not take a ``MemTxAttrs`` or return a ``MemTxResult``.
-
-**TODO**: we should probably clean up this inconsistency and
-turn the function into ``address_space_write_rom`` with an API
-matching ``address_space_write``.
-
-``cpu_physical_memory_write_rom``
-
-
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.19.2
