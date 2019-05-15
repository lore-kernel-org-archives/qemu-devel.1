Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DDC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3352168B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3352168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR14Y-0000Rl-DV
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:04:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s4-0006Wf-Ix
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s2-0001eK-3q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0ry-0001ZM-ND
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4713A300BEA8
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:15 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BF7B1820E;
	Wed, 15 May 2019 20:51:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:31 +0200
Message-Id: <1557953433-19663-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 15 May 2019 20:51:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/21] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

It was found that Hyper-V 2016 on KVM in some configurations (q35 machine +
piix4-usb-uhci) hangs on boot. Root-cause was that one of Hyper-V
level-triggered interrupt handler performs EOI before fixing the cause of
the interrupt. This results in IOAPIC keep re-raising the level-triggered
interrupt after EOI because irq-line remains asserted.

Gory details: https://www.spinics.net/lists/kvm/msg184484.html
(the whole thread).

Turns out we were dealing with similar issues before; in-kernel IOAPIC
implementation has commit 184564efae4d ("kvm: ioapic: conditionally delay
irq delivery duringeoi broadcast") which describes a very similar issue.

Steal the idea from the above mentioned commit for IOAPIC implementation in
QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as well.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190402080215.10747-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c                  | 57 +++++++++++++++++++++++++++++++++++----
 hw/intc/trace-events              |  1 +
 include/hw/i386/ioapic_internal.h |  3 +++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 9d75f84..7074489 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
     }
 }
 
+#define SUCCESSIVE_IRQ_MAX_COUNT 10000
+
+static void delayed_ioapic_service_cb(void *opaque)
+{
+    IOAPICCommonState *s = opaque;
+
+    ioapic_service(s);
+}
+
 static void ioapic_set_irq(void *opaque, int vector, int level)
 {
     IOAPICCommonState *s = opaque;
@@ -222,13 +231,39 @@ void ioapic_eoi_broadcast(int vector)
         }
         for (n = 0; n < IOAPIC_NUM_PINS; n++) {
             entry = s->ioredtbl[n];
-            if ((entry & IOAPIC_LVT_REMOTE_IRR)
-                && (entry & IOAPIC_VECTOR_MASK) == vector) {
-                trace_ioapic_clear_remote_irr(n, vector);
-                s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
-                if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
+
+            if ((entry & IOAPIC_VECTOR_MASK) != vector ||
+                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) != IOAPIC_TRIGGER_LEVEL) {
+                continue;
+            }
+
+            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
+                continue;
+            }
+
+            trace_ioapic_clear_remote_irr(n, vector);
+            s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
+
+            if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
+                ++s->irq_eoi[vector];
+                if (s->irq_eoi[vector] >= SUCCESSIVE_IRQ_MAX_COUNT) {
+                    /*
+                     * Real hardware does not deliver the interrupt immediately
+                     * during eoi broadcast, and this lets a buggy guest make
+                     * slow progress even if it does not correctly handle a
+                     * level-triggered interrupt. Emulate this behavior if we
+                     * detect an interrupt storm.
+                     */
+                    s->irq_eoi[vector] = 0;
+                    timer_mod_anticipate(s->delayed_ioapic_service_timer,
+                                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                                         NANOSECONDS_PER_SECOND / 100);
+                    trace_ioapic_eoi_delayed_reassert(vector);
+                } else {
                     ioapic_service(s);
                 }
+            } else {
+                s->irq_eoi[vector] = 0;
             }
         }
     }
@@ -401,6 +436,9 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
                           "ioapic", 0x1000);
 
+    s->delayed_ioapic_service_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, delayed_ioapic_service_cb, s);
+
     qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
 
     ioapics[ioapic_no] = s;
@@ -408,6 +446,14 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
+static void ioapic_unrealize(DeviceState *dev, Error **errp)
+{
+    IOAPICCommonState *s = IOAPIC_COMMON(dev);
+
+    timer_del(s->delayed_ioapic_service_timer);
+    timer_free(s->delayed_ioapic_service_timer);
+}
+
 static Property ioapic_properties[] = {
     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
     DEFINE_PROP_END_OF_LIST(),
@@ -419,6 +465,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = ioapic_realize;
+    k->unrealize = ioapic_unrealize;
     /*
      * If APIC is in kernel, we need to update the kernel cache after
      * migration, otherwise first 24 gsi routes will be invalid.
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index a28bdce..90c9d07 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
 ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
 ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
+ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI broadcast for vector %d"
 ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
 ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
 ioapic_set_irq(int vector, int level) "vector: %d level: %d"
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index 9848f39..07002f9 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize realize;
+    DeviceUnrealize unrealize;
     void (*pre_save)(IOAPICCommonState *s);
     void (*post_load)(IOAPICCommonState *s);
 } IOAPICCommonClass;
@@ -111,6 +112,8 @@ struct IOAPICCommonState {
     uint8_t version;
     uint64_t irq_count[IOAPIC_NUM_PINS];
     int irq_level[IOAPIC_NUM_PINS];
+    int irq_eoi[IOAPIC_NUM_PINS];
+    QEMUTimer *delayed_ioapic_service_timer;
 };
 
 void ioapic_reset_common(DeviceState *dev);
-- 
1.8.3.1



