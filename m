Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJpG-00020q-2P
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJpC-0005Dh-8S
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:00:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:54764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJpC-0005BZ-1w
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:00:50 -0500
Date: Thu, 19 Jan 2017 23:00:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484859633-24889-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] pci: mark ROMs read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

Looks like we didn't mark PCI ROMs as RO allowing
mischief such as guests writing there.
Further, e.g. vhost gets confused trying to allocate
enough space to log writes there. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 637d545..eaac185 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2199,7 +2199,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
     }
     pdev->has_rom = true;
-    memory_region_init_ram(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
+    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
     vmstate_register_ram(&pdev->rom, &pdev->qdev);
     ptr = memory_region_get_ram_ptr(&pdev->rom);
     load_image(path, ptr);
-- 
MST
