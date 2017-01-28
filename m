Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cXMwD-0003rV-LH
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cXMwA-00014W-Gu
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:56:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cXMwA-000143-7u
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:56:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so63313921wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 22:56:36 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sat, 28 Jan 2017 07:56:22 +0100
Message-Id: <1485586582-6490-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH] hw/char/mcf_uart: QOMify the ColdFire UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Use type_init() etc. to adapt the ColdFire UART
to the latest QEMU device conventions.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/char/mcf_uart.c    | 102 +++++++++++++++++++++++++++++++++++++-------------
 hw/m68k/mcf5208.c     |   6 +--
 include/hw/m68k/mcf.h |   6 +--
 3 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index ecaa091..20f0fef 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -7,12 +7,15 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
 #include "sysemu/char.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 
 typedef struct {
+    SysBusDevice parent_obj;
+
     MemoryRegion iomem;
     uint8_t mr[2];
     uint8_t sr;
@@ -30,6 +33,9 @@ typedef struct {
     CharBackend chr;
 } mcf_uart_state;
 
+#define TYPE_MCF_UART "mcf-uart"
+#define MCF_UART(obj) OBJECT_CHECK(mcf_uart_state, (obj), TYPE_MCF_UART)
+
 /* UART Status Register bits.  */
 #define MCF_UART_RxRDY  0x01
 #define MCF_UART_FFULL  0x02
@@ -220,8 +226,10 @@ void mcf_uart_write(void *opaque, hwaddr addr,
     mcf_uart_update(s);
 }
 
-static void mcf_uart_reset(mcf_uart_state *s)
+static void mcf_uart_reset(DeviceState *dev)
 {
+    mcf_uart_state *s = MCF_UART(dev);
+
     s->fifo_len = 0;
     s->mr[0] = 0;
     s->mr[1] = 0;
@@ -275,36 +283,80 @@ static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
     mcf_uart_push_byte(s, buf[0]);
 }
 
-void *mcf_uart_init(qemu_irq irq, CharDriverState *chr)
-{
-    mcf_uart_state *s;
-
-    s = g_malloc0(sizeof(mcf_uart_state));
-    s->irq = irq;
-    if (chr) {
-        qemu_chr_fe_init(&s->chr, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&s->chr, mcf_uart_can_receive,
-                                 mcf_uart_receive, mcf_uart_event,
-                                 s, NULL, true);
-    }
-    mcf_uart_reset(s);
-    return s;
-}
-
 static const MemoryRegionOps mcf_uart_ops = {
     .read = mcf_uart_read,
     .write = mcf_uart_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-void mcf_uart_mm_init(MemoryRegion *sysmem,
-                      hwaddr base,
-                      qemu_irq irq,
-                      CharDriverState *chr)
+static void mcf_uart_instance_init(Object *obj)
+{
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    mcf_uart_state *s = MCF_UART(dev);
+
+    memory_region_init_io(&s->iomem, obj, &mcf_uart_ops, s, "uart", 0x40);
+    sysbus_init_mmio(dev, &s->iomem);
+
+    sysbus_init_irq(dev, &s->irq);
+}
+
+static void mcf_uart_realize(DeviceState *dev, Error **errp)
+{
+    mcf_uart_state *s = MCF_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, mcf_uart_can_receive, mcf_uart_receive,
+                             mcf_uart_event, s, NULL, true);
+}
+
+static Property mcf_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", mcf_uart_state, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void mcf_uart_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = mcf_uart_realize;
+    dc->reset = mcf_uart_reset;
+    dc->props = mcf_uart_properties;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo mcf_uart_info = {
+    .name          = TYPE_MCF_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(mcf_uart_state),
+    .instance_init = mcf_uart_instance_init,
+    .class_init    = mcf_uart_class_init,
+};
+
+static void mcf_uart_register(void)
+{
+    type_register_static(&mcf_uart_info);
+}
+
+type_init(mcf_uart_register)
+
+void *mcf_uart_init(qemu_irq irq, CharDriverState *chrdrv)
+{
+    DeviceState  *dev;
+
+    dev = qdev_create(NULL, TYPE_MCF_UART);
+    if (chrdrv) {
+        qdev_prop_set_chr(dev, "chardev", chrdrv);
+    }
+    qdev_init_nofail(dev);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+
+    return dev;
+}
+
+void mcf_uart_mm_init(hwaddr base, qemu_irq irq, CharDriverState *chrdrv)
 {
-    mcf_uart_state *s;
+    DeviceState  *dev;
 
-    s = mcf_uart_init(irq, chr);
-    memory_region_init_io(&s->iomem, NULL, &mcf_uart_ops, s, "uart", 0x40);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
+    dev = mcf_uart_init(irq, chrdrv);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 }
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index bad1d33..6563518 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -255,9 +255,9 @@ static void mcf5208evb_init(MachineState *machine)
     /* Internal peripherals.  */
     pic = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
 
-    mcf_uart_mm_init(address_space_mem, 0xfc060000, pic[26], serial_hds[0]);
-    mcf_uart_mm_init(address_space_mem, 0xfc064000, pic[27], serial_hds[1]);
-    mcf_uart_mm_init(address_space_mem, 0xfc068000, pic[28], serial_hds[2]);
+    mcf_uart_mm_init(0xfc060000, pic[26], serial_hds[0]);
+    mcf_uart_mm_init(0xfc064000, pic[27], serial_hds[1]);
+    mcf_uart_mm_init(0xfc068000, pic[28], serial_hds[2]);
 
     mcf5208_sys_init(address_space_mem, pic);
 
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index bf43998..0a14b29 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -4,17 +4,13 @@
 
 #include "target/m68k/cpu-qom.h"
 
-struct MemoryRegion;
-
 /* mcf_uart.c */
 uint64_t mcf_uart_read(void *opaque, hwaddr addr,
                        unsigned size);
 void mcf_uart_write(void *opaque, hwaddr addr,
                     uint64_t val, unsigned size);
 void *mcf_uart_init(qemu_irq irq, CharDriverState *chr);
-void mcf_uart_mm_init(struct MemoryRegion *sysmem,
-                      hwaddr base,
-                      qemu_irq irq, CharDriverState *chr);
+void mcf_uart_mm_init(hwaddr base, qemu_irq irq, CharDriverState *chr);
 
 /* mcf_intc.c */
 qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
-- 
2.7.4
