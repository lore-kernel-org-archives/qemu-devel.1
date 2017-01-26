Received: from eggs.gnu.org ([2001:4830:134:3::10]:36826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUm-0005fo-PQ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUj-0003SJ-VU
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:32 -0500
Received: from smtp.citrix.com ([66.165.176.89]:20876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUj-0003QA-PP
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:29 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 26 Jan 2017 09:37:23 +0000
Message-ID: <1485423445-12302-2-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
References: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/3] xen-platform: re-structure unplug_disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

The current code is poorly structured and potentially leads to multiple
config space reads when one is sufficient. Also the UNPLUG_ALL_IDE_DISKS
flag is mis-named since it also results in SCSI disks being unplugged.

This patch renames the flag and re-structures the code to be more
efficient, and readable.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

v2:
- Fix style issue
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
2.1.4
