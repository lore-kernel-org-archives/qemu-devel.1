Received: from eggs.gnu.org ([2001:4830:134:3::10]:36567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrx-000559-1P
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrv-0000WC-Lr
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:25 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:52 +0000
Message-Id: <20180220184159.16483-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
References: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 04/11] heathrow: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/intc/heathrow_pic.c | 32 +++++++++++---------------------
 hw/intc/trace-events   |  5 +++++
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 7bf44e0d86..5fd2b33a12 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -26,16 +26,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/intc/heathrow_pic.h"
-
-/* debug PIC */
-//#define DEBUG_PIC
-
-#ifdef DEBUG_PIC
-#define PIC_DPRINTF(fmt, ...)                                   \
-    do { printf("PIC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define PIC_DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static inline int heathrow_check_irq(HeathrowPICState *pic)
 {
@@ -61,7 +52,7 @@ static void heathrow_write(void *opaque, hwaddr addr,
     unsigned int n;
 
     n = ((addr & 0xfff) - 0x10) >> 4;
-    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
+    trace_heathrow_write(addr, n, value);
     if (n >= 2)
         return;
     pic = &s->pics[n];
@@ -109,7 +100,7 @@ static uint64_t heathrow_read(void *opaque, hwaddr addr,
             break;
         }
     }
-    PIC_DPRINTF("readl: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
+    trace_heathrow_read(addr, n, value);
     return value;
 }
 
@@ -124,24 +115,23 @@ static void heathrow_set_irq(void *opaque, int num, int level)
     HeathrowState *s = opaque;
     HeathrowPICState *pic;
     unsigned int irq_bit;
+    int last_level;
 
-#if defined(DEBUG)
-    {
-        static int last_level[64];
-        if (last_level[num] != level) {
-            PIC_DPRINTF("set_irq: num=0x%02x level=%d\n", num, level);
-            last_level[num] = level;
-        }
-    }
-#endif
     pic = &s->pics[1 - (num >> 5)];
     irq_bit = 1 << (num & 0x1f);
+    last_level = (pic->levels & irq_bit) ? 1 : 0;
+
     if (level) {
         pic->events |= irq_bit & ~pic->level_triggered;
         pic->levels |= irq_bit;
     } else {
         pic->levels &= ~irq_bit;
     }
+
+    if (last_level != level) {
+        trace_heathrow_set_irq(num, level);
+    }
+
     heathrow_update_irq(s);
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4092d2825e..55e8c2570c 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -186,3 +186,8 @@ nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
 nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
+# hw/intc/heathrow_pic.c
+heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
+heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
+heathrow_set_irq(int num, int level) "set_irq: num=0x%02x level=%d"
-- 
2.11.0
