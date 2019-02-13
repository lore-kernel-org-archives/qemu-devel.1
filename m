Received: from eggs.gnu.org ([209.51.188.92]:39515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGX-0004XC-7n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGW-0005n9-Ap
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGW-0005mp-4A
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:10 +0100
Message-Id: <20190213161913.22107-23-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 22/25] terminal3270: do not use backend timer
 sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

terminal3270 uses the front-end side of the chardev. It shouldn't
create sources from backend side context (with backend
functions).

send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
thread safe.

This partially reverts changes from commit
2c716ba1506769c9be2caa02f0f6d6e7c00f4304.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190206174328.9736-4-marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/terminal3270.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index e9c45e55b1..35b079d5c4 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -31,7 +31,7 @@ typedef struct Terminal3270 {
     uint8_t outv[OUTPUT_BUFFER_SIZE];
     int in_len;
     bool handshake_done;
-    GSource *timer_src;
+    guint timer_tag;
 } Terminal3270;
=20
 #define TYPE_TERMINAL_3270 "x-terminal3270"
@@ -47,10 +47,9 @@ static int terminal_can_read(void *opaque)
=20
 static void terminal_timer_cancel(Terminal3270 *t)
 {
-    if (t->timer_src) {
-        g_source_destroy(t->timer_src);
-        g_source_unref(t->timer_src);
-        t->timer_src =3D NULL;
+    if (t->timer_tag) {
+        g_source_remove(t->timer_tag);
+        t->timer_tag =3D 0;
     }
 }
=20
@@ -100,8 +99,7 @@ static void terminal_read(void *opaque, const uint8_t =
*buf, int size)
     assert(size <=3D (INPUT_BUFFER_SIZE - t->in_len));
=20
     terminal_timer_cancel(t);
-    t->timer_src =3D qemu_chr_timeout_add_ms(t->chr.chr, 600 * 1000,
-                                           send_timing_mark_cb, t);
+    t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark_cb, t);
     memcpy(&t->inv[t->in_len], buf, size);
     t->in_len +=3D size;
     if (t->in_len < 2) {
@@ -160,8 +158,7 @@ static void chr_event(void *opaque, int event)
          * char-socket.c. Once qemu receives the terminal-type of the
          * client, mark handshake done and trigger everything rolling ag=
ain.
          */
-        t->timer_src =3D qemu_chr_timeout_add_ms(t->chr.chr, 600 * 1000,
-                                               send_timing_mark_cb, t);
+        t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark_cb,=
 t);
         break;
     case CHR_EVENT_CLOSED:
         sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
--=20
2.21.0.rc0.1.g036caf7885
