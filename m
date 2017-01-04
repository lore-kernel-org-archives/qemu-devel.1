Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOn87-0005X4-Dg
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOn84-0001dm-8j
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:05:31 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jan 2017 16:05:25 +0100
Message-Id: <20170104150525.4246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] pci-assign: avoid pointless stat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Just check the errno value after fopen and follow it with fstat.
This shuts up Coverity's complaint about TOC/TOU violation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pci-assign-load-rom.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pci-assign-load-rom.c b/hw/i386/pci-assign-load-rom.c
index 0d8e4b2..fd59076 100644
--- a/hw/i386/pci-assign-load-rom.c
+++ b/hw/i386/pci-assign-load-rom.c
@@ -39,19 +39,19 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
              "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/rom",
              domain, bus, slot, function);
 
-    if (stat(rom_file, &st)) {
-        if (errno != ENOENT) {
-            error_report("pci-assign: Invalid ROM.");
-        }
-        return NULL;
-    }
-
     /* Write "1" to the ROM file to enable it */
     fp = fopen(rom_file, "r+");
     if (fp == NULL) {
-        error_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
+        if (errno != ENOENT) {
+            error_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
+        }
         return NULL;
     }
+    if (fstat(fileno(fp), &st) == -1) {
+        error_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
+        goto close_rom;
+    }
+
     val = 1;
     if (fwrite(&val, 1, 1, fp) != 1) {
         goto close_rom;
-- 
2.9.3
