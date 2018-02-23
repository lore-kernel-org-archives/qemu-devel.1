Received: from eggs.gnu.org ([2001:4830:134:3::10]:34164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1epBYL-0002JH-VA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1epBYG-0000cT-Vf
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:30:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 23 Feb 2018 11:29:33 +0000
Message-Id: <20180223112933.4135-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] loader: don't perform overlapping address
 check for memory region ROM images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

All memory region ROM images have a base address of 0 which causes the overlapping
address check to fail if more than one memory region ROM image is present, or an
existing ROM image is loaded at address 0.

Make sure that we ignore the overlapping address check in
rom_check_and_register_reset() if this is a memory region ROM image. In particular
this fixes the "rom: requested regions overlap" error on startup when trying to
run qemu-system-sparc with a -kernel image since commit 7497638642: "tcx: switch to
load_image_mr() and remove prom_addr hack".

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/core/loader.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 91669d65aa..c08f130461 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1104,20 +1104,22 @@ int rom_check_and_register_reset(void)
         if (rom->fw_file) {
             continue;
         }
-        if ((addr > rom->addr) && (as == rom->as)) {
-            fprintf(stderr, "rom: requested regions overlap "
-                    "(rom %s. free=0x" TARGET_FMT_plx
-                    ", addr=0x" TARGET_FMT_plx ")\n",
-                    rom->name, addr, rom->addr);
-            return -1;
+        if (!rom->mr) {
+            if ((addr > rom->addr) && (as == rom->as)) {
+                fprintf(stderr, "rom: requested regions overlap "
+                        "(rom %s. free=0x" TARGET_FMT_plx
+                        ", addr=0x" TARGET_FMT_plx ")\n",
+                        rom->name, addr, rom->addr);
+                return -1;
+            }
+            addr  = rom->addr;
+            addr += rom->romsize;
+            as = rom->as;
         }
-        addr  = rom->addr;
-        addr += rom->romsize;
         section = memory_region_find(rom->mr ? rom->mr : get_system_memory(),
                                      rom->addr, 1);
         rom->isrom = int128_nz(section.size) && memory_region_is_rom(section.mr);
         memory_region_unref(section.mr);
-        as = rom->as;
     }
     qemu_register_reset(rom_reset, NULL);
     roms_loaded = 1;
-- 
2.11.0
