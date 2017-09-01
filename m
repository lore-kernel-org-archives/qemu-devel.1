Received: from eggs.gnu.org ([2001:4830:134:3::10]:54942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjnN-0007wp-K5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjnI-0005BC-UI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:07:29 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 13:07:06 +0200
Message-Id: <20170901110706.429-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH] isa-fdc: assert replaced by proper error exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com

When not available, isa-fdc falls into assert instead of proper error
exit. This patch fixes this behavior.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 hw/block/fdc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 401129073b..0b6def4e1d 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2699,11 +2699,15 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     fdctrl->dma_chann = isa->dma;
     if (fdctrl->dma_chann != -1) {
         fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
-        assert(fdctrl->dma);
+        if (!fdctrl->dma) {
+            error_setg(errp, "isa-fdc not supported");
+            goto error;
+        }
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
     fdctrl_realize_common(dev, fdctrl, &err);
+error:
     if (err != NULL) {
         error_propagate(errp, err);
         return;
-- 
2.13.5
