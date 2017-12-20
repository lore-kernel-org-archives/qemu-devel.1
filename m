Received: from eggs.gnu.org ([2001:4830:134:3::10]:56609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyb-0004tQ-Nc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhya-0007MK-LI
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:17 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhya-0007Lw-C2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:16 -0500
Received: by mail-wr0-x242.google.com with SMTP id v21so12207285wrc.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:49 +0100
Message-Id: <1513790098-9815-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/46] i8259: generalize statistics into common
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It was only for userspace i8259.  Move it to general code so that
kvm-i8259 can also use it in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171210063819.14892-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/i8259.c                 | 37 +------------------------------------
 hw/intc/i8259_common.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/isa/i8259_internal.h |  7 +++++--
 3 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 20c9d0a..d9b9666 100644
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
index 18427b4..a3cadde 100644
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
index 6954b6e..f742c2a 100644
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
1.8.3.1
