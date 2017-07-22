Received: from eggs.gnu.org ([2001:4830:134:3::10]:59941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dG-0000RZ-Cr
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2dF-0006ly-Kg
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:18 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2dF-0006li-Da
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:12:17 -0400
Received: by mail-lf0-x241.google.com with SMTP id t128so758265lff.3
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:12:17 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:11:50 +0300
Message-Id: <1500761510-1556-5-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 4/4] pci: enable RedHat PCI bridges to
 reserve additional buses on PCI init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

In case of Red Hat PCI bridges reserve additional buses, which number is provided
in a vendor-specific capability. 

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/pciinit.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 864954f..f05a8b9 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -15,6 +15,7 @@
 #include "hw/pcidevice.h" // pci_probe_devices
 #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
 #include "hw/pci_regs.h" // PCI_COMMAND
+#include "hw/pci_cap.h" // qemu_pci_cap
 #include "list.h" // struct hlist_node
 #include "malloc.h" // free
 #include "output.h" // dprintf
@@ -578,9 +579,18 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
         pci_bios_init_bus_rec(secbus, pci_bus);
 
         if (subbus != *pci_bus) {
+            u8 res_bus = 0;
+            if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT) {
+                u8 cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
+                if (cap) {
+                    res_bus = pci_config_readb(bdf,
+                            cap + offsetof(struct redhat_pci_bridge_cap,
+                                           bus_res));
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
