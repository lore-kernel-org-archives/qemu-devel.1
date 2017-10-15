Received: from eggs.gnu.org ([2001:4830:134:3::10]:37151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3f7X-00020O-0F
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3f7T-0008GT-RP
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:22:07 -0400
Received: from chuckie.co.uk ([82.165.15.123]:37888
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3f7T-0008GD-LP
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:22:03 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 15 Oct 2017 10:21:49 +0100
Message-Id: <1508059309-28458-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] sun4u: fix assert when adding NICs which
 aren't the in-built model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Commit 8d93297 introduced a bug whereby non-inbuilt NICs are realized before
setting the default MAC address causing an assert. Switch NIC creation
over from pci_create_simple() to pci_create() which works exactly the
same except omitting the realize as originally intended.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 2edd1cc..bf89252 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -490,10 +490,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                 memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
                 onboard_nic = true;
             } else {
-                pci_dev = pci_create_simple(pci_busB, -1, "sunhme");
+                pci_dev = pci_create(pci_busB, -1, "sunhme");
             }
         } else {
-            pci_dev = pci_create_simple(pci_busB, -1, nd->model);
+            pci_dev = pci_create(pci_busB, -1, nd->model);
         }
 
         dev = &pci_dev->qdev;
-- 
1.7.10.4
