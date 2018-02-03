Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvL4-0001FG-JN
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvL1-0005nE-Da
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:46:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36284
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvL0-0005mz-TO
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:46:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:27 +0000
Message-Id: <20180203103727.26457-11-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 10/10] cuda: convert to use the shared mos6522
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

Add the relevant hooks as required for the MacOS timer calibration and delayed
SR interrupt.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 606 ++++++++++++++-------------------------------------
 hw/ppc/mac.h         |  87 ++++----
 2 files changed, 204 insertions(+), 489 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 184d151702..15d9176733 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -26,15 +26,14 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
+#include "hw/misc/mos6522.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 
-/* XXX: implement all timer modes */
-
-/* debug CUDA */
-//#define DEBUG_CUDA
+/* debug CUDA packets */
+//#define DEBUG_CUDA_PACKET
 
 /* debug CUDA packets */
 //#define DEBUG_CUDA_PACKET
@@ -47,426 +46,114 @@
 #endif
 
 /* Bits in B data register: all active low */
-#define TREQ		0x08		/* Transfer request (input) */
-#define TACK		0x10		/* Transfer acknowledge (output) */
-#define TIP		0x20		/* Transfer in progress (output) */
-
-/* Bits in ACR */
-#define SR_CTRL		0x1c		/* Shift register control bits */
-#define SR_EXT		0x0c		/* Shift on external clock */
-#define SR_OUT		0x10		/* Shift out if 1 */
-
-/* Bits in IFR and IER */
-#define IER_SET		0x80		/* set bits in IER */
-#define IER_CLR		0		/* clear bits in IER */
-#define SR_INT		0x04		/* Shift register full/empty */
-#define SR_DATA_INT	0x08
-#define SR_CLOCK_INT	0x10
-#define T1_INT          0x40            /* Timer 1 interrupt */
-#define T2_INT          0x20            /* Timer 2 interrupt */
-
-/* Bits in ACR */
-#define T1MODE          0xc0            /* Timer 1 mode */
-#define T1MODE_CONT     0x40            /*  continuous interrupts */
+#define TREQ            0x08    /* Transfer request (input) */
+#define TACK            0x10    /* Transfer acknowledge (output) */
+#define TIP             0x20    /* Transfer in progress (output) */
 
 /* commands (1st byte) */
-#define ADB_PACKET	0
-#define CUDA_PACKET	1
-#define ERROR_PACKET	2
-#define TIMER_PACKET	3
-#define POWER_PACKET	4
-#define MACIIC_PACKET	5
-#define PMU_PACKET	6
-
-
-/* CUDA commands (2nd byte) */
-#define CUDA_WARM_START			0x0
-#define CUDA_AUTOPOLL			0x1
-#define CUDA_GET_6805_ADDR		0x2
-#define CUDA_GET_TIME			0x3
-#define CUDA_GET_PRAM			0x7
-#define CUDA_SET_6805_ADDR		0x8
-#define CUDA_SET_TIME			0x9
-#define CUDA_POWERDOWN			0xa
-#define CUDA_POWERUP_TIME		0xb
-#define CUDA_SET_PRAM			0xc
-#define CUDA_MS_RESET			0xd
-#define CUDA_SEND_DFAC			0xe
-#define CUDA_BATTERY_SWAP_SENSE		0x10
-#define CUDA_RESET_SYSTEM		0x11
-#define CUDA_SET_IPL			0x12
-#define CUDA_FILE_SERVER_FLAG		0x13
-#define CUDA_SET_AUTO_RATE		0x14
-#define CUDA_GET_AUTO_RATE		0x16
-#define CUDA_SET_DEVICE_LIST		0x19
-#define CUDA_GET_DEVICE_LIST		0x1a
-#define CUDA_SET_ONE_SECOND_MODE	0x1b
-#define CUDA_SET_POWER_MESSAGES		0x21
-#define CUDA_GET_SET_IIC		0x22
-#define CUDA_WAKEUP			0x23
-#define CUDA_TIMER_TICKLE		0x24
-#define CUDA_COMBINED_FORMAT_IIC	0x25
+#define ADB_PACKET      0
+#define CUDA_PACKET     1
+#define ERROR_PACKET    2
+#define TIMER_PACKET    3
+#define POWER_PACKET    4
+#define MACIIC_PACKET   5
+#define PMU_PACKET      6
 
 #define CUDA_TIMER_FREQ (4700000 / 6)
 
 /* CUDA returns time_t's offset from Jan 1, 1904, not 1970 */
 #define RTC_OFFSET                      2082844800
 
