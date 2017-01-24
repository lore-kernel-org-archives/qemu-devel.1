Received: from eggs.gnu.org ([2001:4830:134:3::10]:58206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cv-0006nU-Ua
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cW7Cr-0000n2-4M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:46 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cW7Cq-0000mv-Ua
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:56:41 -0500
Received: by mail-wj0-x241.google.com with SMTP id i7so3195657wjf.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:56:40 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 24 Jan 2017 20:55:41 +0100
Message-Id: <1485287742-31374-2-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1485287742-31374-1-git-send-email-atar4qemu@gmail.com>
References: <1485287742-31374-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/2] niagara: fail if a firmware file is
 missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, armbru@redhat.com, peter.maydell@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>

fail if a firmware file is missing and not qtest_enabled(),
the later is necessary to allow some basic tests if
firmware is not available

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/sparc64/niagara.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index b55d4bb..edde86e 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -35,6 +35,8 @@
 #include "hw/timer/sun4v-rtc.h"
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
+#include "qemu/error-report.h"
+#include "sysemu/qtest.h"
 
 
 typedef struct NiagaraBoardState {
@@ -85,6 +87,17 @@ typedef struct NiagaraBoardState {
 #define NIAGARA_OBP_OFFSET  0x80000ULL
 #define PROM_SIZE_MAX       (4 * 1024 * 1024)
 
+static void add_rom_or_fail(const char *file, const hwaddr addr)
+{
+    /* XXX remove qtest_enabled() check once firmware files are
+     * in the qemu tree
+     */
+    if (!qtest_enabled() && rom_add_file_fixed(file, addr, -1)) {
+        error_report("Unable to load a firmware for -M niagara");
+        exit(1);
+    }
+
+}
 /* Niagara hardware initialisation */
 static void niagara_init(MachineState *machine)
 {
@@ -119,14 +132,13 @@ static void niagara_init(MachineState *machine)
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
