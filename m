Received: from eggs.gnu.org ([2001:4830:134:3::10]:34134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6G-0000SX-OH
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6D-0006fs-Uo
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:36:00 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48804
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIx6D-0006fd-H5
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:57 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 13:35:23 +0000
Message-Id: <1511703326-25325-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/8] sun4u: split IOMMU device out from apb.c
 to sun4u_iommu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

By separating the sun4u IOMMU device into new sun4u_iommu.c and sun4m_iommu.h
files we noticeably simplify apb.c whilst bringing sun4u in line with all the
other IOMMU-supporting architectures.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c              |  273 -------------------------------
 hw/sparc64/Makefile.objs       |    1 +
 hw/sparc64/sun4u.c             |    1 +
 hw/sparc64/sun4u_iommu.c       |  350 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/apb.h      |   57 +------
 include/hw/sparc/sun4u_iommu.h |   50 ++++++
 6 files changed, 403 insertions(+), 329 deletions(-)
 create mode 100644 hw/sparc64/sun4u_iommu.c
 create mode 100644 include/hw/sparc/sun4u_iommu.h

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 7eb5ce0..516dc28 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -49,16 +49,6 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
 #define APB_DPRINTF(fmt, ...)
 #endif
 
-/* debug IOMMU */
-//#define DEBUG_IOMMU
-
-#ifdef DEBUG_IOMMU
-#define IOMMU_DPRINTF(fmt, ...) \
-do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define IOMMU_DPRINTF(fmt, ...)
-#endif
-
 /*
  * Chipset docs:
  * PBM: "UltraSPARC IIi User's Manual",
@@ -136,211 +126,6 @@ static AddressSpace *pbm_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &is->iommu_as;
 }
 
-/* Called from RCU critical section */
-static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
-                                         IOMMUAccessFlags flag)
-{
-    IOMMUState *is = container_of(iommu, IOMMUState, iommu);
-    hwaddr baseaddr, offset;
-    uint64_t tte;
-    uint32_t tsbsize;
-    IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
-        .iova = 0,
-        .translated_addr = 0,
-        .addr_mask = ~(hwaddr)0,
-        .perm = IOMMU_NONE,
-    };
-
-    if (!(is->regs[IOMMU_CTRL >> 3] & IOMMU_CTRL_MMU_EN)) {
-        /* IOMMU disabled, passthrough using standard 8K page */
-        ret.iova = addr & IOMMU_PAGE_MASK_8K;
-        ret.translated_addr = addr;
-        ret.addr_mask = IOMMU_PAGE_MASK_8K;
-        ret.perm = IOMMU_RW;
-
-        return ret;
-    }
-
-    baseaddr = is->regs[IOMMU_BASE >> 3];
-    tsbsize = (is->regs[IOMMU_CTRL >> 3] >> IOMMU_CTRL_TSB_SHIFT) & 0x7;
-
-    if (is->regs[IOMMU_CTRL >> 3] & IOMMU_CTRL_TBW_SIZE) {
-        /* 64K */
-        switch (tsbsize) {
-        case 0:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_64M) >> 13;
-            break;
-        case 1:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_128M) >> 13;
-            break;
-        case 2:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_256M) >> 13;
-            break;
-        case 3:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_512M) >> 13;
-            break;
-        case 4:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_1G) >> 13;
-            break;
-        case 5:
-            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_2G) >> 13;
-            break;
-        default:
-            /* Not implemented, error */
-            return ret;
-        }
-    } else {
-        /* 8K */
-        switch (tsbsize) {
-        case 0:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_8M) >> 10;
-            break;
-        case 1:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_16M) >> 10;
-            break;
-        case 2:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_32M) >> 10;
-            break;
-        case 3:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_64M) >> 10;
-            break;
-        case 4:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_128M) >> 10;
-            break;
-        case 5:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_256M) >> 10;
-            break;
-        case 6:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_512M) >> 10;
-            break;
-        case 7:
-            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_1G) >> 10;
-            break;
-        }
-    }
-
-    tte = address_space_ldq_be(&address_space_memory, baseaddr + offset,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
-
-    if (!(tte & IOMMU_TTE_DATA_V)) {
-        /* Invalid mapping */
-        return ret;
-    }
-
-    if (tte & IOMMU_TTE_DATA_W) {
-        /* Writeable */
-        ret.perm = IOMMU_RW;
-    } else {
-        ret.perm = IOMMU_RO;
-    }
-
-    /* Extract phys */
-    if (tte & IOMMU_TTE_DATA_SIZE) {
-        /* 64K */
-        ret.iova = addr & IOMMU_PAGE_MASK_64K;
-        ret.translated_addr = tte & IOMMU_TTE_PHYS_MASK_64K;
-        ret.addr_mask = (IOMMU_PAGE_SIZE_64K - 1);
-    } else {
-        /* 8K */
-        ret.iova = addr & IOMMU_PAGE_MASK_8K;
-        ret.translated_addr = tte & IOMMU_TTE_PHYS_MASK_8K;
-        ret.addr_mask = (IOMMU_PAGE_SIZE_8K - 1);
-    }
-
-    return ret;
-}
-
-static void iommu_mem_write(void *opaque, hwaddr addr,
-                            uint64_t val, unsigned size)
-{
-    IOMMUState *is = opaque;
-
-    IOMMU_DPRINTF("IOMMU config write: 0x%" HWADDR_PRIx " val: %" PRIx64
-                  " size: %d\n", addr, val, size);
-
-    switch (addr) {
-    case IOMMU_CTRL:
-        if (size == 4) {
-            is->regs[IOMMU_CTRL >> 3] &= 0xffffffffULL;
-            is->regs[IOMMU_CTRL >> 3] |= val << 32;
-        } else {
-            is->regs[IOMMU_CTRL >> 3] = val;
-        }
-        break;
-    case IOMMU_CTRL + 0x4:
-        is->regs[IOMMU_CTRL >> 3] &= 0xffffffff00000000ULL;
-        is->regs[IOMMU_CTRL >> 3] |= val & 0xffffffffULL;
-        break;
-    case IOMMU_BASE:
-        if (size == 4) {
-            is->regs[IOMMU_BASE >> 3] &= 0xffffffffULL;
-            is->regs[IOMMU_BASE >> 3] |= val << 32;
-        } else {
-            is->regs[IOMMU_BASE >> 3] = val;
-        }
-        break;
-    case IOMMU_BASE + 0x4:
-        is->regs[IOMMU_BASE >> 3] &= 0xffffffff00000000ULL;
-        is->regs[IOMMU_BASE >> 3] |= val & 0xffffffffULL;
-        break;
-    case IOMMU_FLUSH:
-    case IOMMU_FLUSH + 0x4:
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP,
-                  "apb iommu: Unimplemented register write "
-                  "reg 0x%" HWADDR_PRIx " size 0x%x value 0x%" PRIx64 "\n",
-                  addr, size, val);
-        break;
-    }
-}
-
-static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
-{
-    IOMMUState *is = opaque;
-    uint64_t val;
-
-    switch (addr) {
-    case IOMMU_CTRL:
-        if (size == 4) {
-            val = is->regs[IOMMU_CTRL >> 3] >> 32;
-        } else {
-            val = is->regs[IOMMU_CTRL >> 3];
-        }
-        break;
-    case IOMMU_CTRL + 0x4:
-        val = is->regs[IOMMU_CTRL >> 3] & 0xffffffffULL;
-        break;
-    case IOMMU_BASE:
-        if (size == 4) {
-            val = is->regs[IOMMU_BASE >> 3] >> 32;
-        } else {
-            val = is->regs[IOMMU_BASE >> 3];
-        }
-        break;
-    case IOMMU_BASE + 0x4:
-        val = is->regs[IOMMU_BASE >> 3] & 0xffffffffULL;
-        break;
-    case IOMMU_FLUSH:
-    case IOMMU_FLUSH + 0x4:
-        val = 0;
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP,
-                      "apb iommu: Unimplemented register read "
-                      "reg 0x%" HWADDR_PRIx " size 0x%x\n",
-                      addr, size);
-        val = 0;
-        break;
-    }
-
-    IOMMU_DPRINTF("IOMMU config read: 0x%" HWADDR_PRIx " val: %" PRIx64
-                  " size: %d\n", addr, val, size);
-
-    return val;
-}
-
 static void apb_config_writel (void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
@@ -806,69 +591,11 @@ static const TypeInfo pbm_pci_bridge_info = {
     },
 };
 
