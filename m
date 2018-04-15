Received: from eggs.gnu.org ([2001:4830:134:3::10]:51940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKA-0005d8-Oo
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rK9-0001BA-Gx
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:53 -0300
Message-Id: <20180415234307.28132-28-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 27/41] hw/lm32: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Michael Walle <michael@walle.cc>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/lm32/lm32_boards.c | 13 +++++++------
 hw/lm32/milkymist.c   | 10 +++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 527bcc229c..ef229dd315 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -88,10 +89,10 @@ static void lm32_evr_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base  = 0x04000000;
-    size_t flash_sector_size       = 256 * 1024;
-    size_t flash_size              = 32 * 1024 * 1024;
+    size_t flash_sector_size       = 256 * K_BYTE;
+    size_t flash_size              = 32 * M_BYTE;
     hwaddr ram_base    = 0x08000000;
-    size_t ram_size                = 64 * 1024 * 1024;
+    size_t ram_size                = 64 * M_BYTE;
     hwaddr timer0_base = 0x80002000;
     hwaddr uart0_base  = 0x80006000;
     hwaddr timer1_base = 0x8000a000;
@@ -174,10 +175,10 @@ static void lm32_uclinux_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base   = 0x04000000;
-    size_t flash_sector_size        = 256 * 1024;
-    size_t flash_size               = 32 * 1024 * 1024;
+    size_t flash_sector_size        = 256 * K_BYTE;
+    size_t flash_size               = 32 * M_BYTE;
     hwaddr ram_base     = 0x08000000;
-    size_t ram_size                 = 64 * 1024 * 1024;
+    size_t ram_size                 = 64 * M_BYTE;
     hwaddr uart0_base   = 0x80000000;
     hwaddr timer0_base  = 0x80002000;
     hwaddr timer1_base  = 0x80010000;
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 85d64fe58d..f530997abb 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -34,11 +35,10 @@
 #include "milkymist-hw.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 
 #define BIOS_FILENAME    "mmone-bios.bin"
 #define BIOS_OFFSET      0x00860000
-#define BIOS_SIZE        (512*1024)
+#define BIOS_SIZE        (512 * K_BYTE)
 #define KERNEL_LOAD_ADDR 0x40000000
 
 typedef struct {
@@ -97,10 +97,10 @@ milkymist_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base   = 0x00000000;
-    size_t flash_sector_size        = 128 * 1024;
-    size_t flash_size               = 32 * 1024 * 1024;
+    size_t flash_sector_size        = 128 * K_BYTE;
+    size_t flash_size               = 32 * M_BYTE;
     hwaddr sdram_base   = 0x40000000;
-    size_t sdram_size               = 128 * 1024 * 1024;
+    size_t sdram_size               = 128 * M_BYTE;
 
     hwaddr initrd_base  = sdram_base + 0x1002000;
     hwaddr cmdline_base = sdram_base + 0x1000000;
-- 
2.17.0
