Received: from eggs.gnu.org ([2001:4830:134:3::10]:38822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXotx-000744-E0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXotu-0006D6-UQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:29 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dXotu-0006Cn-NK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:26 -0400
Received: by mail-lf0-x242.google.com with SMTP id l200so915557lfb.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:20:26 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 19 Jul 2017 16:20:14 +0300
Message-Id: <1500470414-7911-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] pci: enable RedHat pci bridges to
 reserve more buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, marcel@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

In case of RedHat PCI bridges reserve additional buses, which number is provided
in a vendor-specific capability.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/pciinit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 08221e6..b6f3a01 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -578,9 +578,17 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
         pci_bios_init_bus_rec(secbus, pci_bus);
 
         if (subbus != *pci_bus) {
+            u16 vendor = pci_config_readw(bdf, PCI_VENDOR_ID);
+            u8 res_bus = 0;
+            if (vendor == 0x1b36) {
+                u8 cap = pci_find_capability_bdf(bdf, PCI_CAP_ID_VNDR, 0);
+                if (cap) {
+                    res_bus = pci_config_readb(bdf, cap + 16);
+                }
+            }
             dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
-                    subbus, *pci_bus);
-            subbus = *pci_bus;
+                    subbus, *pci_bus + res_bus);
+            subbus = *pci_bus + res_bus;
         } else {
             dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
         }
-- 
2.7.4
