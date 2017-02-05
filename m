Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Aq-3Z
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003HV-Ur
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60842)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Em-At
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:19 +0800
Message-Id: <20170205133727.23424-2-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 1/9] hw/misc: QOM'ify eccmemctl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

* Split the old SysBus init into an instance_init and a
  DeviceClass::realize function
* Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/misc/eccmemctl.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index a0071f3eae..bb7cc52b5e 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -295,22 +295,29 @@ static void ecc_reset(DeviceState *d)
     s->regs[ECC_ECR1] = 0;
 }
 
-static int ecc_init1(SysBusDevice *dev)
+static void ecc_init(Object *obj)
 {
-    ECCState *s = ECC_MEMCTL(dev);
+    ECCState *s = ECC_MEMCTL(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(dev, &s->irq);
-    s->regs[0] = s->version;
-    memory_region_init_io(&s->iomem, OBJECT(dev), &ecc_mem_ops, s, "ecc", ECC_SIZE);
+
+    memory_region_init_io(&s->iomem, obj, &ecc_mem_ops, s, "ecc", ECC_SIZE);
     sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void ecc_realize(DeviceState *dev, Error **errp)
+{
+    ECCState *s = ECC_MEMCTL(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    s->regs[0] = s->version;
 
     if (s->version == ECC_MCC) { // SS-600MP only
         memory_region_init_io(&s->iomem_diag, OBJECT(dev), &ecc_diag_mem_ops, s,
                               "ecc.diag", ECC_DIAG_SIZE);
-        sysbus_init_mmio(dev, &s->iomem_diag);
+        sysbus_init_mmio(sbd, &s->iomem_diag);
     }
-
-    return 0;
 }
 
 static Property ecc_properties[] = {
@@ -321,9 +328,8 @@ static Property ecc_properties[] = {
 static void ecc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = ecc_init1;
+    dc->realize = ecc_realize;
     dc->reset = ecc_reset;
     dc->vmsd = &vmstate_ecc;
     dc->props = ecc_properties;
@@ -333,6 +339,7 @@ static const TypeInfo ecc_info = {
     .name          = TYPE_ECC_MEMCTL,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ECCState),
+    .instance_init = ecc_init,
     .class_init    = ecc_class_init,
 };
 
-- 
2.11.0
