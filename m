Received: from eggs.gnu.org ([2001:4830:134:3::10]:39600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqea-0001T6-GQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqeX-0004Gw-4I
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsqeW-0004GB-H3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A8DD407B397
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:31:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Aug 2018 16:31:23 +0200
Message-Id: <20180823143125.16767-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180823143125.16767-1-marcandre.lureau@redhat.com>
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/5] char-socket: update all ioc handlers
 when changing context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

So far, tcp_chr_update_read_handler() only updated the read
handler. Let's also update the hup handler.

Factorize the code while at it. (note that s->ioc !=3D NULL when
s->connected)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 59 ++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 14f6567f6a..7cd0ae2824 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -353,6 +353,15 @@ static GSource *tcp_chr_add_watch(Chardev *chr, GIOC=
ondition cond)
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
+static void remove_hup_source(SocketChardev *s)
+{
+    if (s->hup_source !=3D NULL) {
+        g_source_destroy(s->hup_source);
+        g_source_unref(s->hup_source);
+        s->hup_source =3D NULL;
+    }
+}
+
 static void tcp_chr_free_connection(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
@@ -367,11 +376,7 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num =3D 0;
     }
=20
-    if (s->hup_source !=3D NULL) {
-        g_source_destroy(s->hup_source);
-        g_source_unref(s->hup_source);
-        s->hup_source =3D NULL;
-    }
+    remove_hup_source(s);
=20
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
@@ -540,6 +545,27 @@ static char *sockaddr_to_str(struct sockaddr_storage=
 *ss, socklen_t ss_len,
     }
 }
=20
+static void update_ioc_handlers(SocketChardev *s)
+{
+    Chardev *chr =3D CHARDEV(s);
+
+    if (!s->connected) {
+        return;
+    }
+
+    remove_fd_in_watch(chr);
+    chr->gsource =3D io_add_watch_poll(chr, s->ioc,
+                                     tcp_chr_read_poll,
+                                     tcp_chr_read, chr,
+                                     chr->gcontext);
+
+    remove_hup_source(s);
+    s->hup_source =3D qio_channel_create_watch(s->ioc, G_IO_HUP);
+    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
+                          chr, NULL);
+    g_source_attach(s->hup_source, chr->gcontext);
+}
+
 static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
@@ -552,16 +578,7 @@ static void tcp_chr_connect(void *opaque)
         s->is_listen, s->is_telnet);
=20
     s->connected =3D 1;
-    chr->gsource =3D io_add_watch_poll(chr, s->ioc,
-                                       tcp_chr_read_poll,
-                                       tcp_chr_read,
-                                       chr, chr->gcontext);
-
-    s->hup_source =3D qio_channel_create_watch(s->ioc, G_IO_HUP);
-    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
-                          chr, NULL);
-    g_source_attach(s->hup_source, chr->gcontext);
-
+    update_ioc_handlers(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
=20
@@ -592,17 +609,7 @@ static void tcp_chr_update_read_handler(Chardev *chr=
)
         tcp_chr_telnet_init(CHARDEV(s));
     }
=20
-    if (!s->connected) {
-        return;
-    }
-
-    remove_fd_in_watch(chr);
-    if (s->ioc) {
-        chr->gsource =3D io_add_watch_poll(chr, s->ioc,
-                                           tcp_chr_read_poll,
-                                           tcp_chr_read, chr,
-                                           chr->gcontext);
-    }
+    update_ioc_handlers(s);
 }
=20
 static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
--=20
2.18.0.547.g1d89318c48
