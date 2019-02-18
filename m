Received: from eggs.gnu.org ([209.51.188.92]:34852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhng-00062H-So
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhnf-0006dk-9k
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:27824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvhnb-0006Xd-G5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:29 -0500
Message-Id: <d490c415fe1629a6421deac1c245a93790e8d39b.1550491301.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1550491301.git.balaton@eik.bme.hu>
References: <cover.1550491301.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 13:01:41 +0100
Subject: [Qemu-devel] [PATCH v2 2/3] mips_fulong2e: Fix bios flash size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>, philmd@redhat.com

According to both the specifications on linux-mips.org referenced in a
comment at the beginning of the file and the flash chip part number
the bios size should be 512k not 1M.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
