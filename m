Received: from eggs.gnu.org ([2001:4830:134:3::10]:42716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZK7-0003KD-R9
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZK4-0003Kb-MK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZK4-0003KL-Dj
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 837FBC05AA56
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:43:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:36 +0300
Message-Id: <20161212224325.20790-6-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/54] char: fold single-user functions in
 caller
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

This shorten a bit the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 97 ++++++++++++++++++++-----------------------------------=
------
 1 file changed, 31 insertions(+), 66 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index a81b61491a..cc7731a680 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1884,22 +1884,6 @@ static void qemu_chr_free_tty(CharDriverState *chr=
)
 {
     fd_chr_free(chr);
 }
-
-static CharDriverState *qemu_chr_open_tty_fd(const CharDriver *driver,
-                                             int fd,
-                                             ChardevCommon *backend,
-                                             bool *be_opened,
-                                             Error **errp)
-{
-    CharDriverState *chr;
-
-    tty_serial_init(fd, 115200, 'N', 8, 1);
-    chr =3D qemu_chr_open_fd(driver, fd, fd, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    return chr;
-}
 #endif /* __linux__ || __sun__ */
=20
 #if defined(__linux__)
@@ -2320,29 +2304,6 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
=20
-static CharDriverState *qemu_chr_open_win_path(const CharDriver *driver,
-                                               const char *filename,
-                                               ChardevCommon *backend,
-                                               Error **errp)
-{
-    CharDriverState *chr;
-    WinCharState *s;
-
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D g_new0(WinCharState, 1);
-    chr->opaque =3D s;
-
-    if (win_chr_init(chr, filename, errp) < 0) {
-        g_free(s);
-        qemu_chr_free_common(chr);
-        return NULL;
-    }
-    return chr;
-}
-
 static int win_chr_pipe_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
@@ -2798,30 +2759,6 @@ static void udp_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_udp(const CharDriver *driver,
-                                          QIOChannelSocket *sioc,
-                                          ChardevCommon *backend,
-                                          bool *be_opened,
-                                          Error **errp)
-{
-    CharDriverState *chr =3D NULL;
-    NetCharDriver *s =3D NULL;
-
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D g_new0(NetCharDriver, 1);
-
-    s->ioc =3D QIO_CHANNEL(sioc);
-    s->bufcnt =3D 0;
-    s->bufptr =3D 0;
-    chr->opaque =3D s;
-    /* be isn't opened until we get a connection */
-    *be_opened =3D false;
-    return chr;
-}
-
 /***********************************************************/
 /* TCP Net console */
=20
@@ -4604,8 +4541,23 @@ static CharDriverState *qmp_chardev_open_serial(co=
nst CharDriver *driver,
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
+    CharDriverState *chr;
+    WinCharState *s;
+
+    chr =3D qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
+
+    s =3D g_new0(WinCharState, 1);
+    chr->opaque =3D s;
+    if (win_chr_init(chr, serial->device, errp) < 0) {
+        g_free(s);
+        qemu_chr_free_common(chr);
+        return NULL;
+    }
=20
-    return qemu_chr_open_win_path(driver, serial->device, common, errp);
+    return chr;
 }
=20
 #else /* WIN32 */
@@ -4674,8 +4626,9 @@ static CharDriverState *qmp_chardev_open_serial(con=
st CharDriver *driver,
         return NULL;
     }
     qemu_set_nonblock(fd);
+    tty_serial_init(fd, 115200, 'N', 8, 1);
=20
-    return qemu_chr_open_tty_fd(driver, fd, common, be_opened, errp);
+    return qemu_chr_open_fd(driver, fd, fd, common, errp);
 }
 #endif
=20
@@ -4925,6 +4878,7 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
     char *name;
     CharDriverState *chr;
+    NetCharDriver *s;
=20
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4933,12 +4887,23 @@ static CharDriverState *qmp_chardev_open_udp(cons=
t CharDriver *driver,
         return NULL;
     }
=20
-    chr =3D qemu_chr_open_udp(driver, sioc, common, be_opened, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
=20
     name =3D g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
+    s =3D g_new0(NetCharDriver, 1);
+    s->ioc =3D QIO_CHANNEL(sioc);
+    s->bufcnt =3D 0;
+    s->bufptr =3D 0;
+    chr->opaque =3D s;
+    /* be isn't opened until we get a connection */
+    *be_opened =3D false;
+
     return chr;
 }
=20
--=20
2.11.0
