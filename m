Received: from eggs.gnu.org ([2001:4830:134:3::10]:46584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk6-000357-RM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk4-0006di-Fk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:02 +1100
Message-Id: <20170112020327.24882-43-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 42/67] hw/gpio: QOM'ify mpc8xxx.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, xiaoqiang zhao <zxq_yx_007@163.com>, David Gibson <david@gibson.dropbear.id.au>

From: xiaoqiang zhao <zxq_yx_007@163.com>

* Drop the old SysBus init function and use instance_init
* Change mpc8xxx_gpio_reset to a DeviceClass::reset function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/gpio/mpc8xxx.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index d149719..e12edb4 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -143,8 +143,10 @@ static void mpc8xxx_gpio_write(void *opaque, hwaddr offset,
     mpc8xxx_gpio_update(s);
 }
 
-static void mpc8xxx_gpio_reset(MPC8XXXGPIOState *s)
+static void mpc8xxx_gpio_reset(DeviceState *dev)
 {
+    MPC8XXXGPIOState *s = MPC8XXX_GPIO(dev);
+
     s->dir = 0;
     s->odr = 0;
     s->dat = 0;
@@ -180,33 +182,33 @@ static const MemoryRegionOps mpc8xxx_gpio_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static int mpc8xxx_gpio_initfn(SysBusDevice *sbd)
+static void mpc8xxx_gpio_initfn(Object *obj)
 {
-    DeviceState *dev = DEVICE(sbd);
-    MPC8XXXGPIOState *s = MPC8XXX_GPIO(dev);
+    DeviceState *dev = DEVICE(obj);
+    MPC8XXXGPIOState *s = MPC8XXX_GPIO(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &mpc8xxx_gpio_ops, s, "mpc8xxx_gpio", 0x1000);
+    memory_region_init_io(&s->iomem, obj, &mpc8xxx_gpio_ops,
+                          s, "mpc8xxx_gpio", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
     qdev_init_gpio_in(dev, mpc8xxx_gpio_set_irq, 32);
     qdev_init_gpio_out(dev, s->out, 32);
-    mpc8xxx_gpio_reset(s);
-    return 0;
 }
 
 static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = mpc8xxx_gpio_initfn;
     dc->vmsd = &vmstate_mpc8xxx_gpio;
+    dc->reset = mpc8xxx_gpio_reset;
 }
 
 static const TypeInfo mpc8xxx_gpio_info = {
     .name          = TYPE_MPC8XXX_GPIO,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MPC8XXXGPIOState),
+    .instance_init = mpc8xxx_gpio_initfn,
     .class_init    = mpc8xxx_gpio_class_init,
 };
 
-- 
2.9.3
