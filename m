Received: from eggs.gnu.org ([209.51.188.92]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h2wDh-0001JQ-36
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h2wDf-0006xu-4h
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:02:17 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8YT4oLWK7gQB44p5UQVHEUR6bFdHy6VcGnGAxFxhWdiQ@mail.gmail.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
	<CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
	<CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
	<CAFEAcA9Ycm43h8ekoc1uP_K7eLT98Qg+EFqE3Lvu66cjU5c5_A@mail.gmail.com>
	<CADYoBw1QFQxicJJ9tQa2Ok7PAdWvgtD4MQncdJ0zi4E2vktVhQ@mail.gmail.com>
	<CAFEAcA-+U75+EQzcpV4kZHw+4xMSbMv3UJ0CV_Q3DVbNx5RbNg@mail.gmail.com>
	<CADYoBw2XWeDUqBHVJBWxJAzQ4f0imosEeLHHoG9AfHfdavOTrA@mail.gmail.com>
	<CAFEAcA8YT4oLWK7gQB44p5UQVHEUR6bFdHy6VcGnGAxFxhWdiQ@mail.gmail.com>
From: bzt <bztemail@gmail.com>
Date: Sun, 10 Mar 2019 12:02:07 +0100
Message-ID: <CADYoBw1TQMpkYbS8g_OzZ4UeQz=NYO=dugRnCuL2mP4xBxcWMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Okay, as you wish. My code works either way and on real hardware as
well, because I acknowledge the periodic IRQ as soon as possible, so
good for me.

Sign-off-by: Zolt=C3=A1n Baldaszti <bztemail@gmail.com>
Subject: [PATCH] Added periodic IRQ support for bcm2836_control local timer
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index cfa5bc7365..82d2f51ffe 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -7,7 +7,13 @@
  * This code is licensed under the GNU GPLv2 and later.
  *
  * At present, only implements interrupt routing, and mailboxes (i.e.,
- * not local timer, PMU interrupt, or AXI counters).
+ * not PMU interrupt, or AXI counters).
+ *
+ * ARM Local Timer IRQ Copyright (c) 2019. Zolt=C3=A1n Baldaszti
+ * The IRQ_TIMER support is still very basic, does not provide timer count=
er
+ * access and other timer features, it just generates periodic IRQs. But i=
t
+ * still requires not only the interrupt enable, but the timer enable bit =
to
+ * be set.
  *
  * Ref:
  * https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/=
QA7_rev3.4.pdf
@@ -18,6 +24,9 @@
 #include "qemu/log.h"

 #define REG_GPU_ROUTE           0x0c
+#define REG_LOCALTIMERROUTING   0x24
+#define REG_LOCALTIMERCONTROL   0x34
+#define REG_LOCALTIMERACK       0x38
 #define REG_TIMERCONTROL        0x40
 #define REG_MBOXCONTROL         0x50
 #define REG_IRQSRC              0x60
@@ -43,6 +52,13 @@
 #define IRQ_TIMER       11
 #define IRQ_MAX         IRQ_TIMER

+#define LOCALTIMER_FREQ      38400000
+#define LOCALTIMER_INTFLAG   (1 << 31)
+#define LOCALTIMER_RELOAD    (1 << 30)
+#define LOCALTIMER_INTENABLE (1 << 29)
+#define LOCALTIMER_ENABLE    (1 << 28)
+#define LOCALTIMER_VALUE(x)  ((x) & 0xfffffff)
+
 static void deliver_local(BCM2836ControlState *s, uint8_t core, uint8_t ir=
q,
                           uint32_t controlreg, uint8_t controlidx)
 {
@@ -78,6 +94,17 @@ static void bcm2836_control_update(BCM2836ControlState *=
s)
         s->fiqsrc[s->route_gpu_fiq] |=3D (uint32_t)1 << IRQ_GPU;
     }