-static const MemoryRegionOps iommu_mem_ops = {
-    .read = iommu_mem_read,
-    .write = iommu_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
-static void iommu_reset(DeviceState *d)
-{
-    IOMMUState *s = SUN4U_IOMMU(d);
-
-    memset(s->regs, 0, IOMMU_NREGS * sizeof(uint64_t));
-}
-
-static void iommu_init(Object *obj)
-{
-    IOMMUState *s = SUN4U_IOMMU(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
-                             TYPE_APB_IOMMU_MEMORY_REGION, OBJECT(s),
-                             "iommu-apb", UINT64_MAX);
-    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "pbm-as");
-
-    memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
-                          IOMMU_NREGS * sizeof(uint64_t));
-    sysbus_init_mmio(sbd, &s->iomem);
-}
-
-static void iommu_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = iommu_reset;
-}
-
-static const TypeInfo pbm_iommu_info = {
-    .name          = TYPE_SUN4U_IOMMU,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(IOMMUState),
-    .instance_init = iommu_init,
-    .class_init    = iommu_class_init,
-};
-
-static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
-{
-    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
-
-    imrc->translate = pbm_translate_iommu;
-}
-
-static const TypeInfo pbm_iommu_memory_region_info = {
-    .parent = TYPE_IOMMU_MEMORY_REGION,
-    .name = TYPE_APB_IOMMU_MEMORY_REGION,
-    .class_init = pbm_iommu_memory_region_class_init,
-};
-
 static void pbm_register_types(void)
 {
     type_register_static(&pbm_host_info);
     type_register_static(&pbm_pci_host_info);
     type_register_static(&pbm_pci_bridge_info);
-    type_register_static(&pbm_iommu_info);
-    type_register_static(&pbm_iommu_memory_region_info);
 }
 
 type_init(pbm_register_types)
diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
index cf9de21..117e0ff 100644
--- a/hw/sparc64/Makefile.objs
+++ b/hw/sparc64/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y += sparc64.o
+obj-y += sun4u_iommu.o
 obj-y += sun4u.o
 obj-y += niagara.o
\ No newline at end of file
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index aaee3de..ec45ec2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_host.h"
 #include "hw/pci-host/apb.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
new file mode 100644
index 0000000..e5aa817
--- /dev/null
+++ b/hw/sparc64/sun4u_iommu.c
@@ -0,0 +1,350 @@
+/*
+ * QEMU sun4u IOMMU emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2012,2013 Artyom Tarasenko
+ * Copyright (c) 2017 Mark Cave-Ayland
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
+#include "hw/sysbus.h"
+#include "hw/sparc/sun4u_iommu.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+/* debug IOMMU */
+//#define DEBUG_IOMMU
+
+#ifdef DEBUG_IOMMU
+#define IOMMU_DPRINTF(fmt, ...) \
+do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define IOMMU_DPRINTF(fmt, ...)
+#endif
+
+
+#define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
+#define IOMMU_PAGE_MASK_8K      (~(IOMMU_PAGE_SIZE_8K - 1))
+#define IOMMU_PAGE_SIZE_64K     (1ULL << 16)
+#define IOMMU_PAGE_MASK_64K     (~(IOMMU_PAGE_SIZE_64K - 1))
+
+#define IOMMU_CTRL              0x0
+#define IOMMU_CTRL_TBW_SIZE     (1ULL << 2)
+#define IOMMU_CTRL_MMU_EN       (1ULL)
+
+#define IOMMU_CTRL_TSB_SHIFT    16
+
+#define IOMMU_BASE              0x8
+#define IOMMU_FLUSH             0x10
+
+#define IOMMU_TTE_DATA_V        (1ULL << 63)
+#define IOMMU_TTE_DATA_SIZE     (1ULL << 61)
+#define IOMMU_TTE_DATA_W        (1ULL << 1)
+
+#define IOMMU_TTE_PHYS_MASK_8K  0x1ffffffe000ULL
+#define IOMMU_TTE_PHYS_MASK_64K 0x1ffffff8000ULL
+
+#define IOMMU_TSB_8K_OFFSET_MASK_8M    0x00000000007fe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_16M   0x0000000000ffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_32M   0x0000000001ffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_64M   0x0000000003ffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_128M  0x0000000007ffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_256M  0x000000000fffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_512M  0x000000001fffe000ULL
+#define IOMMU_TSB_8K_OFFSET_MASK_1G    0x000000003fffe000ULL
+
+#define IOMMU_TSB_64K_OFFSET_MASK_64M  0x0000000003ff0000ULL
+#define IOMMU_TSB_64K_OFFSET_MASK_128M 0x0000000007ff0000ULL
+#define IOMMU_TSB_64K_OFFSET_MASK_256M 0x000000000fff0000ULL
+#define IOMMU_TSB_64K_OFFSET_MASK_512M 0x000000001fff0000ULL
+#define IOMMU_TSB_64K_OFFSET_MASK_1G   0x000000003fff0000ULL
+#define IOMMU_TSB_64K_OFFSET_MASK_2G   0x000000007fff0000ULL
+
+
+/* Called from RCU critical section */
+static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
+                                         IOMMUAccessFlags flag)
+{
+    IOMMUState *is = container_of(iommu, IOMMUState, iommu);
+    hwaddr baseaddr, offset;
+    uint64_t tte;
+    uint32_t tsbsize;
+    IOMMUTLBEntry ret = {
+        .target_as = &address_space_memory,
+        .iova = 0,
+        .translated_addr = 0,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+
+    if (!(is->regs[IOMMU_CTRL >> 3] & IOMMU_CTRL_MMU_EN)) {
+        /* IOMMU disabled, passthrough using standard 8K page */
+        ret.iova = addr & IOMMU_PAGE_MASK_8K;
+        ret.translated_addr = addr;
+        ret.addr_mask = IOMMU_PAGE_MASK_8K;
+        ret.perm = IOMMU_RW;
+
+        return ret;
+    }
+
+    baseaddr = is->regs[IOMMU_BASE >> 3];
+    tsbsize = (is->regs[IOMMU_CTRL >> 3] >> IOMMU_CTRL_TSB_SHIFT) & 0x7;
+
+    if (is->regs[IOMMU_CTRL >> 3] & IOMMU_CTRL_TBW_SIZE) {
+        /* 64K */
+        switch (tsbsize) {
+        case 0:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_64M) >> 13;
+            break;
+        case 1:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_128M) >> 13;
+            break;
+        case 2:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_256M) >> 13;
+            break;
+        case 3:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_512M) >> 13;
+            break;
+        case 4:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_1G) >> 13;
+            break;
+        case 5:
+            offset = (addr & IOMMU_TSB_64K_OFFSET_MASK_2G) >> 13;
+            break;
+        default:
+            /* Not implemented, error */
+            return ret;
+        }
+    } else {
+        /* 8K */
+        switch (tsbsize) {
+        case 0:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_8M) >> 10;
+            break;
+        case 1:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_16M) >> 10;
+            break;
+        case 2:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_32M) >> 10;
+            break;
+        case 3:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_64M) >> 10;
+            break;
+        case 4:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_128M) >> 10;
+            break;
+        case 5:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_256M) >> 10;
+            break;
+        case 6:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_512M) >> 10;
+            break;
+        case 7:
+            offset = (addr & IOMMU_TSB_8K_OFFSET_MASK_1G) >> 10;
+            break;
+        }
+    }
+
+    tte = address_space_ldq_be(&address_space_memory, baseaddr + offset,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
+
+    if (!(tte & IOMMU_TTE_DATA_V)) {
+        /* Invalid mapping */
+        return ret;
+    }
+
+    if (tte & IOMMU_TTE_DATA_W) {
+        /* Writeable */
+        ret.perm = IOMMU_RW;
+    } else {
+        ret.perm = IOMMU_RO;
+    }
+
+    /* Extract phys */
+    if (tte & IOMMU_TTE_DATA_SIZE) {
+        /* 64K */
+        ret.iova = addr & IOMMU_PAGE_MASK_64K;
+        ret.translated_addr = tte & IOMMU_TTE_PHYS_MASK_64K;
+        ret.addr_mask = (IOMMU_PAGE_SIZE_64K - 1);
+    } else {
+        /* 8K */
+        ret.iova = addr & IOMMU_PAGE_MASK_8K;
+        ret.translated_addr = tte & IOMMU_TTE_PHYS_MASK_8K;
+        ret.addr_mask = (IOMMU_PAGE_SIZE_8K - 1);
+    }
+
+    return ret;
+}
+
+static void iommu_mem_write(void *opaque, hwaddr addr,
+                            uint64_t val, unsigned size)
+{
+    IOMMUState *is = opaque;
+
+    IOMMU_DPRINTF("IOMMU config write: 0x%" HWADDR_PRIx " val: %" PRIx64
+                  " size: %d\n", addr, val, size);
+
+    switch (addr) {
+    case IOMMU_CTRL:
+        if (size == 4) {
+            is->regs[IOMMU_CTRL >> 3] &= 0xffffffffULL;
+            is->regs[IOMMU_CTRL >> 3] |= val << 32;
+        } else {
+            is->regs[IOMMU_CTRL >> 3] = val;
+        }
+        break;
+    case IOMMU_CTRL + 0x4:
+        is->regs[IOMMU_CTRL >> 3] &= 0xffffffff00000000ULL;
+        is->regs[IOMMU_CTRL >> 3] |= val & 0xffffffffULL;
+        break;
+    case IOMMU_BASE:
+        if (size == 4) {
+            is->regs[IOMMU_BASE >> 3] &= 0xffffffffULL;
+            is->regs[IOMMU_BASE >> 3] |= val << 32;
+        } else {
+            is->regs[IOMMU_BASE >> 3] = val;
+        }
+        break;
+    case IOMMU_BASE + 0x4:
+        is->regs[IOMMU_BASE >> 3] &= 0xffffffff00000000ULL;
+        is->regs[IOMMU_BASE >> 3] |= val & 0xffffffffULL;
+        break;
+    case IOMMU_FLUSH:
+    case IOMMU_FLUSH + 0x4:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                  "apb iommu: Unimplemented register write "
+                  "reg 0x%" HWADDR_PRIx " size 0x%x value 0x%" PRIx64 "\n",
+                  addr, size, val);
+        break;
+    }
+}
+
+static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IOMMUState *is = opaque;
+    uint64_t val;
+
+    switch (addr) {
+    case IOMMU_CTRL:
+        if (size == 4) {
+            val = is->regs[IOMMU_CTRL >> 3] >> 32;
+        } else {
+            val = is->regs[IOMMU_CTRL >> 3];
+        }
+        break;
+    case IOMMU_CTRL + 0x4:
+        val = is->regs[IOMMU_CTRL >> 3] & 0xffffffffULL;
+        break;
+    case IOMMU_BASE:
+        if (size == 4) {
+            val = is->regs[IOMMU_BASE >> 3] >> 32;
+        } else {
+            val = is->regs[IOMMU_BASE >> 3];
+        }
+        break;
+    case IOMMU_BASE + 0x4:
+        val = is->regs[IOMMU_BASE >> 3] & 0xffffffffULL;
+        break;
+    case IOMMU_FLUSH:
+    case IOMMU_FLUSH + 0x4:
+        val = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "apb iommu: Unimplemented register read "
+                      "reg 0x%" HWADDR_PRIx " size 0x%x\n",
+                      addr, size);
+        val = 0;
+        break;
+    }
+
+    IOMMU_DPRINTF("IOMMU config read: 0x%" HWADDR_PRIx " val: %" PRIx64
+                  " size: %d\n", addr, val, size);
+
+    return val;
+}
+
+static const MemoryRegionOps iommu_mem_ops = {
+    .read = iommu_mem_read,
+    .write = iommu_mem_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void iommu_reset(DeviceState *d)
+{
+    IOMMUState *s = SUN4U_IOMMU(d);
+
+    memset(s->regs, 0, IOMMU_NREGS * sizeof(uint64_t));
+}
+
+static void iommu_init(Object *obj)
+{
+    IOMMUState *s = SUN4U_IOMMU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
+                             TYPE_APB_IOMMU_MEMORY_REGION, OBJECT(s),
+                             "iommu-apb", UINT64_MAX);
+    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "pbm-as");
+
+    memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
+                          IOMMU_NREGS * sizeof(uint64_t));
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void iommu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = iommu_reset;
+}
+
+static const TypeInfo pbm_iommu_info = {
+    .name          = TYPE_SUN4U_IOMMU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IOMMUState),
+    .instance_init = iommu_init,
+    .class_init    = iommu_class_init,
+};
+
+static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate = pbm_translate_iommu;
+}
+
+static const TypeInfo pbm_iommu_memory_region_info = {
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .name = TYPE_APB_IOMMU_MEMORY_REGION,
+    .class_init = pbm_iommu_memory_region_class_init,
+};
+
+static void pbm_register_types(void)
+{
+    type_register_static(&pbm_iommu_info);
+    type_register_static(&pbm_iommu_memory_region_info);
+}
+
+type_init(pbm_register_types)
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 33dbc7a..604d899 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -1,60 +1,7 @@
 #ifndef PCI_HOST_APB_H
 #define PCI_HOST_APB_H
 
