Received: from eggs.gnu.org ([2001:4830:134:3::10]:35253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XR-000442-Bb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007RY-Ij
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007Np-7C
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id n1-v6so5502724wrt.10
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:39 +0200
Message-Id: <20181001220942.2382-13-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/15] hw/core: Remove the 'empty_slot' device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

All previous users of TYPE_EMPTY_SLOT now use TYPE_UNIMPLEMENTED_DEVICE.

Since TYPE_EMPTY_SLOT is no more used/referenced, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/empty_slot.h |   7 ---
 hw/core/empty_slot.c    | 103 ----------------------------------------
 hw/core/Makefile.objs   |   1 -
 3 files changed, 111 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 delete mode 100644 hw/core/empty_slot.c

diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
deleted file mode 100644
index 123a9f8989..0000000000
--- a/include/hw/empty_slot.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef HW_EMPTY_SLOT_H
-#define HW_EMPTY_SLOT_H
-
-/* empty_slot.c */
-void empty_slot_init(hwaddr addr, uint64_t slot_size);
-
-#endif
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
deleted file mode 100644
index c1b9c2b104..0000000000
--- a/hw/core/empty_slot.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * QEMU Empty Slot
- *
- * The empty_slot device emulates known to a bus but not connected devices.
- *
- * Copyright (c) 2010 Artyom Tarasenko
- *
- * This code is licensed under the GNU GPL v2 or (at your option) any later
- * version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/sysbus.h"
-#include "hw/empty_slot.h"
-
-//#define DEBUG_EMPTY_SLOT
-
-#ifdef DEBUG_EMPTY_SLOT
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("empty_slot: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
-
-#define TYPE_EMPTY_SLOT "empty_slot"
-#define EMPTY_SLOT(obj) OBJECT_CHECK(EmptySlot, (obj), TYPE_EMPTY_SLOT)
-
-typedef struct EmptySlot {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint64_t size;
-} EmptySlot;
-
-static uint64_t empty_slot_read(void *opaque, hwaddr addr,
-                                unsigned size)
-{
-    DPRINTF("read from " TARGET_FMT_plx "\n", addr);
-    return 0;
-}
-
-static void empty_slot_write(void *opaque, hwaddr addr,
-                             uint64_t val, unsigned size)
-{
-    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
-}
-
-static const MemoryRegionOps empty_slot_ops = {
-    .read = empty_slot_read,
-    .write = empty_slot_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-void empty_slot_init(hwaddr addr, uint64_t slot_size)
-{
-    if (slot_size > 0) {
-        /* Only empty slots larger than 0 byte need handling. */
-        DeviceState *dev;
-        SysBusDevice *s;
-        EmptySlot *e;
-
-        dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
-        s = SYS_BUS_DEVICE(dev);
-        e = EMPTY_SLOT(dev);
-        e->size = slot_size;
-
-        qdev_init_nofail(dev);
-
-        sysbus_mmio_map(s, 0, addr);
-    }
-}
-
-static int empty_slot_init1(SysBusDevice *dev)
-{
-    EmptySlot *s = EMPTY_SLOT(dev);
-
-    memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
-                          "empty-slot", s->size);
-    sysbus_init_mmio(dev, &s->iomem);
-    return 0;
-}
-
-static void empty_slot_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init = empty_slot_init1;
-}
-
-static const TypeInfo empty_slot_info = {
-    .name          = TYPE_EMPTY_SLOT,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(EmptySlot),
-    .class_init    = empty_slot_class_init,
-};
-
-static void empty_slot_register_types(void)
-{
-    type_register_static(&empty_slot_info);
-}
-
-type_init(empty_slot_register_types)
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca979e..fd75172a21 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -8,7 +8,6 @@ common-obj-y += irq.o
 common-obj-y += hotplug.o
 common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
-common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
-- 
2.19.0
