Received: from eggs.gnu.org ([2001:4830:134:3::10]:37987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96E-0004JA-Vg
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96A-00029T-R4
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:10 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:54090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96A-00028g-KO
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:06 -0400
Received: by mail-wm0-x229.google.com with SMTP id b188-v6so4122420wme.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:15 +0200
Message-Id: <20180630061040.6018-23-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/47] hw/hppa: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20180625124238.25339-20-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hppa/dino.c    |  3 ++-
 hw/hppa/machine.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 26f2704..564b938 100644
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
+#define DINO_MEM_CHUNK_SIZE (8 * MiB)
 
 #define DINO_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2ba2696..cf7c61c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -17,7 +17,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
 #include "hppa_sys.h"
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
+                      ", size %" PRIu64 " kB\n",
+                      kernel_low, kernel_high, kernel_entry, size / KiB);
 
         if (kernel_cmdline) {
             cpu[0]->env.gr[24] = 0x4000;
@@ -203,8 +203,8 @@ static void machine_hppa_init(MachineState *machine)
                (1) Due to sign-extension problems and PDC,
                put the initrd no higher than 1G.
                (2) Reserve 64k for stack.  */
-            initrd_base = MIN(ram_size, 1024 * 1024 * 1024);
-            initrd_base = initrd_base - 64 * 1024;
+            initrd_base = MIN(ram_size, 1 * GiB);
+            initrd_base = initrd_base - 64 * KiB;
             initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
 
             if (initrd_base < kernel_high) {
-- 
1.8.3.1
