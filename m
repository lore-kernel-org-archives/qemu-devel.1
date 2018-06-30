Received: from eggs.gnu.org ([2001:4830:134:3::10]:38098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96P-0004Un-EU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96K-0002YQ-Ov
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:21 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:41012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96K-0002Vg-Di
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:16 -0400
Received: by mail-wr0-x235.google.com with SMTP id h10-v6so10635651wrq.8
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:25 +0200
Message-Id: <20180630061040.6018-33-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/47] hw/mips: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20180625124238.25339-31-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mips_fulong2e.c    |  7 ++++---
 hw/mips/mips_malta.c       | 25 ++++++++++++++-----------
 hw/mips/mips_r4k.c         | 11 ++++++-----
 hw/misc/mips_itu.c         |  3 ++-
 hw/pci-host/xilinx-pcie.c  |  5 +++--
 include/hw/intc/mips_gic.h |  3 ++-
 include/hw/mips/bios.h     |  3 ++-
 7 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 02fb2fd..c1694c8 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -159,7 +160,7 @@ static int64_t load_kernel (CPUMIPSState *env)
     /* Setup minimum environment variables */
     prom_set(prom_buf, index++, "busclock=33000000");
     prom_set(prom_buf, index++, "cpuclock=100000000");
-    prom_set(prom_buf, index++, "memsize=%i", loaderparams.ram_size/1024/1024);
+    prom_set(prom_buf, index++, "memsize=%"PRIi64, loaderparams.ram_size / MiB);
     prom_set(prom_buf, index++, "modetty0=38400n8r");
     prom_set(prom_buf, index++, NULL);
 
@@ -303,10 +304,10 @@ static void mips_fulong2e_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* fulong 2e has 256M ram. */
-    ram_size = 256 * 1024 * 1024;
+    ram_size = 256 * MiB;
 
     /* fulong 2e has a 1M flash.Winbond W39L040AP70Z */
-    bios_size = 1024 * 1024;
+    bios_size = 1 * MiB;
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index b9d92bf..1603f9a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -191,7 +192,7 @@ static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
     int i;
 
     /* work in terms of MB */
