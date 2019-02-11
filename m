Received: from eggs.gnu.org ([209.51.188.92]:37277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt3FL-0003PO-6u
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt32C-0006Bu-QQ
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:41261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gt326-0005qm-2v
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:27 -0500
Message-Id: <4ba510e2c7771808fa5061e14526f313c1ac3817.1549857716.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1549857716.git.balaton@eik.bme.hu>
References: <cover.1549857716.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 11 Feb 2019 05:01:56 +0100
Subject: [Qemu-devel] [PATCH 2/4] mips_fulong2e: Fix bios flash size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

According to both the specifications on linux-mips.org referenced in a
comment at the beginning of the file and the flash chip part number
the bios size should be 512k not 1M.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/mips/mips_fulong2e.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 02549d5c7e..10e6ed585a 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/dma/i8257.h"
@@ -35,7 +36,6 @@
 #include "audio/audio.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
-#include "hw/mips/bios.h"
 #include "hw/ide.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
@@ -51,6 +51,8 @@
 #define ENVP_NB_ENTRIES	 	16
 #define ENVP_ENTRY_SIZE	 	256
 
+/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
+#define BIOS_SIZE (512 * KiB)
 #define MAX_IDE_BUS 2
 
 /*
@@ -307,12 +309,9 @@ static void mips_fulong2e_init(MachineState *machine)
     /* fulong 2e has 256M ram. */
     ram_size = 256 * MiB;
 
-    /* fulong 2e has a 1M flash.Winbond W39L040AP70Z */
-    bios_size = 1 * MiB;
-
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
+    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
 
-- 
2.13.7
