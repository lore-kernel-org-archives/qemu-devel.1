Received: from eggs.gnu.org ([2001:4830:134:3::10]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1fgQdf-00058j-5p
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1fgQda-0001D0-57
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:19:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1fgQdZ-0001Cw-Qy
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:19:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id e7-v6so10441887wrs.9
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 01:19:41 -0700 (PDT)
From: remy.noel@blade-group.com
Date: Fri, 20 Jul 2018 10:19:48 +0200
Message-Id: <20180720081948.23644-1-remy.noel@blade-group.com>
Subject: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Remy Noel <remy.noel@blade-group.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Remy Noel" <remy.noel@blade-group.com>

When removing a secondary-vga device and then adding it back (or adding
an other one), qemu aborts with:
    "RAMBlock "0000:00:02.0/vga.vram" already registered, abort!".

It is caused by the vram staying registered, preventing vga replugging.

Signed-off-by: Remy Noel <remy.noel@blade-group.com>
---
 hw/display/vga-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index e9e62eac70..1c89571e46 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -288,6 +288,7 @@ static void pci_secondary_vga_exit(PCIDevice *dev)
     VGACommonState *s = &d->vga;
 
     graphic_console_close(s->con);
+    vmstate_unregister_ram(&s->vram, DEVICE(dev));
 }
 
 static void pci_secondary_vga_init(Object *obj)
-- 
2.18.0
