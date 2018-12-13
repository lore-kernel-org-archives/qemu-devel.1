Received: from eggs.gnu.org ([2001:4830:134:3::10]:36576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPJ-0005Ed-Fj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPI-0000T1-GS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPI-0007J5-7p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:08 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO8-0007Jk-Af
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:27 +0000
Message-Id: <20181213145445.17935-20-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/37] timer/grlib_gptimer: Convert sysbus init
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
grlib_gptimer_class_init().

Cc: chouteau@adacore.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-18-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/grlib_gptimer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e970a7..183eddc0737 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -347,10 +347,11 @@ static void grlib_gptimer_reset(DeviceState *d)
     }
 }
 
-static int grlib_gptimer_init(SysBusDevice *dev)
+static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
 {
     GPTimerUnit  *unit = GRLIB_GPTIMER(dev);
     unsigned int  i;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     assert(unit->nr_timers > 0);
     assert(unit->nr_timers <= GPTIMER_MAX_TIMERS);
@@ -366,7 +367,7 @@ static int grlib_gptimer_init(SysBusDevice *dev)
         timer->id     = i;
 
         /* One IRQ line for each timer */
-        sysbus_init_irq(dev, &timer->irq);
+        sysbus_init_irq(sbd, &timer->irq);
 
         ptimer_set_freq(timer->ptimer, unit->freq_hz);
     }
@@ -375,8 +376,7 @@ static int grlib_gptimer_init(SysBusDevice *dev)
                           unit, "gptimer",
                           UNIT_REG_SIZE + GPTIMER_REG_SIZE * unit->nr_timers);
 
-    sysbus_init_mmio(dev, &unit->iomem);
-    return 0;
+    sysbus_init_mmio(sbd, &unit->iomem);
 }
 
 static Property grlib_gptimer_properties[] = {
@@ -389,9 +389,8 @@ static Property grlib_gptimer_properties[] = {
 static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = grlib_gptimer_init;
+    dc->realize = grlib_gptimer_realize;
     dc->reset = grlib_gptimer_reset;
     dc->props = grlib_gptimer_properties;
 }
-- 
2.19.2