-    ram_size >>= 20;
+    ram_size /= MiB;
 
     while ((ram_size >= 4) && (nbanks <= 2)) {
         int sz_log2 = MIN(31 - clz32(ram_size), 14);
@@ -843,7 +844,8 @@ static int64_t load_kernel (void)
             /* The kernel allocates the bootmap memory in the low memory after
                the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
                pages.  */
-            initrd_offset = (loaderparams.ram_low_size - initrd_size - 131072
+            initrd_offset = (loaderparams.ram_low_size - initrd_size
+                             - (128 * KiB)
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
             if (kernel_high >= initrd_offset) {
                 error_report("memory too small for initial ram disk '%s'",
@@ -1021,9 +1023,9 @@ void mips_malta_init(MachineState *machine)
     mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
-    if (ram_size > (2048u << 20)) {
-        error_report("Too much memory for this machine: %dMB, maximum 2048MB",
-                     ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 2 * GiB) {
+        error_report("Too much memory for this machine: %" PRId64 "MB,"
+                     " maximum 2048MB", ram_size / MiB);
         exit(1);
     }
 
@@ -1034,17 +1036,18 @@ void mips_malta_init(MachineState *machine)
 
     /* alias for pre IO hole access */
     memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ram",
-                             ram_high, 0, MIN(ram_size, (256 << 20)));
+                             ram_high, 0, MIN(ram_size, 256 * MiB));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
 
     /* alias for post IO hole access, if there is enough RAM */
-    if (ram_size > (512 << 20)) {
+    if (ram_size > 512 * MiB) {
         ram_low_postio = g_new(MemoryRegion, 1);
         memory_region_init_alias(ram_low_postio, NULL,
                                  "mips_malta_low_postio.ram",
-                                 ram_high, 512 << 20,
-                                 ram_size - (512 << 20));
-        memory_region_add_subregion(system_memory, 512 << 20, ram_low_postio);
+                                 ram_high, 512 * MiB,
+                                 ram_size - 512 * MiB);
+        memory_region_add_subregion(system_memory, 512 * MiB,
+                                    ram_low_postio);
     }
 
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -1076,7 +1079,7 @@ void mips_malta_init(MachineState *machine)
     bios = pflash_cfi01_get_memory(fl);
     fl_idx++;
     if (kernel_filename) {
-        ram_low_size = MIN(ram_size, 256 << 20);
+        ram_low_size = MIN(ram_size, 256 * MiB);
         /* For KVM we reserve 1MB of RAM for running bootloader */
         if (kvm_enabled()) {
             ram_low_size -= 0x100000;
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index fc38b4b..d5725d0 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -8,6 +8,7 @@
  * the standard PC ISA addresses.
 */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -143,7 +144,7 @@ static int64_t load_kernel(void)
     }
 
     rom_add_blob_fixed("params", params_buf, params_size,
-                       (16 << 20) - params_size);
+                       16 * MiB - params_size);
 
     g_free(params_buf);
     return entry;
@@ -158,7 +159,7 @@ static void main_cpu_reset(void *opaque)
     env->active_tc.PC = s->vector;
 }
 
-static const int sector_len = 32 * 1024;
+static const int sector_len = 32 * KiB;
 static
 void mips_r4k_init(MachineState *machine)
 {
@@ -194,9 +195,9 @@ void mips_r4k_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* allocate RAM */
-    if (ram_size > (256 << 20)) {
-        error_report("Too much memory for this machine: %dMB, maximum 256MB",
-                     ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 256 * MiB) {
+        error_report("Too much memory for this machine: %" PRId64 "MB,"
+                     " maximum 256MB", ram_size / MiB);
         exit(1);
     }
     memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_size);
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ccc4c7d..43bbec4 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -80,7 +81,7 @@ static void itc_reconfigure(MIPSITUState *tag)
     uint64_t *am = &tag->ITCAddressMap[0];
     MemoryRegion *mr = &tag->storage_io;
     hwaddr address = am[0] & ITC_AM0_BASE_ADDRESS_MASK;
-    uint64_t size = (1 << 10) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
+    uint64_t size = (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
     bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
 
     memory_region_transaction_begin();
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index b0a31b9..60309af 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/xilinx-pcie.h"
@@ -157,9 +158,9 @@ static void xilinx_pcie_host_init(Object *obj)
 static Property xilinx_pcie_host_props[] = {
     DEFINE_PROP_UINT32("bus_nr", XilinxPCIEHost, bus_nr, 0),
     DEFINE_PROP_SIZE("cfg_base", XilinxPCIEHost, cfg_base, 0),
-    DEFINE_PROP_SIZE("cfg_size", XilinxPCIEHost, cfg_size, 32 << 20),
+    DEFINE_PROP_SIZE("cfg_size", XilinxPCIEHost, cfg_size, 32 * MiB),
     DEFINE_PROP_SIZE("mmio_base", XilinxPCIEHost, mmio_base, 0),
-    DEFINE_PROP_SIZE("mmio_size", XilinxPCIEHost, mmio_size, 1 << 20),
+    DEFINE_PROP_SIZE("mmio_size", XilinxPCIEHost, mmio_size, 1 * MiB),
     DEFINE_PROP_BOOL("link_up", XilinxPCIEHost, link_up, true),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index b98d500..902a12b 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -11,6 +11,7 @@
 #ifndef MIPS_GIC_H
 #define MIPS_GIC_H
 
+#include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
 #include "cpu.h"
 /*
@@ -19,7 +20,7 @@
 
 /* The MIPS default location */
 #define GIC_BASE_ADDR           0x1bdc0000ULL
-#define GIC_ADDRSPACE_SZ        (128 * 1024)
+#define GIC_ADDRSPACE_SZ        (128 * KiB)
 
 /* Constants */
 #define GIC_POL_POS     1
diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
index b4b88ac..d67ef33 100644
--- a/include/hw/mips/bios.h
+++ b/include/hw/mips/bios.h
@@ -1,6 +1,7 @@
+#include "qemu/units.h"
 #include "cpu.h"
 
-#define BIOS_SIZE (4 * 1024 * 1024)
+#define BIOS_SIZE (4 * MiB)
 #ifdef TARGET_WORDS_BIGENDIAN
 #define BIOS_FILENAME "mips_bios.bin"
 #else
-- 
1.8.3.1