-/* CUDA registers */
-#define CUDA_REG_B       0x00
-#define CUDA_REG_A       0x01
-#define CUDA_REG_DIRB    0x02
-#define CUDA_REG_DIRA    0x03
-#define CUDA_REG_T1CL    0x04
-#define CUDA_REG_T1CH    0x05
-#define CUDA_REG_T1LL    0x06
-#define CUDA_REG_T1LH    0x07
-#define CUDA_REG_T2CL    0x08
-#define CUDA_REG_T2CH    0x09
-#define CUDA_REG_SR      0x0a
-#define CUDA_REG_ACR     0x0b
-#define CUDA_REG_PCR     0x0c
-#define CUDA_REG_IFR     0x0d
-#define CUDA_REG_IER     0x0e
-#define CUDA_REG_ANH     0x0f
-
-static void cuda_update(CUDAState *s);
 static void cuda_receive_packet_from_host(CUDAState *s,
                                           const uint8_t *data, int len);
-static void cuda_timer_update(CUDAState *s, CUDATimer *ti,
-                              int64_t current_time);
 
-static void cuda_update_irq(CUDAState *s)
-{
-    if (s->ifr & s->ier & (SR_INT | T1_INT | T2_INT)) {
-        qemu_irq_raise(s->irq);
-    } else {
-        qemu_irq_lower(s->irq);
-    }
-}
+/* MacOS uses timer 1 for calibration on startup, so we use
+ * the timebase frequency and cuda_get_counter_value() with
+ * cuda_get_load_time() to steer MacOS to calculate calibrate its timers
+ * correctly for both TCG and KVM (see commit b981289c49 "PPC: Cuda: Use cuda
+ * timer to expose tbfreq to guest" for more information) */
 
-static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
+static uint64_t cuda_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
 {
+    MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
+    CUDAState *cs = mcs->cuda;
+
     /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup */
     uint64_t tb_diff = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                                s->tb_frequency, NANOSECONDS_PER_SECOND) -
+                                cs->tb_frequency, NANOSECONDS_PER_SECOND) -
                            ti->load_time;
 
-    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
+    return (tb_diff * 0xBF401675E5DULL) / (cs->tb_frequency << 24);
 }
 
-static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
+static uint64_t cuda_get_load_time(MOS6522State *s, MOS6522Timer *ti)
 {
+    MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
+    CUDAState *cs = mcs->cuda;
+
     uint64_t load_time = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                                  s->tb_frequency, NANOSECONDS_PER_SECOND);
+                                  cs->tb_frequency, NANOSECONDS_PER_SECOND);
     return load_time;
 }
 
