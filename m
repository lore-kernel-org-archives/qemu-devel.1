Received: from eggs.gnu.org ([2001:4830:134:3::10]:52097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKK-0005p1-5R
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKI-0001HY-Du
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:55 -0300
Message-Id: <20180415234307.28132-30-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 29/41] hw/mips: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/intc/mips_gic.h |  3 ++-
 include/hw/mips/bios.h     |  3 ++-
 hw/mips/boston.c           |  4 ++--
 hw/mips/mips_fulong2e.c    |  7 ++++---
 hw/mips/mips_malta.c       | 23 +++++++++++++----------
 hw/mips/mips_r4k.c         | 11 ++++++-----
 hw/misc/mips_itu.c         |  3 ++-
 hw/pci-host/xilinx-pcie.c  |  5 +++--
 8 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index b98d50094a..c0da44bdb3 100644
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
+#define GIC_ADDRSPACE_SZ        (128 * K_BYTE)
 
 /* Constants */
 #define GIC_POL_POS     1
diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
index b4b88ac43d..b4c97ce87c 100644
--- a/include/hw/mips/bios.h
+++ b/include/hw/mips/bios.h
@@ -1,6 +1,7 @@
+#include "qemu/units.h"
 #include "cpu.h"
 
-#define BIOS_SIZE (4 * 1024 * 1024)
+#define BIOS_SIZE (4 * M_BYTE)
 #ifdef TARGET_WORDS_BIGENDIAN
 #define BIOS_FILENAME "mips_bios.bin"
 #else
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index fb23161b33..edc39e91f7 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -32,7 +32,7 @@
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "qapi/error.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
@@ -437,7 +437,7 @@ static void boston_mach_init(MachineState *machine)
     bool is_64b;
 
     if ((machine->ram_size % G_BYTE) ||
-        (machine->ram_size > (2 * G_BYTE))) {
+        (machine->ram_size > 2 * G_BYTE)) {
         error_report("Memory size must be 1GB or 2GB");
         exit(1);
     }
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 02fb2fdcc4..779883db7c 100644
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
+    prom_set(prom_buf, index++, "memsize=%llu", loaderparams.ram_size / M_BYTE);
     prom_set(prom_buf, index++, "modetty0=38400n8r");
     prom_set(prom_buf, index++, NULL);
 
@@ -303,10 +304,10 @@ static void mips_fulong2e_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* fulong 2e has 256M ram. */
-    ram_size = 256 * 1024 * 1024;
+    ram_size = 256 * M_BYTE;
 
     /* fulong 2e has a 1M flash.Winbond W39L040AP70Z */
-    bios_size = 1024 * 1024;
+    bios_size = 1 * M_BYTE;
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index f6513a4fd5..240dd762be 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -844,7 +845,8 @@ static int64_t load_kernel (void)
             /* The kernel allocates the bootmap memory in the low memory after
                the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
                pages.  */
-            initrd_offset = (loaderparams.ram_low_size - initrd_size - 131072
+            initrd_offset = (loaderparams.ram_low_size - initrd_size
+                             - (128 * K_BYTE)
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
             if (kernel_high >= initrd_offset) {
                 error_report("memory too small for initial ram disk '%s'",
@@ -1022,9 +1024,9 @@ void mips_malta_init(MachineState *machine)
     mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
-    if (ram_size > (2048u << 20)) {
-        error_report("Too much memory for this machine: %dMB, maximum 2048MB",
-                     ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 2 * G_BYTE) {
+        error_report("Too much memory for this machine: %lluMB, maximum 2048MB",
+                     ram_size / M_BYTE);
         exit(1);
     }
 
@@ -1035,17 +1037,18 @@ void mips_malta_init(MachineState *machine)
 
     /* alias for pre IO hole access */
     memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ram",
-                             ram_high, 0, MIN(ram_size, (256 << 20)));
+                             ram_high, 0, MIN(ram_size, 256 * M_BYTE));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
 
     /* alias for post IO hole access, if there is enough RAM */
-    if (ram_size > (512 << 20)) {
+    if (ram_size > 512 * M_BYTE) {
         ram_low_postio = g_new(MemoryRegion, 1);
         memory_region_init_alias(ram_low_postio, NULL,
                                  "mips_malta_low_postio.ram",
-                                 ram_high, 512 << 20,
-                                 ram_size - (512 << 20));
-        memory_region_add_subregion(system_memory, 512 << 20, ram_low_postio);
+                                 ram_high, 512 * M_BYTE,
+                                 ram_size - 512 * M_BYTE);
+        memory_region_add_subregion(system_memory, 512 * M_BYTE,
+                                    ram_low_postio);
     }
 
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -1082,7 +1085,7 @@ void mips_malta_init(MachineState *machine)
     bios = pflash_cfi01_get_memory(fl);
     fl_idx++;
     if (kernel_filename) {
-        ram_low_size = MIN(ram_size, 256 << 20);
+        ram_low_size = MIN(ram_size, 256 * M_BYTE);
         /* For KVM we reserve 1MB of RAM for running bootloader */
         if (kvm_enabled()) {
             ram_low_size -= 0x100000;
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index c26a44da06..2a848bc1c2 100644
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
@@ -144,7 +145,7 @@ static int64_t load_kernel(void)
     }
 
     rom_add_blob_fixed("params", params_buf, params_size,
-                       (16 << 20) - params_size);
+                       16 * M_BYTE - params_size);
 
     g_free(params_buf);
     return entry;
@@ -159,7 +160,7 @@ static void main_cpu_reset(void *opaque)
     env->active_tc.PC = s->vector;
 }
 
-static const int sector_len = 32 * 1024;
+static const int sector_len = 32 * K_BYTE;
 static
 void mips_r4k_init(MachineState *machine)
 {
@@ -195,9 +196,9 @@ void mips_r4k_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* allocate RAM */
-    if (ram_size > (256 << 20)) {
-        error_report("Too much memory for this machine: %dMB, maximum 256MB",
-                     ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 256 * M_BYTE) {
+        error_report("Too much memory for this machine: %lluMB, maximum 256MB",
+                     ram_size / M_BYTE);
         exit(1);
     }
     memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_size);
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ccc4c7d98a..e40d472108 100644
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
+    uint64_t size = (1 * K_BYTE) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
     bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
 
     memory_region_transaction_begin();
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 044e312dc1..6758669ce9 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/xilinx-pcie.h"
@@ -158,9 +159,9 @@ static void xilinx_pcie_host_init(Object *obj)
 static Property xilinx_pcie_host_props[] = {
     DEFINE_PROP_UINT32("bus_nr", XilinxPCIEHost, bus_nr, 0),
     DEFINE_PROP_SIZE("cfg_base", XilinxPCIEHost, cfg_base, 0),
-    DEFINE_PROP_SIZE("cfg_size", XilinxPCIEHost, cfg_size, 32 << 20),
+    DEFINE_PROP_SIZE("cfg_size", XilinxPCIEHost, cfg_size, 32 * M_BYTE),
     DEFINE_PROP_SIZE("mmio_base", XilinxPCIEHost, mmio_base, 0),
-    DEFINE_PROP_SIZE("mmio_size", XilinxPCIEHost, mmio_size, 1 << 20),
+    DEFINE_PROP_SIZE("mmio_size", XilinxPCIEHost, mmio_size, 1 * M_BYTE),
     DEFINE_PROP_BOOL("link_up", XilinxPCIEHost, link_up, true),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.17.0
