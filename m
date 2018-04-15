Received: from eggs.gnu.org ([2001:4830:134:3::10]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJs-0005Hy-LF
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJr-0000sY-EY
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:44:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:46 -0300
Message-Id: <20180415234307.28132-21-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 20/41] hw/hppa: Use the BYTE-based
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c    |  3 ++-
 hw/hppa/machine.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 15aefde09c..31d69ae61b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -76,7 +77,7 @@
 /* #define xxx    0x200 - bit 9 not used */
 #define RS232INT  0x400
 
-#define DINO_MEM_CHUNK_SIZE (8 * 1024 * 1024) /* 8MB */
+#define DINO_MEM_CHUNK_SIZE (8 * M_BYTE)
 
 #define DINO_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 19033e268d..87dbb77987 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -17,7 +17,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
 #include "hw/hppa/hppa_sys.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
@@ -178,8 +178,8 @@ static void machine_hppa_init(MachineState *machine)
         }
         qemu_log_mask(CPU_LOG_PAGE, "Kernel loaded at 0x%08" PRIx64
                       "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
-                      ", size %ld kB.\n",
-                      kernel_low, kernel_high, kernel_entry, size / 1024);
+                      ", size %llu kB\n",
+                      kernel_low, kernel_high, kernel_entry, size / K_BYTE);
 
         if (kernel_cmdline) {
             cpu[0]->env.gr[24] = 0x4000;
@@ -203,8 +203,8 @@ static void machine_hppa_init(MachineState *machine)
                (1) Due to sign-extension problems and PDC,
                put the initrd no higher than 1G.
                (2) Reserve 64k for stack.  */
-            initrd_base = MIN(ram_size, 1024 * 1024 * 1024);
-            initrd_base = initrd_base - 64 * 1024;
+            initrd_base = MIN(ram_size, 1 * G_BYTE);
+            initrd_base = initrd_base - 64 * K_BYTE;
             initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
 
             if (initrd_base < kernel_high) {
-- 
2.17.0
