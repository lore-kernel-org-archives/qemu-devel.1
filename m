Received: from eggs.gnu.org ([2001:4830:134:3::10]:35783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO4-0003z7-JJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO3-00072y-DW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO3-0006w2-30
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO1-0007GM-65
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:14 +0000
Message-Id: <20181213145445.17935-7-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/37] core/empty_slot: Convert sysbus init
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
empty_slot_class_init().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-5-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/empty_slot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index c1b9c2b1041..239f78e2a77 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -71,21 +71,20 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
     }
 }
 
-static int empty_slot_init1(SysBusDevice *dev)
+static void empty_slot_realize(DeviceState *dev, Error **errp)
 {
     EmptySlot *s = EMPTY_SLOT(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
                           "empty-slot", s->size);
-    sysbus_init_mmio(dev, &s->iomem);
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void empty_slot_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = empty_slot_init1;
+    dc->realize = empty_slot_realize;
 }
 
 static const TypeInfo empty_slot_info = {
-- 
2.19.2
