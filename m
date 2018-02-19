Received: from eggs.gnu.org ([2001:4830:134:3::10]:44279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enq2c-0006jw-1e
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enq2a-0007lm-Na
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:19:53 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 19 Feb 2018 18:19:15 +0000
Message-Id: <20180219181922.21586-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 04/11] heathrow: convert to trace-events
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
 hw/intc/heathrow_pic.c         | 31 ++++++++++++-------------------
 hw/intc/trace-events           |  5 +++++
 include/hw/intc/heathrow_pic.h |  1 +
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 7bf44e0d86..afe0b08cbb 100644
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
 
@@ -124,16 +115,18 @@ static void heathrow_set_irq(void *opaque, int num, int level)
     HeathrowState *s = opaque;
     HeathrowPICState *pic;
     unsigned int irq_bit;
+    int last_level = (s->last_levels & (num << 1UL)) ? 1 : 0;
 
-#if defined(DEBUG)
-    {
-        static int last_level[64];
-        if (last_level[num] != level) {
-            PIC_DPRINTF("set_irq: num=0x%02x level=%d\n", num, level);
-            last_level[num] = level;
+    if (last_level != level) {
+        trace_heathrow_set_irq(num, level);
+
+        if (level) {
+            s->last_levels |= (num << 1UL);
+        } else {
+            s->last_levels &= ~(num << 1UL);
         }
     }
-#endif
+
     pic = &s->pics[1 - (num >> 5)];
     irq_bit = 1 << (num & 0x1f);
     if (level) {
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
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
index bc3ffaab87..878a0f7cdb 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -42,6 +42,7 @@ typedef struct HeathrowState {
     MemoryRegion mem;
     HeathrowPICState pics[2];
     qemu_irq *irqs;
+    uint64_t last_levels;
 } HeathrowState;
 
 #define HEATHROW_NUM_IRQS 64
-- 
2.11.0
