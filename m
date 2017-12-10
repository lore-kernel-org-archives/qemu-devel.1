Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvG6-0002CS-IZ
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNvG3-00065D-DO
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNvG3-00064w-4X
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 01:38:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48BA781DE7
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 06:38:38 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Sun, 10 Dec 2017 14:38:17 +0800
Message-Id: <20171210063819.14892-4-peterx@redhat.com>
In-Reply-To: <20171210063819.14892-1-peterx@redhat.com>
References: <20171210063819.14892-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] i8259: generalize statistics into common
 code
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

It was only for userspace i8259.  Move it to general code so that
kvm-i8259 can also use it in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/i8259.c                 | 37 +------------------------------------
 hw/intc/i8259_common.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/isa/i8259_internal.h |  7 +++++--
 3 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 20c9d0a58b..d9b9666aff 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -25,11 +25,9 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
-#include "monitor/monitor.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
-#include "hw/intc/intc.h"
 #include "trace.h"
 
 /* debug PIC */
@@ -51,8 +49,6 @@ typedef struct PICClass {
     DeviceRealize parent_realize;
 } PICClass;
 
-static int irq_level[16];
-static uint64_t irq_count[16];
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
@@ -126,13 +122,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
     int irq_index = s->master ? irq : irq + 8;
 
     trace_pic_set_irq(s->master, irq, level);
-
-    if (level != irq_level[irq_index]) {
-        irq_level[irq_index] = level;
-        if (level == 1) {
-            irq_count[irq_index]++;
-        }
-    }
+    pic_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
@@ -235,31 +225,6 @@ static void pic_reset(DeviceState *dev)
     pic_init_reset(s);
 }
 
-static bool pic_get_statistics(InterruptStatsProvider *obj,
-                               uint64_t **irq_counts, unsigned int *nb_irqs)
-{
-    PICCommonState *s = PIC_COMMON(obj);
-
-    if (s->master) {
-        *irq_counts = irq_count;
-        *nb_irqs = ARRAY_SIZE(irq_count);
-    } else {
-        *irq_counts = NULL;
-        *nb_irqs = 0;
-    }
-    return true;
-}
-
-static void pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
-{
-    PICCommonState *s = PIC_COMMON(obj);
-    monitor_printf(mon, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
-                   "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
-                   s->master ? 0 : 1, s->irr, s->imr, s->isr, s->priority_add,
-                   s->irq_base, s->read_reg_select, s->elcr,
-                   s->special_fully_nested_mode);
-}
-
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 18427b459a..a3caddeefb 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -25,6 +25,10 @@
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/i8259_internal.h"
+#include "monitor/monitor.h"
+
+static int irq_level[16];
+static uint64_t irq_count[16];
 
 void pic_reset_common(PICCommonState *s)
 {
@@ -98,6 +102,43 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     return isadev;
 }
 
+void pic_stat_update_irq(int irq, int level)
+{
+    if (level != irq_level[irq]) {
+        irq_level[irq] = level;
+        if (level == 1) {
+            irq_count[irq]++;
+        }
+    }
+}
+
+bool pic_get_statistics(InterruptStatsProvider *obj,
+                        uint64_t **irq_counts, unsigned int *nb_irqs)
+{
+    PICCommonState *s = PIC_COMMON(obj);
+
+    if (s->master) {
+        *irq_counts = irq_count;
+        *nb_irqs = ARRAY_SIZE(irq_count);
+    } else {
+        *irq_counts = NULL;
+        *nb_irqs = 0;
+    }
+
+    return true;
+}
+
+void pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
+{
+    PICCommonState *s = PIC_COMMON(obj);
+
+    monitor_printf(mon, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
+                   "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
+                   s->master ? 0 : 1, s->irr, s->imr, s->isr, s->priority_add,
+                   s->irq_base, s->read_reg_select, s->elcr,
+                   s->special_fully_nested_mode);
+}
+
 static const VMStateDescription vmstate_pic_common = {
     .name = "i8259",
     .version_id = 1,
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 6954b6ec5f..f742c2a726 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
+#include "hw/intc/intc.h"
 
 typedef struct PICCommonState PICCommonState;
 
@@ -76,8 +77,10 @@ struct PICCommonState {
 };
 
 void pic_reset_common(PICCommonState *s);
-
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
-
+void pic_stat_update_irq(int irq, int level);
+bool pic_get_statistics(InterruptStatsProvider *obj,
+                        uint64_t **irq_counts, unsigned int *nb_irqs);
+void pic_print_info(InterruptStatsProvider *obj, Monitor *mon);
 
 #endif /* QEMU_I8259_INTERNAL_H */
-- 
2.14.3
