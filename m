Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc2A-0007Wx-6d
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc29-000835-9P
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fhc29-00082M-1v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc28-0007j7-2t
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:41:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:41:51 +0100
Message-Id: <20180723144152.13885-5-peter.maydell@linaro.org>
In-Reply-To: <20180723144152.13885-1-peter.maydell@linaro.org>
References: <20180723144152.13885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/5] hw/arm/spitz: Move problematic nand_init()
 code to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

nand_init() does not only create the NAND device, it also realizes
the device with qdev_init_nofail() already. So we must not call
nand_init() from an instance_init function like sl_nand_init(),
otherwise we get superfluous NAND devices in the QOM tree after
introspecting the 'sl-nand' device. So move the nand_init() to the
realize function of 'sl-nand' instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1532006134-7701-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/spitz.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 3cc27a1e444..c4bc3deedf3 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -169,16 +169,22 @@ static void sl_nand_init(Object *obj)
 {
     SLNANDState *s = SL_NAND(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    DriveInfo *nand;
 
     s->ctl = 0;
+
+    memory_region_init_io(&s->iomem, obj, &sl_ops, s, "sl", 0x40);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void sl_nand_realize(DeviceState *dev, Error **errp)
+{
+    SLNANDState *s = SL_NAND(dev);
+    DriveInfo *nand;
+
     /* FIXME use a qdev drive property instead of drive_get() */
     nand = drive_get(IF_MTD, 0, 0);
     s->nand = nand_init(nand ? blk_by_legacy_dinfo(nand) : NULL,
                         s->manf_id, s->chip_id);
-
-    memory_region_init_io(&s->iomem, obj, &sl_ops, s, "sl", 0x40);
-    sysbus_init_mmio(dev, &s->iomem);
 }
 
 /* Spitz Keyboard */
@@ -1079,6 +1085,7 @@ static void sl_nand_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_sl_nand_info;
     dc->props = sl_nand_properties;
+    dc->realize = sl_nand_realize;
     /* Reason: init() method uses drive_get() */
     dc->user_creatable = false;
 }
-- 
2.17.1
