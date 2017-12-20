Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhya-0004s4-IQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyY-0007LY-DF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:16 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyY-0007LJ-5m
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:14 -0500
Received: by mail-wr0-x243.google.com with SMTP id q9so22926459wre.7
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:47 +0100
Message-Id: <1513790098-9815-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/46] i8259: convert DPRINTFs into trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

One thing to mention is that in pic_set_irq() I need to uncomment a few
lines in the macros to make sure IRQ value calculation is correct.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171210063819.14892-2-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/i8259.c      | 26 +++++++++++---------------
 hw/intc/trace-events |  7 +++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe9ecd6..f12e0b2 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -30,17 +30,11 @@
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
 #include "hw/intc/intc.h"
+#include "trace.h"
 
 /* debug PIC */
 //#define DEBUG_PIC
 
-#ifdef DEBUG_PIC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("pic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
-
 //#define DEBUG_IRQ_LATENCY
 //#define DEBUG_IRQ_COUNT
 
@@ -122,8 +116,7 @@ static void pic_update_irq(PICCommonState *s)
 
     irq = pic_get_irq(s);
     if (irq >= 0) {
-        DPRINTF("pic%d: imr=%x irr=%x padd=%d\n",
-                s->master ? 0 : 1, s->imr, s->irr, s->priority_add);
+        trace_pic_update_irq(s->master, s->imr, s->irr, s->priority_add);
         qemu_irq_raise(s->int_out[0]);
     } else {
         qemu_irq_lower(s->int_out[0]);
@@ -140,9 +133,11 @@ static void pic_set_irq(void *opaque, int irq, int level)
     defined(DEBUG_IRQ_LATENCY)
     int irq_index = s->master ? irq : irq + 8;
 #endif
+
+    trace_pic_set_irq(s->master, irq, level);
+
 #if defined(DEBUG_PIC) || defined(DEBUG_IRQ_COUNT)
     if (level != irq_level[irq_index]) {
-        DPRINTF("pic_set_irq: irq=%d level=%d\n", irq_index, level);
         irq_level[irq_index] = level;
 #ifdef DEBUG_IRQ_COUNT
         if (level == 1) {
@@ -223,18 +218,18 @@ int pic_read_irq(DeviceState *d)
         intno = s->irq_base + irq;
     }
 
-#if defined(DEBUG_PIC) || defined(DEBUG_IRQ_LATENCY)
     if (irq == 2) {
         irq = irq2 + 8;
     }
-#endif
+
 #ifdef DEBUG_IRQ_LATENCY
     printf("IRQ%d latency=%0.3fus\n",
            irq,
            (double)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                     irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
 #endif
-    DPRINTF("pic_interrupt: irq=%d\n", irq);
+
+    trace_pic_interrupt(irq, intno);
     return intno;
 }
 
@@ -289,7 +284,8 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    DPRINTF("write: addr=0x%02x val=0x%02x\n", addr, val);
+    trace_pic_ioport_write(s->master, addr, val);
+
     if (addr == 0) {
         if (val & 0x10) {
             pic_init_reset(s);
@@ -402,7 +398,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
             ret = s->imr;
         }
     }
-    DPRINTF("read: addr=0x%02" HWADDR_PRIx " val=0x%02x\n", addr, ret);
+    trace_pic_ioport_read(s->master, addr, ret);
     return ret;
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7077aaa..be76918 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,5 +1,12 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/intc/i8259.c
+pic_update_irq(bool master, uint8_t imr, uint8_t irr, uint8_t padd) "master %d imr %"PRIu8" irr %"PRIu8" padd %"PRIu8
+pic_set_irq(bool master, int irq, int level) "master %d irq %d level %d"
+pic_interrupt(int irq, int intno) "irq %d intno %d"
+pic_ioport_write(bool master, uint64_t addr, uint64_t val) "master %d addr 0x%"PRIx64" val 0x%"PRIx64
+pic_ioport_read(bool master, uint64_t addr, int val) "master %d addr 0x%"PRIx64" val 0x%x"
+
 # hw/intc/apic_common.c
 cpu_set_apic_base(uint64_t val) "0x%016"PRIx64
 cpu_get_apic_base(uint64_t val) "0x%016"PRIx64
-- 
1.8.3.1
