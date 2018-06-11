Received: from eggs.gnu.org ([2001:4830:134:3::10]:43466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSU-000678-AB
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSR-0003Yr-J1
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:53 -0300
Message-Id: <20180611011501.10235-33-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 32/40] hw/ppc: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac.h           |  3 ++-
 include/hw/ppc/spapr.h |  5 +++--
 hw/nvram/spapr_nvram.c | 10 ++++++----
 hw/pci-host/prep.c     |  3 ++-
 hw/ppc/e500.c          | 13 +++++++------
 hw/ppc/e500plat.c      |  3 ++-
 hw/ppc/mac_newworld.c  |  1 -
 hw/ppc/mac_oldworld.c  |  9 ++++-----
 hw/ppc/ppc405_boards.c |  9 +++++----
 hw/ppc/ppc405_uc.c     |  7 ++++---
 hw/ppc/ppc440_bamboo.c |  6 ++++--
 hw/ppc/ppc4xx_devs.c   | 22 ++++++++++++----------
 hw/ppc/ppce500_spin.c  |  3 ++-
 hw/ppc/prep.c          |  4 ++--
 hw/ppc/rs6000_mc.c     | 13 +++++++------
 hw/ppc/sam460ex.c      | 18 ++++++++++--------
 hw/ppc/spapr.c         |  2 +-
 hw/ppc/virtex_ml507.c  |  7 ++++---
 18 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 22a7efbed6..c0af576f8c 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -26,6 +26,7 @@
 #ifndef PPC_MAC_H
 #define PPC_MAC_H
 
+#include "qemu/units.h"
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 #include "hw/ide/internal.h"
@@ -37,7 +38,7 @@
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
 
-#define BIOS_SIZE     (1024 * 1024)
+#define BIOS_SIZE        (1 * MiB)
 #define NVRAM_SIZE        0x2000
 #define PROM_FILENAME    "openbios-ppc"
 #define PROM_ADDR         0xfff00000
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3388750fc7..210cbdd2ca 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1,6 +1,7 @@
 #ifndef HW_SPAPR_H
 #define HW_SPAPR_H
 
+#include "qemu/units.h"
 #include "sysemu/dma.h"
 #include "hw/boards.h"
 #include "hw/ppc/xics.h"
@@ -747,8 +748,8 @@ int spapr_rng_populate_dt(void *fdt);
  */
 #define SPAPR_MAX_RAM_SLOTS     32
 
-/* 1GB alignment for device memory region */
-#define SPAPR_DEVICE_MEM_ALIGN (1ULL << 30)
+/* 1GB alignment for hotplug memory region */
+#define SPAPR_DEVICE_MEM_ALIGN (1 * GiB)
 
 /*
  * Number of 32 bit words in each LMB list entry in ibm,dynamic-memory
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 4a0aec8e1d..3c88f42acf 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -47,9 +48,9 @@ typedef struct sPAPRNVRAM {
 #define VIO_SPAPR_NVRAM(obj) \
      OBJECT_CHECK(sPAPRNVRAM, (obj), TYPE_VIO_SPAPR_NVRAM)
 
-#define MIN_NVRAM_SIZE 8192
-#define DEFAULT_NVRAM_SIZE 65536
-#define MAX_NVRAM_SIZE 1048576
+#define MIN_NVRAM_SIZE      (8 * KiB)
+#define DEFAULT_NVRAM_SIZE  (64 * KiB)
+#define MAX_NVRAM_SIZE      (1 * MiB)
 
 static void rtas_nvram_fetch(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                              uint32_t token, uint32_t nargs,
@@ -167,7 +168,8 @@ static void spapr_nvram_realize(VIOsPAPRDevice *dev, Error **errp)
     nvram->buf = g_malloc0(nvram->size);
 
     if ((nvram->size < MIN_NVRAM_SIZE) || (nvram->size > MAX_NVRAM_SIZE)) {
-        error_setg(errp, "spapr-nvram must be between %d and %d bytes in size",
+        error_setg(errp,
+                   "spapr-nvram must be between %llu and %llu bytes in size",
                    MIN_NVRAM_SIZE, MAX_NVRAM_SIZE);
         return;
     }
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 01f67f9db1..88f035c20b 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -70,7 +71,7 @@ typedef struct PRePPCIState {
     int contiguous_map;
 } PREPPCIState;
 
-#define BIOS_SIZE (1024 * 1024)
+#define BIOS_SIZE (1 * MiB)
 
 static inline uint32_t raven_pci_io_config(hwaddr addr)
 {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 826053edc8..7d19b1498c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "e500.h"
 #include "e500-ccsr.h"
@@ -46,11 +47,11 @@
 #define BINARY_DEVICE_TREE_FILE    "mpc8544ds.dtb"
 #define DTC_LOAD_PAD               0x1800000
 #define DTC_PAD_MASK               0xFFFFF
-#define DTB_MAX_SIZE               (8 * 1024 * 1024)
+#define DTB_MAX_SIZE               (8 * MiB)
 #define INITRD_LOAD_PAD            0x2000000
 #define INITRD_PAD_MASK            0xFFFFFF
 
-#define RAM_SIZES_ALIGN            (64UL << 20)
+#define RAM_SIZES_ALIGN            (64 * MiB)
 
 /* TODO: parameterize */
 #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
