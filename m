Received: from eggs.gnu.org ([2001:4830:134:3::10]:53834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1f0Th0-00022x-V3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1f0Tgz-0000Kl-64
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:05:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1f0Tgz-0000KW-0I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:05:49 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Mon, 26 Mar 2018 17:05:46 +0200
Message-Id: <20180326150546.11324-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv5] dma/i82374: avoid double creation of i82374
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru, agraf@suse.de, ehabkost@redhat.com, thuth@redhat.com

QEMU fails when used with the following command line:

    ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
    qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
    Aborted (core dumped)

The 40p machine type already creates the device i82374. If specified in
the command line, it will try to create it again, hence generating the
error. The function isa_bus_dma() isn't supposed to be called twice for
the same bus. This patch fixes this issue by propagating back the error
so QEMU can fail nicely without Abort or core dump.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
v5:
 * Remove qdev_cleanup_nofail() and call object_property_set_bool() and
   object_unparent() directly.
 * Fix wrong usage of local and global error variables

v4:
 * Change return value from int8_t to int
 * Changed function calling for other architectures.

v3:
 * Removed all unecessary local_err
 * Change return of isa_bus_dma() and DMA_init() from void to int8_t,
   returning -EBUSY on error and 0 on success
 * Added qdev_cleanup_nofail() in case isa_bus_dma() returns error. The
   cleanup looks safe, but please review if I didn't miss any detail

v2:
 * Removed user_creatable=false and replaced by error handling using
   Error **errp and error_propagate();

 hw/dma/i82374.c         |  8 +++++++-
 hw/dma/i8257.c          | 37 +++++++++++++++++++++----------------
 hw/i386/pc.c            |  2 +-
 hw/isa/isa-bus.c        |  8 ++++++--
 hw/mips/mips_fulong2e.c |  2 +-
 hw/mips/mips_jazz.c     |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 include/hw/dma/i8257.h  |  2 +-
 include/hw/isa/isa.h    |  2 +-
 9 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 83c87d92e0..08c06020bf 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/dma/i8257.h"
+#include "qapi/error.h"
 
 #define TYPE_I82374 "i82374"
 #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
@@ -118,13 +119,18 @@ static const MemoryRegionPortio i82374_portio_list[] = {
 static void i82374_realize(DeviceState *dev, Error **errp)
 {
     I82374State *s = I82374(dev);
+    Error *local_err = NULL;
+    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
     portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj),
                     s->iobase);
 
-    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
     memset(s->commands, 0, sizeof(s->commands));
 }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 52675e97c9..e8155cf608 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -622,26 +622,31 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable)
+void i8257_dma_init(ISABus *bus, bool high_page_enable, Error **errp)
 {
     ISADevice *isa1, *isa2;
-    DeviceState *d;
+    DeviceState *d1, *d2;
 
     isa1 = isa_create(bus, TYPE_I8257);
-    d = DEVICE(isa1);
-    qdev_prop_set_int32(d, "base", 0x00);
-    qdev_prop_set_int32(d, "page-base", 0x80);
-    qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x480 : -1);
-    qdev_prop_set_int32(d, "dshift", 0);
-    qdev_init_nofail(d);
+    d1 = DEVICE(isa1);
+    qdev_prop_set_int32(d1, "base", 0x00);
+    qdev_prop_set_int32(d1, "page-base", 0x80);
+    qdev_prop_set_int32(d1, "pageh-base", high_page_enable ? 0x480 : -1);
+    qdev_prop_set_int32(d1, "dshift", 0);
+    qdev_init_nofail(d1);
 
     isa2 = isa_create(bus, TYPE_I8257);
-    d = DEVICE(isa2);
-    qdev_prop_set_int32(d, "base", 0xc0);
-    qdev_prop_set_int32(d, "page-base", 0x88);
-    qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x488 : -1);
-    qdev_prop_set_int32(d, "dshift", 1);
-    qdev_init_nofail(d);
-
-    isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
+    d2 = DEVICE(isa2);
+    qdev_prop_set_int32(d2, "base", 0xc0);
+    qdev_prop_set_int32(d2, "page-base", 0x88);
+    qdev_prop_set_int32(d2, "pageh-base", high_page_enable ? 0x488 : -1);
+    qdev_prop_set_int32(d2, "dshift", 1);
+    qdev_init_nofail(d2);
+
+    if (isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2), errp) < 0) {
+        object_property_set_bool(OBJECT(d1), false, "realized", errp);
+        object_unparent(OBJECT(d1));
+        object_property_set_bool(OBJECT(d2), false, "realized", errp);
+        object_unparent(OBJECT(d2));
+    }
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d36bac8c89..31777a7ed5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1624,7 +1624,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         pcspk_init(isa_bus, pit);
     }
 
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0, &error_fatal);
 
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, no_vmport);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 63fa77effc..8dce35089b 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -104,12 +104,16 @@ void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq)
     qdev_connect_gpio_out(DEVICE(isadev), gpioirq, irq);
 }
 
-void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
+int isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **errp)
 {
     assert(bus && dma8 && dma16);
-    assert(!bus->dma[0] && !bus->dma[1]);
+    if (bus->dma[0] || bus->dma[1]) {
+        error_setg(errp, "DMA already initialized on ISA bus");
+        return -EBUSY;
+    }
     bus->dma[0] = dma8;
     bus->dma[1] = dma16;
+    return 0;
 }
 
 IsaDma *isa_get_dma(ISABus *bus, int nchan)
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 02fb2fdcc4..e98d994f3a 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -243,7 +243,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     isa_bus_irqs(isa_bus, i8259);
     /* init other devices */
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0, &error_fatal);
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7223085547..a1c071e311 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -222,7 +222,7 @@ static void mips_jazz_init(MachineState *machine,
     /* ISA devices */
     i8259 = i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0, &error_fatal);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index f6513a4fd5..7bb9b6071d 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1198,7 +1198,7 @@ void mips_malta_init(MachineState *machine)
     smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
+    i8257_dma_init(isa_bus, 0, &error_fatal);
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
     /* generate SPD EEPROM data */
diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 2cab50bb6c..ad6defbc95 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -44,6 +44,6 @@ typedef struct I8257State {
     PortioList portio_pageh;
 } I8257State;
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable);
+void i8257_dma_init(ISABus *bus, bool high_page_enable, Error **errp);
 
 #endif
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index b9dbab24b4..f152e06e67 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -103,7 +103,7 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs);
 qemu_irq isa_get_irq(ISADevice *dev, int isairq);
 void isa_init_irq(ISADevice *dev, qemu_irq *p, int isairq);
 void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq);
-void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
+int isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **errp);
 IsaDma *isa_get_dma(ISABus *bus, int nchan);
 MemoryRegion *isa_address_space(ISADevice *dev);
 MemoryRegion *isa_address_space_io(ISADevice *dev);
-- 
2.14.3
