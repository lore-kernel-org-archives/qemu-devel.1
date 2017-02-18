Received: from eggs.gnu.org ([2001:4830:134:3::10]:54206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk9-0001sF-7G
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk5-0007CS-V4
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cfEk5-0007CB-Op
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so8403277wmu.2
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 15:48:41 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 19 Feb 2017 00:48:32 +0100
Message-Id: <1487461713-23092-3-git-send-email-huth@tuxfamily.org>
In-Reply-To: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
References: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PULL 2/3] hw/m68k: QOMify the ColdFire interrupt
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Use type_init() and friends to adapt the ColdFire interrupt
controller to the latest QEMU device conventions.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf_intc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index cf58132..8198afa 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -9,10 +9,16 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
 #include "exec/address-spaces.h"
 
+#define TYPE_MCF_INTC "mcf-intc"
+#define MCF_INTC(obj) OBJECT_CHECK(mcf_intc_state, (obj), TYPE_MCF_INTC)
+
 typedef struct {
+    SysBusDevice parent_obj;
+
     MemoryRegion iomem;
     uint64_t ipr;
     uint64_t imr;
@@ -138,8 +144,10 @@ static void mcf_intc_set_irq(void *opaque, int irq, int level)
     mcf_intc_update(s);
 }
 
-static void mcf_intc_reset(mcf_intc_state *s)
+static void mcf_intc_reset(DeviceState *dev)
 {
+    mcf_intc_state *s = MCF_INTC(dev);
+
     s->imr = ~0ull;
     s->ipr = 0;
     s->ifr = 0;
@@ -154,17 +162,49 @@ static const MemoryRegionOps mcf_intc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void mcf_intc_instance_init(Object *obj)
+{
+    mcf_intc_state *s = MCF_INTC(obj);
+
+    memory_region_init_io(&s->iomem, obj, &mcf_intc_ops, s, "mcf", 0x100);
+}
+
+static void mcf_intc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->reset = mcf_intc_reset;
+}
+
+static const TypeInfo mcf_intc_gate_info = {
+    .name          = TYPE_MCF_INTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(mcf_intc_state),
+    .instance_init = mcf_intc_instance_init,
+    .class_init    = mcf_intc_class_init,
+};
+
+static void mcf_intc_register_types(void)
+{
+    type_register_static(&mcf_intc_gate_info);
+}
+
+type_init(mcf_intc_register_types)
+
 qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
                         hwaddr base,
                         M68kCPU *cpu)
 {
+    DeviceState  *dev;
     mcf_intc_state *s;
 
-    s = g_malloc0(sizeof(mcf_intc_state));
+    dev = qdev_create(NULL, TYPE_MCF_INTC);
+    qdev_init_nofail(dev);
+
+    s = MCF_INTC(dev);
     s->cpu = cpu;
-    mcf_intc_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &mcf_intc_ops, s, "mcf", 0x100);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     return qemu_allocate_irqs(mcf_intc_set_irq, s, 64);
-- 
2.7.4
