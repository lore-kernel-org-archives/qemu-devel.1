Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvFz-00026f-MX
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvFy-00062j-NS
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNvFy-000620-HX
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A934880F90
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 06:38:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Sun, 10 Dec 2017 14:38:16 +0800
Message-Id: <20171210063819.14892-3-peterx@redhat.com>
In-Reply-To: <20171210063819.14892-1-peterx@redhat.com>
References: <20171210063819.14892-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] i8259: use DEBUG_IRQ_COUNT always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

It's not really scary to even enable it forever.  After all it's i8259,
and it's even not the kernel one.

Then we can remove quite a few of lines to make it cleaner.  And "info
irq" will always work for it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/i8259.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index f12e0b27f1..20c9d0a58b 100644
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
2.14.3
