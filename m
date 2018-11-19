Received: from eggs.gnu.org ([2001:4830:134:3::10]:52713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mb-42
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiML-0002uG-PP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:51681)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMK-0002p1-V0
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:57 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:02 +0800
Message-Id: <20181119120820.29878-5-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 04/22] core/empty_slot: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
empty_slot_class_init().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/core/empty_slot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index c1b9c2b104..239f78e2a7 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -71,21 +71,20 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
     }
 }
 
-static int empty_slot_init1(SysBusDevice *dev)
+static void empty_slot_realize(DeviceState *dev, Error **errp)
 {
     EmptySlot *s = EMPTY_SLOT(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
                           "empty-slot", s->size);
-    sysbus_init_mmio(dev, &s->iomem);
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void empty_slot_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = empty_slot_init1;
+    dc->realize = empty_slot_realize;
 }
 
 static const TypeInfo empty_slot_info = {
-- 
2.17.1
