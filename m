Received: from eggs.gnu.org ([209.51.188.92]:37872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthl-0003zf-Nl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthk-0006u1-Op
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggthk-0006lm-GQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 16:53:54 +0100
Message-Id: <20190108155354.8591-6-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-1-kraxel@redhat.com>
References: <20190108155354.8591-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] usb: move ehci_create_ich9_with_companions
 to hw/i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This function is only needed when Q35 is in use.  Moving it to
the same file that uses it lets you disable the entire USB
subsystem in x86_64-softmmu.mak; of course doing that will
cause -usb to break horribly, but one thing at a time.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1545064358-4601-1-git-send-email-pbonzini@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/usb.h      |  2 --
 hw/i386/pc_q35.c      | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ehci-pci.c | 53 ---------------------------------------------------
 3 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index a5080adecc..4961405fa0 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -593,8 +593,6 @@ const char *usb_device_get_product_desc(USBDevice *dev);
 
 const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
 
-int ehci_create_ich9_with_companions(PCIBus *bus, int slot);
-
 /* quirks.c */
 
 /* In bulk endpoints are streaming data sources (iow behave like isoc eps) */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0a3f3f18e4..f8efae8236 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -58,6 +58,59 @@
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
 
+struct ehci_companions {
+    const char *name;
+    int func;
+    int port;
+};
+
+static const struct ehci_companions ich9_1d[] = {
+    { .name = "ich9-usb-uhci1", .func = 0, .port = 0 },
+    { .name = "ich9-usb-uhci2", .func = 1, .port = 2 },
+    { .name = "ich9-usb-uhci3", .func = 2, .port = 4 },
+};
+
+static const struct ehci_companions ich9_1a[] = {
+    { .name = "ich9-usb-uhci4", .func = 0, .port = 0 },
+    { .name = "ich9-usb-uhci5", .func = 1, .port = 2 },
+    { .name = "ich9-usb-uhci6", .func = 2, .port = 4 },
+};
+
+static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
+{
+    const struct ehci_companions *comp;
+    PCIDevice *ehci, *uhci;
+    BusState *usbbus;
+    const char *name;
+    int i;
+
+    switch (slot) {
+    case 0x1d:
+        name = "ich9-usb-ehci1";
+        comp = ich9_1d;
+        break;
+    case 0x1a:
+        name = "ich9-usb-ehci2";
+        comp = ich9_1a;
+        break;
+    default:
+        return -1;
+    }
+
+    ehci = pci_create_multifunction(bus, PCI_DEVFN(slot, 7), true, name);
+    qdev_init_nofail(&ehci->qdev);
+    usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
+
+    for (i = 0; i < 3; i++) {
+        uhci = pci_create_multifunction(bus, PCI_DEVFN(slot, comp[i].func),
+                                        true, comp[i].name);
+        qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
+        qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
+        qdev_init_nofail(&uhci->qdev);
+    }
+    return 0;
+}
+
 /* PC hardware initialisation */
 static void pc_q35_init(MachineState *machine)
 {
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 8c0fc53a26..69abbf7b7b 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -230,56 +230,3 @@ static void ehci_pci_register_types(void)
 }
 
 type_init(ehci_pci_register_types)
-
-struct ehci_companions {
-    const char *name;
-    int func;
-    int port;
-};
-
-static const struct ehci_companions ich9_1d[] = {
-    { .name = "ich9-usb-uhci1", .func = 0, .port = 0 },
-    { .name = "ich9-usb-uhci2", .func = 1, .port = 2 },
-    { .name = "ich9-usb-uhci3", .func = 2, .port = 4 },
-};
-
-static const struct ehci_companions ich9_1a[] = {
-    { .name = "ich9-usb-uhci4", .func = 0, .port = 0 },
-    { .name = "ich9-usb-uhci5", .func = 1, .port = 2 },
-    { .name = "ich9-usb-uhci6", .func = 2, .port = 4 },
-};
-
-int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
-{
-    const struct ehci_companions *comp;
-    PCIDevice *ehci, *uhci;
-    BusState *usbbus;
-    const char *name;
-    int i;
-
-    switch (slot) {
-    case 0x1d:
-        name = "ich9-usb-ehci1";
-        comp = ich9_1d;
-        break;
-    case 0x1a:
-        name = "ich9-usb-ehci2";
-        comp = ich9_1a;
-        break;
-    default:
-        return -1;
-    }
-
-    ehci = pci_create_multifunction(bus, PCI_DEVFN(slot, 7), true, name);
-    qdev_init_nofail(&ehci->qdev);
-    usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
-
-    for (i = 0; i < 3; i++) {
-        uhci = pci_create_multifunction(bus, PCI_DEVFN(slot, comp[i].func),
-                                        true, comp[i].name);
-        qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
-        qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
-        qdev_init_nofail(&uhci->qdev);
-    }
-    return 0;
-}
-- 
2.9.3
