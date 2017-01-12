Received: from eggs.gnu.org ([2001:4830:134:3::10]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkA-0003A1-2r
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk7-0006hc-U2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:04 +1100
Message-Id: <20170112020327.24882-45-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 44/67] hw/ppc: QOM'ify ppce500_spin.c
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

Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppce500_spin.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index cf958a9..958536f 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -54,9 +54,9 @@ typedef struct SpinState {
     SpinInfo spin[MAX_CPUS];
 } SpinState;
 
-static void spin_reset(void *opaque)
+static void spin_reset(DeviceState *dev)
 {
-    SpinState *s = opaque;
+    SpinState *s = E500_SPIN(dev);
     int i;
 
     for (i = 0; i < MAX_CPUS; i++) {
@@ -174,30 +174,28 @@ static const MemoryRegionOps spin_rw_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static int ppce500_spin_initfn(SysBusDevice *dev)
+static void ppce500_spin_initfn(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     SpinState *s = E500_SPIN(dev);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &spin_rw_ops, s,
+    memory_region_init_io(&s->iomem, obj, &spin_rw_ops, s,
                           "e500 spin pv device", sizeof(SpinInfo) * MAX_CPUS);
     sysbus_init_mmio(dev, &s->iomem);
-
-    qemu_register_reset(spin_reset, s);
-
-    return 0;
 }
 
 static void ppce500_spin_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = ppce500_spin_initfn;
+    dc->reset = spin_reset;
 }
 
 static const TypeInfo ppce500_spin_info = {
     .name          = TYPE_E500_SPIN,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SpinState),
+    .instance_init = ppce500_spin_initfn,
     .class_init    = ppce500_spin_class_init,
 };
 
-- 
2.9.3