@@ -603,7 +604,7 @@ static int ppce500_prep_device_tree(PPCE500MachineState *machine,
 /* Create -kernel TLB entries for BookE.  */
 hwaddr booke206_page_size_to_tlb(uint64_t size)
 {
-    return 63 - clz64(size >> 10);
+    return 63 - clz64(size / KiB);
 }
 
 static int booke206_initial_map_tsize(CPUPPCState *env)
@@ -671,7 +672,7 @@ static void ppce500_cpu_reset(void *opaque)
 
     /* Set initial guest state. */
     cs->halted = 0;
-    env->gpr[1] = (16<<20) - 8;
+    env->gpr[1] = (16 * MiB) - 8;
     env->gpr[3] = bi->dt_base;
     env->gpr[4] = 0;
     env->gpr[5] = 0;
@@ -1012,9 +1013,9 @@ void ppce500_init(MachineState *machine)
     }
 
     cur_base = loadaddr + payload_size;
-    if (cur_base < (32 * 1024 * 1024)) {
+    if (cur_base < 32 * MiB) {
         /* u-boot occupies memory up to 32MB, so load blobs above */
-        cur_base = (32 * 1024 * 1024);
+        cur_base = 32 * MiB;
     }
 
     /* Load bare kernel only if no bios/u-boot has been provided */
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index d8e3f2066e..963d429cc8 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "e500.h"
 #include "hw/net/fsl_etsec/etsec.h"
@@ -85,7 +86,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     pmc->has_mpc8xxx_gpio = true;
     pmc->has_platform_bus = true;
     pmc->platform_bus_base = 0xf00000000ULL;
-    pmc->platform_bus_size = (128ULL * 1024 * 1024);
+    pmc->platform_bus_size = 128 * MiB;
     pmc->platform_bus_first_irq = 5;
     pmc->platform_bus_num_irqs = 10;
     pmc->ccsrbar_base = 0xFE0000000ULL;
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 744acdfd2e..bf51ad6fdd 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -71,7 +71,6 @@
 #include "hw/usb.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 4608bab014..31f4cea111 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -24,6 +24,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
@@ -46,7 +47,6 @@
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
@@ -118,10 +118,9 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     /* allocate RAM */
-    if (ram_size > (2047 << 20)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d MB, maximum 2047 MB\n",
-                ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 2047 * MiB) {
+        error_report("Too much memory for this machine: %llu MB, "
+                     "maximum 2047 MB", ram_size / MiB);
         exit(1);
     }
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index d301067d3b..70111075b3 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -40,7 +41,7 @@
 #include "exec/address-spaces.h"
 
 #define BIOS_FILENAME "ppc405_rom.bin"
-#define BIOS_SIZE (2048 * 1024)
+#define BIOS_SIZE (2 * MiB)
 
 #define KERNEL_LOAD_ADDR 0x00000000
 #define INITRD_LOAD_ADDR 0x01800000
@@ -216,14 +217,14 @@ static void ref405ep_init(MachineState *machine)
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
     ram_bases[1] = 0x00000000;
     ram_sizes[1] = 0x00000000;
-    ram_size = 128 * 1024 * 1024;
+    ram_size = 128 * MiB;
 #ifdef DEBUG_BOARD_INIT
     printf("%s: register cpu\n", __func__);
 #endif
     env = ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
                         33333333, &pic, kernel_filename == NULL ? 0 : 1);
     /* allocate SRAM */
-    sram_size = 512 * 1024;
+    sram_size = 512 * KiB;
     memory_region_init_ram(sram, NULL, "ef405ep.sram", sram_size,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0xFFF00000, sram);
@@ -589,7 +590,7 @@ static void taihu_405ep_init(MachineState *machine)
 
         bios_size = blk_getlength(blk);
         /* XXX: should check that size is 32MB */
-        bios_size = 32 * 1024 * 1024;
+        bios_size = 32 * MiB;
         fl_sectors = (bios_size + 65535) >> 16;
 #ifdef DEBUG_BOARD_INIT
         printf("Register parallel flash %d size %lx"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 34f8d57b07..4bd9fbcc1e 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -983,10 +984,10 @@ static void ppc405_ocm_init(CPUPPCState *env)
 
     ocm = g_malloc0(sizeof(ppc405_ocm_t));
     /* XXX: Size is 4096 or 0x04000000 */
-    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
+    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4 * KiB,
                            &error_fatal);
