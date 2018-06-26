Received: from eggs.gnu.org ([2001:4830:134:3::10]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fXjBJ-0006D9-Fb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fXjBF-0004jE-Co
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:18:33 -0400
Received: from steffen-goertz.de ([88.198.119.201]:50960)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fXjBF-0004ij-33
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:18:29 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 26 Jun 2018 10:17:43 +0200
Message-Id: <20180626081743.22097-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] arm: Add NRF51 SOC non-volatile memory controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/nvram/Makefile.objs        |   1 +
 hw/nvram/nrf51_nvmc.c         | 165 ++++++++++++++++++++++++++++++++++
 include/hw/nvram/nrf51_nvmc.h |  52 +++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 hw/nvram/nrf51_nvmc.c
 create mode 100644 include/hw/nvram/nrf51_nvmc.h

diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index a912d25391..9edd61e8af 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -5,3 +5,4 @@ common-obj-y +=3D fw_cfg.o
 common-obj-y +=3D chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
 obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
+obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvmc.o
diff --git a/hw/nvram/nrf51_nvmc.c b/hw/nvram/nrf51_nvmc.c
new file mode 100644
index 0000000000..839d03d9c4
--- /dev/null
+++ b/hw/nvram/nrf51_nvmc.c
@@ -0,0 +1,165 @@
+/*
+ * nrf51_nvmc.c
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/nvram/nrf51_nvmc.h"
+#include "exec/address-spaces.h"
+
+#define NRF51_NVMC_SIZE         0x1000
+
+#define NRF51_NVMC_READY        0x400
+#define NRF51_NVMC_READY_READY  0x01
+#define NRF51_NVMC_CONFIG       0x504
+#define NRF51_NVMC_CONFIG_MASK  0x03
+#define NRF51_NVMC_CONFIG_WEN   0x01
+#define NRF51_NVMC_CONFIG_EEN   0x02
+#define NRF51_NVMC_ERASEPCR1    0x508
+#define NRF51_NVMC_ERASEPCR0    0x510
+#define NRF51_NVMC_ERASEALL     0x50C
+#define NRF51_NVMC_ERASEUICR    0x512
+#define NRF51_NVMC_ERASE        0x01
+
+#define NRF51_UICR_OFFSET       0x10001000UL
+#define NRF51_UICR_SIZE         0x100
+
+static uint64_t io_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    Nrf51NVMCState *s =3D NRF51_NVMC(opaque);
+    uint64_t r =3D 0;
+
+    switch (offset) {
+    case NRF51_NVMC_READY:
+        r =3D NRF51_NVMC_READY_READY;
+        break;
+    case NRF51_NVMC_CONFIG:
+        r =3D s->state.config;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n", __func__, of=
fset);
+    }
+
+    return r;
+}
+
+static void io_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned int size)
+{
+    Nrf51NVMCState *s =3D NRF51_NVMC(opaque);
+
+    switch (offset) {
+    case NRF51_NVMC_CONFIG:
+        s->state.config =3D value & NRF51_NVMC_CONFIG_MASK;
+        break;
+    case NRF51_NVMC_ERASEPCR0:
+    case NRF51_NVMC_ERASEPCR1:
+        value &=3D ~(s->page_size - 1);
+        if (value < (s->code_size * s->page_size)) {
+            address_space_write(&s->as, value, MEMTXATTRS_UNSPECIFIED,
+                    s->empty_page, s->page_size);
+        }
+        break;
+    case NRF51_NVMC_ERASEALL:
+        if (value =3D=3D NRF51_NVMC_ERASE) {
+            for (uint32_t i =3D 0; i < s->code_size; i++) {
+                address_space_write(&s->as, i * s->page_size,
+                MEMTXATTRS_UNSPECIFIED, s->empty_page, s->page_size);
+            }
+            address_space_write(&s->as, NRF51_UICR_OFFSET,
+            MEMTXATTRS_UNSPECIFIED, s->empty_page, NRF51_UICR_SIZE);
+        }
+        break;
+    case NRF51_NVMC_ERASEUICR:
+        if (value =3D=3D NRF51_NVMC_ERASE) {
+            address_space_write(&s->as, NRF51_UICR_OFFSET,
+            MEMTXATTRS_UNSPECIFIED, s->empty_page, NRF51_UICR_SIZE);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad write offset 0x%" HWADDR_PRIx "\n", __func__, o=
ffset);
+    }
+}
+
+static const MemoryRegionOps io_ops =3D { .read =3D io_read, .write =3D =
io_write,
+        .endianness =3D DEVICE_LITTLE_ENDIAN, };
+
+static void nrf51_nvmc_init(Object *obj)
+{
+    Nrf51NVMCState *s =3D NRF51_NVMC(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &io_ops, s,
+    TYPE_NRF51_NVMC, NRF51_NVMC_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void nrf51_nvmc_realize(DeviceState *dev, Error **errp)
+{
+    Nrf51NVMCState *s =3D NRF51_NVMC(dev);
+
+    if (!s->mr) {
+        error_setg(errp, "memory property was not set");
+        return;
+    }
+
+    if (s->page_size < NRF51_UICR_SIZE) {
+        error_setg(errp, "page size too small");
+        return;
+    }
+
+    s->empty_page =3D g_malloc(s->page_size);
+    memset(s->empty_page, 0xFF, s->page_size);
+
+    address_space_init(&s->as, s->mr, "system-memory");
+}
+
+static void nrf51_nvmc_unrealize(DeviceState *dev, Error **errp)
+{
+    Nrf51NVMCState *s =3D NRF51_NVMC(dev);
+
+    g_free(s->empty_page);
+    s->empty_page =3D NULL;
+
+}
+
+static Property nrf51_nvmc_properties[] =3D {
+    DEFINE_PROP_UINT16("page_size", Nrf51NVMCState, page_size, 0x400),
+    DEFINE_PROP_UINT32("code_size", Nrf51NVMCState, code_size, 0x100),
+    DEFINE_PROP_LINK("memory", Nrf51NVMCState, mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nrf51_nvmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D nrf51_nvmc_properties;
+    dc->realize =3D nrf51_nvmc_realize;
+    dc->unrealize =3D nrf51_nvmc_unrealize;
+}
+
+static const TypeInfo nrf51_nvmc_info =3D {
+    .name =3D TYPE_NRF51_NVMC,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(Nrf51NVMCState),
+    .instance_init =3D nrf51_nvmc_init,
+    .class_init =3D nrf51_nvmc_class_init
+};
+
+static void nrf51_nvmc_register_types(void)
+{
+    type_register_static(&nrf51_nvmc_info);
+}
+
+type_init(nrf51_nvmc_register_types)
diff --git a/include/hw/nvram/nrf51_nvmc.h b/include/hw/nvram/nrf51_nvmc.=
h
new file mode 100644
index 0000000000..dfd500b14e
--- /dev/null
+++ b/include/hw/nvram/nrf51_nvmc.h
@@ -0,0 +1,52 @@
+/*
+ * nrf51_nvmc.h
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * See Nrf51 reference manual 6 Non-Volatile Memory Controller (NVMC)
+ * See Nrf51 product sheet 8.22 NVMC specifications
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: Memory Region with registers
+ *   to be mapped to the peripherals instance address by the SOC.
+ * + page_size property to set the page size in bytes.
+ * + code_size property to set the code size in number of pages.
+ *
+ * Accuracy of the peripheral model:
+ * + The NVMC is always ready, all requested erase operations succeed
+ *   immediately.
+ * + CONFIG.WEN and CONFIG.EEN flags can be written and read back
+ *   but are not evaluated to check whether a requested write/erase oper=
ation
+ *   is legal.
+ * + Code regions (MPU configuration) are disregarded.
+ */
+#ifndef NRF51_NVMC_H
+#define NRF51_NVMC_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#define TYPE_NRF51_NVMC "nrf51_soc.nvmc"
+#define NRF51_NVMC(obj) OBJECT_CHECK(Nrf51NVMCState, (obj), TYPE_NRF51_N=
VMC)
+
+typedef struct Nrf51NVMCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t code_size;
+    uint16_t page_size;
+    uint8_t *empty_page;
+    MemoryRegion *mr;
+    AddressSpace as;
+
+    struct {
+        uint32_t config:2;
+    } state;
+
+} Nrf51NVMCState;
+
+
+#endif
--=20
2.17.1
