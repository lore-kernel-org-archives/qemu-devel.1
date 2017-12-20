Received: from eggs.gnu.org ([2001:4830:134:3::10]:56400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyK-0004dc-I8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyJ-0007Eq-J6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:00 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyJ-0007ED-At
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:59 -0500
Received: by mail-wm0-x241.google.com with SMTP id i11so11095013wmf.4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:34 +0100
Message-Id: <1513790098-9815-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/46] hw/moxie/moxiesim: Add support for
 loading a BIOS on moxiesim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The moxiesim machine already defines a memory region for a firmware,
but does not provide the possibility to load an image via "-bios" yet.
This will be needed for the boot-serial tester, so let's add support
for "-bios" here now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-6-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/moxie/moxiesim.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 3c3ba9d..6c200be 100644
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
@@ -40,6 +41,8 @@
 #include "elf.h"
 
 #define PHYS_MEM_BASE 0x80000000
+#define FIRMWARE_BASE 0x1000
+#define FIRMWARE_SIZE (128 * 0x1000)
 
 typedef struct {
     uint64_t ram_size;
@@ -122,8 +125,8 @@ static void moxiesim_init(MachineState *machine)
     memory_region_init_ram(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
     memory_region_add_subregion(address_space_mem, ram_base, ram);
 
-    memory_region_init_ram(rom, NULL, "moxie.rom", 128 * 0x1000, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0x1000, rom);
+    memory_region_init_ram(rom, NULL, "moxie.rom", FIRMWARE_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), FIRMWARE_BASE, rom);
 
     if (kernel_filename) {
         loader_params.ram_size = ram_size;
@@ -132,6 +135,11 @@ static void moxiesim_init(MachineState *machine)
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
