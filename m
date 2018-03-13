Received: from eggs.gnu.org ([2001:4830:134:3::10]:50169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqNG-0005ay-Dl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqNF-0003su-Ko
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqNF-0003sI-EM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD97887632
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:18:16 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:18:13 -0600
Message-ID: <20180313201813.2327.55127.stgit@gimli.home>
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 04/11] secondary-vga: properly close QemuConsole
 on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

Using the new graphic_console_close() function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/display/vga-pci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 1674bd3581af..f31293066494 100644
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
