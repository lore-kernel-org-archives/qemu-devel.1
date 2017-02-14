Received: from eggs.gnu.org ([2001:4830:134:3::10]:44066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cdXtn-0002qU-NL
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cdXti-0000vO-QK
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:51:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cdXti-0000v9-KQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:51:38 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B960FC0567B2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:51:38 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 14 Feb 2017 15:51:32 +0800
Message-Id: <1487058692-2789-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] pcie: simplify pcie_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com

When we add PCIe extended capabilities, we should be following the rule
that we add the head extended cap (at offset 0x100) first, then the rest
of them. Meanwhile, we are always adding new capability bits at the end
of the list. Here the "next" looks meaningless in all cases since it
should always be zero (along with the "header").

Simplify the function a bit, and it looks more readable now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pcie.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index cbd4bb4..e0e6f6a 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -664,30 +664,23 @@ void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size)
 {
-    uint32_t header;
-    uint16_t next;
-
     assert(offset >= PCI_CONFIG_SPACE_SIZE);
     assert(offset < offset + size);
     assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);
     assert(size >= 8);
     assert(pci_is_express(dev));
 
-    if (offset == PCI_CONFIG_SPACE_SIZE) {
-        header = pci_get_long(dev->config + offset);
-        next = PCI_EXT_CAP_NEXT(header);
-    } else {
+    if (offset != PCI_CONFIG_SPACE_SIZE) {
         uint16_t prev;
 
         /* 0 is reserved cap id. use internally to find the last capability
            in the linked list */
-        next = pcie_find_capability_list(dev, 0, &prev);
-
+        assert(pcie_find_capability_list(dev, 0, &prev) == 0);
         assert(prev >= PCI_CONFIG_SPACE_SIZE);
-        assert(next == 0);
         pcie_ext_cap_set_next(dev, prev, offset);
     }
-    pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, next));
+
+    pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, 0));
 
     /* Make capability read-only by default */
     memset(dev->wmask + offset, 0, size);
-- 
2.7.4
