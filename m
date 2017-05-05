Received: from eggs.gnu.org ([2001:4830:134:3::10]:47016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF7-0002CW-WA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF6-0006b3-AQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aF6-0006ao-0n
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:44 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:19 +0200
Message-Id: <20170505101337.4650-4-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/21] char: Fix removing wrong GSource that be
 found by fd_in_tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

We use fd_in_tag to find a GSource, fd_in_tag is return value of
g_source_attach(GSource *source, GMainContext *context), the return
value is unique only in the same context, so we may get the same
values with different 'context' parameters.

It is no problem to find the right fd_in_tag by using
 g_main_context_find_source_by_id(GMainContext *context, guint source_id)
while there is only one default main context.

But colo-compare tries to create/use its own context, and if we pass wron=
g
'context' parameter with right fd_in_tag, we will find a wrong GSource to=
 handle.
We tried to fix the related codes in commit b43decb015a6efeb9e3cdbdb80f65=
47ad7248a4c,
but it didn't fix the bug completely, because we still have some codes di=
dn't pass
*right* context parameter for remove_fd_in_watch().

Let's fix it by record the GSource directly instead of fd_in_tag.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1492564532-91680-1-git-send-email-zhang.zhanghailiang@huawei=
.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fd.c     |  8 ++++----
 chardev/char-io.c     | 23 ++++++++---------------
 chardev/char-io.h     |  4 ++--
 chardev/char-pty.c    |  6 +++---
 chardev/char-socket.c |  8 ++++----
 chardev/char-udp.c    |  8 ++++----
 chardev/char.c        |  2 +-
 include/sysemu/char.h |  2 +-
 8 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 548dd4cdd9..0b182c552c 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -58,7 +58,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondit=
ion cond, void *opaque)
     ret =3D qio_channel_read(
         chan, (gchar *)buf, len, NULL);
     if (ret =3D=3D 0) {
-        remove_fd_in_watch(chr, NULL);
+        remove_fd_in_watch(chr);
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
         return FALSE;
     }
