Received: from eggs.gnu.org ([2001:4830:134:3::10]:52023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh278-0007Xq-GG
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh270-0005wt-O7
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:10 -0400
Message-Id: <5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Aug 2017 19:04:38 +0200
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Add emulation of aCube Sam460ex board based on AMCC 460EX embedded SoC.
This is not a full implementation yet with a lot of components still
missing but enough to start a Linux kernel and the U-Boot firmware.

Signed-off-by: Fran=C3=A7ois Revol <revol@free.fr>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 default-configs/ppcemb-softmmu.mak |    3 +
 hw/ppc/Makefile.objs               |    2 +
 hw/ppc/sam460ex.c                  | 1895 ++++++++++++++++++++++++++++++=
++++++
 include/hw/pci/pcie_host.h         |    2 +-
 4 files changed, 1901 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/sam460ex.c

diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
index 94340de..9a0a177 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -16,3 +16,6 @@ CONFIG_XILINX=3Dy
 CONFIG_XILINX_ETHLITE=3Dy
 CONFIG_LIBDECNUMBER=3Dy
 CONFIG_SM501=3Dy
+CONFIG_USB_EHCI_SYSBUS=3Dy
+CONFIG_IDE_SII3112=3Dy
+CONFIG_SAM460EX=3Dy
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 9c5d58a..a242a59 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -27,3 +27,5 @@ obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
 obj-$(CONFIG_E500) +=3D mpc8544_guts.o ppce500_spin.o
 # PowerPC 440 Xilinx ML507 reference board.
 obj-$(CONFIG_XILINX) +=3D virtex_ml507.o
+# ACube Sam460ex board.
+obj-$(CONFIG_SAM460EX) +=3D sam460ex.o
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
new file mode 100644
index 0000000..c61eb99
--- /dev/null
+++ b/hw/ppc/sam460ex.c
@@ -0,0 +1,1895 @@
+/*
+ * QEMU aCube Sam460ex board emulation
+ *
+ * Copyright (c) 2012 Fran=C3=A7ois Revol
+ * Copyright (c) 2016-2017 BALATON Zoltan
+ *
+ * This file is derived from hw/ppc440_bamboo.c,
+ * the copyright for that material belongs to the original owners.
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "sysemu/blockdev.h"
+#include "hw/boards.h"
+#include "sysemu/kvm.h"
+#include "kvm_ppc.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/block-backend.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "hw/ppc/ppc.h"
+#include "hw/ppc/ppc405.h"
+#include "hw/block/flash.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/i2c/ppc4xx_i2c.h"
+#include "hw/i2c/smbus.h"
+#include "hw/usb/hcd-ehci.h"
+
+#undef DEBUG_SDRAM
+#undef DEBUG_L2SRAM
+#undef DEBUG_CPR
+#undef DEBUG_SDR
+#undef DEBUG_AHB
+#undef DEBUG_PCIE
+
+#define BINARY_DEVICE_TREE_FILE "sam460ex.dtb"
+#define UBOOT_FILENAME "u-boot-sam460-20100605.bin"
+/* to extract the official U-Boot bin from the updater: */
+/* dd bs=3D1 skip=3D$(($(stat -c '%s' updater/updater-460) - 0x80000)) \
+     if=3Dupdater/updater-460 of=3Du-boot-sam460-20100605.bin */
+
+/* from Sam460 U-Boot include/configs/Sam460ex.h */
+#define FLASH_BASE             0xfff00000
+#define FLASH_BASE_H           0x4
+#define FLASH_SIZE             (1 << 20)
+#define UBOOT_LOAD_BASE        0xfff80000
+#define UBOOT_SIZE             0x00080000
+#define UBOOT_ENTRY            0xfffffffc
+
+/* from U-Boot */
+#define EPAPR_MAGIC           (0x45504150)
+#define KERNEL_ADDR           0x1000000
+#define FDT_ADDR              0x1800000
+#define RAMDISK_ADDR          0x1900000
+
+/* Sam460ex IRQ MAP:
+   IRQ0  =3D ETH_INT
+   IRQ1  =3D FPGA_INT
+   IRQ2  =3D PCI_INT (PCIA, PCIB, PCIC, PCIB)
+   IRQ3  =3D FPGA_INT2
+   IRQ11 =3D RTC_INT
+   IRQ12 =3D SM502_INT
+*/
+
+#define SDRAM_NR_BANKS 4
+
+/* FIXME: See u-boot.git 8ac41e */
+static const unsigned int ppc460ex_sdram_bank_sizes[] =3D {
+    1024 << 20, 512 << 20, 256 << 20, 128 << 20, 64 << 20, 32 << 20, 0
+};
+
+struct boot_info {
+    uint32_t dt_base;
+    uint32_t dt_size;
+    uint32_t entry;
+};
+
+/***********************************************************************=
******/
+/* L2 Cache as SRAM */
+/* FIXME:fix names */
+enum {
+    DCR_L2CACHE_BASE  =3D 0x030,
+    DCR_L2CACHE_CFG   =3D DCR_L2CACHE_BASE,
+    DCR_L2CACHE_CMD,
+    DCR_L2CACHE_ADDR,
+    DCR_L2CACHE_DATA,
+    DCR_L2CACHE_STAT,
+    DCR_L2CACHE_CVER,
+    DCR_L2CACHE_SNP0,
+    DCR_L2CACHE_SNP1,
+    DCR_L2CACHE_END   =3D DCR_L2CACHE_SNP1,
+};
+
+/* base is 460ex-specific, cf. U-Boot, ppc4xx-isram.h */
+enum {
+    DCR_ISRAM0_BASE   =3D 0x020,
+    DCR_ISRAM0_SB0CR  =3D DCR_ISRAM0_BASE,
+    DCR_ISRAM0_SB1CR,
+    DCR_ISRAM0_SB2CR,
+    DCR_ISRAM0_SB3CR,
+    DCR_ISRAM0_BEAR,
+    DCR_ISRAM0_BESR0,
+    DCR_ISRAM0_BESR1,
+    DCR_ISRAM0_PMEG,
+    DCR_ISRAM0_CID,
+    DCR_ISRAM0_REVID,
+    DCR_ISRAM0_DPC,
+    DCR_ISRAM0_END    =3D DCR_ISRAM0_DPC
+};
+
+enum {
+    DCR_ISRAM1_BASE   =3D 0x0b0,
+    DCR_ISRAM1_SB0CR  =3D DCR_ISRAM1_BASE,
+    /* single bank */
+    DCR_ISRAM1_BEAR   =3D DCR_ISRAM1_BASE + 0x04,
+    DCR_ISRAM1_BESR0,
+    DCR_ISRAM1_BESR1,
+    DCR_ISRAM1_PMEG,
+    DCR_ISRAM1_CID,
+    DCR_ISRAM1_REVID,
+    DCR_ISRAM1_DPC,
+    DCR_ISRAM1_END    =3D DCR_ISRAM1_DPC
+};
+
+typedef struct ppc4xx_l2sram_t {
+    MemoryRegion bank[4];
+    uint32_t l2cache[8];
+    uint32_t isram0[11];
+} ppc4xx_l2sram_t;
+
+#ifdef MAP_L2SRAM
+static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
+                                   uint32_t isarc, uint32_t isacntl,
+                                   uint32_t dsarc, uint32_t dsacntl)
+{
+#ifdef DEBUG_L2SRAM
+    printf("L2SRAM update ISA %08" PRIx32 " %08" PRIx32 " (%08" PRIx32
+           " %08" PRIx32 ") DSA %08" PRIx32 " %08" PRIx32
+           " (%08" PRIx32 " %08" PRIx32 ")\n",
+           isarc, isacntl, dsarc, dsacntl,
+           l2sram->isarc, l2sram->isacntl, l2sram->dsarc, l2sram->dsacnt=
l);
+#endif
+    if (l2sram->isarc !=3D isarc ||
+        (l2sram->isacntl & 0x80000000) !=3D (isacntl & 0x80000000)) {
+        if (l2sram->isacntl & 0x80000000) {
+            /* Unmap previously assigned memory region */
+            printf("L2SRAM unmap ISA %08" PRIx32 "\n", l2sram->isarc);
+            memory_region_del_subregion(get_system_memory(),
+                                        &l2sram->isarc_ram);
+        }
+        if (isacntl & 0x80000000) {
+            /* Map new instruction memory region */
+#ifdef DEBUG_L2SRAM
+            printf("L2SRAM map ISA %08" PRIx32 "\n", isarc);
+#endif
+            memory_region_add_subregion(get_system_memory(), isarc,
+                                        &l2sram->isarc_ram);
+        }
+    }
+    if (l2sram->dsarc !=3D dsarc ||
+        (l2sram->dsacntl & 0x80000000) !=3D (dsacntl & 0x80000000)) {
+        if (l2sram->dsacntl & 0x80000000) {
+            /* Beware not to unmap the region we just mapped */
+            if (!(isacntl & 0x80000000) || l2sram->dsarc !=3D isarc) {
+                /* Unmap previously assigned memory region */
+#ifdef DEBUG_L2SRAM
+                printf("L2SRAM unmap DSA %08" PRIx32 "\n", l2sram->dsarc=
);
+#endif
+                memory_region_del_subregion(get_system_memory(),
+                                            &l2sram->dsarc_ram);
+            }
+        }
+        if (dsacntl & 0x80000000) {
+            /* Beware not to remap the region we just mapped */
+            if (!(isacntl & 0x80000000) || dsarc !=3D isarc) {
+                /* Map new data memory region */
+#ifdef DEBUG_L2SRAM
+                printf("L2SRAM map DSA %08" PRIx32 "\n", dsarc);
+#endif
+                memory_region_add_subregion(get_system_memory(), dsarc,
+                                            &l2sram->dsarc_ram);
+            }
+        }
+    }
+}
+#endif
+
+static uint32_t dcr_read_l2sram(void *opaque, int dcrn)
+{
+    ppc4xx_l2sram_t *l2sram;
+    uint32_t ret;
+
+    l2sram =3D opaque;
+    switch (dcrn) {
+    case DCR_L2CACHE_CFG:
+    case DCR_L2CACHE_CMD:
+    case DCR_L2CACHE_ADDR:
+    case DCR_L2CACHE_DATA:
+    case DCR_L2CACHE_STAT:
+    case DCR_L2CACHE_CVER:
+    case DCR_L2CACHE_SNP0:
+    case DCR_L2CACHE_SNP1:
+        ret =3D l2sram->l2cache[dcrn - DCR_L2CACHE_BASE];
+#ifdef DEBUG_L2SRAM
+        printf("L2SRAM: read DCR[%x(L2CACHE+%x)]: %08" PRIx32 "\n",
+               dcrn, dcrn - DCR_L2CACHE_BASE, ret);
+#endif
+        break;
+
+    case DCR_ISRAM0_SB0CR:
+    case DCR_ISRAM0_SB1CR:
+    case DCR_ISRAM0_SB2CR:
+    case DCR_ISRAM0_SB3CR:
+    case DCR_ISRAM0_BEAR:
+    case DCR_ISRAM0_BESR0:
+    case DCR_ISRAM0_BESR1:
+    case DCR_ISRAM0_PMEG:
+    case DCR_ISRAM0_CID:
+    case DCR_ISRAM0_REVID:
+    case DCR_ISRAM0_DPC:
+        ret =3D l2sram->isram0[dcrn - DCR_ISRAM0_BASE];
+#ifdef DEBUG_L2SRAM
+        printf("L2SRAM: read DCR[%x(ISRAM0+%x)]: %08" PRIx32 "\n",
+               dcrn, dcrn - DCR_ISRAM0_BASE, ret);
+#endif
+        break;
+
+    default:
+        ret =3D 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void dcr_write_l2sram(void *opaque, int dcrn, uint32_t val)
+{
+    /*ppc4xx_l2sram_t *l2sram =3D opaque;*/
+    /* TODO */
+
+    switch (dcrn) {
+    case DCR_L2CACHE_CFG:
+    case DCR_L2CACHE_CMD:
+    case DCR_L2CACHE_ADDR:
+    case DCR_L2CACHE_DATA:
+    case DCR_L2CACHE_STAT:
+    case DCR_L2CACHE_CVER:
+    case DCR_L2CACHE_SNP0:
+    case DCR_L2CACHE_SNP1:
+        /*l2sram->l2cache[dcrn - DCR_L2CACHE_BASE] =3D val;*/
+#ifdef DEBUG_L2SRAM
+        printf("L2SRAM: write DCR[%x(L2CACHE+%x)]: %08" PRIx32 "\n",
+               dcrn, dcrn - DCR_L2CACHE_BASE, val);
+#endif
+        break;
+
+    case DCR_ISRAM0_SB0CR:
+    case DCR_ISRAM0_SB1CR:
+    case DCR_ISRAM0_SB2CR:
+    case DCR_ISRAM0_SB3CR:
+    case DCR_ISRAM0_BEAR:
+    case DCR_ISRAM0_BESR0:
+    case DCR_ISRAM0_BESR1:
+    case DCR_ISRAM0_PMEG:
+    case DCR_ISRAM0_CID:
+    case DCR_ISRAM0_REVID:
+    case DCR_ISRAM0_DPC:
+        /*l2sram->isram0[dcrn - DCR_L2CACHE_BASE] =3D val;*/
+#ifdef DEBUG_L2SRAM
+        printf("L2SRAM: write DCR[%x(ISRAM0+%x)]: %08" PRIx32 "\n",
+               dcrn, dcrn - DCR_ISRAM0_BASE, val);
+#endif
+        break;
+
+    case DCR_ISRAM1_SB0CR:
+    case DCR_ISRAM1_BEAR:
+    case DCR_ISRAM1_BESR0:
+    case DCR_ISRAM1_BESR1:
+    case DCR_ISRAM1_PMEG:
+    case DCR_ISRAM1_CID:
+    case DCR_ISRAM1_REVID:
+    case DCR_ISRAM1_DPC:
+        /*l2sram->isram1[dcrn - DCR_L2CACHE_BASE] =3D val;*/
+#ifdef DEBUG_L2SRAM
+        printf("L2SRAM: write DCR[%x(ISRAM1+%x)]: %08" PRIx32 "\n",
+               dcrn, dcrn - DCR_ISRAM1_BASE, val);
+#endif
+        break;
+    }
+    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
+}
+
+static void l2sram_reset(void *opaque)
+{
+    ppc4xx_l2sram_t *l2sram;
+    /*uint32_t isarc, dsarc, isacntl, dsacntl;*/
+
+    l2sram =3D opaque;
+    memset(l2sram->l2cache, 0, sizeof(l2sram->l2cache));
+    l2sram->l2cache[DCR_L2CACHE_STAT - DCR_L2CACHE_BASE] =3D 0x80000000;
+    memset(l2sram->isram0, 0, sizeof(l2sram->isram0));
+    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
+}
+
+static void ppc4xx_l2sram_init(CPUPPCState *env)
+{
+    ppc4xx_l2sram_t *l2sram;
+
+    l2sram =3D g_malloc0(sizeof(ppc4xx_l2sram_t));
+    /* XXX: Size is 4*64kB for 460ex, cf. U-Boot, ppc4xx-isram.h */
+    memory_region_init_ram(&l2sram->bank[0], NULL, "ppc4xx.l2sram_bank0"=
,
+                           64 * 1024, &error_abort);
+    memory_region_init_ram(&l2sram->bank[1], NULL, "ppc4xx.l2sram_bank1"=
,
+                           64 * 1024, &error_abort);
+    memory_region_init_ram(&l2sram->bank[2], NULL, "ppc4xx.l2sram_bank2"=
,
+                           64 * 1024, &error_abort);
+    memory_region_init_ram(&l2sram->bank[3], NULL, "ppc4xx.l2sram_bank3"=
,
+                           64 * 1024, &error_abort);
+    qemu_register_reset(&l2sram_reset, l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_CFG,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_CMD,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_ADDR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_DATA,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_STAT,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_CVER,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_SNP0,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_L2CACHE_SNP1,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+
+    ppc_dcr_register(env, DCR_ISRAM0_SB0CR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM0_SB1CR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM0_SB2CR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM0_SB3CR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM0_PMEG,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM0_DPC,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+
+    ppc_dcr_register(env, DCR_ISRAM1_SB0CR,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM1_PMEG,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+    ppc_dcr_register(env, DCR_ISRAM1_DPC,
+                     l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
+}
+
+/***********************************************************************=
******/
+/* Clocking Power on Reset */
+enum {
+    CPR0_CFGADDR =3D 0x00C,
+    CPR0_CFGDATA =3D 0x00D,
+};
+
+typedef struct ppc4xx_cpr_t {
+    uint32_t addr;
+} ppc4xx_cpr_t;
+
+static uint32_t dcr_read_cpr(void *opaque, int dcrn)
+{
+    ppc4xx_cpr_t *cpr =3D opaque;
+    uint32_t ret;
+
+    switch (dcrn) {
+    case CPR0_CFGADDR:
+        ret =3D cpr->addr;
+#ifdef DEBUG_CPR
+        printf("read DCR[%x(CPR0ADDR)]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+        break;
+    case CPR0_CFGDATA:
+        ret =3D 0;
+#ifdef DEBUG_CPR
+        printf("read DCR[%x(CPR0DATA)]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+        break;
+    default:
+        /* Avoid gcc warning */
+        ret =3D 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void dcr_write_cpr(void *opaque, int dcrn, uint32_t val)
+{
+    ppc4xx_cpr_t *cpr =3D opaque;
+
+    switch (dcrn) {
+    case CPR0_CFGADDR:
+        cpr->addr =3D val;
+#ifdef DEBUG_CPR
+        printf("write DCR[%x(CPRADDR)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        break;
+    case CPR0_CFGDATA:
+#ifdef DEBUG_CPR
+        printf("write DCR[%x(CPRDATA)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        break;
+    default:
+#ifdef DEBUG_CPR
+        printf("write DCR[%x]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        break;
+    }
+}
+
+static void ppc4xx_cpr_reset(void *opaque)
+{
+    ppc4xx_cpr_t *cpr =3D opaque;
+
+    cpr->addr =3D 0;
+}
+
+static void ppc4xx_cpr_init(CPUPPCState *env)
+{
+    ppc4xx_cpr_t *cpr;
+
+    cpr =3D g_malloc0(sizeof(*cpr));
+    ppc_dcr_register(env, CPR0_CFGADDR, cpr, &dcr_read_cpr, &dcr_write_c=
pr);
+    ppc_dcr_register(env, CPR0_CFGDATA, cpr, &dcr_read_cpr, &dcr_write_c=
pr);
+    qemu_register_reset(ppc4xx_cpr_reset, cpr);
+}
+
+/***********************************************************************=
******/
+/* System DCRs */
+typedef struct ppc4xx_sdr_t ppc4xx_sdr_t;
+struct ppc4xx_sdr_t {
+    uint32_t addr;
+};
+
+enum {
+    SDR0_CFGADDR =3D 0x00e,
+    SDR0_CFGDATA,
+    SDR0_STRP0 =3D 0x020,
+    SDR0_STRP1,
+    SDR0_ECID3 =3D 0x083,
+    SDR0_DDR0 =3D 0x0e1,
+    SDR0_USB0 =3D 0x320,
+};
+
+enum {
+    PESDR0_LOOP =3D 0x303,
+    PESDR0_RCSSET,
+    PESDR0_RCSSTS,
+    PESDR0_RSTSTA =3D 0x310,
+    PESDR1_LOOP =3D 0x343,
+    PESDR1_RCSSET,
+    PESDR1_RCSSTS,
+    PESDR1_RSTSTA =3D 0x365,
+};
+
+#define SDR0_DDR0_DDRM_ENCODE(n)  ((((unsigned long)(n)) & 0x03) << 29)
+#define SDR0_DDR0_DDRM_DDR1       0x20000000
+#define SDR0_DDR0_DDRM_DDR2       0x40000000
+
+static uint32_t dcr_read_sdr(void *opaque, int dcrn)
+{
+    ppc4xx_sdr_t *sdr;
+    uint32_t ret;
+
+    sdr =3D opaque;
+    switch (dcrn) {
+    case SDR0_CFGADDR:
+        ret =3D sdr->addr;
+        break;
+    case SDR0_CFGDATA:
+        switch (sdr->addr) {
+        case SDR0_STRP0:
+            /* FIXME: Is this correct? This breaks timing */
+            ret =3D 0 /*5 << 8 | 15 << 4*/;
+            break;
+        case SDR0_STRP1:
+            ret =3D 5 << 29 | 2 << 26 | 1 << 24;
+            break;
+        case SDR0_ECID3:
+            ret =3D 1 << 20; /* No Security/Kasumi support */
+            break;
+        case SDR0_DDR0:
+            ret =3D SDR0_DDR0_DDRM_ENCODE(1) | SDR0_DDR0_DDRM_DDR1;
+            break;
+        case PESDR0_RCSSET:
+        case PESDR1_RCSSET:
+            ret =3D (1 << 24) | (1 << 16);
+            break;
+        case PESDR0_RCSSTS:
+        case PESDR1_RCSSTS:
+            ret =3D (1 << 16) | (1 << 12);
+            break;
+        case PESDR0_RSTSTA:
+        case PESDR1_RSTSTA:
+            ret =3D 1;
+            break;
+        case PESDR0_LOOP:
+        case PESDR1_LOOP:
+            ret =3D 1 << 12;
+            break;
+        default:
+            ret =3D 0;
+            break;
+        }
+#ifdef DEBUG_SDR
+        if (sdr->addr !=3D 0x20 && sdr->addr !=3D 0x21) {
+            printf("read DCR[%x(SDRDATA[%x])]: %08" PRIx32 "\n",
+                   dcrn, sdr->addr, ret);
+        }
+#endif
+        break;
+    default:
+        ret =3D 0;
+#ifdef DEBUG_SDR
+        printf("read DCR[%x]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+        break;
+    }
+
+    return ret;
+}
+
+static void dcr_write_sdr(void *opaque, int dcrn, uint32_t val)
+{
+    ppc4xx_sdr_t *sdr;
+
+    sdr =3D opaque;
+    switch (dcrn) {
+    case SDR0_CFGADDR:
+        sdr->addr =3D val;
+        break;
+    case SDR0_CFGDATA:
+#ifdef DEBUG_SDR
+        printf("write DCR[%x(SDRDATA[%x])]: %08" PRIx32 "\n",
+               dcrn, sdr->addr, val);
+#endif
+        switch (sdr->addr) {
+        case 0x00: /* B0CR */
+            break;
+        default:
+            break;
+        }
+        break;
+    default:
+#ifdef DEBUG_SDR
+        printf("write DCR[%x]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        break;
+    }
+}
+
+static void sdr_reset(void *opaque)
+{
+    ppc4xx_sdr_t *sdr;
+
+    sdr =3D opaque;
+    sdr->addr =3D 0;
+}
+
+static void ppc4xx_sdr_init(CPUPPCState *env)
+{
+    ppc4xx_sdr_t *sdr;
+
+    sdr =3D g_malloc0(sizeof(ppc4xx_sdr_t));
+    qemu_register_reset(&sdr_reset, sdr);
+    ppc_dcr_register(env, SDR0_CFGADDR,
+                     sdr, &dcr_read_sdr, &dcr_write_sdr);
+    ppc_dcr_register(env, SDR0_CFGDATA,
+                     sdr, &dcr_read_sdr, &dcr_write_sdr);
+    ppc_dcr_register(env, SDR0_USB0,
+                     sdr, &dcr_read_sdr, &dcr_write_sdr);
+}
+
+/***********************************************************************=
******/
+/* SDRAM controller */
+typedef struct ppc4xx_sdram_t {
+    uint32_t addr;
+    int nbanks;
+    MemoryRegion containers[4]; /* used for clipping */
+    MemoryRegion *ram_memories;
+    hwaddr ram_bases[4];
+    hwaddr ram_sizes[4];
+    uint32_t bcr[4];
+} ppc4xx_sdram_t;
+
+enum {
+    SDRAM_R0BAS =3D 0x040,
+    SDRAM_R1BAS,
+    SDRAM_R2BAS,
+    SDRAM_R3BAS,
+    SDRAM_CONF1HB =3D 0x045,
+    SDRAM_PLBADDULL =3D 0x04a,
+    SDRAM_CONF1LL =3D 0x04b,
+    SDRAM_CONFPATHB =3D 0x04f,
+    SDRAM_PLBADDUHB =3D 0x050,
+    SDRAM0_CFGADDR =3D 0x010,
+    SDRAM0_CFGDATA,
+};
+
+/* XXX: TOFIX: some patches have made this code become inconsistent:
+ *      there are type inconsistencies, mixing hwaddr, target_ulong
+ *      and uint32_t
+ */
+static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
+{
+    uint32_t bcr;
+
+    switch (ram_size) {
+    case (8 * M_BYTE):
+        bcr =3D 0xffc0;
+        break;
+    case (16 * M_BYTE):
+        bcr =3D 0xff80;
+        break;
+    case (32 * M_BYTE):
+        bcr =3D 0xff00;
+        break;
+    case (64 * M_BYTE):
+        bcr =3D 0xfe00;
+        break;
+    case (128 * M_BYTE):
+        bcr =3D 0xfc00;
+        break;
+    case (256 * M_BYTE):
+        bcr =3D 0xf800;
+        break;
+    case (512 * M_BYTE):
+        bcr =3D 0xf000;
+        break;
+    case (1 * G_BYTE):
+        bcr =3D 0xe000;
+        break;
+/*
+    case (2 * G_BYTE):
+        bcr =3D 0xc000;
+        break;
+    case (4 * G_BYTE):
+        bcr =3D 0x8000;
+        break;
+*/
+    default:
+        printf("%s: invalid RAM size " TARGET_FMT_plx "\n", __func__,
+               ram_size);
+        return 0;
+    }
+    bcr |=3D ram_base & 0xFF800000;
+    bcr |=3D 1;
+
+    return bcr;
+}
+
+static inline hwaddr sdram_base(uint32_t bcr)
+{
+    return bcr & 0xFF800000;
+}
+
+static target_ulong sdram_size(uint32_t bcr)
+{
+    target_ulong size;
+    int sh;
+
+    sh =3D 1024 - ((bcr >> 6) & 0x3ff);
+    if (sh =3D=3D 0) {
+        size =3D -1;
+    } else {
+        size =3D 8 * M_BYTE * sh;
+    }
+
+    return size;
+}
+
+static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
+                          uint32_t *bcrp, uint32_t bcr, int enabled)
+{
+    unsigned n =3D bcrp - sdram->bcr;
+
+    if (*bcrp & 1) {
+        /* Unmap RAM */
+#ifdef DEBUG_SDRAM
+        printf("%s: unmap RAM area " TARGET_FMT_plx " " TARGET_FMT_lx "\=
n",
+               __func__, sdram_base(*bcrp), sdram_size(*bcrp));
+#endif
+        memory_region_del_subregion(get_system_memory(),
+                                    &sdram->containers[n]);
+        memory_region_del_subregion(&sdram->containers[n],
+                                    &sdram->ram_memories[n]);
+        object_unparent(OBJECT(&sdram->containers[n]));
+    }
+    *bcrp =3D bcr & 0xFFDEE001;
+    if (enabled && (bcr & 1)) {
+#ifdef DEBUG_SDRAM
+        printf("%s: Map RAM area " TARGET_FMT_plx " " TARGET_FMT_lx "\n"=
,
+               __func__, sdram_base(bcr), sdram_size(bcr));
+#endif
+        memory_region_init(&sdram->containers[n], NULL, "sdram-container=
s",
+                           sdram_size(bcr));
+        memory_region_add_subregion(&sdram->containers[n], 0,
+                                    &sdram->ram_memories[n]);
+        memory_region_add_subregion(get_system_memory(),
+                                    sdram_base(bcr),
+                                    &sdram->containers[n]);
+    }
+}
+
+static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
+{
+    int i;
+
+    for (i =3D 0; i < sdram->nbanks; i++) {
+        if (sdram->ram_sizes[i] !=3D 0) {
+            sdram_set_bcr(sdram,
+                          &sdram->bcr[i],
+                          sdram_bcr(sdram->ram_bases[i], sdram->ram_size=
s[i]),
+                          1);
+        } else {
+            sdram_set_bcr(sdram, &sdram->bcr[i], 0, 0);
+        }
+    }
+}
+
+static uint32_t dcr_read_sdram(void *opaque, int dcrn)
+{
+    ppc4xx_sdram_t *sdram;
+    uint32_t ret;
+
+    sdram =3D opaque;
+#ifdef DEBUG_SDR
+        printf("read DCR[%x(SDRAM)]\n", dcrn);
+#endif
+    switch (dcrn) {
+    case SDRAM_R0BAS:
+    case SDRAM_R1BAS:
+    case SDRAM_R2BAS:
+    case SDRAM_R3BAS:
+        ret =3D sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
+                        sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
+        break;
+    case SDRAM_CONF1HB:
+    case SDRAM_CONF1LL:
+    case SDRAM_CONFPATHB:
+    case SDRAM_PLBADDULL:
+    case SDRAM_PLBADDUHB:
+        ret =3D 0;
+        break;
+    case SDRAM0_CFGADDR:
+        ret =3D sdram->addr;
+#ifdef DEBUG_SDR
+        printf("read DCR[%x(SDRAMADDR)]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+        break;
+    case SDRAM0_CFGDATA:
+        switch (sdram->addr) {
+        case 0x0014: /* SDRAM_MCSTAT (405EX) */
+        case 0x001F:
+            ret =3D 0x80000000;
+            break;
+        case 0x0021: /* SDRAM_MCOPT2 */
+            ret =3D 0x08000000;
+            break;
+        case 0x0040: /* SDRAM_MB0CF */
+            ret =3D 0x00008001;
+            break;
+        case 0x007A: /* SDRAM_DLCR */
+            ret =3D 0x02000000;
+            break;
+        case 0x00E1: /* SDR0_DDR0 */
+            ret =3D SDR0_DDR0_DDRM_ENCODE(1) | SDR0_DDR0_DDRM_DDR1;
+            break;
+        default:
+            ret =3D 0;
+            break;
+        }
+#ifdef DEBUG_SDR
+        printf("read DCR[%x(SDRAMDATA)]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+        break;
+    default:
+        ret =3D 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void dcr_write_sdram(void *opaque, int dcrn, uint32_t val)
+{
+    ppc4xx_sdram_t *sdram;
+
+    sdram =3D opaque;
+#ifdef DEBUG_SDR
+        printf("write DCR[%x(SDRAM)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+    switch (dcrn) {
+    case SDRAM_R0BAS:
+    case SDRAM_R1BAS:
+    case SDRAM_R2BAS:
+    case SDRAM_R3BAS:
+    case SDRAM_CONF1HB:
+    case SDRAM_CONF1LL:
+    case SDRAM_CONFPATHB:
+    case SDRAM_PLBADDULL:
+    case SDRAM_PLBADDUHB:
+        break;
+    case SDRAM0_CFGADDR:
+        sdram->addr =3D val;
+#ifdef DEBUG_SDR
+        printf("write DCR[%x(SDRAMADDR)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        break;
+    case SDRAM0_CFGDATA:
+#ifdef DEBUG_SDR
+        printf("write DCR[%x(SDRAMDATA)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+        switch (sdram->addr) {
+        case 0x00: /* B0CR */
+            break;
+        default:
+            break;
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static void sdram_reset(void *opaque)
+{
+    ppc4xx_sdram_t *sdram;
+
+    sdram =3D opaque;
+    sdram->addr =3D 0;
+}
+
+static void ppc440_sdram_init(CPUPPCState *env, int nbanks,
+                              MemoryRegion *ram_memories,
+                              hwaddr *ram_bases,
+                              hwaddr *ram_sizes,
+                              int do_init)
+{
+    ppc4xx_sdram_t *sdram;
+
+    sdram =3D g_malloc0(sizeof(ppc4xx_sdram_t));
+    sdram->nbanks =3D nbanks;
+    sdram->ram_memories =3D ram_memories;
+    memcpy(sdram->ram_bases, ram_bases, nbanks * sizeof(hwaddr));
+    memcpy(sdram->ram_sizes, ram_sizes, nbanks * sizeof(hwaddr));
+    qemu_register_reset(&sdram_reset, sdram);
+    ppc_dcr_register(env, SDRAM0_CFGADDR,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM0_CFGDATA,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    if (do_init) {
+        sdram_map_bcr(sdram);
+    }
+
+    ppc_dcr_register(env, SDRAM_R0BAS,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_R1BAS,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_R2BAS,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_R3BAS,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_CONF1HB,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_PLBADDULL,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_CONF1LL,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_CONFPATHB,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+    ppc_dcr_register(env, SDRAM_PLBADDUHB,
+                     sdram, &dcr_read_sdram, &dcr_write_sdram);
+}
+
+/***********************************************************************=
******/
+/* PLB to AHB bridge */
+enum {
+    AHB_TOP    =3D 0x0A4,
+    AHB_BOT    =3D 0x0A5,
+};
+
+typedef struct ppc4xx_ahb_t {
+    uint32_t top;
+    uint32_t bot;
+} ppc4xx_ahb_t;
+
+static uint32_t dcr_read_ahb(void *opaque, int dcrn)
+{
+    ppc4xx_ahb_t *ahb;
+    uint32_t ret;
+
+    ahb =3D opaque;
+    switch (dcrn) {
+    case AHB_TOP:
+        ret =3D ahb->top;
+        break;
+    case AHB_BOT:
+        ret =3D ahb->bot;
+        break;
+    default:
+        /* Avoid gcc warning */
+        ret =3D 0;
+        break;
+    }
+#ifdef DEBUG_AHB
+    printf("read DCR[%x(AHB+%x)]: %08" PRIx32 "\n", dcrn, dcrn - 0xA0, r=
et);
+#endif
+
+    return ret;
+}
+
+static void dcr_write_ahb(void *opaque, int dcrn, uint32_t val)
+{
+    ppc4xx_ahb_t *ahb;
+
+    ahb =3D opaque;
+#ifdef DEBUG_AHB
+    printf("write DCR[%x(AHB+%x)]: %08" PRIx32 "\n", dcrn, dcrn - 0xA0, =
val);
+#endif
+    switch (dcrn) {
+    case AHB_TOP:
+        ahb->top =3D val;
+        break;
+    case AHB_BOT:
+        ahb->bot =3D val;
+        break;
+    }
+}
+
+static void ppc4xx_ahb_reset(void *opaque)
+{
+    ppc4xx_ahb_t *ahb;
+
+    ahb =3D opaque;
+    /* No error */
+    ahb->top =3D 0;
+    ahb->bot =3D 0;
+}
+
+static void ppc4xx_ahb_init(CPUPPCState *env)
+{
+    ppc4xx_ahb_t *ahb;
+
+    ahb =3D g_malloc0(sizeof(ppc4xx_ahb_t));
+    ppc_dcr_register(env, AHB_TOP, ahb, &dcr_read_ahb, &dcr_write_ahb);
+    ppc_dcr_register(env, AHB_BOT, ahb, &dcr_read_ahb, &dcr_write_ahb);
+    qemu_register_reset(ppc4xx_ahb_reset, ahb);
+}
+
+/***********************************************************************=
******/
+/* PCI Express controller */
+/* This is not complete and not meant to work, only implemented partiall=
y
+ * to allow firmware and guests to find an empty bus. Cards should use P=
CI.
+ */
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
+#define PPC460EX_PCIE_HOST(obj) \
+    OBJECT_CHECK(PPC460EXPCIEState, (obj), TYPE_PPC460EX_PCIE_HOST)
+
+typedef struct PPC460EXPCIEState {
+    PCIExpressHost host;
+
+    MemoryRegion iomem;
+    qemu_irq irq[4];
+    int32_t dcrn_base;
+
+    uint64_t cfg_base;
+    uint32_t cfg_mask;
+    uint64_t msg_base;
+    uint32_t msg_mask;
+    uint64_t omr1_base;
+    uint64_t omr1_mask;
+    uint64_t omr2_base;
+    uint64_t omr2_mask;
+    uint64_t omr3_base;
+    uint64_t omr3_mask;
+    uint64_t reg_base;
+    uint32_t reg_mask;
+    uint32_t special;
+    uint32_t cfg;
+} PPC460EXPCIEState;
+
+#define DCRN_PCIE0_BASE 0x100
+#define DCRN_PCIE1_BASE 0x120
+
+enum {
+    PEGPL_CFGBAH =3D 0x0,
+    PEGPL_CFGBAL,
+    PEGPL_CFGMSK,
+    PEGPL_MSGBAH,
+    PEGPL_MSGBAL,
+    PEGPL_MSGMSK,
+    PEGPL_OMR1BAH,
+    PEGPL_OMR1BAL,
+    PEGPL_OMR1MSKH,
+    PEGPL_OMR1MSKL,
+    PEGPL_OMR2BAH,
+    PEGPL_OMR2BAL,
+    PEGPL_OMR2MSKH,
+    PEGPL_OMR2MSKL,
+    PEGPL_OMR3BAH,
+    PEGPL_OMR3BAL,
+    PEGPL_OMR3MSKH,
+    PEGPL_OMR3MSKL,
+    PEGPL_REGBAH,
+    PEGPL_REGBAL,
+    PEGPL_REGMSK,
+    PEGPL_SPECIAL,
+    PEGPL_CFG,
+};
+
+#ifdef DEBUG_PCIE
+static void dump_pcie_regs(PPC460EXPCIEState *state)
+{
+    printf("dcrn_base=3D%x\n", state->dcrn_base);
+    printf("cfg  base=3D%lx, mask=3D%x, size=3D%x\n", state->cfg_base,
+           state->cfg_mask, ~(state->cfg_mask & 0xfffffffe) + 1);
+    printf("msg  base=3D%lx, mask=3D%x, size=3D%x\n", state->msg_base,
+           state->msg_mask, ~(state->msg_mask & 0xfffffffe) + 1);
+    printf("omr1 base=3D%lx, mask=3D%lx, size=3D%"PRIu64"\n", state->omr=
1_base,
+           state->omr1_mask, ~state->omr1_mask + 1);
+    printf("omr2 base=3D%lx, mask=3D%lx, size=3D%"PRIu64"\n", state->omr=
2_base,
+           state->omr2_mask, ~state->omr2_mask + 1);
+    printf("omr3 base=3D%lx, mask=3D%lx, size=3D%"PRIu64"\n", state->omr=
3_base,
+           state->omr3_mask, ~state->omr3_mask + 1);
+    printf("reg  base=3D%lx, mask=3D%x, size=3D%x\n", state->reg_base,
+           state->reg_mask, ~(state->reg_mask & 0xfffffffe) + 1);
+    printf("special=3D%x, cfg=3D%x\n", state->special, state->cfg);
+}
+#endif
+
+static uint32_t dcr_read_pcie(void *opaque, int dcrn)
+{
+    uint32_t ret =3D 0;
+    PPC460EXPCIEState *state =3D opaque;
+
+    switch (dcrn - state->dcrn_base) {
+    case PEGPL_CFGBAH:
+        ret =3D state->cfg_base >> 32;
+        break;
+    case PEGPL_CFGBAL:
+        ret =3D state->cfg_base;
+        break;
+    case PEGPL_CFGMSK:
+        ret =3D state->cfg_mask;
+        break;
+    case PEGPL_MSGBAH:
+        ret =3D state->msg_base >> 32;
+        break;
+    case PEGPL_MSGBAL:
+        ret =3D state->msg_base;
+        break;
+    case PEGPL_MSGMSK:
+        ret =3D state->msg_mask;
+        break;
+    case PEGPL_OMR1BAH:
+        ret =3D state->omr1_base >> 32;
+        break;
+    case PEGPL_OMR1BAL:
+        ret =3D state->omr1_base;
+        break;
+    case PEGPL_OMR1MSKH:
+        ret =3D state->omr1_mask >> 32;
+        break;
+    case PEGPL_OMR1MSKL:
+        ret =3D state->omr1_mask;
+        break;
+    case PEGPL_OMR2BAH:
+        ret =3D state->omr2_base >> 32;
+        break;
+    case PEGPL_OMR2BAL:
+        ret =3D state->omr2_base;
+        break;
+    case PEGPL_OMR2MSKH:
+        ret =3D state->omr2_mask >> 32;
+        break;
+    case PEGPL_OMR2MSKL:
+        ret =3D state->omr3_mask;
+        break;
+    case PEGPL_OMR3BAH:
+        ret =3D state->omr3_base >> 32;
+        break;
+    case PEGPL_OMR3BAL:
+        ret =3D state->omr3_base;
+        break;
+    case PEGPL_OMR3MSKH:
+        ret =3D state->omr3_mask >> 32;
+        break;
+    case PEGPL_OMR3MSKL:
+        ret =3D state->omr3_mask;
+        break;
+    case PEGPL_REGBAH:
+        ret =3D state->reg_base >> 32;
+        break;
+    case PEGPL_REGBAL:
+        ret =3D state->reg_base;
+        break;
+    case PEGPL_REGMSK:
+        ret =3D state->reg_mask;
+        break;
+    case PEGPL_SPECIAL:
+        ret =3D state->special;
+        break;
+    case PEGPL_CFG:
+        ret =3D state->cfg;
+        break;
+    }
+#ifdef DEBUG_PCIE
+        printf("read DCR[%x(PCIE)]: %08" PRIx32 "\n", dcrn, ret);
+#endif
+
+    return ret;
+}
+
+static void dcr_write_pcie(void *opaque, int dcrn, uint32_t val)
+{
+    PPC460EXPCIEState *s =3D opaque;
+    uint64_t size;
+
+#ifdef DEBUG_PCIE
+    printf("write DCR[%x(PCIE)]: %08" PRIx32 "\n", dcrn, val);
+#endif
+    switch (dcrn - s->dcrn_base) {
+    case PEGPL_CFGBAH:
+        s->cfg_base =3D ((uint64_t)val << 32) | (s->cfg_base & 0xfffffff=
f);
+        break;
+    case PEGPL_CFGBAL:
+        s->cfg_base =3D (s->cfg_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_CFGMSK:
+        s->cfg_mask =3D val;
+        size =3D ~(val & 0xfffffffe) + 1;
+#ifdef DEBUG_PCIE
+        printf("%s: %smapping cfg at %lx/%x (size=3D%lx)\n", __func__,
+               (val & 1 ? "" : "un"), s->cfg_base, val, size);
+#endif
+        qemu_mutex_lock_iothread();
+        pcie_host_mmcfg_update(PCIE_HOST_BRIDGE(s), val & 1, s->cfg_base=
, size);
+        qemu_mutex_unlock_iothread();
+        break;
+    case PEGPL_MSGBAH:
+        s->msg_base =3D ((uint64_t)val << 32) | (s->msg_base & 0xfffffff=
f);
+        break;
+    case PEGPL_MSGBAL:
+        s->msg_base =3D (s->msg_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_MSGMSK:
+        s->msg_mask =3D val;
+        break;
+    case PEGPL_OMR1BAH:
+        s->omr1_base =3D ((uint64_t)val << 32) | (s->omr1_base & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR1BAL:
+        s->omr1_base =3D (s->omr1_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_OMR1MSKH:
+        s->omr1_mask =3D ((uint64_t)val << 32) | (s->omr1_mask & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR1MSKL:
+        s->omr1_mask =3D (s->omr1_mask & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_OMR2BAH:
+        s->omr2_base =3D ((uint64_t)val << 32) | (s->omr2_base & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR2BAL:
+        s->omr2_base =3D (s->omr2_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_OMR2MSKH:
+        s->omr2_mask =3D ((uint64_t)val << 32) | (s->omr2_mask & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR2MSKL:
+        s->omr2_mask =3D (s->omr2_mask & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_OMR3BAH:
+        s->omr3_base =3D ((uint64_t)val << 32) | (s->omr3_base & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR3BAL:
+        s->omr3_base =3D (s->omr3_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_OMR3MSKH:
+        s->omr3_mask =3D ((uint64_t)val << 32) | (s->omr3_mask & 0xfffff=
fff);
+        break;
+    case PEGPL_OMR3MSKL:
+        s->omr3_mask =3D (s->omr3_mask & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_REGBAH:
+        s->reg_base =3D ((uint64_t)val << 32) | (s->reg_base & 0xfffffff=
f);
+        break;
+    case PEGPL_REGBAL:
+        s->reg_base =3D (s->reg_base & 0xffffffff00000000ULL) | val;
+        break;
+    case PEGPL_REGMSK:
+        s->reg_mask =3D val;
+        /* FIXME: how is size encoded? */
+        size =3D (val =3D=3D 0x7001 ? 4096 : ~(val & 0xfffffffe) + 1);
+#ifdef DEBUG_PCIE
+        printf("%s: %smapping reg at %lx/%x (size=3D%lx)\n", __func__,
+               (val & 1 ? "" : "un"), s->reg_base, val, size);
+#endif
+        break;
+    case PEGPL_SPECIAL:
+        s->special =3D val;
+        break;
+    case PEGPL_CFG:
+        s->cfg =3D val;
+#ifdef DEBUG_PCIE
+        dump_pcie_regs(s);
+#endif
+        break;
+    }
+}
+
+static void ppc460ex_set_irq(void *opaque, int irq_num, int level)
+{
+       PPC460EXPCIEState *s =3D opaque;
+       qemu_set_irq(s->irq[irq_num], level);
+}
+
+static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
+{
+    PPC460EXPCIEState *s =3D PPC460EX_PCIE_HOST(dev);
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
+    int i, id;
+    char buf[16];
+
+    switch (s->dcrn_base) {
+    case DCRN_PCIE0_BASE:
+        id =3D 0;
+        break;
+    case DCRN_PCIE1_BASE:
+        id =3D 1;
+        break;
+    }
+    snprintf(buf, sizeof(buf), "pcie%d-io", id);
+    memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
+    for (i =3D 0; i < 4; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
+    }
+    snprintf(buf, sizeof(buf), "pcie.%d", id);
+    pci->bus =3D pci_register_bus(DEVICE(s), buf, ppc460ex_set_irq,
+                                pci_swizzle_map_irq_fn, s, &s->iomem,
+                                get_system_io(), 0, 4, TYPE_PCIE_BUS);
+}
+
+static Property ppc460ex_pcie_props[] =3D {
+    DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ppc460ex_pcie_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->realize =3D ppc460ex_pcie_realize;
+    dc->props =3D ppc460ex_pcie_props;
+    dc->hotpluggable =3D false;
+}
+
+static const TypeInfo ppc460ex_pcie_host_info =3D {
+    .name =3D TYPE_PPC460EX_PCIE_HOST,
+    .parent =3D TYPE_PCIE_HOST_BRIDGE,
+    .instance_size =3D sizeof(PPC460EXPCIEState),
+    .class_init =3D ppc460ex_pcie_class_init,
+};
+
+static void ppc460ex_pcie_register(void)
+{
+    type_register_static(&ppc460ex_pcie_host_info);
+}
+
+type_init(ppc460ex_pcie_register)
+
+static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s, CPUPPCStat=
e *env)
+{
+#ifdef DEBUG_PCIE
+    printf("%s: base=3D%x\n", __func__, s->dcrn_base);
+#endif
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+}
+
+static void ppc460ex_pcie_init(CPUPPCState *env)
+{
+    DeviceState *dev;
+
+    dev =3D qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
+    qdev_init_nofail(dev);
+    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+
+    dev =3D qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
+    qdev_init_nofail(dev);
+    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+}
+
+/***********************************************************************=
******/
+/* SPD eeprom content from mips_malta.c */
+
+struct _eeprom24c0x_t {
+  uint8_t tick;
+  uint8_t address;
+  uint8_t command;
+  uint8_t ack;
+  uint8_t scl;
+  uint8_t sda;
+  uint8_t data;
+  uint8_t contents[256];
+};
+
+typedef struct _eeprom24c0x_t eeprom24c0x_t;
+
+static eeprom24c0x_t spd_eeprom =3D {
+    .contents =3D {
+        /* 00000000: */ 0x80, 0x08, 0xFF, 0x0D, 0x0A, 0xFF, 0x40, 0x00,
+        /* 00000008: */ 0x04, 0x75, 0x54, 0x00, 0x82, 0x08, 0x00, 0x01,
+        /* 00000010: */ 0x8F, 0x04, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00,
+        /* 00000018: */ 0x00, 0x00, 0x00, 0x14, 0x0F, 0x14, 0x2D, 0xFF,
+        /* 00000020: */ 0x15, 0x08, 0x15, 0x08, 0x00, 0x00, 0x00, 0x00,
+        /* 00000028: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000030: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000038: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xD0,
+        /* 00000040: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000048: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000050: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000058: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000060: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000068: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000070: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000078: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x64, 0xF4,
+    },
+};
+
+static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
+{
+    enum { SDR =3D 0x4, DDR1 =3D 0x7, DDR2 =3D 0x8 } type;
+    uint8_t *spd =3D spd_eeprom.contents;
+    uint8_t nbanks =3D 0;
+    uint16_t density =3D 0;
+    int i;
+
+    /* work in terms of MB */
+    ram_size >>=3D 20;
+
+    while ((ram_size >=3D 4) && (nbanks <=3D 2)) {
+        int sz_log2 =3D MIN(31 - clz32(ram_size), 14);
+        nbanks++;
+        density |=3D 1 << (sz_log2 - 2);
+        ram_size -=3D 1 << sz_log2;
+    }
+
+    /* split to 2 banks if possible */
+    if ((nbanks =3D=3D 1) && (density > 1)) {
+        nbanks++;
+        density >>=3D 1;
+    }
+
+    if (density & 0xff00) {
+        density =3D (density & 0xe0) | ((density >> 8) & 0x1f);
+        type =3D DDR2;
+    } else if (!(density & 0x1f)) {
+        type =3D DDR2;
+    } else {
+        type =3D SDR;
+    }
+
+    if (ram_size) {
+        fprintf(stderr, "Warning: SPD cannot represent final %dMB"
+                " of SDRAM\n", (int)ram_size);
+    }
+
+    /* fill in SPD memory information */
+    spd[2] =3D type;
+    spd[5] =3D nbanks;
+    spd[31] =3D density;
+#ifdef DEBUG_SDRAM
+    printf("SPD: nbanks %d density %d\n", nbanks, density);
+#endif
+    /* XXX: this is totally random */
+    spd[9] =3D 0x10; /* CAS tcyc */
+    spd[18] =3D 0x20; /* CAS bit */
+    spd[23] =3D 0x10; /* CAS tcyc */
+    spd[25] =3D 0x10; /* CAS tcyc */
+
+    /* checksum */
+    spd[63] =3D 0;
+    for (i =3D 0; i < 63; i++) {
+        spd[63] +=3D spd[i];
+    }
+
+    /* copy for SMBUS */
+    memcpy(eeprom, spd, sizeof(spd_eeprom.contents));
+}
+
+static void generate_eeprom_serial(uint8_t *eeprom)
+{
+    int i, pos =3D 0;
+    uint8_t mac[6] =3D { 0x00 };
+    uint8_t sn[5] =3D { 0x01, 0x23, 0x45, 0x67, 0x89 };
+
+    /* version */
+    eeprom[pos++] =3D 0x01;
+
+    /* count */
+    eeprom[pos++] =3D 0x02;
+
+    /* MAC address */
+    eeprom[pos++] =3D 0x01; /* MAC */
+    eeprom[pos++] =3D 0x06; /* length */
+    memcpy(&eeprom[pos], mac, sizeof(mac));
+    pos +=3D sizeof(mac);
+
+    /* serial number */
+    eeprom[pos++] =3D 0x02; /* serial */
+    eeprom[pos++] =3D 0x05; /* length */
+    memcpy(&eeprom[pos], sn, sizeof(sn));
+    pos +=3D sizeof(sn);
+
+    /* checksum */
+    eeprom[pos] =3D 0;
+    for (i =3D 0; i < pos; i++) {
+        eeprom[pos] +=3D eeprom[i];
+    }
+}
+
+/***********************************************************************=
******/
+
+static int sam460ex_load_uboot(void)
+{
+    DriveInfo *dinfo;
+    BlockBackend *blk =3D NULL;
+    hwaddr base =3D FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
+    long bios_size =3D FLASH_SIZE;
+    int fl_sectors;
+
+    dinfo =3D drive_get(IF_PFLASH, 0, 0);
+    if (dinfo) {
+        blk =3D blk_by_legacy_dinfo(dinfo);
+        bios_size =3D blk_getlength(blk);
+    }
+    fl_sectors =3D (bios_size + 65535) >> 16;
+
+    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
+                               blk, (64 * 1024), fl_sectors,
+                               1, 0x89, 0x18, 0x0000, 0x0, 1)) {
+        fprintf(stderr, "qemu: Error registering flash memory.\n");
+        /* XXX: return an error instead? */
+        exit(1);
+    }
+
+    if (!blk) {
+        /*fprintf(stderr, "No flash image given with the 'pflash' parame=
ter,"
+                " using default u-boot image\n");*/
+        base =3D UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
+        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
+    }
+
+    return 0;
+}
+
+static int sam460ex_load_device_tree(hwaddr addr,
+                                     uint32_t ramsize,
+                                     hwaddr initrd_base,
+                                     hwaddr initrd_size,
+                                     const char *kernel_cmdline)
+{
+    int ret =3D -1;
+    uint32_t mem_reg_property[] =3D { 0, 0, cpu_to_be32(ramsize) };
+    char *filename;
+    int fdt_size;
+    void *fdt;
+    uint32_t tb_freq =3D 400000000;
+    uint32_t clock_freq =3D 400000000;
+
+    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_=
FILE);
+    if (!filename) {
+        goto out;
+    }
+    fdt =3D load_device_tree(filename, &fdt_size);
+    g_free(filename);
+    if (fdt =3D=3D NULL) {
+        goto out;
+    }
+
+    /* Manipulate device tree in memory. */
+
+    ret =3D qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
+                               sizeof(mem_reg_property));
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set /memory/reg\n");
+    }
+
+    /* default FDT doesn't have a /chosen node... */
+    qemu_fdt_add_subnode(fdt, "/chosen");
+
+    ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                                    initrd_base);
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+    }
+
+    ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                                    (initrd_base + initrd_size));
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+    }
+
+    ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                                      kernel_cmdline);
+    if (ret < 0) {
+        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+    }
+
+    /* Copy data from the host device tree into the guest. Since the gue=
st can
+     * directly access the timebase without host involvement, we must ex=
pose
+     * the correct frequencies. */
+    if (kvm_enabled()) {
+        tb_freq =3D kvmppc_get_tbfreq();
+        clock_freq =3D kvmppc_get_clockfreq();
+    }
+
+    qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "clock-frequency",
+                              clock_freq);
+    qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
+                              tb_freq);
+
+    rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
+    g_free(fdt);
+    ret =3D fdt_size;
+
+out:
+
+    return ret;
+}
+
+/* Create reset TLB entries for BookE, mapping only the flash memory.  *=
/
+static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env)
+{
+    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
+
+    /* on reset the flash is mapped by a shadow TLB,
+     * but since we don't implement them we need to use
+     * the same values U-Boot will use to avoid a fault.
+     */
+    tlb->attr =3D 0;
+    tlb->prot =3D PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << =
4);
+    tlb->size =3D 0x10000000; /* up to 0xffffffff  */
+    tlb->EPN =3D 0xf0000000 & TARGET_PAGE_MASK;
+    tlb->RPN =3D (0xf0000000 & TARGET_PAGE_MASK) | 0x4;
+    tlb->PID =3D 0;
+}
+
+/* Create reset TLB entries for BookE, spanning the 32bit addr space.  *=
/
+static void mmubooke_create_initial_mapping(CPUPPCState *env,
+                                     target_ulong va,
+                                     hwaddr pa)
+{
+    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
+
+    tlb->attr =3D 0;
+    tlb->prot =3D PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << =
4);
+    tlb->size =3D 1 << 31; /* up to 0x80000000  */
+    tlb->EPN =3D va & TARGET_PAGE_MASK;
+    tlb->RPN =3D pa & TARGET_PAGE_MASK;
+    tlb->PID =3D 0;
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    PowerPCCPU *cpu =3D opaque;
+    CPUPPCState *env =3D &cpu->env;
+    struct boot_info *bi =3D env->load_info;
+
+    cpu_reset(CPU(cpu));
+
+    /* either we have a kernel to boot or we jump to U-Boot */
+    if (bi->entry !=3D UBOOT_ENTRY) {
+        env->gpr[1] =3D (16 << 20) - 8;
+        env->gpr[3] =3D FDT_ADDR;
+
+        fprintf(stderr, "cpu reset: kernel entry %x\n", bi->entry);
+        env->nip =3D bi->entry;
+
+        /* Create a mapping for the kernel.  */
+        mmubooke_create_initial_mapping(env, 0, 0);
+        env->gpr[6] =3D tswap32(EPAPR_MAGIC);
+        env->gpr[7] =3D (16 << 20) - 8; /*bi->ima_size;*/
+
+    } else {
+        env->nip =3D UBOOT_ENTRY;
+        mmubooke_create_initial_mapping_uboot(env);
+        fprintf(stderr, "cpu reset: U-Boot entry\n");
+    }
+}
+
+static void sam460ex_init(MachineState *machine)
+{
+    MemoryRegion *address_space_mem =3D get_system_memory();
+    MemoryRegion *isa =3D g_new(MemoryRegion, 1);
+    MemoryRegion *ram_memories =3D g_new(MemoryRegion, SDRAM_NR_BANKS);
+    hwaddr ram_bases[SDRAM_NR_BANKS];
+    hwaddr ram_sizes[SDRAM_NR_BANKS];
+    MemoryRegion *l2cache_ram =3D g_new(MemoryRegion, 1);
+    qemu_irq *irqs, *uic[4];
+    PCIBus *pci_bus;
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
+    PPC4xxI2CState *i2c[2];
+    hwaddr entry =3D UBOOT_ENTRY;
+    hwaddr loadaddr =3D 0;
+    target_long initrd_size =3D 0;
+    DeviceState *dev;
+    SysBusDevice *sbdev;
+    int success;
+    int i;
+    struct boot_info *boot_info;
+    const size_t smbus_eeprom_size =3D 8 * 256;
+    uint8_t *smbus_eeprom_buf =3D g_malloc0(smbus_eeprom_size);
+
+    /* Setup CPU. */
+    if (machine->cpu_model =3D=3D NULL) {
+        machine->cpu_model =3D "460EX";
+    }
+    cpu =3D cpu_ppc_init(machine->cpu_model);
+    if (cpu =3D=3D NULL) {
+        fprintf(stderr, "Unable to initialize CPU!\n");
+        exit(1);
+    }
+    env =3D &cpu->env;
+
+    qemu_register_reset(main_cpu_reset, cpu);
+    boot_info =3D g_malloc0(sizeof(*boot_info));
+    env->load_info =3D boot_info;
+
+    ppc_booke_timers_init(cpu, 50000000, 0);
+    ppc_dcr_init(env, NULL, NULL);
+
+    /* PLB arbitrer */
+    ppc4xx_plb_init(env);
+
+    /* interrupt controllers */
+    irqs =3D g_malloc0(sizeof(*irqs) * PPCUIC_OUTPUT_NB);
+    irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
+    irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
+    uic[0] =3D ppcuic_init(env, irqs, 0x0C0, 0, 1);
+    uic[1] =3D ppcuic_init(env, &uic[0][30], 0x0D0, 0, 1);
+    uic[2] =3D ppcuic_init(env, &uic[0][10], 0x0E0, 0, 1);
+    uic[3] =3D ppcuic_init(env, &uic[0][16], 0x0F0, 0, 1);
+
+    /* SDRAM controller */
+    memset(ram_bases, 0, sizeof(ram_bases));
+    memset(ram_sizes, 0, sizeof(ram_sizes));
+    /* put all RAM on first bank because board has one slot
+     * and firmware only checks that */
+    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size,
+                                   1/*SDRAM_NR_BANKS*/,
+                                   ram_memories,
+                                   ram_bases, ram_sizes,
+                                   ppc460ex_sdram_bank_sizes);
+#ifdef DEBUG_SDRAM
+    printf("RAMSIZE %dMB\n", (int)(machine->ram_size / M_BYTE));
+#endif
+
+    /* XXX does 460EX have ECC interrupts? */
+    ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
+                      ram_bases, ram_sizes, 1);
+
+    /* generate SPD EEPROM data */
+    for (i =3D 0; i < SDRAM_NR_BANKS; i++) {
+#ifdef DEBUG_SDRAM
+        printf("bank %d: %" HWADDR_PRIx "\n", i, ram_sizes[i]);
+#endif
+        generate_eeprom_spd(&smbus_eeprom_buf[i * 256], ram_sizes[i]);
+    }
+    generate_eeprom_serial(&smbus_eeprom_buf[4 * 256]);
+    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
+
+    /* IIC controllers */
+    dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]=
);
+    i2c[0] =3D PPC4xx_I2C(dev);
+    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
+    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_siz=
e);
+    g_free(smbus_eeprom_buf);
+
+    dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]=
);
+    i2c[1] =3D PPC4xx_I2C(dev);
+
+    /* External bus controller */
+    ppc405_ebc_init(env);
+
+    /* CPR */
+    ppc4xx_cpr_init(env);
+
+    /* PLB to AHB bridge */
+    ppc4xx_ahb_init(env);
+
+    /* System DCRs */
+    ppc4xx_sdr_init(env);
+
+    /* MAL */
+    ppc4xx_mal_init(env, 4, 16, &uic[2][3]);
+
+    /* 256K of L2 cache as memory */
+    ppc4xx_l2sram_init(env);
+    /* FIXME: remove this after fixing l2sram mapping above? */
+    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 =
<< 10,
+                           &error_abort);
+    memory_region_add_subregion(address_space_mem, 0x400000000LL, l2cach=
e_ram);
+
+    /* USB */
+    sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
+    dev =3D qdev_create(NULL, "sysbus-ohci");
+    qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
+    qdev_prop_set_uint32(dev, "num-ports", 6);
+    qdev_init_nofail(dev);
+    sbdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
+    sysbus_connect_irq(sbdev, 0, uic[2][30]);
+    usb_create_simple(usb_bus_find(-1), "usb-kbd");
+    usb_create_simple(usb_bus_find(-1), "usb-mouse");
+
+    /* PCI bus */
+    ppc460ex_pcie_init(env);
+    /*XXX: FIXME: is this correct? */
+    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
+                                uic[1][0], uic[1][20], uic[1][21], uic[1=
][22],
+                                NULL);
+    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
+    if (!pci_bus) {
+        fprintf(stderr, "couldn't create PCI controller!\n");
+        exit(1);
+    }
+    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io(),
+                             0, 0x10000);
+    memory_region_add_subregion(get_system_memory(), 0xc08000000, isa);
+
+    /* PCI devices */
+    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
+    /* SoC has a single SATA port but we don't emulate that yet
+     * However, firmware and usual clients have driver for SiI311x
+     * so add one for convenience by default */
+    pci_create_simple(pci_bus, -1, "sii3112");
+
+    /* SoC has 4 UARTs
+     * but board has only one wired and two are present in fdt */
+    if (serial_hds[0] !=3D NULL) {
+        serial_mm_init(address_space_mem, 0x4ef600300, 0, uic[1][1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hds[0],
+                       DEVICE_BIG_ENDIAN);
+    }
+    if (serial_hds[1] !=3D NULL) {
+        serial_mm_init(address_space_mem, 0x4ef600400, 0, uic[0][1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hds[1],
+                       DEVICE_BIG_ENDIAN);
+    }
+
+    /* Load U-Boot image. */
+    if (!machine->kernel_filename) {
+        success =3D sam460ex_load_uboot();
+        if (success < 0) {
+            fprintf(stderr, "qemu: could not load firmware\n");
+            exit(1);
+        }
+    }
+
+    /* Load kernel. */
+    if (machine->kernel_filename) {
+        success =3D load_uimage(machine->kernel_filename, &entry, &loada=
ddr, NULL,
+            NULL, NULL);
+        fprintf(stderr, "load_uimage: %d\n", success);
+        if (success < 0) {
+            uint64_t elf_entry, elf_lowaddr;
+
+            success =3D load_elf(machine->kernel_filename, NULL, NULL, &=
elf_entry,
+                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE, 0=
, 0);
+            fprintf(stderr, "load_elf: %d\n", success);
+            entry =3D elf_entry;
+            loadaddr =3D elf_lowaddr;
+        }
+        /* XXX try again as binary */
+        if (success < 0) {
+            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+                    machine->kernel_filename);
+            exit(1);
+        }
+    }
+
+    /* Load initrd. */
+    if (machine->initrd_filename) {
+        initrd_size =3D load_image_targphys(machine->initrd_filename,
+                                          RAMDISK_ADDR,
+                                          machine->ram_size - RAMDISK_AD=
DR);
+        fprintf(stderr, "load_image: %d\n", initrd_size);
+        if (initrd_size < 0) {
+            fprintf(stderr, "qemu: could not load ram disk '%s' at %x\n"=
,
+                    machine->initrd_filename, RAMDISK_ADDR);
+            exit(1);
+        }
+    }
+
+    /* If we're loading a kernel directly, we must load the device tree =
too. */
+    if (machine->kernel_filename) {
+        int dt_size;
+
+        dt_size =3D sam460ex_load_device_tree(FDT_ADDR, machine->ram_siz=
e,
+                                    RAMDISK_ADDR, initrd_size,
+                                    machine->kernel_cmdline);
+        if (dt_size < 0) {
+            fprintf(stderr, "couldn't load device tree\n");
+            exit(1);
+        }
+
+        boot_info->dt_base =3D FDT_ADDR;
+        boot_info->dt_size =3D dt_size;
+    }
+
+    boot_info->entry =3D entry;
+}
+
+static void sam460ex_machine_init(MachineClass *mc)
+{
+    mc->desc =3D "aCube Sam460ex";
+    mc->init =3D sam460ex_init;
+    mc->default_ram_size =3D 512 * M_BYTE;
+}
+
+DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index 4d23c80..3f7b988 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -65,7 +65,7 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
  * bit 12 - 14: function number
  * bit  0 - 11: offset in configuration space of a given device
  */
-#define PCIE_MMCFG_SIZE_MAX             (1ULL << 28)
+#define PCIE_MMCFG_SIZE_MAX             (1ULL << 29)
 #define PCIE_MMCFG_SIZE_MIN             (1ULL << 20)
 #define PCIE_MMCFG_BUS_BIT              20
 #define PCIE_MMCFG_BUS_MASK             0x1ff
--=20
2.7.4
