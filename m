Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUL1-00047o-LY
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKx-00056I-5I
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:39 -0400
Message-Id: <ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1503249785.git.balaton@eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Aug 2017 19:23:05 +0200
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/15] ppc: Add aCube Sam460ex board
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
 default-configs/ppcemb-softmmu.mak |   3 +
 hw/ppc/Makefile.objs               |   2 +
 hw/ppc/sam460ex.c                  | 611 +++++++++++++++++++++++++++++++=
++++++
 3 files changed, 616 insertions(+)
 create mode 100644 hw/ppc/sam460ex.c

diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
index 635923a..90b42f0 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -17,3 +17,6 @@ CONFIG_XILINX=3Dy
 CONFIG_XILINX_ETHLITE=3Dy
 CONFIG_LIBDECNUMBER=3Dy
 CONFIG_SM501=3Dy
+CONFIG_USB_EHCI_SYSBUS=3Dy
+CONFIG_IDE_SII3112=3Dy
+CONFIG_SAM460EX=3Dy
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index fc39fe4..0aaea5b 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -27,3 +27,5 @@ obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
 obj-$(CONFIG_E500) +=3D mpc8544_guts.o ppce500_spin.o
 # PowerPC 440 Xilinx ML507 reference board.
 obj-$(CONFIG_XILINX) +=3D virtex_ml507.o
+# ACube Sam460ex board.
+obj-$(CONFIG_SAM460EX) +=3D ppc440_uc.o sam460ex.o
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
new file mode 100644
index 0000000..7cf4f6f
--- /dev/null
+++ b/hw/ppc/sam460ex.c
@@ -0,0 +1,611 @@
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
+#include "hw/ppc/ppc440.h"
+#include "hw/ppc/ppc405.h"
+#include "hw/block/flash.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/i2c/ppc4xx_i2c.h"
+#include "hw/i2c/smbus.h"
+#include "hw/usb/hcd-ehci.h"
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
--=20
2.7.6
