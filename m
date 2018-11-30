Received: from eggs.gnu.org ([2001:4830:134:3::10]:38525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0006B2-Oq
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGg-0002U1-PC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:29 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:55473)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGf-0002Nr-P5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:26 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:41 +0800
Message-Id: <20181130093852.20739-11-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/21] intc/puv3_intc: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
puv3_intc_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/intc/puv3_intc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488aacc..69ddc8c19a 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -101,10 +101,10 @@ static const MemoryRegionOps puv3_intc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_intc_init(SysBusDevice *sbd)
+static void puv3_intc_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     PUV3INTCState *s = PUV3_INTC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     qdev_init_gpio_in(dev, puv3_intc_handler, PUV3_IRQS_NR);
     sysbus_init_irq(sbd, &s->parent_irq);
@@ -115,15 +115,12 @@ static int puv3_intc_init(SysBusDevice *sbd)
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_intc_ops, s, "puv3_intc",
                           PUV3_REGS_OFFSET);
     sysbus_init_mmio(sbd, &s->iomem);
-
-    return 0;
 }
 
 static void puv3_intc_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
-
-    sdc->init = puv3_intc_init;
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = puv3_intc_realize;
 }
 
 static const TypeInfo puv3_intc_info = {
-- 
2.17.1