-static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
-{
-    int64_t d;
-    unsigned int counter;
-
-    d = get_counter_value(s, ti);
-
-    if (ti->index == 0) {
-        /* the timer goes down from latch to -1 (period of latch + 2) */
-        if (d <= (ti->counter_value + 1)) {
-            counter = (ti->counter_value - d) & 0xffff;
-        } else {
-            counter = (d - (ti->counter_value + 1)) % (ti->latch + 2);
-            counter = (ti->latch - counter) & 0xffff;
-        }
-    } else {
-        counter = (ti->counter_value - d) & 0xffff;
-    }
-    return counter;
-}
-
-static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
-{
-    CUDA_DPRINTF("T%d.counter=%d\n", 1 + ti->index, val);
-    ti->load_time = get_counter_load_time(s, ti);
-    ti->counter_value = val;
-    cuda_timer_update(s, ti, ti->load_time);
-}
-
-static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
-{
-    int64_t d, next_time;
-    unsigned int counter;
-
-    /* current counter value */
-    d = muldiv64(current_time - ti->load_time,
-                 ti->frequency, NANOSECONDS_PER_SECOND);
-    /* the timer goes down from latch to -1 (period of latch + 2) */
-    if (d <= (ti->counter_value + 1)) {
-        counter = (ti->counter_value - d) & 0xffff;
-    } else {
-        counter = (d - (ti->counter_value + 1)) % (ti->latch + 2);
-        counter = (ti->latch - counter) & 0xffff;
-    }
-
-    /* Note: we consider the irq is raised on 0 */
-    if (counter == 0xffff) {
-        next_time = d + ti->latch + 1;
-    } else if (counter == 0) {
-        next_time = d + ti->latch + 2;
-    } else {
-        next_time = d + counter;
-    }
-    CUDA_DPRINTF("latch=%d counter=%" PRId64 " delta_next=%" PRId64 "\n",
-                 ti->latch, d, next_time - d);
-    next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->frequency) +
-                         ti->load_time;
-    if (next_time <= current_time) {
-        next_time = current_time + 1;
-    }
-    return next_time;
-}
-
-static void cuda_timer_update(CUDAState *s, CUDATimer *ti,
-                              int64_t current_time)
-{
-    if (!ti->timer)
-        return;
-    if (ti->index == 0 && (s->acr & T1MODE) != T1MODE_CONT) {
-        timer_del(ti->timer);
-    } else {
-        ti->next_irq_time = get_next_irq_time(ti, current_time);
-        timer_mod(ti->timer, ti->next_irq_time);
-    }
-}
-
-static void cuda_timer1(void *opaque)
-{
-    CUDAState *s = opaque;
-    CUDATimer *ti = &s->timers[0];
-
-    cuda_timer_update(s, ti, ti->next_irq_time);
-    s->ifr |= T1_INT;
-    cuda_update_irq(s);
-}
-
-static void cuda_timer2(void *opaque)
-{
-    CUDAState *s = opaque;
-    CUDATimer *ti = &s->timers[1];
-
-    cuda_timer_update(s, ti, ti->next_irq_time);
-    s->ifr |= T2_INT;
-    cuda_update_irq(s);
-}
-
 static void cuda_set_sr_int(void *opaque)
 {
     CUDAState *s = opaque;
+    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522State *ms = MOS6522(mcs);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
 
-    CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
-    s->ifr |= SR_INT;
-    cuda_update_irq(s);
+    mdc->set_sr_int(ms);
 }
 
 static void cuda_delay_set_sr_int(CUDAState *s)
 {
+    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522State *ms = MOS6522(mcs);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
     int64_t expire;
 
-    if (s->dirb == 0xff) {
-        /* Not in Mac OS, fire the IRQ directly */
-        cuda_set_sr_int(s);
+    if (ms->dirb == 0xff || s->sr_delay_ns == 0) {
+        /* Disabled or not in Mac OS, fire the IRQ directly */
+        mdc->set_sr_int(ms);
         return;
     }
 
     CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
 
-    expire = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 300 * SCALE_US;
+    expire = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
     timer_mod(s->sr_delay_timer, expire);
 }
 
-static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
-{
-    CUDAState *s = opaque;
-    uint32_t val;
-
-    addr = (addr >> 9) & 0xf;
-    switch(addr) {
-    case CUDA_REG_B:
-        val = s->b;
-        break;
-    case CUDA_REG_A:
-        val = s->a;
-        break;
-    case CUDA_REG_DIRB:
-        val = s->dirb;
-        break;
-    case CUDA_REG_DIRA:
-        val = s->dira;
-        break;
-    case CUDA_REG_T1CL:
-        val = get_counter(s, &s->timers[0]) & 0xff;
-        s->ifr &= ~T1_INT;
-        cuda_update_irq(s);
-        break;
-    case CUDA_REG_T1CH:
-        val = get_counter(s, &s->timers[0]) >> 8;
-        cuda_update_irq(s);
-        break;
-    case CUDA_REG_T1LL:
-        val = s->timers[0].latch & 0xff;
-        break;
-    case CUDA_REG_T1LH:
-        /* XXX: check this */
-        val = (s->timers[0].latch >> 8) & 0xff;
-        break;
-    case CUDA_REG_T2CL:
-        val = get_counter(s, &s->timers[1]) & 0xff;
-        s->ifr &= ~T2_INT;
-        cuda_update_irq(s);
-        break;
-    case CUDA_REG_T2CH:
-        val = get_counter(s, &s->timers[1]) >> 8;
-        break;
-    case CUDA_REG_SR:
-        val = s->sr;
-        s->ifr &= ~(SR_INT | SR_CLOCK_INT | SR_DATA_INT);
-        cuda_update_irq(s);
-        break;
-    case CUDA_REG_ACR:
-        val = s->acr;
-        break;
-    case CUDA_REG_PCR:
-        val = s->pcr;
-        break;
-    case CUDA_REG_IFR:
-        val = s->ifr;
-        if (s->ifr & s->ier) {
-            val |= 0x80;
-        }
-        break;
-    case CUDA_REG_IER:
-        val = s->ier | 0x80;
-        break;
-    default:
-    case CUDA_REG_ANH:
-        val = s->anh;
-        break;
-    }
-    if (addr != CUDA_REG_IFR || val != 0) {
-        CUDA_DPRINTF("read: reg=0x%x val=%02x\n", (int)addr, val);
-    }
-
-    return val;
-}
-
-static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
-{
-    CUDAState *s = opaque;
-
-    addr = (addr >> 9) & 0xf;
-    CUDA_DPRINTF("write: reg=0x%x val=%02x\n", (int)addr, val);
-
-    switch(addr) {
-    case CUDA_REG_B:
-        s->b = (s->b & ~s->dirb) | (val & s->dirb);
-        cuda_update(s);
-        break;
-    case CUDA_REG_A:
-        s->a = (s->a & ~s->dira) | (val & s->dira);
-        break;
-    case CUDA_REG_DIRB:
-        s->dirb = val;
-        break;
-    case CUDA_REG_DIRA:
-        s->dira = val;
-        break;
-    case CUDA_REG_T1CL:
-        s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
-        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        break;
-    case CUDA_REG_T1CH:
-        s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
-        s->ifr &= ~T1_INT;
-        set_counter(s, &s->timers[0], s->timers[0].latch);
-        break;
-    case CUDA_REG_T1LL:
-        s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
-        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        break;
-    case CUDA_REG_T1LH:
-        s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
-        s->ifr &= ~T1_INT;
-        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        break;
-    case CUDA_REG_T2CL:
-        s->timers[1].latch = (s->timers[1].latch & 0xff00) | val;
-        break;
-    case CUDA_REG_T2CH:
-        /* To ensure T2 generates an interrupt on zero crossing with the
-           common timer code, write the value directly from the latch to
-           the counter */
-        s->timers[1].latch = (s->timers[1].latch & 0xff) | (val << 8);
-        s->ifr &= ~T2_INT;
-        set_counter(s, &s->timers[1], s->timers[1].latch);
-        break;
-    case CUDA_REG_SR:
-        s->sr = val;
-        break;
-    case CUDA_REG_ACR:
-        s->acr = val;
-        cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        break;
-    case CUDA_REG_PCR:
-        s->pcr = val;
-        break;
-    case CUDA_REG_IFR:
-        /* reset bits */
-        s->ifr &= ~val;
-        cuda_update_irq(s);
-        break;
-    case CUDA_REG_IER:
-        if (val & IER_SET) {
-            /* set bits */
-            s->ier |= val & 0x7f;
-        } else {
-            /* reset bits */
-            s->ier &= ~val;
-        }
-        cuda_update_irq(s);
-        break;
-    default:
-    case CUDA_REG_ANH:
-        s->anh = val;
-        break;
-    }
-}
-
 /* NOTE: TIP and TREQ are negated */
 static void cuda_update(CUDAState *s)
 {
+    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522State *ms = MOS6522(mcs);
     int packet_received, len;
 
     packet_received = 0;
-    if (!(s->b & TIP)) {
+    if (!(ms->b & TIP)) {
         /* transfer requested from host */
 
-        if (s->acr & SR_OUT) {
+        if (ms->acr & SR_OUT) {
             /* data output */
-            if ((s->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
+            if ((ms->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
                 if (s->data_out_index < sizeof(s->data_out)) {
-                    CUDA_DPRINTF("send: %02x\n", s->sr);
-                    s->data_out[s->data_out_index++] = s->sr;
+                    CUDA_DPRINTF("send: %02x\n", ms->sr);
+                    s->data_out[s->data_out_index++] = ms->sr;
                     cuda_delay_set_sr_int(s);
                 }
             }
         } else {
             if (s->data_in_index < s->data_in_size) {
                 /* data input */
-                if ((s->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
-                    s->sr = s->data_in[s->data_in_index++];
-                    CUDA_DPRINTF("recv: %02x\n", s->sr);
+                if ((ms->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
+                    ms->sr = s->data_in[s->data_in_index++];
+                    CUDA_DPRINTF("recv: %02x\n", ms->sr);
                     /* indicate end of transfer */
                     if (s->data_in_index >= s->data_in_size) {
-                        s->b = (s->b | TREQ);
+                        ms->b = (ms->b | TREQ);
                     }
                     cuda_delay_set_sr_int(s);
                 }
@@ -474,12 +161,13 @@ static void cuda_update(CUDAState *s)
         }
     } else {
         /* no transfer requested: handle sync case */
-        if ((s->last_b & TIP) && (s->b & TACK) != (s->last_b & TACK)) {
+        if ((s->last_b & TIP) && (ms->b & TACK) != (s->last_b & TACK)) {
             /* update TREQ state each time TACK change state */
-            if (s->b & TACK)
-                s->b = (s->b | TREQ);
-            else
-                s->b = (s->b & ~TREQ);
+            if (ms->b & TACK) {
+                ms->b = (ms->b | TREQ);
+            } else {
+                ms->b = (ms->b & ~TREQ);
+            }
             cuda_delay_set_sr_int(s);
         } else {
             if (!(s->last_b & TIP)) {
@@ -490,13 +178,13 @@ static void cuda_update(CUDAState *s)
             }
             /* signal if there is data to read */
             if (s->data_in_index < s->data_in_size) {
-                s->b = (s->b & ~TREQ);
+                ms->b = (ms->b & ~TREQ);
             }
         }
     }
 
-    s->last_acr = s->acr;
-    s->last_b = s->b;
+    s->last_acr = ms->acr;
+    s->last_b = ms->b;
 
     /* NOTE: cuda_receive_packet_from_host() can call cuda_update()
        recursively */
@@ -538,9 +226,8 @@ static void cuda_adb_poll(void *opaque)
         obuf[1] = 0x40; /* polled data */
         cuda_send_packet_to_host(s, obuf, olen + 2);
     }
-    timer_mod(s->adb_poll_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                   (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
+    timer_mod(s->adb_poll_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
 }
 
 /* description of commands */
@@ -787,35 +474,35 @@ static void cuda_receive_packet_from_host(CUDAState *s,
     }
 }
 
-static const MemoryRegionOps cuda_ops = {
-    .read = cuda_read,
-    .write = cuda_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-};
+static uint64_t mos6522_cuda_read(void *opaque, hwaddr addr, unsigned size)
+{
+    CUDAState *s = opaque;
+    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522State *ms = MOS6522(mcs);
 
-static bool cuda_timer_exist(void *opaque, int version_id)
+    addr = (addr >> 9) & 0xf;
+    return mos6522_read(ms, addr, size);
+}
+
+static void mos6522_cuda_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
 {
-    CUDATimer *s = opaque;
+    CUDAState *s = opaque;
+    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522State *ms = MOS6522(mcs);
 
-    return s->timer != NULL;
+    addr = (addr >> 9) & 0xf;
+    mos6522_write(ms, addr, val, size);
 }
 
-static const VMStateDescription vmstate_cuda_timer = {
-    .name = "cuda_timer",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT16(latch, CUDATimer),
-        VMSTATE_UINT16(counter_value, CUDATimer),
-        VMSTATE_INT64(load_time, CUDATimer),
-        VMSTATE_INT64(next_irq_time, CUDATimer),
-        VMSTATE_TIMER_PTR_TEST(timer, CUDATimer, cuda_timer_exist),
-        VMSTATE_END_OF_LIST()
-    }
+static const MemoryRegionOps mos6522_cuda_ops = {
+    .read = mos6522_cuda_read,
+    .write = mos6522_cuda_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
 };
 
 static const VMStateDescription vmstate_cuda = {
@@ -823,18 +510,8 @@ static const VMStateDescription vmstate_cuda = {
     .version_id = 4,
     .minimum_version_id = 4,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(a, CUDAState),
-        VMSTATE_UINT8(b, CUDAState),
         VMSTATE_UINT8(last_b, CUDAState),
-        VMSTATE_UINT8(dira, CUDAState),
-        VMSTATE_UINT8(dirb, CUDAState),
-        VMSTATE_UINT8(sr, CUDAState),
-        VMSTATE_UINT8(acr, CUDAState),
         VMSTATE_UINT8(last_acr, CUDAState),
-        VMSTATE_UINT8(pcr, CUDAState),
-        VMSTATE_UINT8(ifr, CUDAState),
-        VMSTATE_UINT8(ier, CUDAState),
-        VMSTATE_UINT8(anh, CUDAState),
         VMSTATE_INT32(data_in_size, CUDAState),
         VMSTATE_INT32(data_in_index, CUDAState),
         VMSTATE_INT32(data_out_index, CUDAState),
@@ -844,8 +521,6 @@ static const VMStateDescription vmstate_cuda = {
         VMSTATE_BUFFER(data_in, CUDAState),
         VMSTATE_BUFFER(data_out, CUDAState),
         VMSTATE_UINT32(tick_offset, CUDAState),
-        VMSTATE_STRUCT_ARRAY(timers, CUDAState, 2, 1,
-                             vmstate_cuda_timer, CUDATimer),
         VMSTATE_TIMER_PTR(adb_poll_timer, CUDAState),
         VMSTATE_TIMER_PTR(sr_delay_timer, CUDAState),
         VMSTATE_END_OF_LIST()
@@ -856,61 +531,48 @@ static void cuda_reset(DeviceState *dev)
 {
     CUDAState *s = CUDA(dev);
 
-    s->b = 0;
-    s->a = 0;
-    s->dirb = 0xff;
-    s->dira = 0;
-    s->sr = 0;
-    s->acr = 0;
-    s->pcr = 0;
-    s->ifr = 0;
-    s->ier = 0;
-    //    s->ier = T1_INT | SR_INT;
-    s->anh = 0;
     s->data_in_size = 0;
     s->data_in_index = 0;
     s->data_out_index = 0;
     s->autopoll = 0;
-
-    s->timers[0].latch = 0xffff;
-    set_counter(s, &s->timers[0], 0xffff);
-
-    s->timers[1].latch = 0xffff;
-
-    s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
 }
 
-static void cuda_realizefn(DeviceState *dev, Error **errp)
+static void cuda_realize(DeviceState *dev, Error **errp)
 {
     CUDAState *s = CUDA(dev);
+    SysBusDevice *sbd;
+    MOS6522State *ms;
+    DeviceState *d;
     struct tm tm;
 
-    s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1, s);
-    s->timers[0].frequency = CUDA_TIMER_FREQ;
-    s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2, s);
-    s->timers[1].frequency = (SCALE_US * 6000) / 4700;
+    d = qdev_create(NULL, TYPE_MOS6522_CUDA);
+    object_property_set_link(OBJECT(d), OBJECT(s), "cuda", errp);
+    qdev_init_nofail(d);
+    s->mos6522_cuda = MOS6522_CUDA(d);
+
+    /* Pass IRQ from 6522 */
+    ms = MOS6522(d);
+    sbd = SYS_BUS_DEVICE(s);
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
 
     qemu_get_timedate(&tm, 0);
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
+    s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
+    s->sr_delay_ns = 300 * SCALE_US;
+
     s->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
-    s->autopoll_rate_ms = 20;
     s->adb_poll_mask = 0xffff;
+    s->autopoll_rate_ms = 20;
 }
 
-static void cuda_initfn(Object *obj)
+static void cuda_init(Object *obj)
 {
-    SysBusDevice *d = SYS_BUS_DEVICE(obj);
     CUDAState *s = CUDA(obj);
-    int i;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->mem, obj, &cuda_ops, s, "cuda", 0x2000);
-    sysbus_init_mmio(d, &s->mem);
-    sysbus_init_irq(d, &s->irq);
-
-    for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
-        s->timers[i].index = i;
-    }
+    memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x2000);
+    sysbus_init_mmio(sbd, &s->mem);
 
     qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
                         DEVICE(obj), "adb.0");
@@ -925,7 +587,7 @@ static void cuda_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = cuda_realizefn;
+    dc->realize = cuda_realize;
     dc->reset = cuda_reset;
     dc->vmsd = &vmstate_cuda;
     dc->props = cuda_properties;
@@ -936,12 +598,62 @@ static const TypeInfo cuda_type_info = {
     .name = TYPE_CUDA,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(CUDAState),
-    .instance_init = cuda_initfn,
+    .instance_init = cuda_init,
     .class_init = cuda_class_init,
 };
 
+static void mos6522_cuda_portB_write(MOS6522State *s)
+{
+    MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
+
+    cuda_update(mcs->cuda);
+}
+
+static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
+{
+    MOS6522State *ms = MOS6522(dev);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+
+    mdc->parent_realize(dev, errp);
+
+    ms->timers[0].frequency = CUDA_TIMER_FREQ;
+    ms->timers[1].frequency = (SCALE_US * 6000) / 4700;
+}
+
+static void mos6522_cuda_init(Object *obj)
+{
+    MOS6522CUDAState *s = MOS6522_CUDA(obj);
+
+    object_property_add_link(obj, "cuda", TYPE_OBJECT,
+                             (Object **) &s->cuda,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+}
+
+static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+
+    dc->realize = mos6522_cuda_realize;
+    mdc->portB_write = mos6522_cuda_portB_write;
+    mdc->get_timer1_counter_value = cuda_get_counter_value;
+    mdc->get_timer2_counter_value = cuda_get_counter_value;
+    mdc->get_timer1_load_time = cuda_get_load_time;
+    mdc->get_timer2_load_time = cuda_get_load_time;
+}
+
+static const TypeInfo mos6522_cuda_type_info = {
+    .name = TYPE_MOS6522_CUDA,
+    .parent = TYPE_MOS6522,
+    .instance_size = sizeof(MOS6522CUDAState),
+    .instance_init = mos6522_cuda_init,
+    .class_init = mos6522_cuda_class_init,
+};
+
 static void cuda_register_types(void)
 {
+    type_register_static(&mos6522_cuda_type_info);
     type_register_static(&cuda_type_info);
 }
 
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index fa78115c95..3e9f13d9b4 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/ide/internal.h"
 #include "hw/input/adb.h"
+#include "hw/misc/mos6522.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
@@ -44,59 +45,48 @@
 
 #define ESCC_CLOCK 3686400
 
+/* CUDA commands (2nd byte) */
+#define CUDA_WARM_START                0x0
+#define CUDA_AUTOPOLL                  0x1
+#define CUDA_GET_6805_ADDR             0x2
+#define CUDA_GET_TIME                  0x3
+#define CUDA_GET_PRAM                  0x7
+#define CUDA_SET_6805_ADDR             0x8
+#define CUDA_SET_TIME                  0x9
+#define CUDA_POWERDOWN                 0xa
+#define CUDA_POWERUP_TIME              0xb
+#define CUDA_SET_PRAM                  0xc
+#define CUDA_MS_RESET                  0xd
+#define CUDA_SEND_DFAC                 0xe
+#define CUDA_BATTERY_SWAP_SENSE        0x10
+#define CUDA_RESET_SYSTEM              0x11
+#define CUDA_SET_IPL                   0x12
+#define CUDA_FILE_SERVER_FLAG          0x13
+#define CUDA_SET_AUTO_RATE             0x14
+#define CUDA_GET_AUTO_RATE             0x16
+#define CUDA_SET_DEVICE_LIST           0x19
+#define CUDA_GET_DEVICE_LIST           0x1a
+#define CUDA_SET_ONE_SECOND_MODE       0x1b
+#define CUDA_SET_POWER_MESSAGES        0x21
+#define CUDA_GET_SET_IIC               0x22
+#define CUDA_WAKEUP                    0x23
+#define CUDA_TIMER_TICKLE              0x24
+#define CUDA_COMBINED_FORMAT_IIC       0x25
+
 /* Cuda */
 #define TYPE_CUDA "cuda"
 #define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
 
-/**
- * CUDATimer:
- * @counter_value: counter value at load time
- */
-typedef struct CUDATimer {
-    int index;
-    uint16_t latch;
-    uint16_t counter_value;
-    int64_t load_time;
-    int64_t next_irq_time;
-    uint64_t frequency;
-    QEMUTimer *timer;
-} CUDATimer;
-
-/**
- * CUDAState:
- * @b: B-side data
- * @a: A-side data
- * @dirb: B-side direction (1=output)
- * @dira: A-side direction (1=output)
- * @sr: Shift register
- * @acr: Auxiliary control register
- * @pcr: Peripheral control register
- * @ifr: Interrupt flag register
- * @ier: Interrupt enable register
- * @anh: A-side data, no handshake
- * @last_b: last value of B register
- * @last_acr: last value of ACR register
- */
+typedef struct MOS6522CUDAState MOS6522CUDAState;
+
 typedef struct CUDAState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
-
     MemoryRegion mem;
-    /* cuda registers */
-    uint8_t b;
-    uint8_t a;
-    uint8_t dirb;
-    uint8_t dira;
-    uint8_t sr;
-    uint8_t acr;
-    uint8_t pcr;
-    uint8_t ifr;
-    uint8_t ier;
-    uint8_t anh;
 
     ADBBusState adb_bus;
-    CUDATimer timers[2];
+    MOS6522CUDAState *mos6522_cuda;
 
     uint32_t tick_offset;
     uint64_t tb_frequency;
@@ -105,6 +95,7 @@ typedef struct CUDAState {
     uint8_t last_acr;
 
     /* MacOS 9 is racy and requires a delay upon setting the SR_INT bit */
+    uint64_t sr_delay_ns;
     QEMUTimer *sr_delay_timer;
 
     int data_in_size;
@@ -120,6 +111,18 @@ typedef struct CUDAState {
     QEMUTimer *adb_poll_timer;
 } CUDAState;
 
+/* MOS6522 CUDA */
+typedef struct MOS6522CUDAState {
+    /*< private >*/
+    MOS6522State parent_obj;
+
+    CUDAState *cuda;
+} MOS6522CUDAState;
+
+#define TYPE_MOS6522_CUDA "mos6522-cuda"
+#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
+                                       TYPE_MOS6522_CUDA)
+
 /* MacIO */
 #define TYPE_OLDWORLD_MACIO "macio-oldworld"
 #define TYPE_NEWWORLD_MACIO "macio-newworld"
-- 
2.11.0
