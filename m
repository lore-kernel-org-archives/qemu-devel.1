Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVm47-0006Mj-A8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVm43-0007QD-Ag
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:22:15 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cVm43-0007Q9-4e
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:22:11 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so29481829wmr.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 13:22:11 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 23 Jan 2017 22:21:58 +0100
Message-Id: <1485206518-32403-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] niagara: fail if a firmware file is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/sparc64/niagara.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index b55d4bb..e945b5a 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -35,6 +35,7 @@
 #include "hw/timer/sun4v-rtc.h"
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
+#include "qemu/error-report.h"
 
 
 typedef struct NiagaraBoardState {
@@ -85,6 +86,14 @@ typedef struct NiagaraBoardState {
 #define NIAGARA_OBP_OFFSET  0x80000ULL
 #define PROM_SIZE_MAX       (4 * 1024 * 1024)
 
+static void add_rom_or_fail(const char *file, const hwaddr addr)
+{
+    if (rom_add_file_fixed(file, addr, -1)) {
+        error_report("Unable to load a firmware for -M niagara");
+        exit(1);
+    }
+
+}
 /* Niagara hardware initialisation */
 static void niagara_init(MachineState *machine)
 {
@@ -119,14 +128,13 @@ static void niagara_init(MachineState *machine)
                                          "sun4v.prom", PROM_SIZE_MAX);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
 
-    rom_add_file_fixed("nvram1", NIAGARA_NVRAM_BASE, -1);
-    rom_add_file_fixed("1up-md.bin", NIAGARA_MD_ROM_BASE, -1);
-    rom_add_file_fixed("1up-hv.bin", NIAGARA_HV_ROM_BASE, -1);
+    add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
+    add_rom_or_fail("1up-md.bin", NIAGARA_MD_ROM_BASE);
+    add_rom_or_fail("1up-hv.bin", NIAGARA_HV_ROM_BASE);
 
-    rom_add_file_fixed("reset.bin", NIAGARA_PROM_BASE, -1);
-    rom_add_file_fixed("q.bin", NIAGARA_PROM_BASE + NIAGARA_Q_OFFSET, -1);
-    rom_add_file_fixed("openboot.bin", NIAGARA_PROM_BASE + NIAGARA_OBP_OFFSET,
-                       -1);
+    add_rom_or_fail("reset.bin", NIAGARA_PROM_BASE);
+    add_rom_or_fail("q.bin", NIAGARA_PROM_BASE + NIAGARA_Q_OFFSET);
+    add_rom_or_fail("openboot.bin", NIAGARA_PROM_BASE + NIAGARA_OBP_OFFSET);
 
     /* the virtual ramdisk is kind of initrd, but it resides
        outside of the partition RAM */
-- 
2.7.2
