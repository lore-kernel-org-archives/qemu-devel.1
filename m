Received: from eggs.gnu.org ([2001:4830:134:3::10]:46958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbE-0003y6-Mp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbD-0000Bt-JO
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbD-0000Bc-Ay
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EB9580B56
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:21:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:02 +0400
Message-Id: <20170316092121.25672-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/21] mux: simplfy muxes_realize_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

mux_chr_event() already send events to all backends, rename it,
export it, and use it from muxes_realize_done. This should help abstract
away mux implementation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-mux.h |  2 +-
 chardev/char-mux.c | 11 ++++++++---
 chardev/char.c     |  9 ++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/chardev/char-mux.h b/chardev/char-mux.h
index 9a2fffce91..3f41dfcfd2 100644
--- a/chardev/char-mux.h
+++ b/chardev/char-mux.h
@@ -58,6 +58,6 @@ typedef struct MuxChardev {
=20
 void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
 void mux_set_focus(Chardev *chr, int focus);
-void mux_chr_send_event(MuxChardev *d, int mux_nr, int event);
+void mux_chr_send_all_event(Chardev *chr, int event);
=20
 #endif /* CHAR_MUX_H */
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 5547a36a0a..37d42c65c6 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -114,7 +114,7 @@ static void mux_print_help(Chardev *chr)
     }
 }
=20
-void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
+static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
 {
     CharBackend *be =3D d->backends[mux_nr];
=20
@@ -222,9 +222,9 @@ static void mux_chr_read(void *opaque, const uint8_t =
*buf, int size)
=20
 bool muxes_realized;
=20
-static void mux_chr_event(void *opaque, int event)
+void mux_chr_send_all_event(Chardev *chr, int event)
 {
-    MuxChardev *d =3D MUX_CHARDEV(opaque);
+    MuxChardev *d =3D MUX_CHARDEV(chr);
     int i;
=20
     if (!muxes_realized) {
@@ -237,6 +237,11 @@ static void mux_chr_event(void *opaque, int event)
     }
 }
=20
+static void mux_chr_event(void *opaque, int event)
+{
+    mux_chr_send_all_event(CHARDEV(opaque), event);
+}
+
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxChardev *d =3D MUX_CHARDEV(s);
diff --git a/chardev/char.c b/chardev/char.c
index aad639b620..674c097fbe 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -451,22 +451,17 @@ static void muxes_realize_done(Notifier *notifier, =
void *unused)
 {
     Chardev *chr;
=20
+    muxes_realized =3D true;
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (CHARDEV_IS_MUX(chr)) {
-            MuxChardev *d =3D MUX_CHARDEV(chr);
-            int i;
-
             /* send OPENED to all already-attached FEs */
-            for (i =3D 0; i < d->mux_cnt; i++) {
-                mux_chr_send_event(d, i, CHR_EVENT_OPENED);
-            }
+            mux_chr_send_all_event(CHARDEV(chr), CHR_EVENT_OPENED);
             /* mark mux as OPENED so any new FEs will immediately receiv=
e
              * OPENED event
              */
             qemu_chr_be_event(chr, CHR_EVENT_OPENED);
         }
     }
-    muxes_realized =3D true;
 }
=20
 static Notifier muxes_realize_notify =3D {
--=20
2.12.0.191.gc5d8de91d
