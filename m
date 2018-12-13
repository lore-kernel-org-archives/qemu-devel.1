Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPP-0005Jb-3K
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPG-0000Pz-60
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPF-000747-So
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:06 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO9-0007KC-Am
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:57 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:29 +0000
Message-Id: <20181213145445.17935-22-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/37] usb/tusb6010: Convert sysbus init
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
tusb6010_class_init().

Cc: kraxel@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Message-id: 20181130093852.20739-20-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/tusb6010.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index a2128024c11..501706e2b29 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -808,10 +808,10 @@ static void tusb6010_reset(DeviceState *dev)
     musb_reset(s->musb);
 }
 
-static int tusb6010_init(SysBusDevice *sbd)
+static void tusb6010_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     TUSBState *s = TUSB(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     s->otg_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_otg_tick, s);
     s->pwr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_power_tick, s);
@@ -822,15 +822,13 @@ static int tusb6010_init(SysBusDevice *sbd)
     sysbus_init_irq(sbd, &s->irq);
     qdev_init_gpio_in(dev, tusb6010_irq, musb_irq_max + 1);
     s->musb = musb_init(dev, 1);
-    return 0;
 }
 
 static void tusb6010_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = tusb6010_init;
+    dc->realize = tusb6010_realize;
     dc->reset = tusb6010_reset;
 }
 
-- 
2.19.2
