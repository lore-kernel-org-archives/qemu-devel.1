Received: from eggs.gnu.org ([2001:4830:134:3::10]:51196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3M-0000vN-OR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3H-0002JJ-45
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3G-0002Hg-TZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:11 -0400
Received: by mail-wm0-x241.google.com with SMTP id p204so5455286wmg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:12 +0200
Message-Id: <1499955874-10954-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/41] serial: move TIOCM update to a separate
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

will be used by the following patch

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-13-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4fb8f3..09157f9 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -312,6 +312,24 @@ static void serial_write_fcr(SerialState *s, uint8_t val)
     }
 }
 
+static void serial_update_tiocm(SerialState *s)
+{
+    int flags;
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
+
+    flags &= ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
+
+    if (s->mcr & UART_MCR_RTS) {
+        flags |= CHR_TIOCM_RTS;
+    }
+    if (s->mcr & UART_MCR_DTR) {
+        flags |= CHR_TIOCM_DTR;
+    }
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
+}
+
 static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
                                 unsigned size)
 {
@@ -426,24 +444,13 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
         break;
     case 4:
         {
-            int flags;
             int old_mcr = s->mcr;
             s->mcr = val & 0x1f;
             if (val & UART_MCR_LOOP)
                 break;
 
             if (s->poll_msl >= 0 && old_mcr != s->mcr) {
-
-                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
-
-                flags &= ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
-
-                if (val & UART_MCR_RTS)
-                    flags |= CHR_TIOCM_RTS;
-                if (val & UART_MCR_DTR)
-                    flags |= CHR_TIOCM_DTR;
-
-                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
+                serial_update_tiocm(s);
                 /* Update the modem status after a one-character-send wait-time, since there may be a response
                    from the device/computer at the other end of the serial line */
                 timer_mod(s->modem_status_poll, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time);
-- 
1.8.3.1
