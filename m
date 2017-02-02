Received: from eggs.gnu.org ([2001:4830:134:3::10]:38236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEW-0003nt-6B
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEU-0004eI-4G
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:48 -0500
Received: from mail.kernel.org ([198.145.29.136]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZMET-0004eD-O1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:45 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu,  2 Feb 2017 10:35:37 -0800
Message-Id: <1486060541-29146-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/5] xen-platform: re-structure unplug_disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, peter.maydell@linaro.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

The current code is poorly structured and potentially leads to multiple
config space reads when one is sufficient. Also the UNPLUG_ALL_IDE_DISKS
flag is mis-named since it also results in SCSI disks being unplugged.

This patch renames the flag and re-structures the code to be more
efficient, and readable.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen_platform.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 2e1e543..f50915f 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -88,7 +88,7 @@ static void log_writeb(PCIXenPlatformState *s, char val)
 }
 
 /* Xen Platform, Fixed IOPort */
-#define UNPLUG_ALL_IDE_DISKS 1
+#define UNPLUG_ALL_DISKS 1
 #define UNPLUG_ALL_NICS 2
 #define UNPLUG_AUX_IDE_DISKS 4
 
@@ -110,14 +110,21 @@ static void pci_unplug_nics(PCIBus *bus)
 static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
 {
     /* We have to ignore passthrough devices */
-    if (pci_get_word(d->config + PCI_CLASS_DEVICE) ==
-            PCI_CLASS_STORAGE_IDE
-            && strcmp(d->name, "xen-pci-passthrough") != 0) {
+    if (!strcmp(d->name, "xen-pci-passthrough")) {
+        return;
+    }
+
+    switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
+    case PCI_CLASS_STORAGE_IDE:
         pci_piix3_xen_ide_unplug(DEVICE(d));
-    } else if (pci_get_word(d->config + PCI_CLASS_DEVICE) ==
-            PCI_CLASS_STORAGE_SCSI
-            && strcmp(d->name, "xen-pci-passthrough") != 0) {
+        break;
+
+    case PCI_CLASS_STORAGE_SCSI:
         object_unparent(OBJECT(d));
+        break;
+
+    default:
+        break;
     }
 }
 
@@ -134,9 +141,9 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
     case 0: {
         PCIDevice *pci_dev = PCI_DEVICE(s);
         /* Unplug devices.  Value is a bitmask of which devices to
-           unplug, with bit 0 the IDE devices, bit 1 the network
+           unplug, with bit 0 the disk devices, bit 1 the network
            devices, and bit 2 the non-primary-master IDE devices. */
-        if (val & UNPLUG_ALL_IDE_DISKS) {
+        if (val & UNPLUG_ALL_DISKS) {
             DPRINTF("unplug disks\n");
             pci_unplug_disks(pci_dev->bus);
         }
-- 
1.9.1
