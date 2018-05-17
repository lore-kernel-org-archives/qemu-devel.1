Received: from eggs.gnu.org ([2001:4830:134:3::10]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJFA1-0006Ol-Iz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJF9w-0004We-8e
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJF9w-0004W1-47
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EF2FBB422
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:25:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 May 2018 11:25:13 +0200
Message-Id: <20180517092513.735-5-kraxel@redhat.com>
In-Reply-To: <20180517092513.735-1-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] bochs-display: add pcie support
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
---
 hw/display/bochs-display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 9ea6f798f4..23dbf57b8f 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -254,6 +254,7 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
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
 
@@ -341,6 +348,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
     .interfaces     = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
-- 
2.9.3
