Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1g7Jsl-0001Ej-1z
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1g7JeP-0001ht-Tw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:19:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1g7JeP-0001hb-NT
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:19:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id b19-v6so2027007wme.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 05:19:41 -0700 (PDT)
From: remy.noel@blade-group.com
Date: Tue,  2 Oct 2018 14:19:35 +0200
Message-Id: <20181002121935.23706-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] secondary-vga: delete mmio subregions upon
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
Cc: "remy.noel" <remy.noel@blade-group.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "remy.noel" <remy.noel@blade-group.com>

93abfc88bd649de1933588bfc7175605331b3ea9 introduced a reference cycle in
the vga-pci devices, preventing cleanup of the object upon hotblug.

This patch allows to break the cycle.

Signed-off-by: remy.noel <remy.noel@blade-group.com>
---
 hw/display/vga-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 24ca1b3e1f..a68f014c9f 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -309,6 +309,11 @@ static void pci_secondary_vga_exit(PCIDevice *dev)
     VGACommonState *s = &d->vga;
 
     graphic_console_close(s->con);
+    memory_region_del_subregion(&d->mmio, &d->mrs[0]);
+    memory_region_del_subregion(&d->mmio, &d->mrs[1]);
+    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
+        memory_region_del_subregion(&d->mmio, &d->mrs[2]);
+    }
 }
 
 static void pci_secondary_vga_init(Object *obj)
-- 
2.19.0
