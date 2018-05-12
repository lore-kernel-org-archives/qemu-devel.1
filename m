Received: from eggs.gnu.org ([2001:4830:134:3::10]:55977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fHI2v-0007QT-UH
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fHI2u-0007bS-Kz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:05:57 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cyrus296@gmail.com>) id 1fHI2u-0007bI-F5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:05:56 -0400
Received: by mail-it0-x244.google.com with SMTP id q4-v6so4223298ite.3
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:05:56 -0700 (PDT)
From: Calvin Lee <cyrus296@gmail.com>
Date: Fri, 11 May 2018 18:05:45 -0600
Message-Id: <20180512000545.966-3-cyrus296@gmail.com>
In-Reply-To: <20180512000545.966-1-cyrus296@gmail.com>
References: <20180512000545.966-1-cyrus296@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v2 2/2] PC Chipset: Send serial bytes at
 correct rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, Calvin Lee <cyrus296@gmail.com>

This fixes bug in QEMU such that UART bytes would be sent immediatly
after being put in the THR regardless of the UART frequency (and divisor).
Now they will be sent at the appropriate rate.

Signed-off-by: Calvin Lee <cyrus296@gmail.com>
---
I am not sure about VM migration here. I want to move a struct field
from one VMStateDescription to a new one. I did this by bumping the
version number on the old VMStateDescription, and kept the field as
`_TEST`. If this is incorrect please let me know.

 hw/char/serial.c         | 51 +++++++++++++++++++++++++++++++++++-----
 include/hw/char/serial.h |  2 ++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4159a46a2f..542d949ccd 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -359,9 +359,8 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
             s->lsr &= ~UART_LSR_THRE;
             s->lsr &= ~UART_LSR_TEMT;
             serial_update_irq(s);
-            if (s->tsr_retry == 0) {
-                serial_xmit(s);
-            }
+            timer_mod(s->xmit_timeout_timer,
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time);
         }
         break;
     case 1:
@@ -586,6 +585,15 @@ static void serial_receive_break(SerialState *s)
     serial_update_irq(s);
 }
 
+/* There is data to be sent in xmit_fifo or the thr */
+static void xmit_timeout_int(void *opaque)
+{
+    SerialState *s = opaque;
+    if (s->tsr_retry == 0) {
+        serial_xmit(s);
+    }
+}
+
 /* There's data in recv_fifo and s->rbr has not been read for 4 char transmit times */
 static void fifo_timeout_int (void *opaque) {
     SerialState *s = opaque;
@@ -723,15 +731,20 @@ static bool serial_tsr_needed(void *opaque)
     SerialState *s = (SerialState *)opaque;
     return s->tsr_retry != 0;
 }
+static bool serial_tsr_thr_exists(void *opaque, int version_id)
+{
+    return version_id < 2;
+}
 
 static const VMStateDescription vmstate_serial_tsr = {
     .name = "serial/tsr",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .needed = serial_tsr_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(tsr_retry, SerialState),
-        VMSTATE_UINT8(thr, SerialState),
+        /* Moved to `xmit_timeout_timer` */
+        VMSTATE_UINT8_TEST(thr, SerialState, serial_tsr_thr_exists),
         VMSTATE_UINT8(tsr, SerialState),
         VMSTATE_END_OF_LIST()
     }
@@ -772,6 +785,24 @@ static const VMStateDescription vmstate_serial_xmit_fifo = {
     }
 };
 
+static bool serial_xmit_timeout_timer_needed(void *opaque)
+{
+    SerialState *s = (SerialState *)opaque;
+    return timer_pending(s->xmit_timeout_timer);
+}
+
+static const VMStateDescription vmstate_serial_xmit_timeout_timer = {
+    .name = "serial/xmit_timeout_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = serial_xmit_timeout_timer_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(thr, SerialState),
+        VMSTATE_TIMER_PTR(xmit_timeout_timer, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool serial_fifo_timeout_timer_needed(void *opaque)
 {
     SerialState *s = (SerialState *)opaque;
@@ -849,6 +880,7 @@ const VMStateDescription vmstate_serial = {
         &vmstate_serial_tsr,
         &vmstate_serial_recv_fifo,
         &vmstate_serial_xmit_fifo,
+        &vmstate_serial_xmit_timeout_timer,
         &vmstate_serial_fifo_timeout_timer,
         &vmstate_serial_timeout_ipending,
         &vmstate_serial_poll,
@@ -880,6 +912,7 @@ static void serial_reset(void *opaque)
     s->poll_msl = 0;
 
     s->timeout_ipending = 0;
+    timer_del(s->xmit_timeout_timer);
     timer_del(s->fifo_timeout_timer);
     timer_del(s->modem_status_poll);
 
@@ -928,7 +961,10 @@ void serial_realize_core(SerialState *s, Error **errp)
 {
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
-    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
+    s->xmit_timeout_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) xmit_timeout_int, s);
+    s->fifo_timeout_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
     qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
@@ -945,6 +981,9 @@ void serial_exit_core(SerialState *s)
     timer_del(s->modem_status_poll);
     timer_free(s->modem_status_poll);
 
+    timer_del(s->xmit_timeout_timer);
+    timer_free(s->xmit_timeout_timer);
+
     timer_del(s->fifo_timeout_timer);
     timer_free(s->fifo_timeout_timer);
 
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 0acfbbc382..09aece90fb 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -65,6 +65,8 @@ struct SerialState {
     /* Time when the last byte was successfully sent out of the tsr */
     uint64_t last_xmit_ts;
     Fifo8 recv_fifo;
+    /* Time to read the next byte from the thr */
+    QEMUTimer *xmit_timeout_timer;
     Fifo8 xmit_fifo;
     /* Interrupt trigger level for recv_fifo */
     uint8_t recv_fifo_itl;
-- 
2.17.0
