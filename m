Received: from eggs.gnu.org ([2001:4830:134:3::10]:49413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nw-0001V5-Hq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3np-0004Q8-7F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:30 +1100
Message-Id: <20180306040154.3669-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/30] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?q?Fran=C3=A7ois=20Revol?= <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Add emulation of aCube Sam460ex board based on AMCC 460EX embedded SoC.
This is not a complete implementation yet with a lot of components
still missing but enough for the U-Boot firmware to start and to boot
a Linux kernel or AROS.

Signed-off-by: Fran=C3=A7ois Revol <revol@free.fr>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 Makefile                           |   2 +-
 default-configs/ppc-softmmu.mak    |   2 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/ppc/Makefile.objs               |   3 +-
 hw/ppc/sam460ex.c                  | 603 +++++++++++++++++++++++++++++++=
++++++
 pc-bios/canyonlands.dtb            | Bin 0 -> 9779 bytes
 pc-bios/canyonlands.dts            | 566 +++++++++++++++++++++++++++++++=
+++
 7 files changed, 1175 insertions(+), 2 deletions(-)
 create mode 100644 hw/ppc/sam460ex.c
 create mode 100644 pc-bios/canyonlands.dtb
 create mode 100644 pc-bios/canyonlands.dts

diff --git a/Makefile b/Makefile
index 352f3d5104..9a75c48ae0 100644
--- a/Makefile
+++ b/Makefile
@@ -779,7 +779,7 @@ efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
 efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
 qemu-icon.bmp qemu_logo_no_text.svg \
-bamboo.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
+bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb =
\
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
 s390-ccw.img s390-netboot.img \
 spapr-rtas.bin slof.bin skiboot.lid \
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index 76e29cfa14..4d7be45ac5 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -21,6 +21,8 @@ CONFIG_E500=3Dy
 CONFIG_OPENPIC_KVM=3D$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_ETSEC=3Dy
+# For Sam460ex
+CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_SM501=3Dy
 CONFIG_IDE_SII3112=3Dy
 CONFIG_I2C=3Dy
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
index bc5e1b3ffe..67d18b2e0e 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -15,6 +15,7 @@ CONFIG_PTIMER=3Dy
 CONFIG_I8259=3Dy
 CONFIG_XILINX=3Dy
 CONFIG_XILINX_ETHLITE=3Dy
+CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_SM501=3Dy
 CONFIG_IDE_SII3112=3Dy
 CONFIG_I2C=3Dy
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index bddc742bfb..86d82a6ec3 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,7 +13,8 @@ endif
 obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y +=3D ppc4xx_devs.o ppc405_uc.o
-obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc405_boards.o ppc440_bamboo.o p=
pc440_pcix.o
+obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc405_boards.o
+obj-$(CONFIG_PPC4XX) +=3D ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o sam4=
60ex.o
 # PReP
 obj-$(CONFIG_PREP) +=3D prep.o
 obj-$(CONFIG_PREP) +=3D prep_systemio.o
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
new file mode 100644
index 0000000000..70b8e76d9c
--- /dev/null
+++ b/hw/ppc/sam460ex.c
@@ -0,0 +1,603 @@
+/*
+ * QEMU aCube Sam460ex board emulation
+ *
+ * Copyright (c) 2012 Fran=C3=A7ois Revol
+ * Copyright (c) 2016-2018 BALATON Zoltan
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
+#include "qemu/error-report.h"
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
+#include "hw/ppc/ppc440.h"
+#include "hw/ppc/ppc405.h"
+#include "hw/block/flash.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/i2c/ppc4xx_i2c.h"
+#include "hw/i2c/smbus.h"
+#include "hw/usb/hcd-ehci.h"
+
+#define BINARY_DEVICE_TREE_FILE "canyonlands.dtb"
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
+/* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
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
+        warn_report("SPD cannot represent final " RAM_ADDR_FMT "MB"
+                    " of SDRAM", ram_size);
+    }
+
+    /* fill in SPD memory information */
+    spd[2] =3D type;
+    spd[5] =3D nbanks;
+    spd[31] =3D density;
+
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
+        error_report("qemu: Error registering flash memory.");
+        /* XXX: return an error instead? */
+        exit(1);
+    }
+
+    if (!blk) {
+        /*error_report("No flash image given with the 'pflash' parameter=
,"
+                " using default u-boot image");*/
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
+    uint32_t tb_freq =3D 50000000;
+    uint32_t clock_freq =3D 50000000;
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
+        error_report("couldn't set /memory/reg");
+    }
+
+    /* default FDT doesn't have a /chosen node... */
+    qemu_fdt_add_subnode(fdt, "/chosen");
+
+    ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                                    initrd_base);
+    if (ret < 0) {
+        error_report("couldn't set /chosen/linux,initrd-start");
+    }
+
+    ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                                    (initrd_base + initrd_size));
+    if (ret < 0) {
+        error_report("couldn't set /chosen/linux,initrd-end");
+    }
+
+    ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                                      kernel_cmdline);
+    if (ret < 0) {
+        error_report("couldn't set /chosen/bootargs");
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
+    cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
+    env =3D &cpu->env;
+    if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
+        error_report("Only MMU model BookE is supported by this machine.=
");
+        exit(1);
+    }
+
+#ifdef TARGET_PPCEMB
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-ppcemb is deprecated, "
+                    "please use qemu-system-ppc instead.");
+    }
+#endif
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
+    uic[0] =3D ppcuic_init(env, irqs, 0xc0, 0, 1);
+    uic[1] =3D ppcuic_init(env, &uic[0][30], 0xd0, 0, 1);
+    uic[2] =3D ppcuic_init(env, &uic[0][10], 0xe0, 0, 1);
+    uic[3] =3D ppcuic_init(env, &uic[0][16], 0xf0, 0, 1);
+
+    /* SDRAM controller */
+    memset(ram_bases, 0, sizeof(ram_bases));
+    memset(ram_sizes, 0, sizeof(ram_sizes));
+    /* put all RAM on first bank because board has one slot
+     * and firmware only checks that */
+    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
+                                   ram_memories, ram_bases, ram_sizes,
+                                   ppc460ex_sdram_bank_sizes);
+
+    /* FIXME: does 460EX have ECC interrupts? */
+    ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
+                      ram_bases, ram_sizes, 1);
+
+    /* generate SPD EEPROM data */
+    for (i =3D 0; i < SDRAM_NR_BANKS; i++) {
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
+    /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
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
+    /* FIXME: is this correct? */
+    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
+                                uic[1][0], uic[1][20], uic[1][21], uic[1=
][22],
+                                NULL);
+    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
+    if (!pci_bus) {
+        error_report("couldn't create PCI controller!");
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
+    if (defaults_enabled()) {
+        pci_create_simple(pci_bus, -1, "sii3112");
+    }
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
+            error_report("qemu: could not load firmware");
+            exit(1);
+        }
+    }
+
+    /* Load kernel. */
+    if (machine->kernel_filename) {
+        success =3D load_uimage(machine->kernel_filename, &entry, &loada=
ddr,
+                              NULL, NULL, NULL);
+        if (success < 0) {
+            uint64_t elf_entry, elf_lowaddr;
+
+            success =3D load_elf(machine->kernel_filename, NULL, NULL, &=
elf_entry,
+                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE, 0=
, 0);
+            entry =3D elf_entry;
+            loadaddr =3D elf_lowaddr;
+        }
+        /* XXX try again as binary */
+        if (success < 0) {
+            error_report("qemu: could not load kernel '%s'",
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
+        if (initrd_size < 0) {
+            error_report("qemu: could not load ram disk '%s' at %x",
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
+            error_report("couldn't load device tree");
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
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
+    mc->default_ram_size =3D 512 * M_BYTE;
+}
+
+DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/pc-bios/canyonlands.dtb b/pc-bios/canyonlands.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..9dce3443ad9578a8a4bb92ba6=
970cb2ae54d1ec3
GIT binary patch
literal 9779
zcmc&)%a0sK8L!?oi9<HFNy5`Sc5TU6VjIuwt{+H93?z{daIgeINIuv--MzDoXS$p2
zo_!c0mVbcch{VMQE*y{$$^~(7BqGECt*nRx5|^A17nFztLI@jvzpv`+shOR1w05MF
zR8#fU_o(kxRo&Hd|G9_%Fy_L#G3J^v=3DYE0qBI-v_&!D0#zKZdo?N9v%4q8Ne!u1!>
zDtsD!(h#P+v(YGySK}z(EAnBKCpE@c6u<HaJms&VQeF@Zv#3smoxEpJuU;yL{YypJ
zzmzsxX_co<FWtP->7<<wuyzj8ef0>sO^@!Ap!;S^SEp4L4Xw0wM`h)a?%Q+eHd;FR
zBZ$kfZ>#!BeM6YOVj*qMs@(eV2F8e^t*21WUN3gi>iSEo8&^87e2*B5qnv?26ZrNF
z{KFaer+}AHDVzLvQI}B_{*5vF09*K;2Xp*S4)-+LzvfYsZKoV=3D>5*H;&xwbCX*b8j
zH=3D}e^RC|Cd59QpL8C$}b+C@4R;mz_Ut*UX^gmIBKRWTf<mFK&Ufo>)1k5<Q79Ku)W
zu5plv5FODAp2Cl_H(-vi5Izaq1+;IVK7*=3D0L05{x8atKoMPO%bChka`yAyejtFz{k
z>U<v}A6Mryu=3D^|E|12tV;&ZN5`@R8~eFq!Hlypbhw+18%=3D^xiV^{3kRHe@}ieIJGl
z>iw*1A7$T%Ky##h+&od9#6I$}s(tUG|D^UIj$$A8UfTI6`?&7JzB;MU6<Y2!vVJh;
z)(=3DrrdXk2G!W)-|c`<erFW0rlI|8V(?Ywc>j?LR&oUejgj!*5oVYisp-YrhzXyAvS
zdicM+&j1#khikFomeCP=3DhihRR#apSjY3PvBa*c3rAP@8~9oIS?%xi#`Q5Ak&BGAGC
z*O119c5uBh4|N?A$92{E2ge&gk@s=3D5q9?{Y6#;FKq@9y}@~aO1d5q!Uj)&88B0#Jo
z@w(+(294%GH1cK>x^Sa&c~F8x=3DFr@QZzg)j)n3^Yz3#OR3Mnn^MYQ(3FUwf=3D=3DFn0a
zc?jU(?ye3w9z6$6m``BjBweJoi9cy4tNN2MCXvK>Yp2Qwy>54+hR~8`Mi0;#H$S_!
zQ0`=3DYt|()!ql)ZNJc@=3DgBr<u1h|gr)^O?YQGgLj1L%}}i8C;G*-{2=3D`y|@KDqv=3Dz=
J
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

literal 0
HcmV?d00001

diff --git a/pc-bios/canyonlands.dts b/pc-bios/canyonlands.dts
new file mode 100644
index 0000000000..0d6ac92d0f
--- /dev/null
+++ b/pc-bios/canyonlands.dts
@@ -0,0 +1,566 @@
+/*
+ * Device Tree Source for AMCC Canyonlands (460EX)
+ *
+ * Copyright 2008-2009 DENX Software Engineering, Stefan Roese <sr@denx.=
de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+	model =3D "amcc,canyonlands";
+	compatible =3D "amcc,canyonlands";
+	dcr-parent =3D <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 =3D &EMAC0;
+		ethernet1 =3D &EMAC1;
+		serial0 =3D &UART0;
+		serial1 =3D &UART1;
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			model =3D "PowerPC,460EX";
+			reg =3D <0x00000000>;
+			clock-frequency =3D <0>; /* Filled in by U-Boot */
+			timebase-frequency =3D <0>; /* Filled in by U-Boot */
+			i-cache-line-size =3D <32>;
+			d-cache-line-size =3D <32>;
+			i-cache-size =3D <32768>;
+			d-cache-size =3D <32768>;
+			dcr-controller;
+			dcr-access-method =3D "native";
+			next-level-cache =3D <&L2C0>;
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible =3D "ibm,uic-460ex","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <0>;
+		dcr-reg =3D <0x0c0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible =3D "ibm,uic-460ex","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <1>;
+		dcr-reg =3D <0x0d0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	UIC2: interrupt-controller2 {
+		compatible =3D "ibm,uic-460ex","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <2>;
+		dcr-reg =3D <0x0e0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0xa 0x4 0xb 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	UIC3: interrupt-controller3 {
+		compatible =3D "ibm,uic-460ex","ibm,uic";
+		interrupt-controller;
+		cell-index =3D <3>;
+		dcr-reg =3D <0x0f0 0x009>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		#interrupt-cells =3D <2>;
+		interrupts =3D <0x10 0x4 0x11 0x4>; /* cascade */
+		interrupt-parent =3D <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible =3D "ibm,sdr-460ex";
+		dcr-reg =3D <0x00e 0x002>;
+	};
+
+	CPR0: cpr {
+		compatible =3D "ibm,cpr-460ex";
+		dcr-reg =3D <0x00c 0x002>;
+	};
+
+	CPM0: cpm {
+		compatible =3D "ibm,cpm";
+		dcr-access-method =3D "native";
+		dcr-reg =3D <0x160 0x003>;
+		unused-units =3D <0x00000100>;
+		idle-doze =3D <0x02000000>;
+		standby =3D <0xfeff791d>;
+	};
+
+	L2C0: l2c {
+		compatible =3D "ibm,l2-cache-460ex", "ibm,l2-cache";
+		dcr-reg =3D <0x020 0x008		/* Internal SRAM DCR's */
+			   0x030 0x008>;	/* L2 cache DCR's */
+		cache-line-size =3D <32>;		/* 32 bytes */
+		cache-size =3D <262144>;		/* L2, 256K */
+		interrupt-parent =3D <&UIC1>;
+		interrupts =3D <11 1>;
+	};
+
+	plb {
+		compatible =3D "ibm,plb-460ex", "ibm,plb4";
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+		clock-frequency =3D <0>; /* Filled in by U-Boot */
+
+		SDRAM0: sdram {
+			compatible =3D "ibm,sdram-460ex", "ibm,sdram-405gp";
+			dcr-reg =3D <0x010 0x002>;
+		};
+
+		CRYPTO: crypto@180000 {
+			compatible =3D "amcc,ppc460ex-crypto", "amcc,ppc4xx-crypto";
+			reg =3D <4 0x00180000 0x80400>;
+			interrupt-parent =3D <&UIC0>;
+			interrupts =3D <0x1d 0x4>;
+		};
+
+		HWRNG: hwrng@110000 {
+			compatible =3D "amcc,ppc460ex-rng", "ppc4xx-rng";
+			reg =3D <4 0x00110000 0x50>;
+		};
+
+		MAL0: mcmal {
+			compatible =3D "ibm,mcmal-460ex", "ibm,mcmal2";
+			dcr-reg =3D <0x180 0x062>;
+			num-tx-chans =3D <2>;
+			num-rx-chans =3D <16>;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			interrupt-parent =3D <&UIC2>;
+			interrupts =3D <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x3 0x4
+					/*TXDE*/  0x4 0x4
+					/*RXDE*/  0x5 0x4>;
+		};
+
+		USB0: ehci@bffd0400 {
+			compatible =3D "ibm,usb-ehci-460ex", "usb-ehci";
+			interrupt-parent =3D <&UIC2>;
+			interrupts =3D <0x1d 4>;
+			reg =3D <4 0xbffd0400 0x90 4 0xbffd0490 0x70>;
+		};
+
+		USB1: usb@bffd0000 {
+			compatible =3D "ohci-le";
+			reg =3D <4 0xbffd0000 0x60>;
+			interrupt-parent =3D <&UIC2>;
+			interrupts =3D <0x1e 4>;
+		};
+
+		USBOTG0: usbotg@bff80000 {
+			compatible =3D "amcc,dwc-otg";
+			reg =3D <0x4 0xbff80000 0x10000>;
+			interrupt-parent =3D <&USBOTG0>;
+			#interrupt-cells =3D <1>;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			interrupts =3D <0x0 0x1 0x2>;
+			interrupt-map =3D </* USB-OTG */ 0x0 &UIC2 0x1c 0x4
+					 /* HIGH-POWER */ 0x1 &UIC1 0x1a 0x8
+					 /* DMA */ 0x2 &UIC0 0xc 0x4>;
+		};
+
+		AHBDMA: dma@bffd0800 {
+			compatible =3D "snps,dma-spear1340";
+			reg =3D <4 0xbffd0800 0x400>;
+			interrupt-parent =3D <&UIC3>;
+			interrupts =3D <0x5 0x4>;
+			#dma-cells =3D <3>;
+		};
+
+		SATA0: sata@bffd1000 {
+			compatible =3D "amcc,sata-460ex";
+			reg =3D <4 0xbffd1000 0x800>;
+			interrupt-parent =3D <&UIC3>;
+			interrupts =3D <0x0 0x4>;
+			dmas =3D <&AHBDMA 0 1 0>;
+			dma-names =3D "sata-dma";
+		};
+
+		POB0: opb {
+			compatible =3D "ibm,opb-460ex", "ibm,opb";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0xb0000000 0x00000004 0xb0000000 0x50000000>;
+			clock-frequency =3D <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible =3D "ibm,ebc-460ex", "ibm,ebc";
+				dcr-reg =3D <0x012 0x002>;
+				#address-cells =3D <2>;
+				#size-cells =3D <1>;
+				clock-frequency =3D <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
+				interrupts =3D <0x6 0x4>;
+				interrupt-parent =3D <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible =3D "amd,s29gl512n", "cfi-flash";
+					bank-width =3D <2>;
+					reg =3D <0x00000000 0x00000000 0x04000000>;
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+					partition@0 {
+						label =3D "kernel";
+						reg =3D <0x00000000 0x001e0000>;
+					};
+					partition@1e0000 {
+						label =3D "dtb";
+						reg =3D <0x001e0000 0x00020000>;
+					};
+					partition@200000 {
+						label =3D "ramdisk";
+						reg =3D <0x00200000 0x01400000>;
+					};
+					partition@1600000 {
+						label =3D "jffs2";
+						reg =3D <0x01600000 0x00400000>;
+					};
+					partition@1a00000 {
+						label =3D "user";
+						reg =3D <0x01a00000 0x02560000>;
+					};
+					partition@3f60000 {
+						label =3D "env";
+						reg =3D <0x03f60000 0x00040000>;
+					};
+					partition@3fa0000 {
+						label =3D "u-boot";
+						reg =3D <0x03fa0000 0x00060000>;
+					};
+				};
+
+				cpld@2,0 {
+					compatible =3D "amcc,ppc460ex-bcsr";
+					reg =3D <2 0x0 0x9>;
+				};
+
+				ndfc@3,0 {
+					compatible =3D "ibm,ndfc";
+					reg =3D <0x00000003 0x00000000 0x00002000>;
+					ccr =3D <0x00001000>;
+					bank-settings =3D <0x80002222>;
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+
+					nand {
+						#address-cells =3D <1>;
+						#size-cells =3D <1>;
+
+						partition@0 {
+							label =3D "u-boot";
+							reg =3D <0x00000000 0x00100000>;
+						};
+						partition@100000 {
+							label =3D "user";
+							reg =3D <0x00000000 0x03f00000>;
+						};
+					};
+				};
+			};
+
+			UART0: serial@ef600300 {
+				device_type =3D "serial";
+				compatible =3D "ns16550";
+				reg =3D <0xef600300 0x00000008>;
+				virtual-reg =3D <0xef600300>;
+				clock-frequency =3D <0>; /* Filled in by U-Boot */
+				current-speed =3D <0>; /* Filled in by U-Boot */
+				interrupt-parent =3D <&UIC1>;
+				interrupts =3D <0x1 0x4>;
+			};
+
+			UART1: serial@ef600400 {
+				device_type =3D "serial";
+				compatible =3D "ns16550";
+				reg =3D <0xef600400 0x00000008>;
+				virtual-reg =3D <0xef600400>;
+				clock-frequency =3D <0>; /* Filled in by U-Boot */
+				current-speed =3D <0>; /* Filled in by U-Boot */
+				interrupt-parent =3D <&UIC0>;
+				interrupts =3D <0x1 0x4>;
+			};
+
+			IIC0: i2c@ef600700 {
+				compatible =3D "ibm,iic-460ex", "ibm,iic";
+				reg =3D <0xef600700 0x00000014>;
+				interrupt-parent =3D <&UIC0>;
+				interrupts =3D <0x2 0x4>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+                                rtc@68 {
+                                        compatible =3D "st,m41t80";
+                                        reg =3D <0x68>;
+					interrupt-parent =3D <&UIC2>;
+					interrupts =3D <0x19 0x8>;
+                                };
+                                sttm@48 {
+                                        compatible =3D "ad,ad7414";
+                                        reg =3D <0x48>;
+					interrupt-parent =3D <&UIC1>;
+					interrupts =3D <0x14 0x8>;
+                                };
+			};
+
+			IIC1: i2c@ef600800 {
+				compatible =3D "ibm,iic-460ex", "ibm,iic";
+				reg =3D <0xef600800 0x00000014>;
+				interrupt-parent =3D <&UIC0>;
+				interrupts =3D <0x3 0x4>;
+			};
+
+			GPIO0: gpio@ef600b00 {
+				compatible =3D "ibm,ppc4xx-gpio";
+				reg =3D <0xef600b00 0x00000048>;
+				gpio-controller;
+			};
+
+			ZMII0: emac-zmii@ef600d00 {
+				compatible =3D "ibm,zmii-460ex", "ibm,zmii";
+				reg =3D <0xef600d00 0x0000000c>;
+			};
+
+			RGMII0: emac-rgmii@ef601500 {
+				compatible =3D "ibm,rgmii-460ex", "ibm,rgmii";
+				reg =3D <0xef601500 0x00000008>;
+				has-mdio;
+			};
+
+			TAH0: emac-tah@ef601350 {
+				compatible =3D "ibm,tah-460ex", "ibm,tah";
+				reg =3D <0xef601350 0x00000030>;
+			};
+
+			TAH1: emac-tah@ef601450 {
+				compatible =3D "ibm,tah-460ex", "ibm,tah";
+				reg =3D <0xef601450 0x00000030>;
+			};
+
+			EMAC0: ethernet@ef600e00 {
+				device_type =3D "network";
+				compatible =3D "ibm,emac-460ex", "ibm,emac4sync";
+				interrupt-parent =3D <&EMAC0>;
+				interrupts =3D <0x0 0x1>;
+				#interrupt-cells =3D <1>;
+				#address-cells =3D <0>;
+				#size-cells =3D <0>;
+				interrupt-map =3D </*Status*/ 0x0 &UIC2 0x10 0x4
+						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				reg =3D <0xef600e00 0x000000c4>;
+				local-mac-address =3D [000000000000]; /* Filled in by U-Boot */
+				mal-device =3D <&MAL0>;
+				mal-tx-channel =3D <0>;
+				mal-rx-channel =3D <0>;
+				cell-index =3D <0>;
+				max-frame-size =3D <9000>;
+				rx-fifo-size =3D <4096>;
+				tx-fifo-size =3D <2048>;
+				rx-fifo-size-gige =3D <16384>;
+				phy-mode =3D "rgmii";
+				phy-map =3D <0x00000000>;
+				rgmii-device =3D <&RGMII0>;
+				rgmii-channel =3D <0>;
+				tah-device =3D <&TAH0>;
+				tah-channel =3D <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+			EMAC1: ethernet@ef600f00 {
+				device_type =3D "network";
+				compatible =3D "ibm,emac-460ex", "ibm,emac4sync";
+				interrupt-parent =3D <&EMAC1>;
+				interrupts =3D <0x0 0x1>;
+				#interrupt-cells =3D <1>;
+				#address-cells =3D <0>;
+				#size-cells =3D <0>;
+				interrupt-map =3D </*Status*/ 0x0 &UIC2 0x11 0x4
+						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
+				reg =3D <0xef600f00 0x000000c4>;
+				local-mac-address =3D [000000000000]; /* Filled in by U-Boot */
+				mal-device =3D <&MAL0>;
+				mal-tx-channel =3D <1>;
+				mal-rx-channel =3D <8>;
+				cell-index =3D <1>;
+				max-frame-size =3D <9000>;
+				rx-fifo-size =3D <4096>;
+				tx-fifo-size =3D <2048>;
+				rx-fifo-size-gige =3D <16384>;
+				phy-mode =3D "rgmii";
+				phy-map =3D <0x00000000>;
+				rgmii-device =3D <&RGMII0>;
+				rgmii-channel =3D <1>;
+				tah-device =3D <&TAH1>;
+				tah-channel =3D <1>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+				mdio-device =3D <&EMAC0>;
+			};
+		};
+
+		PCIX0: pci@c0ec00000 {
+			device_type =3D "pci";
+			#interrupt-cells =3D <1>;
+			#size-cells =3D <2>;
+			#address-cells =3D <3>;
+			compatible =3D "ibm,plb-pcix-460ex", "ibm,plb-pcix";
+			primary;
+			large-inbound-windows;
+			enable-msi-hole;
+			reg =3D <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
+			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
+			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging regi=
sters */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges =3D <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x=
00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000c 0x0ee00000 0x00000000 =
0x00100000
+				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 =
0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+
+			/* This drives busses 0 to 0x3f */
+			bus-range =3D <0x0 0x3f>;
+
+			/* All PCI interrupts are routed to ext IRQ 2 -> UIC1-0 */
+			interrupt-map-mask =3D <0x0 0x0 0x0 0x0>;
+			interrupt-map =3D < 0x0 0x0 0x0 0x0 &UIC1 0x0 0x8 >;
+		};
+
+		PCIE0: pciex@d00000000 {
+			device_type =3D "pci";
+			#interrupt-cells =3D <1>;
+			#size-cells =3D <2>;
+			#address-cells =3D <3>;
+			compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";
+			primary;
+			port =3D <0x0>; /* port number */
+			reg =3D <0x0000000d 0x00000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08010000 0x00001000>;	/* Registers */
+			dcr-reg =3D <0x100 0x020>;
+			sdr-base =3D <0x300>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges =3D <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x=
00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00000000 0x00000000 =
0x00100000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 =
0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+
+			/* This drives busses 40 to 0x7f */
+			bus-range =3D <0x40 0x7f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
+			interrupt-map =3D <
+				0x0 0x0 0x0 0x1 &UIC3 0xc 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0xd 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
+		};
+
+		PCIE1: pciex@d20000000 {
+			device_type =3D "pci";
+			#interrupt-cells =3D <1>;
+			#size-cells =3D <2>;
+			#address-cells =3D <3>;
+			compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex";
+			primary;
+			port =3D <0x1>; /* port number */
+			reg =3D <0x0000000d 0x20000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08011000 0x00001000>;	/* Registers */
+			dcr-reg =3D <0x120 0x020>;
+			sdr-base =3D <0x340>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges =3D <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x=
00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00100000 0x00000000 =
0x00100000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 =
0x00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+
+			/* This drives busses 80 to 0xbf */
+			bus-range =3D <0x80 0xbf>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
+			interrupt-map =3D <
+				0x0 0x0 0x0 0x1 &UIC3 0x10 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x11 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
+		};
+
+		MSI: ppc4xx-msi@C10000000 {
+			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
+			reg =3D < 0xC 0x10000000 0x100>;
+			sdr-base =3D <0x36C>;
+			msi-data =3D <0x00000000>;
+			msi-mask =3D <0x44440000>;
+			interrupt-count =3D <3>;
+			interrupts =3D <0 1 2 3>;
+			interrupt-parent =3D <&UIC3>;
+			#interrupt-cells =3D <1>;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			interrupt-map =3D <0 &UIC3 0x18 1
+					1 &UIC3 0x19 1
+					2 &UIC3 0x1A 1
+					3 &UIC3 0x1B 1>;
+		};
+	};
+};
--=20
2.14.3
