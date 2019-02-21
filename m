Received: from eggs.gnu.org ([209.51.188.92]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwnl8-0004iV-T3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwnl5-00063J-0U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37876 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gwnl3-00061H-3d
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:47:22 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 21 Feb 2019 13:45:59 +0100
Message-Id: <1550753160-15142-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] target/mips: fulong2e: Fix bios flash size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: BALATON Zoltan <balaton@eik.bme.hu>

According to both the specifications on linux-mips.org referenced in a
comment at the beginning of the file and the flash chip part number
the bios size should be 512k not 1M.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_fulong2e.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 02549d5..10e6ed5 100644
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
=20
+/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
+#define BIOS_SIZE (512 * KiB)
 #define MAX_IDE_BUS 2
=20
 /*
@@ -307,12 +309,9 @@ static void mips_fulong2e_init(MachineState *machine=
)
     /* fulong 2e has 256M ram. */
     ram_size =3D 256 * MiB;
=20
-    /* fulong 2e has a 1M flash.Winbond W39L040AP70Z */
-    bios_size =3D 1 * MiB;
-
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_=
size);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
+    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
=20
--=20
2.7.4