-    memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc", &ocm->isarc_ram,
-                             0, 4096);
+    memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc",
+                             &ocm->isarc_ram, 0, 4 * KiB);
     qemu_register_reset(&ocm_reset, ocm);
     ppc_dcr_register(env, OCM0_ISARC,
                      ocm, &dcr_read_ocm, &dcr_write_ocm);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 44e6a0c21b..8b37fc6182 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -49,7 +50,8 @@
 #define PPC440EP_SDRAM_NR_BANKS 4
 
 static const unsigned int ppc440ep_sdram_bank_sizes[] = {
-    256<<20, 128<<20, 64<<20, 32<<20, 16<<20, 8<<20, 0
+    256 * MiB, 128 * MiB, 64 * MiB,
+    32 * MiB, 16 * MiB, 8 * MiB, 0
 };
 
 static hwaddr entry;
@@ -151,7 +153,7 @@ static void main_cpu_reset(void *opaque)
     CPUPPCState *env = &cpu->env;
 
     cpu_reset(CPU(cpu));
-    env->gpr[1] = (16<<20) - 8;
+    env->gpr[1] = (16 * MiB) - 8;
     env->gpr[3] = FDT_ADDR;
     env->nip = entry;
 
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 2e963894fe..bc6b5c29c1 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
@@ -29,6 +30,7 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "qemu/error-report.h"
 
 #define DEBUG_UIC
 
@@ -353,25 +355,25 @@ static uint32_t sdram_bcr (hwaddr ram_base,
     uint32_t bcr;
 
     switch (ram_size) {
-    case (4 * 1024 * 1024):
+    case 4 * MiB:
         bcr = 0x00000000;
         break;
-    case (8 * 1024 * 1024):
+    case 8 * MiB:
         bcr = 0x00020000;
         break;
-    case (16 * 1024 * 1024):
+    case 16 * MiB:
         bcr = 0x00040000;
         break;
-    case (32 * 1024 * 1024):
+    case 32 * MiB:
         bcr = 0x00060000;
         break;
-    case (64 * 1024 * 1024):
+    case 64 * MiB:
         bcr = 0x00080000;
         break;
-    case (128 * 1024 * 1024):
+    case 128 * MiB:
         bcr = 0x000A0000;
         break;
-    case (256 * 1024 * 1024):
+    case 256 * MiB:
         bcr = 0x000C0000;
         break;
     default:
@@ -399,7 +401,7 @@ static target_ulong sdram_size (uint32_t bcr)
     if (sh == 7)
         size = -1;
     else
-        size = (4 * 1024 * 1024) << sh;
+        size = (4 * MiB) << sh;
 
     return size;
 }
@@ -702,8 +704,8 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
 
     ram_size -= size_left;
     if (size_left) {
-        printf("Truncating memory to %d MiB to fit SDRAM controller limits.\n",
-               (int)(ram_size >> 20));
+        error_report("Truncating memory to %llu MiB to fit SDRAM "
+                     "controller limits", ram_size / MiB);
     }
 
     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 69ca2d0e42..c45fc858de 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -28,6 +28,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/hw_accel.h"
@@ -89,7 +90,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     SpinInfo *curspin = data.host_ptr;
-    hwaddr map_size = 64 * 1024 * 1024;
+    hwaddr map_size = 64 * MiB;
     hwaddr map_start;
 
     cpu_synchronize_state(cs);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index a8d26f74fc..31c8d92a6a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -50,7 +50,7 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "elf.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "kvm_ppc.h"
 
 /* SMP is not enabled, for now */
@@ -60,7 +60,7 @@
 
 #define CFG_ADDR 0xf0000510
 
-#define BIOS_SIZE (1024 * 1024)
+#define BIOS_SIZE (1 * MiB)
 #define BIOS_FILENAME "ppc_rom.bin"
 #define KERNEL_LOAD_ADDR 0x01000000
 #define INITRD_LOAD_ADDR 0x01800000
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index b6135650bd..2e7de729db 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/isa/isa.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
@@ -109,7 +110,7 @@ static void rs6000mc_port0820_write(void *opaque, uint32_t addr, uint32_t val)
             size = end_address - start_address;
             memory_region_set_enabled(&s->simm[socket - 1], size != 0);
             memory_region_set_address(&s->simm[socket - 1],
-                                      start_address * 8 * 1024 * 1024);
+                                      start_address * 8 * MiB);
         }
     }
 }
