Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1e-00036m-Ln
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1b-0003pt-0Q
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8O1a-0003oz-QO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 13:11:56 +0200
Message-Id: <20181005111157.12801-4-kraxel@redhat.com>
In-Reply-To: <20181005111157.12801-1-kraxel@redhat.com>
References: <20181005111157.12801-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] secondary-vga: delete mmio subregions upon
 exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "remy.noel" <remy.noel@blade-group.com>

From: "remy.noel" <remy.noel@blade-group.com>

93abfc88bd649de1933588bfc7175605331b3ea9 introduced a reference cycle in
the vga-pci devices, preventing cleanup of the object upon hotblug.

This patch allows to break the cycle.

Signed-off-by: remy.noel <remy.noel@blade-group.com>
Message-id: 20181002121935.23706-1-remy.noel@blade-group.com

[ kraxel: delete the recently added edid region too ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga-pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 24ca1b3e1f..a17c96e703 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -309,6 +309,14 @@ static void pci_secondary_vga_exit(PCIDevice *dev)
     VGACommonState *s = &d->vga;
 
     graphic_console_close(s->con);
+    memory_region_del_subregion(&d->mmio, &d->mrs[0]);
+    memory_region_del_subregion(&d->mmio, &d->mrs[1]);
+    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
+        memory_region_del_subregion(&d->mmio, &d->mrs[2]);
+    }
+    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_EDID)) {
+        memory_region_del_subregion(&d->mmio, &d->mrs[3]);
+    }
 }
 
 static void pci_secondary_vga_init(Object *obj)
-- 
2.9.3
