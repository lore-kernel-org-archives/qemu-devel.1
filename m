Received: from eggs.gnu.org ([2001:4830:134:3::10]:52812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMR-0001mo-B8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMO-0002yl-No
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:03 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:00 +0800
Message-Id: <20181119120820.29878-3-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 02/22] block/noenand: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
onenand_class_init().

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: qemu-block@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/block/onenand.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 0cb8d7fa13..6bf89aac1d 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -768,9 +768,8 @@ static const MemoryRegionOps onenand_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int onenand_initfn(SysBusDevice *sbd)
+static void onenand_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     OneNANDState *s = ONE_NAND(dev);
     uint32_t size = 1 << (24 + ((s->id.dev >> 4) & 7));
     void *ram;
@@ -790,14 +789,14 @@ static int onenand_initfn(SysBusDevice *sbd)
                           0xff, size + (size >> 5));
     } else {
         if (blk_is_read_only(s->blk)) {
-            error_report("Can't use a read-only drive");
-            return -1;
+            error_setg(errp, "Can't use a read-only drive");
+            return;
         }
         blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                      BLK_PERM_ALL, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            return -1;
+            error_propagate(errp, local_err);
+            return;
         }
         s->blk_cur = s->blk;
     }
@@ -814,15 +813,14 @@ static int onenand_initfn(SysBusDevice *sbd)
     s->data[1][0] = ram + ((0x0200 + (1 << (PAGE_SHIFT - 1))) << s->shift);
     s->data[1][1] = ram + ((0x8010 + (1 << (PAGE_SHIFT - 6))) << s->shift);
     onenand_mem_setup(s);
-    sysbus_init_irq(sbd, &s->intr);
-    sysbus_init_mmio(sbd, &s->container);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->intr);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container);
     vmstate_register(dev,
                      ((s->shift & 0x7f) << 24)
                      | ((s->id.man & 0xff) << 16)
                      | ((s->id.dev & 0xff) << 8)
                      | (s->id.ver & 0xff),
                      &vmstate_onenand, s);
-    return 0;
 }
 
 static Property onenand_properties[] = {
@@ -837,9 +835,8 @@ static Property onenand_properties[] = {
 static void onenand_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = onenand_initfn;
+    dc->realize = onenand_realize;
     dc->reset = onenand_system_reset;
     dc->props = onenand_properties;
 }
-- 
2.17.1