-#include "qemu-common.h"
-#include "hw/pci/pci_host.h"
-
-#define IOMMU_NREGS             3
-
-#define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
-#define IOMMU_PAGE_MASK_8K      (~(IOMMU_PAGE_SIZE_8K - 1))
-#define IOMMU_PAGE_SIZE_64K     (1ULL << 16)
-#define IOMMU_PAGE_MASK_64K     (~(IOMMU_PAGE_SIZE_64K - 1))
-
-#define IOMMU_CTRL              0x0
-#define IOMMU_CTRL_TBW_SIZE     (1ULL << 2)
-#define IOMMU_CTRL_MMU_EN       (1ULL)
-
-#define IOMMU_CTRL_TSB_SHIFT    16
-
-#define IOMMU_BASE              0x8
-#define IOMMU_FLUSH             0x10
-
-#define IOMMU_TTE_DATA_V        (1ULL << 63)
-#define IOMMU_TTE_DATA_SIZE     (1ULL << 61)
-#define IOMMU_TTE_DATA_W        (1ULL << 1)
-
-#define IOMMU_TTE_PHYS_MASK_8K  0x1ffffffe000ULL
-#define IOMMU_TTE_PHYS_MASK_64K 0x1ffffff8000ULL
-
-#define IOMMU_TSB_8K_OFFSET_MASK_8M    0x00000000007fe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_16M   0x0000000000ffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_32M   0x0000000001ffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_64M   0x0000000003ffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_128M  0x0000000007ffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_256M  0x000000000fffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_512M  0x000000001fffe000ULL
-#define IOMMU_TSB_8K_OFFSET_MASK_1G    0x000000003fffe000ULL
-
-#define IOMMU_TSB_64K_OFFSET_MASK_64M  0x0000000003ff0000ULL
-#define IOMMU_TSB_64K_OFFSET_MASK_128M 0x0000000007ff0000ULL
-#define IOMMU_TSB_64K_OFFSET_MASK_256M 0x000000000fff0000ULL
-#define IOMMU_TSB_64K_OFFSET_MASK_512M 0x000000001fff0000ULL
-#define IOMMU_TSB_64K_OFFSET_MASK_1G   0x000000003fff0000ULL
-#define IOMMU_TSB_64K_OFFSET_MASK_2G   0x000000007fff0000ULL
-
-typedef struct IOMMUState {
-    SysBusDevice parent_obj;
-
-    AddressSpace iommu_as;
-    IOMMUMemoryRegion iommu;
-
-    MemoryRegion iomem;
-    uint64_t regs[IOMMU_NREGS];
-} IOMMUState;
-
-#define TYPE_SUN4U_IOMMU "sun4u-iommu"
-#define SUN4U_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4U_IOMMU)
+#include "hw/sparc/sun4u_iommu.h"
 
 #define MAX_IVEC 0x40
 
