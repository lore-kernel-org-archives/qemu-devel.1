Received: from eggs.gnu.org ([209.51.188.92]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRFI-00068i-SK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRFA-0004e9-P8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grRFA-0004UJ-91
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7FADC058CB7
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:44:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:28 +0100
Message-Id: <20190206174328.9736-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/6] char-pty: remove write_lock usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The lock usage was described with its introduction in commit
9005b2a7589540a3733b3abdcfbccfe7746cd1a1. It was necessary because PTY
write() shares more state than GIOChannel with other
operations.

This made char-pty a bit different from other chardev, that only lock
around the write operation.  This was apparent in commit
7b3621f47a990c5099c6385728347f69a8d0e55c, which introduced an idle
source to avoid the lock.

By removing the PTY chardev state sharing on write() with previous
patch, we can remove the lock and the idle source.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-pty.c | 50 +++-------------------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index f8772c9e15..b034332edd 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -36,15 +36,12 @@ typedef struct {
     QIOChannel *ioc;
     int read_bytes;
=20
-    /* Protected by the Chardev chr_write_lock.  */
     int connected;
     GSource *timer_src;
-    GSource *open_source;
 } PtyChardev;
=20
 #define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PT=
Y)
=20
-static void pty_chr_update_read_handler_locked(Chardev *chr);
 static void pty_chr_state(Chardev *chr, int connected);
=20
 static void pty_chr_timer_cancel(PtyChardev *s)
@@ -56,32 +53,19 @@ static void pty_chr_timer_cancel(PtyChardev *s)
     }
 }
=20
-static void pty_chr_open_src_cancel(PtyChardev *s)
-{
-    if (s->open_source) {
-        g_source_destroy(s->open_source);
-        g_source_unref(s->open_source);
-        s->open_source =3D NULL;
-    }
-}
-
 static gboolean pty_chr_timer(gpointer opaque)
 {
     struct Chardev *chr =3D CHARDEV(opaque);
     PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
-    qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_timer_cancel(s);
-    pty_chr_open_src_cancel(s);
     if (!s->connected) {
         /* Next poll ... */
-        pty_chr_update_read_handler_locked(chr);
+        qemu_chr_be_update_read_handlers(chr, chr->gcontext);
     }
-    qemu_mutex_unlock(&chr->chr_write_lock);
     return FALSE;
 }
=20
-/* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
     PtyChardev *s =3D PTY_CHARDEV(chr);
@@ -94,8 +78,7 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
     g_free(name);
 }
=20
-/* Called with chr_write_lock held.  */
-static void pty_chr_update_read_handler_locked(Chardev *chr)
+static void pty_chr_update_read_handler(Chardev *chr)
 {
     PtyChardev *s =3D PTY_CHARDEV(chr);
     GPollFD pfd;
@@ -117,14 +100,6 @@ static void pty_chr_update_read_handler_locked(Chard=
ev *chr)
     }
 }
=20
-static void pty_chr_update_read_handler(Chardev *chr)
-{
-    qemu_mutex_lock(&chr->chr_write_lock);
-    pty_chr_update_read_handler_locked(chr);
-    qemu_mutex_unlock(&chr->chr_write_lock);
-}
-
-/* Called with chr_write_lock held.  */
 static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     PtyChardev *s =3D PTY_CHARDEV(chr);
@@ -179,23 +154,11 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
     return TRUE;
 }
=20
-static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    PtyChardev *s =3D PTY_CHARDEV(opaque);
-
-    s->open_source =3D NULL;
-    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-    return FALSE;
-}
-
-/* Called with chr_write_lock held.  */
 static void pty_chr_state(Chardev *chr, int connected)
 {
     PtyChardev *s =3D PTY_CHARDEV(chr);
=20
     if (!connected) {
-        pty_chr_open_src_cancel(s);
         remove_fd_in_watch(chr);
         s->connected =3D 0;
         /* (re-)connect poll interval for idle guests: once per second.
@@ -205,13 +168,8 @@ static void pty_chr_state(Chardev *chr, int connecte=
d)
     } else {
         pty_chr_timer_cancel(s);
         if (!s->connected) {
-            g_assert(s->open_source =3D=3D NULL);
-            s->open_source =3D g_idle_source_new();
             s->connected =3D 1;
-            g_source_set_callback(s->open_source,
-                                  qemu_chr_be_generic_open_func,
-                                  chr, NULL);
-            g_source_attach(s->open_source, chr->gcontext);
+            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
         }
         if (!chr->gsource) {
             chr->gsource =3D io_add_watch_poll(chr, s->ioc,
@@ -227,11 +185,9 @@ static void char_pty_finalize(Object *obj)
     Chardev *chr =3D CHARDEV(obj);
     PtyChardev *s =3D PTY_CHARDEV(obj);
=20
-    qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
-    qemu_mutex_unlock(&chr->chr_write_lock);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
--=20
2.20.1.519.g8feddda32c
