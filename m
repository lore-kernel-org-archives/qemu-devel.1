Received: from eggs.gnu.org ([2001:4830:134:3::10]:47338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ff1MS-0007Y5-Lt
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ff1MN-0003ET-2J
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:08:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ff1MM-0003E2-TM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE36F401EF04
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 11:08:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Jul 2018 13:07:55 +0200
Message-Id: <20180716110755.12499-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/char/serial: retry write if EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If the chardev returns -1 with EAGAIN errno on write(), it should try
to send it again (EINTR is handled by the chardev itself).

This fixes commit 019288bf137183bf3407c9824655b753bfafc99f
"hw/char/serial: Only retry if qemu_chr_fe_write returns 0"

Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index cd7d747c68..8bd1da2fa3 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -261,15 +261,20 @@ static void serial_xmit(SerialState *s)
         if (s->mcr & UART_MCR_LOOP) {
             /* in loopback mode, say that we just received a char */
             serial_receive1(s, &s->tsr, 1);
-        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 &&
-                   s->tsr_retry < MAX_XMIT_RETRY) {
-            assert(s->watch_tag =3D=3D 0);
-            s->watch_tag =3D
-                qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
-                                      serial_watch_cb, s);
-            if (s->watch_tag > 0) {
-                s->tsr_retry++;
-                return;
+        } else {
+            int rc =3D qemu_chr_fe_write(&s->chr, &s->tsr, 1);
+
+            if ((rc =3D=3D 0 ||
+                 (rc =3D=3D -1 && errno =3D=3D EAGAIN)) &&
+                s->tsr_retry < MAX_XMIT_RETRY) {
+                assert(s->watch_tag =3D=3D 0);
+                s->watch_tag =3D
+                    qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                          serial_watch_cb, s);
+                if (s->watch_tag > 0) {
+                    s->tsr_retry++;
+                    return;
+                }
             }
         }
         s->tsr_retry =3D 0;
--=20
2.18.0.129.ge3331758f1
