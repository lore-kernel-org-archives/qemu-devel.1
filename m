Received: from eggs.gnu.org ([2001:4830:134:3::10]:43674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5y-0000Td-QX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5x-00070k-F2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58398
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7O5x-0006zg-89
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:53 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 25 Oct 2017 16:59:20 +0100
Message-Id: <1508947167-5304-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv4 06/13] sparc32_dma: use object link instead
 of qdev property to pass IOMMU reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This enables us to remove the last remaining (opaque) qdev property. Whilst we
are here, also update iommu_init() to use TYPE_SUN4M_IOMMU instead of a
hardcoded string.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/sparc32_dma.c |   13 +++++--------
 hw/sparc/sun4m.c     |    4 ++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index ae8fa06..c56a2ba 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -263,24 +263,21 @@ static void sparc32_dma_device_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->iomem);
 
+    object_property_add_link(OBJECT(dev), "iommu", TYPE_SUN4M_IOMMU,
+                             (Object **) &s->iommu,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     qdev_init_gpio_in(dev, dma_set_irq, 1);
     qdev_init_gpio_out(dev, s->gpio, 2);
 }
 
-static Property sparc32_dma_device_properties[] = {
-    DEFINE_PROP_PTR("iommu_opaque", DMADeviceState, iommu),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = sparc32_dma_device_reset;
     dc->vmsd = &vmstate_sparc32_dma_device;
-    dc->props = sparc32_dma_device_properties;
-    /* Reason: pointer property "iommu_opaque" */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo sparc32_dma_device_info = {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 4f2ed4b..12d36b5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -297,7 +297,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "iommu");
+    dev = qdev_create(NULL, TYPE_SUN4M_IOMMU);
     qdev_prop_set_uint32(dev, "version", version);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
@@ -313,7 +313,7 @@ static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
     SysBusDevice *s;
 
     dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
-    qdev_prop_set_ptr(dev, "iommu_opaque", iommu);
+    object_property_set_link(OBJECT(dev), OBJECT(iommu), "iommu", &error_abort);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, daddr);
-- 
1.7.10.4
