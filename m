Received: from eggs.gnu.org ([2001:4830:134:3::10]:50947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDX-0003J7-TC
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDU-0004qk-HK
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:31 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDU-0004qK-5j
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:28 -0500
Received: by mail-pf0-x241.google.com with SMTP id v26so21822318pfl.7
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:36 -0800
Message-Id: <20171229063145.29167-30-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 29/38] hw/hppa: Implement DINO system board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Now that we have the prerequisites in target/hppa/,
implement the hardware for a PA7100LC.

This also enables build for hppa-softmmu.

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Since it is all new code, squashed all branch development
withing hw/hppa/ to a single patch.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.objs                    |   1 +
 hw/hppa/hppa_hardware.h          |  64 +++++
 hw/hppa/hppa_sys.h               |  24 ++
 hw/hppa/dino.c                   | 520 +++++++++++++++++++++++++++++++++++++++
 hw/hppa/machine.c                | 212 +++++++++++++++-
 hw/hppa/pci.c                    |  90 +++++++
 default-configs/hppa-softmmu.mak |  14 ++
 hw/hppa/Makefile.objs            |   2 +-
 hw/hppa/trace-events             |   4 +
 9 files changed, 929 insertions(+), 2 deletions(-)
 create mode 100644 hw/hppa/hppa_hardware.h
 create mode 100644 hw/hppa/hppa_sys.h
 create mode 100644 hw/hppa/dino.c
 create mode 100644 hw/hppa/pci.c
 create mode 100644 default-configs/hppa-softmmu.mak
 create mode 100644 hw/hppa/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..a3c1171ddb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -153,6 +153,7 @@ trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
+trace-events-subdirs += hw/hppa
 trace-events-subdirs += hw/xen
 trace-events-subdirs += hw/ide
 trace-events-subdirs += ui
diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
new file mode 100644
index 0000000000..242a326552
--- /dev/null
+++ b/hw/hppa/hppa_hardware.h
@@ -0,0 +1,64 @@
+/* HPPA cores and system support chips.  */
+
+#define FIRMWARE_START	0xf0000000
+#define FIRMWARE_END	0xf0800000
+
+#define DEVICE_HPA_LEN	0x00100000
+
+#define GSC_HPA		0xffc00000
+#define DINO_HPA	0xfff80000
+#define DINO_UART_HPA	0xfff83000
+#define  DINO_UART_BASE	0xfff83800
+#define DINO_SCSI_HPA	0xfff8c000
+#define LASI_HPA	0xffd00000
+#define LASI_UART_HPA	0xffd05000
+#define LASI_SCSI_HPA	0xffd06000
+#define LASI_LAN_HPA	0xffd07000
+#define LASI_LPT_HPA	0xffd02000
+#define LASI_AUDIO_HPA	0xffd04000
+#define LASI_PS2KBD_HPA	0xffd08000
+#define LASI_PS2MOU_HPA	0xffd08100
+#define LASI_GFX_HPA	0xf8000000
+#define CPU_HPA		0xfffbe000
+#define MEMORY_HPA	0xfffbf000
+
+#define PCI_HPA         DINO_HPA        /* PCI bus */
+#define IDE_HPA         0xf9000000      /* Boot disc controller */
+
+/* offsets to DINO HPA: */
+#define DINO_PCI_ADDR           0x064
+#define DINO_CONFIG_DATA        0x068
+#define DINO_IO_DATA            0x06c
+
+#define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
+#define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)
+
+#define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
+#define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
+
+#define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */
+
+
+#if 0
+[    2.160168] 1. Phantom PseudoBC GSC+ Port at 0xffc00000 [8] { 7, 0x0, 0x504, 0x00000 }
+[    2.260162] 2. Dino PCI Bridge at 0xfff80000 [8/0] { 13, 0x3, 0x680, 0x0000a }
+[    2.350158] 3. Merlin+ 132 Dino RS-232 at 0xfff83000 [8/0/63] { 10, 0x0, 0x022, 0x0008c }
+[    2.450160] 4. Merlin 160 Core FW-SCSI at 0xfff8c000 [8/12] { 4, 0x0, 0x03d, 0x00089 }
+[    2.550161] 5. Merlin 160 Core BA at 0xffd00000 [8/16] { 11, 0x0, 0x03d, 0x00081 }, additional addresses: 0xffd0c000 0xffc00000
+[    2.700165] 6. Merlin 160 Core RS-232 at 0xffd05000 [8/16/4] { 10, 0x0, 0x03d, 0x0008c }
+[    2.800160] 7. Merlin 160 Core SCSI at 0xffd06000 [8/16/5] { 10, 0x0, 0x03d, 0x00082 }
+[    2.900162] 8. Merlin 160 Core LAN (802.3) at 0xffd07000 [8/16/6] { 10, 0x0, 0x03d, 0x0008a }
+[    3.010187] 9. Merlin 160 Core Centronics at 0xffd02000 [8/16/0] { 10, 0x0, 0x03d, 0x00074 }, additional addresses: 0xffd01000 0xffd03000
+[    3.170204] 10. Merlin 160 Core Audio at 0xffd04000 [8/16/1] { 10, 0x4, 0x03d, 0x0007b }
+[    3.270157] 11. Merlin 160 Core PS/2 Port at 0xffd08000 [8/16/7] { 10, 0x0, 0x03d, 0x00084 }
+[    3.370151] 12. Merlin 160 Core PS/2 Port at 0xffd08100 [8/16/8] { 10, 0x0, 0x03d, 0x00084 }
+[    3.480148] 13. Coral SGC Graphics at 0xfa000000 [8/4] { 10, 0x0, 0x004, 0x00077 }
+[    3.570145] 14. Coral SGC Graphics at 0xf4000000 [8/8] { 10, 0x0, 0x004, 0x00077 }
+[    3.670146] 15. Gecko GSC Core Graphics at 0xf8000000 [8/24] { 10, 0x0, 0x016, 0x00085 }, additional addresses: 0xf0011000
+[    3.810147] 16. Merlin L2 160 (9000/778/B160L) at 0xfffbe000 [62] { 0, 0x0, 0x502, 0x00004 }
+[    3.920139] 17. Memory at 0xfffbf000 [63] { 1, 0x0, 0x067, 0x00009 }
+[    4.000142] 18. Merlin+ 132 Dino PS/2 Port at 0xfff81000 [1] { 10, 0x0, 0x022, 0x00096 }
+[    4.231309] CPU(s): 1 out of 1 PA7300LC (PCX-L2) at 160.000000 MHz online
+
+./hppa-softmmu/qemu-system-hppa -kernel bios.bin -nographic  -serial mon:stdio
+#endif
diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
new file mode 100644
index 0000000000..a182d1f34e
--- /dev/null
+++ b/hw/hppa/hppa_sys.h
@@ -0,0 +1,24 @@
+/* HPPA cores and system support chips.  */
+
+#ifndef HW_HPPA_SYS_H
+#define HW_HPPA_SYS_H
+
+#include "target/hppa/cpu-qom.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/ide.h"
+#include "hw/i386/pc.h"
+#include "hw/irq.h"
+
+#include "hw/hppa/hppa_hardware.h"
+
+PCIBus *dino_init(MemoryRegion *, qemu_irq *, qemu_irq *);
+
+#define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
+
+/* hppa_pci.c.  */
+extern const MemoryRegionOps hppa_pci_ignore_ops;
+extern const MemoryRegionOps hppa_pci_conf1_ops;
+extern const MemoryRegionOps hppa_pci_iack_ops;
+
+#endif
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
new file mode 100644
index 0000000000..6ae470b1d2
--- /dev/null
+++ b/hw/hppa/dino.c
@@ -0,0 +1,520 @@
+/*
+ * HP-PARISC Dino PCI chipset emulation.
+ *
+ * (C) 2017 by Helge Deller <deller@gmx.de>
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ * Documentation available at:
+ * https://parisc.wiki.kernel.org/images-parisc/9/91/Dino_ers.pdf
+ * https://parisc.wiki.kernel.org/images-parisc/7/70/Dino_3_1_Errata.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/devices.h"
+#include "sysemu/sysemu.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hppa_sys.h"
+#include "exec/address-spaces.h"
+
+
+#define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
+
+#define DINO_IAR0               0x004
+#define DINO_IODC               0x008
+#define DINO_IRR0               0x00C  /* RO */
+#define DINO_IAR1               0x010
+#define DINO_IRR1               0x014  /* RO */
+#define DINO_IMR                0x018
+#define DINO_IPR                0x01C
+#define DINO_TOC_ADDR           0x020
+#define DINO_ICR                0x024
+#define DINO_ILR                0x028  /* RO */
+#define DINO_IO_COMMAND         0x030  /* WO */
+#define DINO_IO_STATUS          0x034  /* RO */
+#define DINO_IO_CONTROL         0x038
+#define DINO_IO_GSC_ERR_RESP    0x040  /* RO */
+#define DINO_IO_ERR_INFO        0x044  /* RO */
+#define DINO_IO_PCI_ERR_RESP    0x048  /* RO */
+#define DINO_IO_FBB_EN          0x05c
+#define DINO_IO_ADDR_EN         0x060
+#define DINO_PCI_CONFIG_ADDR    0x064
+#define DINO_PCI_CONFIG_DATA    0x068
+#define DINO_PCI_IO_DATA        0x06c
+#define DINO_PCI_MEM_DATA       0x070  /* Dino 3.x only */
+#define DINO_GSC2X_CONFIG       0x7b4  /* RO */
+#define DINO_GMASK              0x800
+#define DINO_PAMR               0x804
+#define DINO_PAPR               0x808
+#define DINO_DAMODE             0x80c
+#define DINO_PCICMD             0x810
+#define DINO_PCISTS             0x814  /* R/WC */
+#define DINO_MLTIM              0x81c
+#define DINO_BRDG_FEAT          0x820
+#define DINO_PCIROR             0x824
+#define DINO_PCIWOR             0x828
+#define DINO_TLTIM              0x830
+
+#define DINO_IRQS 11            /* bits 0-10 are architected */
+#define DINO_IRR_MASK   0x5ff   /* only 10 bits are implemented */
+#define DINO_LOCAL_IRQS (DINO_IRQS+1)
+
+#define DINO_MASK_IRQ(x)        (1<<(x))
+
+#define PCIINTA   0x001
+#define PCIINTB   0x002
+#define PCIINTC   0x004
+#define PCIINTD   0x008
+#define PCIINTE   0x010
+#define PCIINTF   0x020
+#define GSCEXTINT 0x040
+/* #define xxx       0x080 - bit 7 is "default" */
+/* #define xxx    0x100 - bit 8 not used */
+/* #define xxx    0x200 - bit 9 not used */
+#define RS232INT  0x400
+
+#define DINO_MEM_CHUNK_SIZE (8*1024*1024) // 8MB
+
+#define DINO_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
+
+typedef struct DinoState {
+    PCIHostState parent_obj;
+
+    /* PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
+       so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.  */
+
+    uint32_t iar0;
+    uint32_t iar1;
+    uint32_t imr;
+    uint32_t ipr;
+    uint32_t icr;
+    uint32_t ilr;
+    uint32_t io_addr_en;
+    uint32_t io_control;
+
+    MemoryRegion this_mem;
+    MemoryRegion pci_mem;
+    MemoryRegion pci_mem_alias[32];
+
+    AddressSpace bm_as;
+    MemoryRegion bm;
+    MemoryRegion bm_ram_alias;
+    MemoryRegion bm_pci_alias;
+
+    MemoryRegion cpu0_eir_mem;
+} DinoState;
+
+/*
+ * Dino can forward memory accesses from the CPU in the range between
+ * 0xf0800000 and 0xff000000 to the PCI bus.
+ */
+static void gsc_to_pci_forwarding(DinoState *s)
+{
+    uint32_t io_addr_en, tmp;
+    int enabled, i;
+
+    tmp = extract32(s->io_control, 7, 2);
+    enabled = (tmp == 0x01);
+    io_addr_en = s->io_addr_en;
+
+    memory_region_transaction_begin();
+    for (i = 1; i < 31; i++) {
+        MemoryRegion *mem = &s->pci_mem_alias[i];
+        if (enabled && (io_addr_en & (1U << i))) {
+            if (!memory_region_is_mapped(mem)) {
+                uint32_t addr = 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
+                memory_region_add_subregion(get_system_memory(), addr, mem);
+            }
+        } else if (memory_region_is_mapped(mem)) {
+            memory_region_del_subregion(get_system_memory(), mem);
+        }
+    }
+    memory_region_transaction_commit();
+}
+
+static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
+                                unsigned size, bool is_write)
+{
+    switch (addr) {
+    case DINO_IAR0:
+    case DINO_IAR1:
+    case DINO_IRR0:
+    case DINO_IRR1:
+    case DINO_IMR:
+    case DINO_IPR:
+    case DINO_ICR:
+    case DINO_ILR:
+    case DINO_IO_CONTROL:
+    case DINO_IO_ADDR_EN:
+    case DINO_PCI_IO_DATA:
+        return true;
+    case DINO_PCI_IO_DATA+2:
+        return size <= 2;
+    case DINO_PCI_IO_DATA+1:
+    case DINO_PCI_IO_DATA+3:
+        return size == 1;
+    }
+    return false;
+}
+
+static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
+                                             uint64_t *data, unsigned size,
+                                             MemTxAttrs attrs)
+{
+    DinoState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+    AddressSpace *io;
+    uint16_t ioaddr;
+    uint32_t val;
+
+    switch (addr) {
+    case DINO_PCI_IO_DATA ... DINO_PCI_IO_DATA+3:
+        /* Read from PCI IO space. */
+        io = &address_space_io;
+        ioaddr = s->parent_obj.config_reg;
+        switch (size) {
+        case 1:
+            val = address_space_ldub(io, ioaddr, attrs, &ret);
+            break;
+        case 2:
+            val = address_space_lduw_be(io, ioaddr, attrs, &ret);
+            break;
+        case 4:
+            val = address_space_ldl_be(io, ioaddr, attrs, &ret);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case DINO_IO_ADDR_EN:
+        val = s->io_addr_en;
+        break;
+    case DINO_IO_CONTROL:
+        val = s->io_control;
+        break;
+
+    case DINO_IAR0:
+        val = s->iar0;
+        break;
+    case DINO_IAR1:
+        val = s->iar1;
+        break;
+    case DINO_IMR:
+        val = s->imr;
+        break;
+    case DINO_ICR:
+        val = s->icr;
+        break;
+    case DINO_IPR:
+        val = s->ipr;
+        /* Any read to IPR clears the register.  */
+        s->ipr = 0;
+        break;
+    case DINO_ILR:
+        val = s->ilr;
+        break;
+    case DINO_IRR0:
+        val = s->ilr & s->imr & ~s->icr;
+        break;
+    case DINO_IRR1:
+        val = s->ilr & s->imr & s->icr;
+        break;
+
+    default:
+        /* Controlled by dino_chip_mem_valid above.  */
+        g_assert_not_reached();
+    }
+
+    *data = val;
+    return ret;
+}
+
+static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
+                                              uint64_t val, unsigned size,
+                                              MemTxAttrs attrs)
+{
+    DinoState *s = opaque;
+    AddressSpace *io;
+    MemTxResult ret;
+    uint16_t ioaddr;
+
+    switch (addr) {
+    case DINO_IO_DATA ... DINO_PCI_IO_DATA+3:
+        /* Write into PCI IO space.  */
+        io = &address_space_io;
+        ioaddr = s->parent_obj.config_reg;
+        switch (size) {
+        case 1:
+            address_space_stb(io, ioaddr, val, attrs, &ret);
+            break;
+        case 2:
+            address_space_stw_be(io, ioaddr, val, attrs, &ret);
+            break;
+        case 4:
+            address_space_stl_be(io, ioaddr, val, attrs, &ret);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return ret;
+
+    case DINO_IO_ADDR_EN:
+        /* Never allow first (=firmware) and last (=Dino) areas.  */
+        s->io_addr_en = val & 0x7ffffffe;
+        gsc_to_pci_forwarding(s);
+        break;
+    case DINO_IO_CONTROL:
+        s->io_control = val;
+        gsc_to_pci_forwarding(s);
+        break;
+
+    case DINO_IAR0:
+        s->iar0 = val;
+        break;
+    case DINO_IAR1:
+        s->iar1 = val;
+        break;
+    case DINO_IMR:
+        s->imr = val;
+        break;
+    case DINO_ICR:
+        s->icr = val;
+        break;
+    case DINO_IPR:
+        /* Any write to IPR clears the register.  */
+        s->ipr = 0;
+        break;
+
+    case DINO_ILR:
+    case DINO_IRR0:
+    case DINO_IRR1:
+        /* These registers are read-only.  */
+        break;
+
+    default:
+        /* Controlled by dino_chip_mem_valid above.  */
+        g_assert_not_reached();
+    }
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps dino_chip_ops = {
+    .read_with_attrs = dino_chip_read_with_attrs,
+    .write_with_attrs = dino_chip_write_with_attrs,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .accepts = dino_chip_mem_valid,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const VMStateDescription vmstate_dino = {
+    .name = "Dino",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(iar0, DinoState),
+        VMSTATE_UINT32(iar1, DinoState),
+        VMSTATE_UINT32(imr, DinoState),
+        VMSTATE_UINT32(ipr, DinoState),
+        VMSTATE_UINT32(icr, DinoState),
+        VMSTATE_UINT32(ilr, DinoState),
+        VMSTATE_UINT32(io_addr_en, DinoState),
+        VMSTATE_UINT32(io_control, DinoState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+/* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
+
+static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsigned len)
+{
+    PCIHostState *s = opaque;
+    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
+}
+
+static void dino_config_data_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned len)
+{
+    PCIHostState *s = opaque;
+    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
+}
+
+static const MemoryRegionOps dino_config_data_ops = {
+    .read = dino_config_data_read,
+    .write = dino_config_data_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static AddressSpace *dino_pcihost_set_iommu(PCIBus *bus, void *opaque,
+                                            int devfn)
+{
+    DinoState *s = opaque;
+
+    return &s->bm_as;
+}
+
+/*
+ * Dino interrupts are connected as shown on Page 78, Table 23
+ * (Little-endian bit numbers)
+ *    0   PCI INTA
+ *    1   PCI INTB
+ *    2   PCI INTC
+ *    3   PCI INTD
+ *    4   PCI INTE
+ *    5   PCI INTF
+ *    6   GSC External Interrupt
+ *    7   Bus Error for "less than fatal" mode
+ *    8   PS2
+ *    9   Unused
+ *    10  RS232
+ */
+
+static void dino_set_irq(void *opaque, int irq, int level)
+{
+    DinoState *s = opaque;
+    uint32_t bit = 1u << irq;
+    uint32_t old_ilr = s->ilr;
+
+    if (level) {
+        uint32_t ena = bit & ~old_ilr;
+        s->ipr |= ena;
+        s->ilr = old_ilr | bit;
+        if (ena & s->imr) {
+            uint32_t iar = (ena & s->icr ? s->iar1 : s->iar0);
+            stl_be_phys(&address_space_memory, iar & -32, iar & 31);
+        }
+    } else {
+        s->ilr = old_ilr & ~bit;
+    }
+}
+
+static int dino_pci_map_irq(PCIDevice *d, int irq_num)
+{
+    int slot = d->devfn >> 3;
+    int local_irq;
+
+    assert(irq_num >= 0 && irq_num <= 3);
+
+    local_irq = slot & 0x03;
+
+    return local_irq;
+}
+
+static void dino_set_timer_irq(void *opaque, int irq, int level)
+{
+    /* ??? Not connected.  */
+}
+
+static void dino_set_serial_irq(void *opaque, int irq, int level)
+{
+    dino_set_irq(opaque, 10, level);
+}
+
+PCIBus *dino_init(MemoryRegion *addr_space,
+                  qemu_irq *p_rtc_irq, qemu_irq *p_ser_irq)
+{
+    DeviceState *dev;
+    DinoState *s;
+    PCIBus *b;
+    int i;
+
+    dev = qdev_create(NULL, TYPE_DINO_PCI_HOST_BRIDGE);
+    s = DINO_PCI_HOST_BRIDGE(dev);
+
+    /* Dino PCI access from main memory.  */
+    memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
+                          s, "dino", 4096);
+    memory_region_add_subregion(addr_space, DINO_HPA, &s->this_mem);
+
+    /* Dino PCI config. */
+    memory_region_init_io(&s->parent_obj.conf_mem, OBJECT(&s->parent_obj),
+                          &pci_host_conf_be_ops, dev, "pci-conf-idx", 4);
+    memory_region_init_io(&s->parent_obj.data_mem, OBJECT(&s->parent_obj),
+                          &dino_config_data_ops, dev, "pci-conf-data", 4);
+    memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
+                                &s->parent_obj.conf_mem);
+    memory_region_add_subregion(&s->this_mem, DINO_CONFIG_DATA,
+                                &s->parent_obj.data_mem);
+
+    /* Dino PCI bus memory.  */
+    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 1ull << 32);
+
+    b = pci_register_bus(dev, "pci",
+                         dino_set_irq, dino_pci_map_irq, s,
+                         &s->pci_mem, get_system_io(),
+                         PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
+    s->parent_obj.bus = b;
+    qdev_init_nofail(dev);
+
+    /* Set up windows into PCI bus memory.  */
+    for (i = 1; i < 31; i++) {
+        uint32_t addr = 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
+        char *name = g_strdup_printf("PCI Outbound Window %d", i);
+        memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
+                                 name, &s->pci_mem, addr,
+                                 DINO_MEM_CHUNK_SIZE);
+    }
+
+    /* Set up PCI view of memory: Bus master address space.  */
+    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 1ull << 32);
+    memory_region_init_alias(&s->bm_ram_alias, OBJECT(s),
+                             "bm-system", addr_space, 0,
+                             0xf0000000 + DINO_MEM_CHUNK_SIZE);
+    memory_region_init_alias(&s->bm_pci_alias, OBJECT(s),
+                             "bm-pci", &s->pci_mem,
+                             0xf0000000 + DINO_MEM_CHUNK_SIZE,
+                             31 * DINO_MEM_CHUNK_SIZE);
+    memory_region_add_subregion(&s->bm, 0,
+                                &s->bm_ram_alias);
+    memory_region_add_subregion(&s->bm,
+                                0xf0000000 + DINO_MEM_CHUNK_SIZE,
+                                &s->bm_pci_alias);
+    address_space_init(&s->bm_as, &s->bm, "pci-bm");
+    pci_setup_iommu(b, dino_pcihost_set_iommu, s);
+
+    *p_rtc_irq = qemu_allocate_irq(dino_set_timer_irq, s, 0);
+    *p_ser_irq = qemu_allocate_irq(dino_set_serial_irq, s, 0);
+
+    return b;
+}
+
+static int dino_pcihost_init(SysBusDevice *dev)
+{
+    return 0;
+}
+
+static void dino_pcihost_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    k->init = dino_pcihost_init;
+    dc->vmsd = &vmstate_dino;
+}
+
+static const TypeInfo dino_pcihost_info = {
+    .name          = TYPE_DINO_PCI_HOST_BRIDGE,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(DinoState),
+    .class_init    = dino_pcihost_class_init,
+};
+
+static void dino_register_types(void)
+{
+    type_register_static(&dino_pcihost_info);
+}
+
+type_init(dino_register_types)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4625e591ea..d491c2aeed 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -1,5 +1,5 @@
 /*
- * QEMU HPPA hardware system emulator.
+ * QEMU HP-PARISC (HPPA) hardware system emulator.
  * Copyright 2017 Helge Deller <deller@gmx.de>
  *
  */
