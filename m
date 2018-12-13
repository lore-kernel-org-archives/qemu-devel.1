Received: from eggs.gnu.org ([2001:4830:134:3::10]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPV-0005Qb-Te
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPV-0000lE-1l
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPU-00071P-QK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:20 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-0007IZ-QA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:22 +0000
Message-Id: <20181213145445.17935-15-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/37] milkymist-pfpu: Convert sysbus init
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
milkymist_pfpu_class_init().

Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-13-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/milkymist-pfpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 86f5e383b0f..4a03c7ee637 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -497,17 +497,16 @@ static void milkymist_pfpu_reset(DeviceState *d)
     }
 }
 
-static int milkymist_pfpu_init(SysBusDevice *dev)
+static void milkymist_pfpu_realize(DeviceState *dev, Error **errp)
 {
     MilkymistPFPUState *s = MILKYMIST_PFPU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->regs_region, OBJECT(dev), &pfpu_mmio_ops, s,
             "milkymist-pfpu", MICROCODE_END * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
+    sysbus_init_mmio(sbd, &s->regs_region);
 }
 
 static const VMStateDescription vmstate_milkymist_pfpu = {
@@ -527,9 +526,8 @@ static const VMStateDescription vmstate_milkymist_pfpu = {
 static void milkymist_pfpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_pfpu_init;
+    dc->realize = milkymist_pfpu_realize;
     dc->reset = milkymist_pfpu_reset;
     dc->vmsd = &vmstate_milkymist_pfpu;
 }
-- 
2.19.2
