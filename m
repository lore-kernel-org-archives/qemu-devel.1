Received: from eggs.gnu.org ([2001:4830:134:3::10]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB6-0007nb-Jn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB5-00018c-Gc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB5-00017E-9I
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:03 -0400
Received: by mail-wr0-x241.google.com with SMTP id b8-v6so6678959wro.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:59 +0200
Message-Id: <1530216310-52873-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 49/60] ioapic: support "info irq"
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

This include both userspace and in-kernel ioapic.  Note that the numbers
can be inaccurate for kvm-ioapic.  One reason is the same with
kvm-i8259, that when irqfd is used, irqs can be delivered all inside
kernel without our notice.  Meanwhile, kvm-ioapic is specially treated
when irq numbers <ISA_NUM_IRQS, those irqs will be delivered in kernel
too via kvm-i8259 (please refer to kvm_pc_gsi_handler).

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171229073104.3810-5-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/ioapic.c              |  2 ++
 hw/intc/ioapic.c                  |  1 +
 hw/intc/ioapic_common.c           | 23 +++++++++++++++++++++++
 include/hw/i386/ioapic_internal.h |  3 +++
 4 files changed, 29 insertions(+)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 646f624..5274dc7 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -132,8 +132,10 @@ static void kvm_ioapic_reset(DeviceState *dev)
 static void kvm_ioapic_set_irq(void *opaque, int irq, int level)
 {
     KVMIOAPICState *s = opaque;
+    IOAPICCommonState *common = IOAPIC_COMMON(s);
     int delivered;
 
+    ioapic_stat_update_irq(common, irq, level);
     delivered = kvm_set_irq(kvm_state, s->kvm_gsi_base + irq, level);
     apic_report_irq_delivered(delivered);
 }
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index c45f073..222f3f7 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -148,6 +148,7 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
      * the cleanest way of doing it but it should work. */
 
     trace_ioapic_set_irq(vector, level);
+    ioapic_stat_update_irq(s, vector, level);
     if (vector == 0) {
         vector = 2;
     }
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index a02c135..692dc37 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -35,6 +35,28 @@
  */
 int ioapic_no;
 
+void ioapic_stat_update_irq(IOAPICCommonState *s, int irq, int level)
+{
+    if (level != s->irq_level[irq]) {
+        s->irq_level[irq] = level;
+        if (level == 1) {
+            s->irq_count[irq]++;
+        }
+    }
+}
+
+static bool ioapic_get_statistics(InterruptStatsProvider *obj,
+                                  uint64_t **irq_counts,
+                                  unsigned int *nb_irqs)
+{
+    IOAPICCommonState *s = IOAPIC_COMMON(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = IOAPIC_NUM_PINS;
+
+    return true;
+}
+
 static void ioapic_irr_dump(Monitor *mon, const char *name, uint32_t bitmap)
 {
     int i;
@@ -176,6 +198,7 @@ static void ioapic_common_class_init(ObjectClass *klass, void *data)
     dc->realize = ioapic_common_realize;
     dc->vmsd = &vmstate_ioapic_common;
     ic->print_info = ioapic_print_info;
+    ic->get_statistics = ioapic_get_statistics;
 }
 
 static const TypeInfo ioapic_common_type = {
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index a11d86d..9848f39 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -109,10 +109,13 @@ struct IOAPICCommonState {
     uint64_t ioredtbl[IOAPIC_NUM_PINS];
     Notifier machine_done;
     uint8_t version;
+    uint64_t irq_count[IOAPIC_NUM_PINS];
+    int irq_level[IOAPIC_NUM_PINS];
 };
 
 void ioapic_reset_common(DeviceState *dev);
 
 void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s);
+void ioapic_stat_update_irq(IOAPICCommonState *s, int irq, int level);
 
 #endif /* QEMU_IOAPIC_INTERNAL_H */
-- 
1.8.3.1
