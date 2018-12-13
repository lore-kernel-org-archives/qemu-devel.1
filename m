Received: from eggs.gnu.org ([2001:4830:134:3::10]:35804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-0003zs-8T
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO3-000724-03
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO2-0006zA-Ld
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO1-0007Ge-NC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:15 +0000
Message-Id: <20181213145445.17935-8-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/37] display/g364fb: Convert sysbus init
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
g364fb_sysbus_class_init().

Cc: pbonzini@redhat.com
Cc: kraxel@redhat.com
Cc: f4bug@amsat.org
Cc: alistair.francis@wdc.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-6-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/g364fb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 8ad7e5d8242..3407adf98d2 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -489,18 +489,16 @@ typedef struct {
     G364State g364;
 } G364SysBusState;
 
-static int g364fb_sysbus_init(SysBusDevice *sbd)
+static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     G364SysBusState *sbs = G364(dev);
     G364State *s = &sbs->g364;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     g364fb_init(dev, s);
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->mem_ctrl);
     sysbus_init_mmio(sbd, &s->mem_vram);
-
-    return 0;
 }
 
 static void g364fb_sysbus_reset(DeviceState *d)
@@ -518,9 +516,8 @@ static Property g364fb_sysbus_properties[] = {
 static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = g364fb_sysbus_init;
+    dc->realize = g364fb_sysbus_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "G364 framebuffer";
     dc->reset = g364fb_sysbus_reset;
-- 
2.19.2