@@ -140,7 +141,7 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
 {
     RS6000MCState *s = RS6000MC_DEVICE(dev);
     int socket = 0;
-    unsigned int ram_size = s->ram_size / (1024 * 1024);
+    unsigned int ram_size = s->ram_size / MiB;
 
     while (socket < 6) {
         if (ram_size >= 64) {
@@ -163,8 +164,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
             char name[] = "simm.?";
             name[5] = socket + '0';
             memory_region_allocate_system_memory(&s->simm[socket], OBJECT(dev),
-                                                 name, s->simm_size[socket]
-                                                 * 1024 * 1024);
+                                                 name,
+                                                 s->simm_size[socket] * MiB);
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
         }
@@ -172,8 +173,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
         error_setg(errp, "RAM size incompatible with this board. "
-                   "Try again with something else, like %d MB",
-                   s->ram_size / 1024 / 1024 - ram_size);
+                   "Try again with something else, like %lld MB",
+                   s->ram_size / MiB - ram_size);
         return;
     }
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 2a98c10664..b35e3fff1c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -12,8 +12,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
@@ -46,7 +47,7 @@
 /* from Sam460 U-Boot include/configs/Sam460ex.h */
 #define FLASH_BASE             0xfff00000
 #define FLASH_BASE_H           0x4
-#define FLASH_SIZE             (1 << 20)
+#define FLASH_SIZE             (1 * MiB)
 #define UBOOT_LOAD_BASE        0xfff80000
 #define UBOOT_SIZE             0x00080000
 #define UBOOT_ENTRY            0xfffffffc
@@ -71,7 +72,8 @@
 
 /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
 static const unsigned int ppc460ex_sdram_bank_sizes[] = {
-    1024 << 20, 512 << 20, 256 << 20, 128 << 20, 64 << 20, 32 << 20, 0
+    1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB,
+    64 * MiB, 32 * MiB, 0
 };
 
 struct boot_info {
@@ -225,7 +227,7 @@ static int sam460ex_load_uboot(void)
     fl_sectors = (bios_size + 65535) >> 16;
 
     if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
-                               blk, (64 * 1024), fl_sectors,
+                               blk, 64 * KiB, fl_sectors,
                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
         error_report("qemu: Error registering flash memory.");
         /* XXX: return an error instead? */
@@ -359,14 +361,14 @@ static void main_cpu_reset(void *opaque)
 
     /* either we have a kernel to boot or we jump to U-Boot */
     if (bi->entry != UBOOT_ENTRY) {
-        env->gpr[1] = (16 << 20) - 8;
+        env->gpr[1] = (16 * MiB) - 8;
         env->gpr[3] = FDT_ADDR;
         env->nip = bi->entry;
 
         /* Create a mapping for the kernel.  */
         mmubooke_create_initial_mapping(env, 0, 0);
         env->gpr[6] = tswap32(EPAPR_MAGIC);
-        env->gpr[7] = (16 << 20) - 8; /*bi->ima_size;*/
+        env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
         env->nip = UBOOT_ENTRY;
@@ -479,8 +481,8 @@ static void sam460ex_init(MachineState *machine)
     /* 256K of L2 cache as memory */
     ppc4xx_l2sram_init(env);
     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
-    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 << 10,
-                           &error_abort);
+    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram",
+                           256 * KiB, &error_abort);
     memory_region_add_subregion(address_space_mem, 0x400000000LL, l2cache_ram);
 
     /* USB */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3ba3bc8b6c..f8a3a711fd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2756,7 +2756,7 @@ static void spapr_machine_init(MachineState *machine)
         }
     }
 
-    if (spapr->rma_size < (MIN_RMA_SLOF << 20)) {
+    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
         error_report(
             "pSeries SLOF firmware requires >= %ldM guest RMA (Real Mode Area memory)",
             MIN_RMA_SLOF);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index b4bb90d50b..7891464cd9 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
@@ -45,7 +46,7 @@
 #include "ppc405.h"
 
 #define EPAPR_MAGIC    (0x45504150)
-#define FLASH_SIZE     (16 * 1024 * 1024)
+#define FLASH_SIZE     (16 * MiB)
 
 #define INTC_BASEADDR       0x81800000
 #define UART16550_BASEADDR  0x83e01003
@@ -127,7 +128,7 @@ static void main_cpu_reset(void *opaque)
        *   r8: 0
        *   r9: 0
     */
-    env->gpr[1] = (16<<20) - 8;
+    env->gpr[1] = (16 * MiB) - 8;
     /* Provide a device-tree.  */
     env->gpr[3] = bi->fdt;
     env->nip = bi->bootstrap_pc;
@@ -235,7 +236,7 @@ static void virtex_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(PFLASH_BASEADDR, NULL, "virtex.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          (64 * 1024), FLASH_SIZE >> 16,
+                          64 * KiB, FLASH_SIZE >> 16,
                           1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     cpu_irq = (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];
-- 
2.17.1
