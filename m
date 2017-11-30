Received: from eggs.gnu.org ([2001:4830:134:3::10]:49127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKb6-0005K0-AV
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKb5-0006uB-EA
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:32 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Nov 2017 09:53:06 +0100
Message-Id: <1512031988-32490-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1512031988-32490-1-git-send-email-thuth@redhat.com>
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 5/7] hw/moxie/moxiesim: Add support
 for loading a BIOS on moxiesim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Edgar Iglesias <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>

The moxiesim machine already defines a memory region for a firmware,
but does not provide the possibility to load an image via "-bios" yet.
This will be needed for the boot-serial tester, so let's add support
for "-bios" here now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/moxie/moxiesim.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 3ba5848..00f56df 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -41,6 +42,8 @@
 #include "elf.h"
 
 #define PHYS_MEM_BASE 0x80000000
+#define FIRMWARE_BASE 0x1000
+#define FIRMWARE_SIZE (128 * 0x1000)
 
 typedef struct {
     uint64_t ram_size;
@@ -123,8 +126,8 @@ static void moxiesim_init(MachineState *machine)
     memory_region_init_ram(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
     memory_region_add_subregion(address_space_mem, ram_base, ram);
 
-    memory_region_init_ram(rom, NULL, "moxie.rom", 128 * 0x1000, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0x1000, rom);
+    memory_region_init_ram(rom, NULL, "moxie.rom", FIRMWARE_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), FIRMWARE_BASE, rom);
 
     if (kernel_filename) {
         loader_params.ram_size = ram_size;
@@ -133,6 +136,11 @@ static void moxiesim_init(MachineState *machine)
         loader_params.initrd_filename = initrd_filename;
         load_kernel(cpu, &loader_params);
     }
+    if (bios_name) {
+        if (load_image_targphys(bios_name, FIRMWARE_BASE, FIRMWARE_SIZE) < 0) {
+            error_report("Failed to load firmware '%s'", bios_name);
+        }
+    }
 
     /* A single 16450 sits at offset 0x3f8.  */
     if (serial_hds[0]) {
-- 
1.8.3.1
