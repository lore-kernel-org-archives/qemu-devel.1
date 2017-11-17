Received: from eggs.gnu.org ([2001:4830:134:3::10]:58272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgyP-0003UP-W6
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgyP-0005Lw-3b
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:46:26 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59148
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFgyO-0005Ks-Si
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:46:25 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 17 Nov 2017 13:42:47 +0000
Message-Id: <1510926167-23326-16-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 15/15] sun4u: switch from EBUS_DPRINTF() macro
 to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c      |   12 ++----------
 hw/sparc64/trace-events |    3 +++
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index da386d3..50ccf75 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -47,17 +47,9 @@
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
 #include "elf.h"
+#include "trace.h"
 #include "qemu/cutils.h"
 
-//#define DEBUG_EBUS
-
-#ifdef DEBUG_EBUS
-#define EBUS_DPRINTF(fmt, ...)                                  \
-    do { printf("EBUS: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define EBUS_DPRINTF(fmt, ...)
-#endif
-
 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
 #define PROM_SIZE_MAX        (4 * 1024 * 1024)
@@ -218,7 +210,7 @@ static void ebus_isa_irq_handler(void *opaque, int n, int level)
     qemu_irq irq = s->isa_bus_irqs[n];
 
     /* Pass ISA bus IRQs onto their gpio equivalent */
-    EBUS_DPRINTF("Set ISA IRQ %d level %d\n", n, level);
+    trace_ebus_isa_irq_handler(n, level);
     if (irq) {
         qemu_set_irq(irq, level);
     }
diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
index 9284b1f..04d80b7 100644
--- a/hw/sparc64/trace-events
+++ b/hw/sparc64/trace-events
@@ -1 +1,4 @@
 # See docs/devel/tracing.txt for syntax documentation.
+
+# hw/sparc64/sun4u.c
+ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
-- 
1.7.10.4
