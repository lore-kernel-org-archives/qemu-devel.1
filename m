Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSkt9-0004t6-UA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSkt5-0007tP-71
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:44 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
	([40.107.3.96]:45373
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dSkt4-0007qA-TV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:39 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  5 Jul 2017 17:02:03 +0300
Message-ID: <1499263324-15184-13-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 12/13] serial: move TIOCM update to a
 separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

will be used by the following patch

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index ab14ca4..e47f0b6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -312,6 +312,24 @@ static void serial_write_fcr(SerialState *s, uint8_t v=
al)
     }
 }
=20
+static void serial_update_tiocm(SerialState *s)
+{
+    int flags;
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
+
+    flags &=3D ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
+
+    if (s->mcr & UART_MCR_RTS) {
+        flags |=3D CHR_TIOCM_RTS;
+    }
+    if (s->mcr & UART_MCR_DTR) {
+        flags |=3D CHR_TIOCM_DTR;
+    }
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
+}
+
 static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
                                 unsigned size)
 {
@@ -426,24 +444,13 @@ static void serial_ioport_write(void *opaque, hwaddr =
addr, uint64_t val,
         break;
     case 4:
         {
-            int flags;
             int old_mcr =3D s->mcr;
             s->mcr =3D val & 0x1f;
             if (val & UART_MCR_LOOP)
                 break;
=20
             if (s->poll_msl >=3D 0 && old_mcr !=3D s->mcr) {
-
-                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM, &fl=
ags);
-
-                flags &=3D ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
-
-                if (val & UART_MCR_RTS)
-                    flags |=3D CHR_TIOCM_RTS;
-                if (val & UART_MCR_DTR)
-                    flags |=3D CHR_TIOCM_DTR;
-
-                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM, &fl=
ags);
+                serial_update_tiocm(s);
                 /* Update the modem status after a one-character-send wait=
-time, since there may be a response
                    from the device/computer at the other end of the serial=
 line */
                 timer_mod(s->modem_status_poll, qemu_clock_get_ns(QEMU_CLO=
CK_VIRTUAL) + s->char_transmit_time);
--=20
2.7.4