+    /* handle THE local timer interrupt for one of the cores' IRQ/FIQ */
+    if ((s->local_timer_control & LOCALTIMER_INTENABLE) &&
+        (s->local_timer_control & LOCALTIMER_INTFLAG)) {
+        /* note: this will keep firing the IRQ as Peter asked */
+        if (s->route_localtimer & 4) {
+            s->fiqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 << IRQ_T=
IMER;
+        } else {
+            s->irqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 << IRQ_T=
IMER;
+        }
+    }
+
     for (i =3D 0; i < BCM2836_NCORES; i++) {
         /* handle local timer interrupts for this core */
         if (s->timerirqs[i]) {
@@ -162,6 +189,54 @@ static void bcm2836_control_set_gpu_fiq(void
*opaque, int irq, int level)
     bcm2836_control_update(s);
 }

+static void bcm2836_control_local_timer_set_next(void *opaque)
+{
+    BCM2836ControlState *s =3D opaque;
+    uint64_t next_event;
+
+    assert(LOCALTIMER_VALUE(s->local_timer_control) > 0);
+
+    next_event =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+        muldiv64(LOCALTIMER_VALUE(s->local_timer_control),
+            NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
+    timer_mod(&s->timer, next_event);
+}
+
+static void bcm2836_control_local_timer_tick(void *opaque)
+{
+    BCM2836ControlState *s =3D opaque;
+
+    bcm2836_control_local_timer_set_next(s);
+
+    s->local_timer_control |=3D LOCALTIMER_INTFLAG;
+    bcm2836_control_update(s);
+}
+
+static void bcm2836_control_local_timer_control(void *opaque, uint32_t val=
)
+{
+    BCM2836ControlState *s =3D opaque;
+
+    s->local_timer_control =3D val;
+    if (val & LOCALTIMER_ENABLE) {
+        bcm2836_control_local_timer_set_next(s);
+    } else {
+        timer_del(&s->timer);
+    }
+}
+
+static void bcm2836_control_local_timer_ack(void *opaque, uint32_t val)
+{
+    BCM2836ControlState *s =3D opaque;
+
+    if (val & LOCALTIMER_INTFLAG) {
+        s->local_timer_control &=3D ~LOCALTIMER_INTFLAG;
+    }
+    if ((val & LOCALTIMER_RELOAD) &&
+        (s->local_timer_control & LOCALTIMER_ENABLE)) {
+            bcm2836_control_local_timer_set_next(s);
+    }
+}
+
 static uint64_t bcm2836_control_read(void *opaque, hwaddr offset,
unsigned size)
 {
     BCM2836ControlState *s =3D opaque;
@@ -170,6 +245,12 @@ static uint64_t bcm2836_control_read(void
*opaque, hwaddr offset, unsigned size)
         assert(s->route_gpu_fiq < BCM2836_NCORES
                && s->route_gpu_irq < BCM2836_NCORES);
         return ((uint32_t)s->route_gpu_fiq << 2) | s->route_gpu_irq;
+    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
+        return s->route_localtimer;
+    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
+        return s->local_timer_control;
+    } else if (offset =3D=3D REG_LOCALTIMERACK) {
+        return 0;
     } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL) {
         return s->timercontrol[(offset - REG_TIMERCONTROL) >> 2];
     } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
@@ -195,6 +276,12 @@ static void bcm2836_control_write(void *opaque,
hwaddr offset,
     if (offset =3D=3D REG_GPU_ROUTE) {
         s->route_gpu_irq =3D val & 0x3;
         s->route_gpu_fiq =3D (val >> 2) & 0x3;
+    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
+        s->route_localtimer =3D val & 7;
+    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
+        bcm2836_control_local_timer_control(s, val);
+    } else if (offset =3D=3D REG_LOCALTIMERACK) {
+        bcm2836_control_local_timer_ack(s, val);
     } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL) {
         s->timercontrol[(offset - REG_TIMERCONTROL) >> 2] =3D val & 0xff;
     } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
@@ -227,6 +314,10 @@ static void bcm2836_control_reset(DeviceState *d)

     s->route_gpu_irq =3D s->route_gpu_fiq =3D 0;

+    timer_del(&s->timer);
+    s->route_localtimer =3D 0;
+    s->local_timer_control =3D 0;
+
     for (i =3D 0; i < BCM2836_NCORES; i++) {
         s->timercontrol[i] =3D 0;
         s->mailboxcontrol[i] =3D 0;
@@ -263,11 +354,14 @@ static void bcm2836_control_init(Object *obj)
     /* outputs to CPU cores */
     qdev_init_gpio_out_named(dev, s->irq, "irq", BCM2836_NCORES);
     qdev_init_gpio_out_named(dev, s->fiq, "fiq", BCM2836_NCORES);
+
+    /* create a qemu virtual timer */
+    timer_init_ns(&s->timer, QEMU_CLOCK_VIRTUAL,
bcm2836_control_local_timer_tick, s);
 }

 static const VMStateDescription vmstate_bcm2836_control =3D {
     .name =3D TYPE_BCM2836_CONTROL,
-    .version_id =3D 1,
+    .version_id =3D 2,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mailboxes, BCM2836ControlState,
@@ -277,6 +371,9 @@ static const VMStateDescription vmstate_bcm2836_control=
 =3D {
         VMSTATE_UINT32_ARRAY(timercontrol, BCM2836ControlState,
BCM2836_NCORES),
         VMSTATE_UINT32_ARRAY(mailboxcontrol, BCM2836ControlState,
                              BCM2836_NCORES),
+        VMSTATE_TIMER_V(timer, BCM2836ControlState, 2),
+        VMSTATE_UINT32_V(local_timer_control, BCM2836ControlState, 2),
+        VMSTATE_UINT8_V(route_localtimer, BCM2836ControlState, 2),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/intc/bcm2836_control.h
b/include/hw/intc/bcm2836_control.h
index 613f3c4186..de061b8929 100644
--- a/include/hw/intc/bcm2836_control.h
+++ b/include/hw/intc/bcm2836_control.h
@@ -5,6 +5,9 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
+ * ARM Local Timer IRQ Copyright (c) 2019. Zolt=C3=A1n Baldaszti
+ * Added basic IRQ_TIMER interrupt support
+ *
  * This code is licensed under the GNU GPLv2 and later.
  */

@@ -12,6 +15,7 @@
 #define BCM2836_CONTROL_H

 #include "hw/sysbus.h"
+#include "qemu/timer.h"

 /* 4 mailboxes per core, for 16 total */
 #define BCM2836_NCORES 4
@@ -39,6 +43,11 @@ typedef struct BCM2836ControlState {
     bool gpu_irq, gpu_fiq;
     uint8_t timerirqs[BCM2836_NCORES];

+    /* local timer */
+    QEMUTimer timer;
+    uint32_t local_timer_control;
+    uint8_t route_localtimer;
+
     /* interrupt source registers, post-routing (also input-derived;
visible) */
     uint32_t irqsrc[BCM2836_NCORES];
     uint32_t fiqsrc[BCM2836_NCORES];


On 3/9/19, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Sat, 9 Mar 2019 at 01:03, bzt <bztemail@gmail.com> wrote:
>> Thanks for your answers. If I don't clear the INTENABLE flag, then the
>> IRQ would keep firing constantly. This is not how the real hardware
>> works: it triggers the IRQ once, and then it inhibits. The timer won't
>> trigger the IRQ again until you acknowledge it by writing the INTFLAG
>> into the ack register. My solution emulates this behaviour. That's
>> what the triggered flag was for in my original patch. Should I bring
>> that flag back or is the current solution acceptable knowing this?
>
> Huh. The QA7 spec doc is pretty clear that the IRQ is kept high
> until the guest acknowledges it (and that is how in general
> IRQ/FIQ works for Arm -- it is level triggered and it stays high
> until the guest silences the device):
> "An interrupt is generated as long as the interrupt flag is set
> and the interrupt-enable bit is set" and "The user must clear the
> interrupt flag".
>
>
> thanks
> -- PMM
>
