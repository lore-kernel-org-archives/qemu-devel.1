Received: from eggs.gnu.org ([2001:4830:134:3::10]:47119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJna-00035b-MP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJnX-0007SP-3I
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:30 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:23:34 +0200
Message-Id: <20180627232334.14142-11-laurent@vivier.eu>
In-Reply-To: <20180627232334.14142-1-laurent@vivier.eu>
References: <20180627232334.14142-1-laurent@vivier.eu>
Subject: [Qemu-devel] [C v2 10/10] hw/m68k: define Macintosh Quadra 800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Laurent Vivier <Laurent@Vivier.EU>

From: Laurent Vivier <Laurent@Vivier.EU>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                      |  19 ++
 default-configs/m68k-softmmu.mak |  14 ++
 hw/intc/Makefile.objs            |   1 +
 hw/intc/q800_irq.c               |  73 ++++++++
 hw/m68k/Makefile.objs            |   6 +-
 hw/m68k/bootinfo.h               | 100 ++++++++++
 hw/m68k/q800.c                   | 385 +++++++++++++++++++++++++++++++++++++++
 include/hw/intc/q800_irq.h       |  39 ++++
 tests/qom-test.c                 |   5 +
 tests/test-hmp.c                 |   3 +-
 10 files changed, 642 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/q800_irq.c
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 hw/m68k/q800.c
 create mode 100644 include/hw/intc/q800_irq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c626f6a07..3c7c8d891e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -693,6 +693,25 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+q800
+M: Laurent Vivier <laurent@vivier.eu>
+S: Maintained
+F: hw/audio/asc.c
+F: hw/block/swim.c
+F: hw/m68k/bootinfo.h
+F: hw/display/macfb-template.h
+F: hw/display/macfb.c
+F: hw/intc/q800_irq.c
+F: hw/m68k/q800.c
+F: hw/misc/mac_via.c
+F: hw/nubus/*
+F: include/hw/audio/asc.h
+F: include/hw/block/swim.h
+F: include/hw/display/macfb.h
+F: include/hw/intc/q800_irq.h
+F: include/hw/misc/mac_via.h
+F: include/hw/nubus/*
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 60f7cdfbf2..993644aa42 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -2,3 +2,17 @@
 
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
+CONFIG_ESCC=y
+CONFIG_FRAMEBUFFER=y
+CONFIG_ADB=y
+CONFIG_MOS6522=y
+CONFIG_MAC_VIA=y
+CONFIG_Q800_IRQ=y
+CONFIG_MAC=y
+CONFIG_SCSI=y
+CONFIG_ESP=y
+CONFIG_ASC=y
+CONFIG_MACFB=y
+CONFIG_NUBUS=y
+CONFIG_DP8393X=y
+CONFIG_SWIM=y
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 0e9963f5ee..030967a0b3 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -46,3 +46,4 @@ obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
+obj-$(CONFIG_Q800_IRQ) += q800_irq.o
diff --git a/hw/intc/q800_irq.c b/hw/intc/q800_irq.c
new file mode 100644
index 0000000000..ec9d542d2e
--- /dev/null
+++ b/hw/intc/q800_irq.c
@@ -0,0 +1,73 @@
+/*
+ * QEMU Motorla 680x0 Macintosh hardware System Emulator
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/intc/q800_irq.h"
+
+
+static void q800_set_irq(void *opaque, int irq, int level)
+{
+    Q800IRQControllerState *s = opaque;
+    int i;
+
+
+    if (level) {
+        s->ipr |= 1 << irq;
+    } else {
+        s->ipr &= ~(1 << irq);
+    }
+
+    for (i = 7; i >= 0; i--) {
+        if ((s->ipr >> i) & 1) {
+            m68k_set_irq_level(s->cpu, i + 1, i + 25);
+            return;
+        }
+    }
+    m68k_set_irq_level(s->cpu, 0, 0);
+}
+
+static void q800_irq_init(Object *obj)
+{
+    Q800IRQControllerState *s = Q800_IRQC(obj);
+
+    qdev_init_gpio_in(DEVICE(obj), q800_set_irq, 8);
+
+    object_property_add_link(obj, "cpu", TYPE_M68K_CPU,
+                             (Object **) &s->cpu,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+}
+
+static const TypeInfo q800_irq_type_info = {
+    .name = TYPE_Q800_IRQC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Q800IRQControllerState),
+    .instance_init = q800_irq_init,
+};
+
+static void q800_irq_register_types(void)
+{
+    type_register_static(&q800_irq_type_info);
+}
+
+type_init(q800_irq_register_types);
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index d1f089c08a..18ebf1937a 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,2 +1,4 @@
-obj-y += an5206.o mcf5208.o
-obj-y += mcf5206.o mcf_intc.o
+obj-$(CONFIG_COLDFIRE) += an5206.o mcf5208.o
+obj-$(CONFIG_MAC) += q800.o
+
+obj-$(CONFIG_COLDFIRE) += mcf5206.o mcf_intc.o
diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
new file mode 100644
index 0000000000..6584775f6d
--- /dev/null
+++ b/hw/m68k/bootinfo.h
@@ -0,0 +1,100 @@
+struct bi_record {
+    uint16_t tag;        /* tag ID */
+    uint16_t size;       /* size of record */
+    uint32_t data[0];    /* data */
+};
+
+/* machine independent tags */
+
+#define BI_LAST         0x0000 /* last record */
+#define BI_MACHTYPE     0x0001 /* machine type (u_long) */
+#define BI_CPUTYPE      0x0002 /* cpu type (u_long) */
+#define BI_FPUTYPE      0x0003 /* fpu type (u_long) */
+#define BI_MMUTYPE      0x0004 /* mmu type (u_long) */
+#define BI_MEMCHUNK     0x0005 /* memory chunk address and size */
+                               /* (struct mem_info) */
+#define BI_RAMDISK      0x0006 /* ramdisk address and size */
+                               /* (struct mem_info) */
+#define BI_COMMAND_LINE 0x0007 /* kernel command line parameters */
+                               /* (string) */
+
+/*  Macintosh-specific tags (all u_long) */
+
+#define BI_MAC_MODEL    0x8000  /* Mac Gestalt ID (model type) */
+#define BI_MAC_VADDR    0x8001  /* Mac video base address */
+#define BI_MAC_VDEPTH   0x8002  /* Mac video depth */
+#define BI_MAC_VROW     0x8003  /* Mac video rowbytes */
+#define BI_MAC_VDIM     0x8004  /* Mac video dimensions */
+#define BI_MAC_VLOGICAL 0x8005  /* Mac video logical base */
+#define BI_MAC_SCCBASE  0x8006  /* Mac SCC base address */
+#define BI_MAC_BTIME    0x8007  /* Mac boot time */
+#define BI_MAC_GMTBIAS  0x8008  /* Mac GMT timezone offset */
+#define BI_MAC_MEMSIZE  0x8009  /* Mac RAM size (sanity check) */
+#define BI_MAC_CPUID    0x800a  /* Mac CPU type (sanity check) */
+#define BI_MAC_ROMBASE  0x800b  /* Mac system ROM base address */
+
+/*  Macintosh hardware profile data */
+
+#define BI_MAC_VIA1BASE 0x8010  /* Mac VIA1 base address (always present) */
+#define BI_MAC_VIA2BASE 0x8011  /* Mac VIA2 base address (type varies) */
+#define BI_MAC_VIA2TYPE 0x8012  /* Mac VIA2 type (VIA, RBV, OSS) */
+#define BI_MAC_ADBTYPE  0x8013  /* Mac ADB interface type */
+#define BI_MAC_ASCBASE  0x8014  /* Mac Apple Sound Chip base address */
+#define BI_MAC_SCSI5380 0x8015  /* Mac NCR 5380 SCSI (base address, multi) */
+#define BI_MAC_SCSIDMA  0x8016  /* Mac SCSI DMA (base address) */
+#define BI_MAC_SCSI5396 0x8017  /* Mac NCR 53C96 SCSI (base address, multi) */
+#define BI_MAC_IDETYPE  0x8018  /* Mac IDE interface type */
+#define BI_MAC_IDEBASE  0x8019  /* Mac IDE interface base address */
+#define BI_MAC_NUBUS    0x801a  /* Mac Nubus type (none, regular, pseudo) */
+#define BI_MAC_SLOTMASK 0x801b  /* Mac Nubus slots present */
+#define BI_MAC_SCCTYPE  0x801c  /* Mac SCC serial type (normal, IOP) */
+#define BI_MAC_ETHTYPE  0x801d  /* Mac builtin ethernet type (Sonic, MACE */
+#define BI_MAC_ETHBASE  0x801e  /* Mac builtin ethernet base address */
+#define BI_MAC_PMU      0x801f  /* Mac power management / poweroff hardware */
+#define BI_MAC_IOP_SWIM 0x8020  /* Mac SWIM floppy IOP */
+#define BI_MAC_IOP_ADB  0x8021  /* Mac ADB IOP */
+
+#define BOOTINFO0(as, base, id) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record)); \
+        base += 2; \
+    } while (0)
+
+#define BOOTINFO1(as, base, id, value) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record) + 4); \
+        base += 2; \
+        stl_phys(as, base, value); \
+        base += 4; \
+    } while (0)
+
+#define BOOTINFO2(as, base, id, value1, value2) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record) + 8); \
+        base += 2; \
+        stl_phys(as, base, value1); \
+        base += 4; \
+        stl_phys(as, base, value2); \
+        base += 4; \
+    } while (0)
+
+#define BOOTINFOSTR(as, base, id, string) \
+    do { \
+        int i; \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, \
+                 (sizeof(struct bi_record) + strlen(string) + 2) & ~1); \
+        base += 2; \
+        for (i = 0; string[i]; i++) { \
+            stb_phys(as, base++, string[i]); \
+        } \
+        stb_phys(as, base++, 0); \
+        base = (parameters_base + 1) & ~1; \
+    } while (0)
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
new file mode 100644
index 0000000000..51ad3c6c76
--- /dev/null
+++ b/hw/m68k/q800.c
@@ -0,0 +1,385 @@
+/*
+ * QEMU Motorla 680x0 Macintosh hardware System Emulator
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "elf.h"
+#include "hw/loader.h"
+#include "hw/display/framebuffer.h"
+#include "ui/console.h"
+#include "exec/address-spaces.h"
+#include "hw/char/escc.h"
+#include "hw/sysbus.h"
+#include "hw/scsi/esp.h"
+#include "bootinfo.h"
+#include "hw/misc/mac_via.h"
+#include "hw/input/adb.h"
+#include "hw/audio/asc.h"
+#include "hw/nubus/mac-nubus-bridge.h"
+#include "hw/display/macfb.h"
+#include "hw/intc/q800_irq.h"
+#include "hw/block/swim.h"
+#include "net/net.h"
+#include "qapi/error.h"
+
+#define MACROM_ADDR     0x40000000
+#define MACROM_SIZE     0x00100000
+
+/*
+ *              .ident          = MAC_MODEL_Q800,
+ *              .name           = "Quadra 800",
+ *              .adb_type       = MAC_ADB_II,
+ *              .via_type       = MAC_VIA_QUADRA,
+ *              .scsi_type      = MAC_SCSI_QUADRA,
+ *              .scc_type       = MAC_SCC_QUADRA,
+ *              .ether_type     = MAC_ETHER_SONIC,
+ *              .nubus_type     = MAC_NUBUS
+ */
+
+#define MACROM_FILENAME "MacROM.bin"
+
+#define Q800_MACHINE_ID 35
+#define Q800_CPU_ID (1 << 2)
+#define Q800_FPU_ID (1 << 2)
+#define Q800_MMU_ID (1 << 2)
+
+#define MACH_MAC        3
+#define Q800_MAC_CPU_ID 2
+
+#define VIA_BASE              0x50f00000
+#define SONIC_PROM_BASE       0x50f08000
+#define SONIC_BASE            0x50f0a000
+#define SCC_BASE              0x50f0c020
+#define ESP_BASE              0x50f10000
+#define ESP_PDMA              0x50f10100
+#define ASC_BASE              0x50F14000
+#define SWIM_BASE             0x50F1E000
+#define NUBUS_SUPER_SLOT_BASE 0x60000000
+#define NUBUS_SLOT_BASE       0xf0000000
+
+/* the video base, whereas it a Nubus address,
+ * is needed by the kernel to have early display and
+ * thus provided by the bootloader
+ */
+#define VIDEO_BASE            0xf9001000
+
+#define MAC_CLOCK  3686418
+
+static void main_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(cs);
+    cpu->env.aregs[7] = ldl_phys(cs->as, 0);
+    cpu->env.pc = ldl_phys(cs->as, 4);
+}
+
+static void q800_init(MachineState *machine)
+{
+    M68kCPU *cpu = NULL;
+    int linux_boot;
+    int32_t kernel_size;
+    uint64_t elf_entry;
+    char *filename;
+    int bios_size;
+    ram_addr_t initrd_base;
+    int32_t initrd_size;
+    MemoryRegion *rom;
+    MemoryRegion *ram;
+    ram_addr_t ram_size = machine->ram_size;
+    const char *kernel_filename = machine->kernel_filename;
+    const char *initrd_filename = machine->initrd_filename;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    hwaddr parameters_base;
+    CPUState *cs;
+    DeviceState *dev;
+    DeviceState *via_dev, *pic_dev;
+    SysBusESPState *sysbus_esp;
+    ESPState *esp;
+    SysBusDevice *sysbus;
+    BusState *adb_bus;
+    NubusBus *nubus;
+    DriveInfo *fds[2];
+
+    linux_boot = (kernel_filename != NULL);
+
+    /* init CPUs */
+    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    if (!cpu) {
+            hw_error("qemu: unable to find m68k CPU definition\n");
+            exit(1);
+    }
+    qemu_register_reset(main_cpu_reset, cpu);
+
+    ram = g_malloc(sizeof(*ram));
+    memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abort);
+    memory_region_add_subregion(get_system_memory(), 0, ram);
+
+    /* IRQ controller */
+
+    pic_dev = qdev_create(NULL, TYPE_Q800_IRQC);
+    object_property_set_link(OBJECT(pic_dev), OBJECT(cpu), "cpu",
+                             &error_abort);
+    qdev_init_nofail(pic_dev);
+
+    /* VIA */
+
+    via_dev = qdev_create(NULL, TYPE_MAC_VIA);
+    qdev_init_nofail(via_dev);
+    sysbus = SYS_BUS_DEVICE(via_dev);
+    sysbus_mmio_map(sysbus, 0, VIA_BASE);
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0,
+                                qdev_get_gpio_in(pic_dev, 0));
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1,
+                                qdev_get_gpio_in(pic_dev, 1));
+
+    adb_bus = qdev_get_child_bus(via_dev, "adb.0");
+    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
+    qdev_init_nofail(dev);
+    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
+    qdev_init_nofail(dev);
+
+    /* MACSONIC */
+
+    if (nb_nics != 1) {
+        hw_error("Q800 needs a dp83932 ethernet interfaces");
+    }
+    if (!nd_table[0].model) {
+        nd_table[0].model = g_strdup("dp83932");
+    }
+    if (strcmp(nd_table[0].model, "dp83932") != 0) {
+        hw_error("Q800 needs a dp83932 ethernet interfaces");
+    } else {
+        /* MacSonic driver needs an Apple MAC address
+         * Valid prefix are:
+         * 00:05:02 Apple
+         * 00:80:19 Dayna Communications, Inc.
+         * 00:A0:40 Apple
+         * 08:00:07 Apple
+         * (Q800 use the last one)
+         */
+        nd_table[0].macaddr.a[0] = 0x08;
+        nd_table[0].macaddr.a[1] = 0x00;
+        nd_table[0].macaddr.a[2] = 0x07;
+    }
+    qemu_check_nic_model(&nd_table[0], "dp83932");
+    dev = qdev_create(NULL, "dp8393x");
+    qdev_set_nic_properties(dev, &nd_table[0]);
+    qdev_prop_set_uint8(dev, "it_shift", 2);
+    qdev_prop_set_bit(dev, "big_endian", true);
+    qdev_prop_set_ptr(dev, "dma_mr", get_system_memory());
+    qdev_init_nofail(dev);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(sysbus, 0, SONIC_BASE);
+    sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(pic_dev, 2));
+
+    /* SCC */
+
+    dev = qdev_create(NULL, TYPE_ESCC);
+    qdev_prop_set_uint32(dev, "disabled", 0);
+    qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
+    qdev_prop_set_uint32(dev, "it_shift", 1);
+    qdev_prop_set_bit(dev, "bit_swap", true);
+    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
+    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
+    qdev_prop_set_uint32(dev, "chnBtype", 0);
+    qdev_prop_set_uint32(dev, "chnAtype", 0);
+    qdev_init_nofail(dev);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(pic_dev, 3));
+    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(pic_dev, 3));
+    sysbus_mmio_map(sysbus, 0, SCC_BASE);
+
+    /* SCSI */
+
+    dev = qdev_create(NULL, TYPE_ESP);
+    sysbus_esp = ESP_STATE(dev);
+    esp = &sysbus_esp->esp;
+    esp->dma_memory_read = NULL;
+    esp->dma_memory_write = NULL;
+    esp->dma_opaque = NULL;
+    sysbus_esp->it_shift = 4;
+    esp->dma_enabled = 1;
+    qdev_init_nofail(dev);
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
+                                                         "via2-irq",
+                                                         VIA2_IRQ_SCSI_BIT));
+    sysbus_connect_irq(sysbus, 1,
+                       qdev_get_gpio_in_named(via_dev, "via2-irq",
+                                              VIA2_IRQ_SCSI_DATA_BIT));
+    sysbus_mmio_map(sysbus, 0, ESP_BASE);
+    sysbus_mmio_map(sysbus, 1, ESP_PDMA);
+
+    scsi_bus_legacy_handle_cmdline(&esp->bus);
+
+    /* Apple Sound Chip */
+
+    dev = qdev_create(NULL, TYPE_ASC);
+    qdev_prop_set_uint8(dev, "asctype", ASC_TYPE_ASC);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ASC_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in_named(via_dev, "via2-irq",
+                                              VIA2_IRQ_ASC_BIT));
+
+    /* SWIM floppy controller */
+
+    if (drive_get_max_bus(IF_FLOPPY) >= 2) {
+        fprintf(stderr, "qemu: too many floppy drives\n");
+        exit(1);
+    }
+    fds[0] = drive_get(IF_FLOPPY, 0, 0);
+    fds[1] = drive_get(IF_FLOPPY, 0, 1);
+
+    dev = qdev_create(NULL, TYPE_SWIM);
+    if (fds[0]) {
+        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fds[0]),
+                            &error_fatal);
+    }
+    if (fds[1]) {
+        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
+                            &error_fatal);
+    }
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
+
+    /* NuBus */
+
+    dev = qdev_create(NULL, TYPE_MAC_NUBUS_BRIDGE);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, NUBUS_SUPER_SLOT_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE);
+
+    nubus = MAC_NUBUS_BRIDGE(dev)->bus;
+
+    /* framebuffer in nubus slot #9 */
+
+    dev = qdev_create(BUS(nubus), TYPE_NUBUS_MACFB);
+    qdev_prop_set_uint32(dev, "width", graphic_width);
+    qdev_prop_set_uint32(dev, "height", graphic_height);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_init_nofail(dev);
+
+    cs = CPU(cpu);
+    if (linux_boot) {
+        uint64_t high;
+        kernel_size = load_elf(kernel_filename, NULL, NULL,
+                               &elf_entry, NULL, &high, 1,
+                               EM_68K, 0, 0);
+        if (kernel_size < 0) {
+            hw_error("qemu: could not load kernel '%s'\n",
+                      kernel_filename);
+            exit(1);
+        }
+        stl_phys(cs->as, 4, elf_entry); /* reset initial PC */
+        parameters_base = (high + 1) & ~1;
+
+        BOOTINFO1(cs->as, parameters_base, BI_MACHTYPE, MACH_MAC);
+        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, Q800_FPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, Q800_MMU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, Q800_CPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_CPUID, Q800_MAC_CPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_MODEL, Q800_MACHINE_ID);
+        BOOTINFO1(cs->as, parameters_base,
+                  BI_MAC_MEMSIZE, ram_size >> 20); /* in MB */
+        BOOTINFO2(cs->as, parameters_base, BI_MEMCHUNK, 0, ram_size);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VADDR, VIDEO_BASE);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VDEPTH, graphic_depth);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VDIM,
+                  (graphic_height << 16) | graphic_width);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VROW,
+                  (graphic_width * graphic_depth + 7) / 8);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
+
+        if (kernel_cmdline) {
+            BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
+                        kernel_cmdline);
+        }
+
+        /* load initrd */
+        if (initrd_filename) {
+            initrd_size = get_image_size(initrd_filename);
+            if (initrd_size < 0) {
+                hw_error("qemu: could not load initial ram disk '%s'\n",
+                         initrd_filename);
+                exit(1);
+            }
+
+            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
+            load_image_targphys(initrd_filename, initrd_base,
+                                ram_size - initrd_base);
+            BOOTINFO2(cs->as, parameters_base, BI_RAMDISK, initrd_base,
+                      initrd_size);
+        } else {
+            initrd_base = 0;
+            initrd_size = 0;
+        }
+        BOOTINFO0(cs->as, parameters_base, BI_LAST);
+    } else {
+        uint8_t *ptr;
+        /* allocate and load BIOS */
+        rom = g_malloc(sizeof(*rom));
+        memory_region_init_ram(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+                               &error_abort);
+        if (bios_name == NULL) {
+            bios_name = MACROM_FILENAME;
+        }
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        memory_region_set_readonly(rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+
+        /* Load MacROM binary */
+        if (filename) {
+            bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
+            g_free(filename);
+        } else {
+            bios_size = -1;
+        }
+        if (bios_size < 0 || bios_size > MACROM_SIZE) {
+            hw_error("qemu: could not load MacROM '%s'\n", bios_name);
+            exit(1);
+        }
+        ptr = rom_ptr(MACROM_ADDR);
+        stl_phys(cs->as, 0, ldl_p(ptr));    /* reset initial SP */
+        stl_phys(cs->as, 4,
+                 MACROM_ADDR + ldl_p(ptr + 4)); /* reset initial PC */
+    }
+}
+
+static void q800_machine_init(MachineClass *mc)
+{
+    mc->desc = "Macintosh Quadra 800";
+    mc->init = q800_init;
+    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->max_cpus = 1;
+    mc->is_default = 0;
+    mc->block_default_type = IF_SCSI;
+}
+
+DEFINE_MACHINE("q800", q800_machine_init)
diff --git a/include/hw/intc/q800_irq.h b/include/hw/intc/q800_irq.h
new file mode 100644
index 0000000000..91c2de1cc5
--- /dev/null
+++ b/include/hw/intc/q800_irq.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU Motorla 680x0 Macintosh hardware System Emulator
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef Q800_IRQ_H
+#define Q800_IRQ_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_Q800_IRQC "q800-irq-controller"
+#define Q800_IRQC(obj) OBJECT_CHECK(Q800IRQControllerState, (obj), \
+                                    TYPE_Q800_IRQC)
+
+typedef struct Q800IRQControllerState {
+    SysBusDevice parent_obj;
+
+    M68kCPU *cpu;
+    uint8_t ipr;
+} Q800IRQControllerState;
+
+#endif
diff --git a/tests/qom-test.c b/tests/qom-test.c
index e6f712cbd3..373699fda4 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -19,12 +19,17 @@ static const char *blacklist_x86[] = {
     "xenfv", "xenpv", NULL
 };
 
+static const char *blacklist_m68k[] = {
+    "q800", NULL
+};
+
 static const struct {
     const char *arch;
     const char **machine;
 } blacklists[] = {
     { "i386", blacklist_x86 },
     { "x86_64", blacklist_x86 },
+    { "m68k", blacklist_m68k },
 };
 
 static bool is_blacklisted(const char *arch, const char *mach)
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5352c9c088..f3b79d5bdf 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -139,7 +139,8 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     /* Ignore blacklisted machines that have known problems */
-    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
+    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname) ||
+        !strcmp("q800", mname)) {
         return;
     }
 
-- 
2.14.4
