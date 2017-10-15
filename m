Received: from eggs.gnu.org ([2001:4830:134:3::10]:48955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWN-0002T1-IO
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWK-0006bP-DE
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWK-0006b6-6o
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:20 -0400
Date: Sun, 15 Oct 2017 06:23:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-12-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/26] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Whilst the underlying PCI bridge implementation supports 32-bit PCI IO
accesses, unfortunately they are truncated at the legacy 64K limit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci_bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 17feae5..a47d257 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
     sec_bus->address_space_io = &br->address_space_io;
-    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io", 65536);
+    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
+                       UINT32_MAX);
     br->windows = pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
-- 
MST
