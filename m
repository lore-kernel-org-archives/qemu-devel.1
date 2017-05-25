Received: from eggs.gnu.org ([2001:4830:134:3::10]:34514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvO-0004EW-Ms
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvJ-0005Q3-Li
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:34 -0400
Received: from m12-15.163.com ([220.181.12.15]:35521)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvI-0005Ow-0N
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:29 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Thu, 25 May 2017 21:34:44 +0800
Message-Id: <20170525133451.22459-2-zxq_yx_007@163.com>
In-Reply-To: <20170525133451.22459-1-zxq_yx_007@163.com>
References: <20170525133451.22459-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/8] hw/misc: QOM'ify eccmemctl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au, f4bug@amsat.org

* Split the old SysBus init into an instance_init and a
  DeviceClass::realize function
* Drop the old SysBus init function and use instance_init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.13.0.rc2.115.g10c78a162
