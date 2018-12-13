Received: from eggs.gnu.org ([2001:4830:134:3::10]:35918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOH-0004C1-GW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOG-0007JV-JC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOG-0006zA-Bj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:04 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-0007IK-6p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:21 +0000
Message-Id: <20181213145445.17935-14-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/37] milkymist-hpdmc: Convert sysbus init
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
milkymist_hpdmc_class_init().

Cc: gxt@mprc.pku.edu.cn
Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-12-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/milkymist-hpdmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140eec6ba..44dc0698ec8 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -129,15 +129,13 @@ static void milkymist_hpdmc_reset(DeviceState *d)
                          | IODELAY_PLL2_LOCKED;
 }
 
-static int milkymist_hpdmc_init(SysBusDevice *dev)
+static void milkymist_hpdmc_realize(DeviceState *dev, Error **errp)
 {
     MilkymistHpdmcState *s = MILKYMIST_HPDMC(dev);
 
     memory_region_init_io(&s->regs_region, OBJECT(dev), &hpdmc_mmio_ops, s,
             "milkymist-hpdmc", R_MAX * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->regs_region);
 }
 
 static const VMStateDescription vmstate_milkymist_hpdmc = {
@@ -153,9 +151,8 @@ static const VMStateDescription vmstate_milkymist_hpdmc = {
 static void milkymist_hpdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_hpdmc_init;
+    dc->realize = milkymist_hpdmc_realize;
     dc->reset = milkymist_hpdmc_reset;
     dc->vmsd = &vmstate_milkymist_hpdmc;
 }
-- 
2.19.2
