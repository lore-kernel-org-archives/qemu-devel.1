Received: from eggs.gnu.org ([2001:4830:134:3::10]:58715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ5-0004mj-ST
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ3-0005EO-KY
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:31:01 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:26250)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQDQ2-00056H-Rh
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:30:59 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 23:30:30 +0800
Message-Id: <20181123153040.18933-12-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/21] milkymist-hpdmc: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, gxt@mprc.pku.edu.cn, michael@walle.cc, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
milkymist_hpdmc_class_init().

Cc: gxt@mprc.pku.edu.cn
Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/misc/milkymist-hpdmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140eec6b..44dc0698ec 100644
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
2.17.1
