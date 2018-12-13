Received: from eggs.gnu.org ([2001:4830:134:3::10]:35739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO3-0003wH-7h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO2-00070x-98
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO1-0006w2-VW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO0-0007Fr-3W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:12 +0000
Message-Id: <20181213145445.17935-5-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/37] block/noenand: Convert sysbus init
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
onenand_class_init().

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: qemu-block@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-3-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/onenand.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 2b48609776d..f11118a6876 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -772,9 +772,9 @@ static const MemoryRegionOps onenand_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int onenand_initfn(SysBusDevice *sbd)
+static void onenand_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     OneNANDState *s = ONE_NAND(dev);
     uint32_t size = 1 << (24 + ((s->id.dev >> 4) & 7));
     void *ram;
@@ -794,14 +794,14 @@ static int onenand_initfn(SysBusDevice *sbd)
                           0xff, size + (size >> 5));
     } else {
         if (blk_is_read_only(s->blk)) {
-            error_report("Can't use a read-only drive");
-            return -1;
+            error_setg(errp, "Can't use a read-only drive");
+            return;
         }
         blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                      BLK_PERM_ALL, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            return -1;
+            error_propagate(errp, local_err);
+            return;
         }
         s->blk_cur = s->blk;
     }
@@ -826,7 +826,6 @@ static int onenand_initfn(SysBusDevice *sbd)
                      | ((s->id.dev & 0xff) << 8)
                      | (s->id.ver & 0xff),
                      &vmstate_onenand, s);
-    return 0;
 }
 
 static Property onenand_properties[] = {
@@ -841,9 +840,8 @@ static Property onenand_properties[] = {
 static void onenand_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = onenand_initfn;
+    dc->realize = onenand_realize;
     dc->reset = onenand_system_reset;
     dc->props = onenand_properties;
 }
-- 
2.19.2
