Received: from eggs.gnu.org ([2001:4830:134:3::10]:38076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cOrge-0005No-Rp
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cOrga-0005i6-Mi
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cOrga-0005hV-H4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9304C3D94D
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 19:57:24 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  4 Jan 2017 21:57:15 +0200
Message-Id: <1483559838-8797-2-git-send-email-marcel@redhat.com>
In-Reply-To: <1483559838-8797-1-git-send-email-marcel@redhat.com>
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] hw/pcie: fix Extended Configuration Space
 for devices with no Extended Capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, yvugenfi@redhat.com

Absence of any Extended Capabilities is required to be
indicated by an Extended Capability header with a Capability ID of
0000h, a Capability Version of 0h, and a Next Capability Offset of 000h.

Instead of inserting a 'NULL' capability is simpler to mark the start
of the Extended Configuration Space as read-only to achieve the same
behaviour.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 99cfb45..62c1def 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -109,6 +109,9 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
                  PCI_EXP_DEVCAP2_EFF | PCI_EXP_DEVCAP2_EETLPP);
 
     pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
+
+    /* read-only to behave like a 'NULL' Extended Capability Header */
+    pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
     return pos;
 }
 
-- 
2.5.5