@@ -89,9 +89,9 @@ static void fd_chr_update_read_handler(Chardev *chr,
 {
     FDChardev *s =3D FD_CHARDEV(chr);
=20
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     if (s->ioc_in) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc_in,
+        chr->gsource =3D io_add_watch_poll(chr, s->ioc_in,
                                            fd_chr_read_poll,
                                            fd_chr_read, chr,
                                            context);
@@ -103,7 +103,7 @@ static void char_fd_finalize(Object *obj)
     Chardev *chr =3D CHARDEV(obj);
     FDChardev *s =3D FD_CHARDEV(obj);
=20
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     if (s->ioc_in) {
         object_unref(OBJECT(s->ioc_in));
     }
diff --git a/chardev/char-io.c b/chardev/char-io.c
index b4bb094ea3..b5708eef45 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -98,7 +98,7 @@ static GSourceFuncs io_watch_poll_funcs =3D {
     .finalize =3D io_watch_poll_finalize,
 };
=20
-guint io_add_watch_poll(Chardev *chr,
+GSource *io_add_watch_poll(Chardev *chr,
                         QIOChannel *ioc,
                         IOCanReadHandler *fd_can_read,
                         QIOChannelFunc fd_read,
@@ -106,7 +106,6 @@ guint io_add_watch_poll(Chardev *chr,
                         GMainContext *context)
 {
     IOWatchPoll *iwp;
-    int tag;
     char *name;
=20
     iwp =3D (IOWatchPoll *) g_source_new(&io_watch_poll_funcs,
@@ -122,21 +121,15 @@ guint io_add_watch_poll(Chardev *chr,
     g_source_set_name((GSource *)iwp, name);
     g_free(name);
=20
-    tag =3D g_source_attach(&iwp->parent, context);
+    g_source_attach(&iwp->parent, context);
     g_source_unref(&iwp->parent);
-    return tag;
+    return (GSource *)iwp;
 }
=20
-static void io_remove_watch_poll(guint tag, GMainContext *context)
+static void io_remove_watch_poll(GSource *source)
 {
-    GSource *source;
     IOWatchPoll *iwp;
=20
-    g_return_if_fail(tag > 0);
-
-    source =3D g_main_context_find_source_by_id(context, tag);
-    g_return_if_fail(source !=3D NULL);
-
     iwp =3D io_watch_poll_from_source(source);
     if (iwp->src) {
         g_source_destroy(iwp->src);
@@ -146,11 +139,11 @@ static void io_remove_watch_poll(guint tag, GMainCo=
ntext *context)
     g_source_destroy(&iwp->parent);
 }
=20
-void remove_fd_in_watch(Chardev *chr, GMainContext *context)
+void remove_fd_in_watch(Chardev *chr)
 {
-    if (chr->fd_in_tag) {
-        io_remove_watch_poll(chr->fd_in_tag, context);
-        chr->fd_in_tag =3D 0;
+    if (chr->gsource) {
+        io_remove_watch_poll(chr->gsource);
+        chr->gsource =3D NULL;
     }
 }
=20
diff --git a/chardev/char-io.h b/chardev/char-io.h
index 842be56bda..55973a7671 100644
--- a/chardev/char-io.h
+++ b/chardev/char-io.h
@@ -29,14 +29,14 @@
 #include "sysemu/char.h"
=20
 /* Can only be used for read */
-guint io_add_watch_poll(Chardev *chr,
+GSource *io_add_watch_poll(Chardev *chr,
                         QIOChannel *ioc,
                         IOCanReadHandler *fd_can_read,
                         QIOChannelFunc fd_read,
                         gpointer user_data,
                         GMainContext *context);
=20
-void remove_fd_in_watch(Chardev *chr, GMainContext *context);
+void remove_fd_in_watch(Chardev *chr);
=20
 int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
=20
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index a6337be8aa..581ab34278 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -199,7 +199,7 @@ static void pty_chr_state(Chardev *chr, int connected=
)
             g_source_remove(s->open_tag);
             s->open_tag =3D 0;
         }
-        remove_fd_in_watch(chr, NULL);
+        remove_fd_in_watch(chr);
         s->connected =3D 0;
         /* (re-)connect poll interval for idle guests: once per second.
          * We check more frequently in case the guests sends data to
@@ -215,8 +215,8 @@ static void pty_chr_state(Chardev *chr, int connected=
)
             s->connected =3D 1;
             s->open_tag =3D g_idle_add(qemu_chr_be_generic_open_func, ch=
r);
         }
-        if (!chr->fd_in_tag) {
-            chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+        if (!chr->gsource) {
+            chr->gsource =3D io_add_watch_poll(chr, s->ioc,
                                                pty_chr_read_poll,
                                                pty_chr_read,
                                                chr, NULL);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 36ab0d633a..d8de0518c5 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -327,7 +327,7 @@ static void tcp_chr_free_connection(Chardev *chr)
     }
=20
     tcp_set_msgfds(chr, NULL, 0);
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     object_unref(OBJECT(s->sioc));
     s->sioc =3D NULL;
     object_unref(OBJECT(s->ioc));
@@ -484,7 +484,7 @@ static void tcp_chr_connect(void *opaque)
=20
     s->connected =3D 1;
     if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+        chr->gsource =3D io_add_watch_poll(chr, s->ioc,
                                            tcp_chr_read_poll,
                                            tcp_chr_read,
                                            chr, NULL);
@@ -501,9 +501,9 @@ static void tcp_chr_update_read_handler(Chardev *chr,
         return;
     }
=20
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+        chr->gsource =3D io_add_watch_poll(chr, s->ioc,
                                            tcp_chr_read_poll,
                                            tcp_chr_read, chr,
                                            context);
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 804bd22efa..12240e528a 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -81,7 +81,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondi=
tion cond, void *opaque)
     ret =3D qio_channel_read(
         s->ioc, (char *)s->buf, sizeof(s->buf), NULL);
     if (ret <=3D 0) {
-        remove_fd_in_watch(chr, NULL);
+        remove_fd_in_watch(chr);
         return FALSE;
     }
     s->bufcnt =3D ret;
@@ -101,9 +101,9 @@ static void udp_chr_update_read_handler(Chardev *chr,
 {
     UdpChardev *s =3D UDP_CHARDEV(chr);
=20
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     if (s->ioc) {
-        chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
+        chr->gsource =3D io_add_watch_poll(chr, s->ioc,
                                            udp_chr_read_poll,
                                            udp_chr_read, chr,
                                            context);
@@ -115,7 +115,7 @@ static void char_udp_finalize(Object *obj)
     Chardev *chr =3D CHARDEV(obj);
     UdpChardev *s =3D UDP_CHARDEV(obj);
=20
-    remove_fd_in_watch(chr, NULL);
+    remove_fd_in_watch(chr);
     if (s->ioc) {
         object_unref(OBJECT(s->ioc));
     }
diff --git a/chardev/char.c b/chardev/char.c
index 3df116350b..54cd5f4081 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -560,7 +560,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     cc =3D CHARDEV_GET_CLASS(s);
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
         fe_open =3D 0;
-        remove_fd_in_watch(s, context);
+        remove_fd_in_watch(s);
     } else {
         fe_open =3D 1;
     }
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450881d42c..84f5c2312c 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -93,7 +93,7 @@ struct Chardev {
     char *filename;
     int logfd;
     int be_open;
-    guint fd_in_tag;
+    GSource *gsource;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
     QTAILQ_ENTRY(Chardev) next;
 };
--=20
2.12.2