@@ -72,8 +19,6 @@ typedef struct IOMMUState {
 #define APB_DEVICE(obj) \
     OBJECT_CHECK(APBState, (obj), TYPE_APB)
 
-#define TYPE_APB_IOMMU_MEMORY_REGION "pbm-iommu-memory-region"
-
 typedef struct APBState {
     PCIHostState parent_obj;
 
diff --git a/include/hw/sparc/sun4u_iommu.h b/include/hw/sparc/sun4u_iommu.h
new file mode 100644
index 0000000..bc4506b
--- /dev/null
+++ b/include/hw/sparc/sun4u_iommu.h
@@ -0,0 +1,50 @@
+/*
+ * QEMU sun4u IOMMU emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2012,2013 Artyom Tarasenko
+ * Copyright (c) 2017 Mark Cave-Ayland
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
+#ifndef SUN4U_IOMMU_H
+#define SUN4U_IOMMU_H
+
+#include "qemu-common.h"
+#include "hw/sysbus.h"
+
+#define IOMMU_NREGS             3
+
+typedef struct IOMMUState {
+    SysBusDevice parent_obj;
+
+    AddressSpace iommu_as;
+    IOMMUMemoryRegion iommu;
+
+    MemoryRegion iomem;
+    uint64_t regs[IOMMU_NREGS];
+} IOMMUState;
+
+#define TYPE_SUN4U_IOMMU "sun4u-iommu"
+#define SUN4U_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4U_IOMMU)
+
+#define TYPE_APB_IOMMU_MEMORY_REGION "pbm-iommu-memory-region"
+
+#endif
-- 
1.7.10.4
