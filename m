Received: from eggs.gnu.org ([209.51.188.92]:38588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAx7e-0008Nb-NI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAx7d-0004kV-7W
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hAx7c-0004k5-Sk
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:37:09 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon,  1 Apr 2019 15:36:59 +0200
Message-Id: <20190401133659.20421-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liran Alon <liran.alon@oracle.com>

It was found that Hyper-V 2016 on KVM in some configurations (q35 machine=
 +
piix4-usb-uhci) hangs on boot. Trace analysis led us to the conclusion th=
at
it is mishandling level-triggered interrupt performing EOI without fixing
the root cause. This causes immediate re-assertion and L2 VM (which is
supposedly expected to fix the cause of the interrupt) is not making any
progress.

Gory details: https://www.spinics.net/lists/kvm/msg184484.html

Turns out we were dealing with similar issues before; in-kernel IOAPIC
implementation has commit 184564efae4d ("kvm: ioapic: conditionally delay
irq delivery duringeoi broadcast") which describes a very similar issue.

Steal the idea from the above mentioned commit for IOAPIC implementation =
in
QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as wel=
l.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 hw/intc/ioapic.c                  | 43 ++++++++++++++++++++++++++++++-
 hw/intc/trace-events              |  1 +
 include/hw/i386/ioapic_internal.h |  3 +++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 9d75f84d3b..daf45cc8a8 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
     }
 }
=20
+#define SUCCESSIVE_IRQ_MAX_COUNT 10000
+
+static void ioapic_timer(void *opaque)
+{
+    IOAPICCommonState *s =3D opaque;
+
+    ioapic_service(s);
+}
+
 static void ioapic_set_irq(void *opaque, int vector, int level)
 {
     IOAPICCommonState *s =3D opaque;
@@ -227,7 +236,28 @@ void ioapic_eoi_broadcast(int vector)
                 trace_ioapic_clear_remote_irr(n, vector);
                 s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
                 if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n)))=
 {
-                    ioapic_service(s);
+                    bool level =3D ((entry >> IOAPIC_LVT_TRIGGER_MODE_SH=
IFT) & 1)
+                        =3D=3D IOAPIC_TRIGGER_LEVEL;
+
+                    ++s->irq_reassert[vector];
+                    if (!level ||
+                        s->irq_reassert[vector] < SUCCESSIVE_IRQ_MAX_COU=
NT) {
+                        ioapic_service(s);
+                    } else {
+                        /*
+                         * Real hardware does not deliver the interrupt
+                         * immediately during eoi broadcast, and this le=
ts a
+                         * buggy guest make slow progress even if it doe=
s not
+                         * correctly handle a level-triggered interrupt.=
 Emulate
+                         * this behavior if we detect an interrupt storm=
.
+                         */
+                        trace_ioapic_eoi_delayed_reassert(vector);
+                        timer_mod(s->timer,
+                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) =
+
+                                  NANOSECONDS_PER_SECOND / 100);
+                    }
+                } else {
+                    s->irq_reassert[vector] =3D 0;
                 }
             }
         }
@@ -401,6 +431,8 @@ static void ioapic_realize(DeviceState *dev, Error **=
errp)
     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
                           "ioapic", 0x1000);
=20
+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ioapic_timer, s);
+
     qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
=20
     ioapics[ioapic_no] =3D s;
@@ -408,6 +440,14 @@ static void ioapic_realize(DeviceState *dev, Error *=
*errp)
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
=20
+static void ioapic_unrealize(DeviceState *dev, Error **errp)
+{
+    IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
+
+    timer_del(s->timer);
+    timer_free(s->timer);
+}
+
 static Property ioapic_properties[] =3D {
     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_=
DEF),
     DEFINE_PROP_END_OF_LIST(),
@@ -419,6 +459,7 @@ static void ioapic_class_init(ObjectClass *klass, voi=
d *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     k->realize =3D ioapic_realize;
+    k->unrealize =3D ioapic_unrealize;
     /*
      * If APIC is in kernel, we need to update the kernel cache after
      * migration, otherwise first 24 gsi routes will be invalid.
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index a28bdce925..90c9d07c1a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx6=
4" =3D 0x%08x"
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
 ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d =
vector %d"
 ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
+ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI broadca=
st for vector %d"
 ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val=
) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" ret=
val 0x%"PRIx32
 ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t va=
l) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" v=
al 0x%"PRIx32
 ioapic_set_irq(int vector, int level) "vector: %d level: %d"
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 9848f391bb..e0ee88db40 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
     SysBusDeviceClass parent_class;
=20
     DeviceRealize realize;
+    DeviceUnrealize unrealize;
     void (*pre_save)(IOAPICCommonState *s);
     void (*post_load)(IOAPICCommonState *s);
 } IOAPICCommonClass;
@@ -111,6 +112,8 @@ struct IOAPICCommonState {
     uint8_t version;
     uint64_t irq_count[IOAPIC_NUM_PINS];
     int irq_level[IOAPIC_NUM_PINS];
+    int irq_reassert[IOAPIC_NUM_PINS];
+    QEMUTimer *timer;
 };
=20
 void ioapic_reset_common(DeviceState *dev);
--=20
2.20.1
