Received: from eggs.gnu.org ([2001:4830:134:3::10]:38527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0006B4-Ox
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGg-0002U8-Ph
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:29 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:33 +0800
Message-Id: <20181130093852.20739-3-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/21] block/noenand: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
onenand_class_init().

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: qemu-block@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/onenand.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 2b48609776..f11118a687 100644
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
2.17.1
