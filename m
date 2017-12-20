Received: from eggs.gnu.org ([2001:4830:134:3::10]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhya-0004s2-G2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyZ-0007Ls-Gq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:16 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyZ-0007Lg-9d
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:15 -0500
Received: by mail-wm0-x241.google.com with SMTP id t8so11243600wmc.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:48 +0100
Message-Id: <1513790098-9815-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/46] i8259: use DEBUG_IRQ_COUNT always
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

It's not really scary to even enable it forever.  After all it's i8259,
and it's even not the kernel one.

Then we can remove quite a few of lines to make it cleaner.  And "info
irq" will always work for it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171210063819.14892-3-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/i8259.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index f12e0b2..20c9d0a 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -36,7 +36,6 @@
 //#define DEBUG_PIC
 
 //#define DEBUG_IRQ_LATENCY
-//#define DEBUG_IRQ_COUNT
 
 #define TYPE_I8259 "isa-i8259"
 #define PIC_CLASS(class) OBJECT_CLASS_CHECK(PICClass, (class), TYPE_I8259)
@@ -52,12 +51,8 @@ typedef struct PICClass {
     DeviceRealize parent_realize;
 } PICClass;
 
-#if defined(DEBUG_PIC) || defined(DEBUG_IRQ_COUNT)
 static int irq_level[16];
-#endif
-#ifdef DEBUG_IRQ_COUNT
 static uint64_t irq_count[16];
-#endif
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -128,24 +123,17 @@ static void pic_set_irq(void *opaque, int irq, int level)
 {
     PICCommonState *s = opaque;
     int mask = 1 << irq;
-
-#if defined(DEBUG_PIC) || defined(DEBUG_IRQ_COUNT) || \
-    defined(DEBUG_IRQ_LATENCY)
     int irq_index = s->master ? irq : irq + 8;
-#endif
 
     trace_pic_set_irq(s->master, irq, level);
 
-#if defined(DEBUG_PIC) || defined(DEBUG_IRQ_COUNT)
     if (level != irq_level[irq_index]) {
         irq_level[irq_index] = level;
-#ifdef DEBUG_IRQ_COUNT
         if (level == 1) {
             irq_count[irq_index]++;
         }
-#endif
     }
-#endif
+
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
         irq_time[irq_index] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -253,12 +241,8 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     PICCommonState *s = PIC_COMMON(obj);
 
     if (s->master) {
-#ifdef DEBUG_IRQ_COUNT
         *irq_counts = irq_count;
         *nb_irqs = ARRAY_SIZE(irq_count);
-#else
-        return false;
-#endif
     } else {
         *irq_counts = NULL;
         *nb_irqs = 0;
-- 
1.8.3.1