@@ -17,12 +17,222 @@
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
+#include "hw/hppa/hppa_sys.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 
+#define MAX_IDE_BUS 2
+
+static ISABus *hppa_isa_bus(void)
+{
+    ISABus *isa_bus;
+    qemu_irq *isa_irqs;
+    MemoryRegion *isa_region;
+
+    isa_region = g_new(MemoryRegion, 1);
+    memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
+                          NULL, "isa-io", 0x800);
+    memory_region_add_subregion(get_system_memory(), IDE_HPA,
+                                isa_region);
+
+    isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
+                          &error_abort);
+    isa_irqs = i8259_init(isa_bus,
+                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
+                          NULL);
+    isa_bus_irqs(isa_bus, isa_irqs);
+
+    return isa_bus;
+}
+
+static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
+{
+    addr &= (0x10000000 - 1);
+    return addr;
+}
 
 static void machine_hppa_init(MachineState *machine)
 {
+    ram_addr_t ram_size = machine->ram_size;
+    const char *cpu_model
+        = machine->cpu_model ? machine->cpu_model : "hppa1.1";
+    const char *kernel_filename = machine->kernel_filename;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    const char *initrd_filename = machine->initrd_filename;
+    PCIBus *pci_bus;
+    ISABus *isa_bus;
+    qemu_irq rtc_irq, serial_irq;
+    char *firmware_filename;
+    uint64_t firmware_entry, firmware_low, firmware_high;
+    long size;
+    uint64_t kernel_entry = 0, kernel_low, kernel_high;
+    HPPACPU *cpu0;
+    MemoryRegion *addr_space = get_system_memory();
+    MemoryRegion *rom_region;
+    MemoryRegion *ram_region;
+    MemoryRegion *cpu0_region;
+    long i;
+
+    /* Create 1 cpu (for now).  */
+    cpu0 = HPPA_CPU(cpu_generic_init(TYPE_HPPA_CPU, cpu_model));
+
+    cpu0_region = g_new(MemoryRegion, 1);
+    memory_region_init_io(cpu0_region, OBJECT(cpu0), &hppa_io_eir_ops,
+                          cpu0, "cpu0-io-eir", 4);
+    memory_region_add_subregion(addr_space, CPU_HPA, cpu0_region);
+
+    /* Limit main memory. */
+    if (ram_size > FIRMWARE_START) {
+        machine->ram_size = ram_size = FIRMWARE_START;
+    }
+
+    /* Main memory region. */
+    ram_region = g_new(MemoryRegion, 1);
+    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
+                                         "ram", ram_size);
+    memory_region_add_subregion(addr_space, 0, ram_region);
+
+    /* Init Dino (PCI host bus chip).  */
+    pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
+    assert(pci_bus);
+
+    /* Create ISA bus. */
+    isa_bus = hppa_isa_bus();
+    assert(isa_bus);
+
+    /* Realtime clock, used by firmware for PDC_TOD call. */
+    mc146818_rtc_init(isa_bus, 2000, rtc_irq);
+
+    /* Serial code setup.  */
+    if (serial_hds[0]) {
+        uint32_t addr = DINO_UART_HPA + 0x800;
+        serial_mm_init(addr_space, addr, 0, serial_irq,
+                       115200, serial_hds[0], DEVICE_BIG_ENDIAN);
+        fprintf(stderr, "Serial port created at 0x%x\n", addr);
+    }
+
+    /* SCSI disk setup. */
+    lsi53c895a_create(pci_bus);
+
+    /* Network setup.  e1000 is good enough, failing Tulip support.  */
+    for (i = 0; i < nb_nics; i++) {
+        pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+    }
+
+    /* Load firmware.  Given that this is not "real" firmware,
+       but one explicitly written for the emulation, we might as
+       well load it directly from and ELF image.  */
+    firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                       bios_name ? bios_name : "bios.bin");
+    if (firmware_filename == NULL) {
+        error_report("no firmware provided");
+        exit(1);
+    }
+
+    size = load_elf(firmware_filename, NULL,
+                    NULL, &firmware_entry, &firmware_low, &firmware_high,
+                    true, EM_PARISC, 0, 0);
+
+    /* Unfortunately, load_elf sign-extends reading elf32.  */
+    firmware_entry = (target_ureg)firmware_entry;
+    firmware_low = (target_ureg)firmware_low;
+    firmware_high = (target_ureg)firmware_high;
+
+    if (size < 0) {
+        error_report("could not load firmware '%s'", firmware_filename);
+        exit(1);
+    }
+    fprintf(stderr, "Firmware loaded at 0x%08lx-0x%08lx, entry at 0x%08lx.\n",
+            firmware_low, firmware_high, firmware_entry);
+    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
+        error_report("Firmware overlaps with memory or IO space");
+        exit(1);
+    }
+    g_free(firmware_filename);
+
+    rom_region = g_new(MemoryRegion, 1);
+    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
+                                         "firmware",
+                                         (FIRMWARE_END - FIRMWARE_START));
+    memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
+
+    /* Start main cpu at the firmware entry point.  */
+    cpu_set_pc(CPU(cpu0), firmware_entry);
+    /* FIXME: Other CPUs need to start at tight loop */
+
+    /* Load kernel */
+    if (kernel_filename) {
+        fprintf(stderr, "LOADING kernel '%s'\n", kernel_filename);
+        size = load_elf(kernel_filename, &cpu_hppa_to_phys,
+                        NULL, &kernel_entry, &kernel_low, &kernel_high,
+                        true, EM_PARISC, 0, 0);
+
+        /* Unfortunately, load_elf sign-extends reading elf32.  */
+        kernel_entry = (target_ureg) cpu_hppa_to_phys(NULL, kernel_entry);
+        kernel_low = (target_ureg)kernel_low;
+        kernel_high = (target_ureg)kernel_high;
+
+        if (size < 0) {
+            error_report("could not load kernel '%s'", kernel_filename);
+            exit(1);
+        }
+
+        fprintf(stderr, "Kernel loaded at 0x%08lx-0x%08lx, entry at 0x%08lx, "
+                "size %ld kB.\n",
+                kernel_low, kernel_high, kernel_entry, size / 1024);
+
+        if (kernel_cmdline) {
+            cpu0->env.gr[24] = 0x4000;
+            pstrcpy_targphys("cmdline", cpu0->env.gr[24],
+                             TARGET_PAGE_SIZE, kernel_cmdline);
+        }
+
+        if (initrd_filename) {
+            ram_addr_t initrd_base;
+            long initrd_size;
+
+            initrd_size = get_image_size(initrd_filename);
+            if (initrd_size < 0) {
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
+                exit(1);
+            }
+
+            /* Load the initrd image high in memory.
+               Mirror the algorithm used by palo:
+               (1) Due to sign-extension problems and PDC,
+               put the initrd no higher than 1G.
+               (2) Reserve 64k for stack.  */
+            initrd_base = MIN(ram_size, 1024 * 1024 * 1024);
+            initrd_base = initrd_base - 64 * 1024;
+            initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
+
+            if (initrd_base < kernel_high) {
+                error_report("kernel and initial ram disk too large!");
+                exit(1);
+            }
+
+            load_image_targphys(initrd_filename, initrd_base, initrd_size);
+            cpu0->env.gr[23] = initrd_base;
+            cpu0->env.gr[22] = initrd_base + initrd_size;
+        }
+    }
+
+    if (!kernel_entry) {
+        /* When booting via firmware, tell firmware if we want interactive
+         * mode (kernel_entry=1), and to boot from CD (gr[24]='d')
+         * or hard disc * (gr[24]='c').
+         */
+        kernel_entry = boot_menu ? 1 : 0;
+        cpu0->env.gr[24] = machine->boot_order[0];
+    }
+
+    /* We jump to the firmware entry routine and pass the
+     * various parameters in registers. After firmware initialization,
+     * firmware will start the Linux kernel with ramdisk and cmdline.
+     */
+    cpu0->env.gr[26] = ram_size;
+    cpu0->env.gr[25] = kernel_entry;
 }
 
 static void machine_hppa_machine_init(MachineClass *mc)
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
new file mode 100644
index 0000000000..766420254e
--- /dev/null
+++ b/hw/hppa/pci.c
@@ -0,0 +1,90 @@
+/*
+ * QEMU HP-PARISC PCI support functions.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hppa_sys.h"
+#include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
+
+
+/* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
+
+static uint64_t ignore_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void ignore_write(void *opaque, hwaddr addr, uint64_t v, unsigned size)
+{
+}
+
+const MemoryRegionOps hppa_pci_ignore_ops = {
+    .read = ignore_read,
+    .write = ignore_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+
+/* PCI config space reads/writes, to byte-word addressable memory.  */
+static uint64_t bw_conf1_read(void *opaque, hwaddr addr,
+                              unsigned size)
+{
+    PCIBus *b = opaque;
+    return pci_data_read(b, addr, size);
+}
+
+static void bw_conf1_write(void *opaque, hwaddr addr,
+                           uint64_t val, unsigned size)
+{
+    PCIBus *b = opaque;
+    pci_data_write(b, addr, val, size);
+}
+
+const MemoryRegionOps hppa_pci_conf1_ops = {
+    .read = bw_conf1_read,
+    .write = bw_conf1_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/* PCI/EISA Interrupt Acknowledge Cycle.  */
+
+static uint64_t iack_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return pic_read_irq(isa_pic);
+}
+
+static void special_write(void *opaque, hwaddr addr,
+                          uint64_t val, unsigned size)
+{
+    trace_hppa_pci_iack_write();
+}
+
+const MemoryRegionOps hppa_pci_iack_ops = {
+    .read = iack_read,
+    .write = special_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
new file mode 100644
index 0000000000..013e5f046f
--- /dev/null
+++ b/default-configs/hppa-softmmu.mak
@@ -0,0 +1,14 @@
+include pci.mak
+include usb.mak
+CONFIG_SERIAL=y
+CONFIG_SERIAL_ISA=y
+CONFIG_ISA_BUS=y
+CONFIG_I8259=y
+CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
+CONFIG_VIRTIO=y
+CONFIG_E1000_PCI=y
+CONFIG_IDE_ISA=y
+CONFIG_IDE_CMD646=y
+# CONFIG_IDE_MMIO=y
+CONFIG_VIRTIO_VGA=y
+CONFIG_MC146818RTC=y
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
index 46b2ae18de..bef241ed25 100644
--- a/hw/hppa/Makefile.objs
+++ b/hw/hppa/Makefile.objs
@@ -1 +1 @@
-obj-y += machine.o
+obj-y += machine.o pci.o dino.o
diff --git a/hw/hppa/trace-events b/hw/hppa/trace-events
new file mode 100644
index 0000000000..14c67937e1
--- /dev/null
+++ b/hw/hppa/trace-events
@@ -0,0 +1,4 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/hppa/pci.c
+hppa_pci_iack_write(void) ""
-- 
2.14.3
