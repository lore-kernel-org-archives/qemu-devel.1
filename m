Received: from eggs.gnu.org ([2001:4830:134:3::10]:57512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEmR-0000ax-JU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEmQ-0007g4-KI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:51 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:38803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEmQ-0007eJ-Ct
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:34:50 -0400
Received: by mail-lf0-x241.google.com with SMTP id y15so11398907lfd.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:34:50 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:34:32 +0300
Message-Id: <1501284872-2078-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
References: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/3] pci: enable RedHat PCI bridges to
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
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

In case of Red Hat Generic PCIE Root Port reserve additional buses,
which number is provided in a vendor-specific capability.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/pciinit.c | 37 +++++++++++++++++++++++++++++++++++--
 src/hw/pci_ids.h |  3 +++
 src/types.h      |  2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 864954f..a302a85 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -15,6 +15,7 @@
 #include "hw/pcidevice.h" // pci_probe_devices
 #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
 #include "hw/pci_regs.h" // PCI_COMMAND
+#include "fw/dev-pci.h" // qemu_pci_cap
 #include "list.h" // struct hlist_node
 #include "malloc.h" // free
 #include "output.h" // dprintf
@@ -578,9 +579,41 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
         pci_bios_init_bus_rec(secbus, pci_bus);
 
         if (subbus != *pci_bus) {
+            u8 res_bus = 0;
+            if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
+                    pci_config_readw(bdf, PCI_DEVICE_ID) ==
+                            PCI_DEVICE_ID_REDHAT_ROOT_PORT) {
+                u8 cap;
+                do {
+                    cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
+                } while (cap &&
+                         pci_config_readb(bdf, cap + PCI_CAP_VNDR_SPEC_TYPE) !=
+                                REDHAT_CAP_TYPE_QEMU);
+                if (cap) {
+                    u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
+                    if (cap_len != QEMU_PCI_CAP_SIZE) {
+                        dprintf(1, "PCI: QEMU cap length %d is invalid\n",
+                                cap_len);
+                    } else {
+                        res_bus = pci_config_readb(bdf,
+                                                   cap + QEMU_PCI_CAP_BUS_RES);
+                        if ((u8)(res_bus + secbus) < secbus ||
+                            (u8)(res_bus + secbus) < res_bus) {
+                            dprintf(1, "PCI: bus_reserve value %d is invalid\n",
+                                    res_bus);
+                            res_bus = 0;
+                        } else {
+                            dprintf(1, "PCI: QEMU cap is found, value = %u\n",
+                                    res_bus);
+                        }
+                    }
+                }
+                res_bus = MAX(*pci_bus, secbus + res_bus);
+            }
             dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
-                    subbus, *pci_bus);
-            subbus = *pci_bus;
+                    subbus, res_bus);
+            subbus = res_bus;
+            *pci_bus = res_bus;
         } else {
             dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
         }
diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
index 4ac73b4..38fa2ca 100644
--- a/src/hw/pci_ids.h
+++ b/src/hw/pci_ids.h
@@ -2263,6 +2263,9 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
 #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
 
+#define PCI_VENDOR_ID_REDHAT		0x1b36
+#define PCI_DEVICE_ID_REDHAT_ROOT_PORT	0x000C
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
diff --git a/src/types.h b/src/types.h
index 19d9f6c..75d9108 100644
--- a/src/types.h
+++ b/src/types.h
@@ -122,6 +122,8 @@ extern void __force_link_error__only_in_16bit(void) __noreturn;
             typeof(divisor) __divisor = divisor;        \
             (((x) + ((__divisor) / 2)) / (__divisor));  \
         })
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
 #define ALIGN(x,a)              __ALIGN_MASK(x,(typeof(x))(a)-1)
 #define __ALIGN_MASK(x,mask)    (((x)+(mask))&~(mask))
 #define ALIGN_DOWN(x,a)         ((x) & ~((typeof(x))(a)-1))
-- 
2.7.4
