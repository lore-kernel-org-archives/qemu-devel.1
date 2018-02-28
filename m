Received: from eggs.gnu.org ([2001:4830:134:3::10]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0tQ-0002bw-Pu
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0tL-0000aM-4j
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:31:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1er0tK-0000Zg-U2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:31:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 28 Feb 2018 13:31:06 +0100
Message-Id: <20180228123110.6507-6-kraxel@redhat.com>
In-Reply-To: <20180228123110.6507-1-kraxel@redhat.com>
References: <20180228123110.6507-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v6 5/9] secondary-vga: properly close
 QemuConsole on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

Using the new graphic_console_close() function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 1674bd3581..f312930664 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -292,6 +292,14 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
 }
 
+static void pci_secondary_vga_exit(PCIDevice *dev)
+{
+    PCIVGAState *d = PCI_VGA(dev);
+    VGACommonState *s = &d->vga;
+
+    graphic_console_close(s->con);
+}
+
 static void pci_secondary_vga_init(Object *obj)
 {
     /* Expose framebuffer byteorder via QOM */
@@ -361,6 +369,7 @@ static void secondary_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_secondary_vga_realize;
+    k->exit = pci_secondary_vga_exit;
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
     dc->props = secondary_pci_properties;
     dc->reset = pci_secondary_vga_reset;
-- 
2.9.3
