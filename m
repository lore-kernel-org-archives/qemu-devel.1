Received: from eggs.gnu.org ([2001:4830:134:3::10]:48456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZH-00059X-Va
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZG-0007Fh-GO
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZG-0007FT-B8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:10 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:48 +0200
Message-Id: <1531840015-28804-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] PC Chipset: Improve serial divisor
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Calvin Lee <cyrus296@gmail.com>

From: Calvin Lee <cyrus296@gmail.com>

This fixes several problems I found in the UART serial implementation.
Now all divisor values are allowed, while before divisor values of zero
and below the base baud rate were rejected. All changes are in reference
to http://www.sci.muni.cz/docs/pc/serport.txt

Signed-off-by: Calvin Lee <cyrus296@gmail.com>
Message-Id: <20180512000545.966-2-cyrus296@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index cd7d747..d3b75f0 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -150,13 +150,10 @@ static void serial_update_irq(SerialState *s)
 
 static void serial_update_parameters(SerialState *s)
 {
-    int speed, parity, data_bits, stop_bits, frame_size;
+    float speed;
+    int parity, data_bits, stop_bits, frame_size;
     QEMUSerialSetParams ssp;
 
-    if (s->divider == 0 || s->divider > s->baudbase) {
-        return;
-    }
-
     /* Start bit. */
     frame_size = 1;
     if (s->lcr & 0x08) {
@@ -169,14 +166,16 @@ static void serial_update_parameters(SerialState *s)
     } else {
             parity = 'N';
     }
-    if (s->lcr & 0x04)
+    if (s->lcr & 0x04) {
         stop_bits = 2;
-    else
+    } else {
         stop_bits = 1;
+    }
 
     data_bits = (s->lcr & 0x03) + 5;
     frame_size += data_bits + stop_bits;
-    speed = s->baudbase / s->divider;
+    /* Zero divisor should give about 3500 baud */
+    speed = (s->divider == 0) ? 3500 : (float) s->baudbase / s->divider;
     ssp.speed = speed;
     ssp.parity = parity;
     ssp.data_bits = data_bits;
@@ -184,7 +183,7 @@ static void serial_update_parameters(SerialState *s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
-    DPRINTF("speed=%d parity=%c data=%d stop=%d\n",
+    DPRINTF("speed=%.2f parity=%c data=%d stop=%d\n",
            speed, parity, data_bits, stop_bits);
 }
 
@@ -341,7 +340,11 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     default:
     case 0:
         if (s->lcr & UART_LCR_DLAB) {
-            s->divider = (s->divider & 0xff00) | val;
+            if (size == 2) {
+                s->divider = (s->divider & 0xff00) | val;
+            } else if (size == 4) {
+                s->divider = val;
+            }
             serial_update_parameters(s);
         } else {
             s->thr = (uint8_t) val;
-- 
1.8.3.1
