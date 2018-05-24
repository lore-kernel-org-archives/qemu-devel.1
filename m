Received: from eggs.gnu.org ([2001:4830:134:3::10]:52883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRK-0000Ok-4g
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRE-00030g-2P
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRD-00030M-V6
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C68A4071188
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:55 +0200
Message-Id: <20180524154556.17876-7-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] bochs-display: add pcie support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180522165058.15404-6-kraxel@redhat.com
---
 hw/display/bochs-display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 9607df1c34..c33524b558 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -253,6 +253,7 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
 {
     BochsDisplayState *s = BOCHS_DISPLAY(dev);
     Object *obj = OBJECT(dev);
+    int ret;
 
     s->con = graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_ops, s);
 
@@ -280,6 +281,12 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
     pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
 
+    if (pci_bus_is_express(pci_get_bus(dev))) {
+        dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+        ret = pcie_endpoint_cap_init(dev, 0x80);
+        assert(ret > 0);
+    }
+
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
 }
 
@@ -342,6 +349,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
     .interfaces     = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
-- 
2.9.3
