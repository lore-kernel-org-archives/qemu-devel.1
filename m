Received: from eggs.gnu.org ([2001:4830:134:3::10]:56620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyc-0004uD-KH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyb-0007Me-Io
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:18 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyb-0007MO-CK
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:17 -0500
Received: by mail-wr0-x244.google.com with SMTP id y21so22927336wrc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:50 +0100
Message-Id: <1513790098-9815-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/46] kvm-i8259: support "info pic" and "info
 irq"
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

Let's leverage the i8259 common code for kvm-i8259 too.

I think it's still possible that stats can lost when i8259 is in kernel
and meanwhile when irqfd is used, e.g., by vfio or vhost devices.
However that should be rare IMHO since they should be using MSIs mostly
if they really want performance (that's why people use vhost and device
assignment), and no old INTx should be used.  As long as the INTx users
are emulated in QEMU the stats will be correct.

For "info pic", it should be always accurate since we fetch kvm regs
before dump.

More importantly, it's just too simple to do this now - it's only 10+
LOC to gain this feature.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171210063819.14892-5-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8259.c    | 8 ++++++++
 hw/intc/i8259_common.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 11d1b72..57abe09 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -111,6 +111,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
     int delivered;
 
+    pic_stat_update_irq(irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     apic_report_irq_delivered(delivered);
 }
@@ -139,12 +140,15 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
     PICCommonClass *k = PIC_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->reset     = kvm_pic_reset;
     kpc->parent_realize = dc->realize;
     dc->realize   = kvm_pic_realize;
     k->pre_save   = kvm_pic_get;
     k->post_load  = kvm_pic_put;
+    ic->get_statistics = pic_get_statistics;
+    ic->print_info = pic_print_info;
 }
 
 static const TypeInfo kvm_i8259_info = {
@@ -153,6 +157,10 @@ static const TypeInfo kvm_i8259_info = {
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_INTERRUPT_STATS_PROVIDER },
+        { }
+    },
 };
 
 static void kvm_pic_register_types(void)
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index a3cadde..7efd2e8 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -132,6 +132,7 @@ void pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
 {
     PICCommonState *s = PIC_COMMON(obj);
 
+    pic_dispatch_pre_save(s);
     monitor_printf(mon, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                    "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
                    s->master ? 0 : 1, s->irr, s->imr, s->isr, s->priority_add,
-- 
1.8.3.1
