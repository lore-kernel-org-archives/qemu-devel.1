Received: from eggs.gnu.org ([2001:4830:134:3::10]:35293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY5-0002WP-H6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY4-0001nW-H8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:09 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 18:17:50 +0100
Message-Id: <20180607171751.11510-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/4] mos6522: move timer frequency
 initialisation to mos6522_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The 6522 VIA timer frequency cannot be set by altering registers within the
device itself and hence it is a fixed property of the machine.

Move the initialisation of the timer frequency to the mos6522 reset function
and ensure that any subclasses always call the parent reset function so that
it isn't required to store the timer frequency within vmstate_mos6522_timer
itself.

By moving the frequency initialisation to the device reset function then we
find that the realize function for both mos6522 and mos6522_cuda becomes
obsolete and can simply be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c      |  6 +++---
 hw/misc/mos6522.c         | 13 +++----------
 include/hw/misc/mos6522.h |  2 +-
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 8aba2e63ec..9651ed9744 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -597,12 +597,12 @@ static void mos6522_cuda_portB_write(MOS6522State *s)
     cuda_update(cs);
 }
 
-static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
+static void mos6522_cuda_reset(DeviceState *dev)
 {
     MOS6522State *ms = MOS6522(dev);
     MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
 
-    mdc->parent_realize(dev, errp);
+    mdc->parent_reset(dev);
 
     ms->timers[0].frequency = CUDA_TIMER_FREQ;
     ms->timers[1].frequency = (SCALE_US * 6000) / 4700;
@@ -613,7 +613,7 @@ static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
 
-    dc->realize = mos6522_cuda_realize;
+    dc->reset = mos6522_cuda_reset;
     mdc->portB_write = mos6522_cuda_portB_write;
     mdc->get_timer1_counter_value = cuda_get_counter_value;
     mdc->get_timer2_counter_value = cuda_get_counter_value;
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index facdaed5d5..d0a0c9e5d9 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -427,18 +427,12 @@ static void mos6522_reset(DeviceState *dev)
     /* s->ier = T1_INT | SR_INT; */
     s->anh = 0;
 
+    s->timers[0].frequency = s->frequency;
     s->timers[0].latch = 0xffff;
     set_counter(s, &s->timers[0], 0xffff);
 
-    s->timers[1].latch = 0xffff;
-}
-
-static void mos6522_realize(DeviceState *dev, Error **errp)
-{
-    MOS6522State *s = MOS6522(dev);
-
-    s->timers[0].frequency = s->frequency;
     s->timers[1].frequency = s->frequency;
+    s->timers[1].latch = 0xffff;
 }
 
 static void mos6522_init(Object *obj)
@@ -469,11 +463,10 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
 
-    dc->realize = mos6522_realize;
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
     dc->props = mos6522_properties;
-    mdc->parent_realize = dc->realize;
+    mdc->parent_reset = dc->reset;
     mdc->set_sr_int = mos6522_set_sr_int;
     mdc->portB_write = mos6522_portB_write;
     mdc->portA_write = mos6522_portA_write;
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index cb0fd7db78..f52b41920b 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -130,7 +130,7 @@ typedef struct MOS6522State {
 typedef struct MOS6522DeviceClass {
     DeviceClass parent_class;
 
-    DeviceRealize parent_realize;
+    DeviceReset parent_reset;
     void (*set_sr_int)(MOS6522State *dev);
     void (*portB_write)(MOS6522State *dev);
     void (*portA_write)(MOS6522State *dev);
-- 
2.11.0
