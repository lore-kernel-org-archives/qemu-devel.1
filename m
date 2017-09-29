Received: from eggs.gnu.org ([2001:4830:134:3::10]:34746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxvvP-0003Zw-4E
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxvvJ-00012w-Vq
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:05:55 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 29 Sep 2017 16:05:40 +0200
Message-Id: <20170929140540.13766-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv2] dma/i82374: avoid double creation of i82374
 device
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, ehabkost@redhat.com, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com
List-ID: <qemu-devel.nongnu.org>

v2:
    Removed user_creatable=false and replaced by error handling using
    Error **errp and error_propagate();

QEMU fails when used with the following command line:

    ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
    qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
    Aborted (core dumped)

The 40p machine type already creates the device i82374. If specified in the
command line, it will try to create it again, hence generating the error. The
function isa_bus_dma() isn't supposed to be called twice for the same bus. One
way to avoid this problem is to set user_creatable=false.

A possible fix in a near future would be making
isa_bus_dma()/DMA_init()/i82374_realize() return an error instead of asserting
as well.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 hw/dma/i82374.c      | 7 +++++--
 hw/dma/i8257.c       | 7 +++++--
 hw/isa/isa-bus.c     | 9 +++++++--
 include/hw/isa/isa.h | 4 ++--
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975df0..385a42cb57 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 
 #define TYPE_I82374 "i82374"
 #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
@@ -117,14 +118,16 @@ static const MemoryRegionPortio i82374_portio_list[] = {
 static void i82374_realize(DeviceState *dev, Error **errp)
 {
     I82374State *s = I82374(dev);
+    Error *local_err = NULL;
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
     portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj),
                     s->iobase);
 
-    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
+    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1, &local_err);
     memset(s->commands, 0, sizeof(s->commands));
+    error_propagate(errp, local_err);
 }
 
 static Property i82374_properties[] = {
@@ -135,7 +138,7 @@ static Property i82374_properties[] = {
 static void i82374_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    
+
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     dc->props = i82374_properties;
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e893bf..94b1ae7533 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -27,6 +27,7 @@
 #include "hw/isa/i8257.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 #define I8257(obj) \
     OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
@@ -622,10 +623,11 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void DMA_init(ISABus *bus, int high_page_enable)
+void DMA_init(ISABus *bus, int high_page_enable, Error **errp)
 {
     ISADevice *isa1, *isa2;
     DeviceState *d;
+    Error *local_err = NULL;
 
     isa1 = isa_create(bus, TYPE_I8257);
     d = DEVICE(isa1);
@@ -643,5 +645,6 @@ void DMA_init(ISABus *bus, int high_page_enable)
     qdev_prop_set_int32(d, "dshift", 1);
     qdev_init_nofail(d);
 
-    isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
+    isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2), &local_err);
+    error_propagate(errp, local_err);
 }
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0eab9d..aa7d8de856 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -104,12 +104,17 @@ void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq)
     qdev_connect_gpio_out(DEVICE(isadev), gpioirq, irq);
 }
 
-void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
+void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **errp)
 {
+    Error *local_err = NULL;
     assert(bus && dma8 && dma16);
-    assert(!bus->dma[0] && !bus->dma[1]);
+    if (bus->dma[0] && bus->dma[1]) {
+        error_setg(errp, "isa dma device i82374 already created");
+        return;
+    }
     bus->dma[0] = dma8;
     bus->dma[1] = dma16;
+    error_propagate(errp, local_err);
 }
 
 IsaDma *isa_get_dma(ISABus *bus, int nchan)
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 95593408ef..5cf4ceaf39 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -103,7 +103,7 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs);
 qemu_irq isa_get_irq(ISADevice *dev, int isairq);
 void isa_init_irq(ISADevice *dev, qemu_irq *p, int isairq);
 void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq);
-void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
+void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **errp);
 IsaDma *isa_get_dma(ISABus *bus, int nchan);
 MemoryRegion *isa_address_space(ISADevice *dev);
 MemoryRegion *isa_address_space_io(ISADevice *dev);
@@ -152,5 +152,5 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)
 }
 
 /* i8257.c */
-void DMA_init(ISABus *bus, int high_page_enable);
+void DMA_init(ISABus *bus, int high_page_enable, Error **errp);
 #endif
-- 
2.13.5
