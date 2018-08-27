Received: from eggs.gnu.org ([2001:4830:134:3::10]:56498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv5-0003fF-Me
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv4-0005jR-Mb
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPv4-0005ij-GZ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3211087A82
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:16 +0200
Message-Id: <20180827222322.26009-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180827222322.26009-1-marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/9] chardev: use a child source for qio input
 source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

GLib child source were added with version 2.28. We can use them now
that we bumped our requirement to 2.40.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-io.c | 48 +++++------------------------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index f81052481a..8ced184160 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -33,7 +33,6 @@ typedef struct IOWatchPoll {
     IOCanReadHandler *fd_can_read;
     GSourceFunc fd_read;
     void *opaque;
-    GMainContext *context;
 } IOWatchPoll;
=20
 static IOWatchPoll *io_watch_poll_from_source(GSource *source)
@@ -55,47 +54,24 @@ static gboolean io_watch_poll_prepare(GSource *source=
,
         iwp->src =3D qio_channel_create_watch(
             iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
         g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL)=
;
-        g_source_attach(iwp->src, iwp->context);
-    } else {
-        g_source_destroy(iwp->src);
+        g_source_add_child_source(source, iwp->src);
         g_source_unref(iwp->src);
+    } else {
+        g_source_remove_child_source(source, iwp->src);
         iwp->src =3D NULL;
     }
     return FALSE;
 }
=20
-static gboolean io_watch_poll_check(GSource *source)
-{
-    return FALSE;
-}
-
 static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc call=
back,
                                        gpointer user_data)
 {
-    abort();
-}
-
-static void io_watch_poll_finalize(GSource *source)
-{
-    /* Due to a glib bug, removing the last reference to a source
-     * inside a finalize callback causes recursive locking (and a
-     * deadlock).  This is not a problem inside other callbacks,
-     * including dispatch callbacks, so we call io_remove_watch_poll
-     * to remove this source.  At this point, iwp->src must
-     * be NULL, or we would leak it.
-     *
-     * This would be solved much more elegantly by child sources,
-     * but we support older glib versions that do not have them.
-     */
-    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
-    assert(iwp->src =3D=3D NULL);
+    return G_SOURCE_CONTINUE;
 }
=20
 static GSourceFuncs io_watch_poll_funcs =3D {
     .prepare =3D io_watch_poll_prepare,
-    .check =3D io_watch_poll_check,
     .dispatch =3D io_watch_poll_dispatch,
-    .finalize =3D io_watch_poll_finalize,
 };
=20
 GSource *io_add_watch_poll(Chardev *chr,
@@ -115,7 +91,6 @@ GSource *io_add_watch_poll(Chardev *chr,
     iwp->ioc =3D ioc;
     iwp->fd_read =3D (GSourceFunc) fd_read;
     iwp->src =3D NULL;
-    iwp->context =3D context;
=20
     name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
     g_source_set_name((GSource *)iwp, name);
@@ -126,23 +101,10 @@ GSource *io_add_watch_poll(Chardev *chr,
     return (GSource *)iwp;
 }
=20
-static void io_remove_watch_poll(GSource *source)
-{
-    IOWatchPoll *iwp;
-
-    iwp =3D io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src =3D NULL;
-    }
-    g_source_destroy(&iwp->parent);
-}
-
 void remove_fd_in_watch(Chardev *chr)
 {
     if (chr->gsource) {
-        io_remove_watch_poll(chr->gsource);
+        g_source_destroy(chr->gsource);
         chr->gsource =3D NULL;
     }
 }
--=20
2.18.0.547.g1d89318c48
