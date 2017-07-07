Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTR-0005qW-TW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTR-00043y-6N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTQ-00040L-VX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:55 +0100
Message-Id: <1499438577-7674-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/11] hw/pci/pci.c: Use
 memory_region_init_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Since we pass the same DeviceState object to
memory_region_init_rom_nomigrate() and vmstate_register_ram(), we can
switch to using memory_region_init_rom() instead.

(This isn't entirely obvious from the code since it is using
&pdev->qdev rather than DEVICE(pdov) for some reason, but
PCIDevice does indeed use 'qdev' for its parent DeviceState member.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e73279a..258fbe5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2235,8 +2235,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
     }
     pdev->has_rom = true;
-    memory_region_init_rom_nomigrate(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
-    vmstate_register_ram(&pdev->rom, &pdev->qdev);
+    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
     ptr = memory_region_get_ram_ptr(&pdev->rom);
     load_image(path, ptr);
     g_free(path);
-- 
2.7.4
