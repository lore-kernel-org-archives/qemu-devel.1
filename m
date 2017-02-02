Received: from eggs.gnu.org ([2001:4830:134:3::10]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjn-0003sf-Vj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjm-0003kv-TB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIjm-0003jt-LE
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C527C7E9DE
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:51:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:20 +0400
Message-Id: <20170202145141.17138-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/22] char: remove qemu_chr_be_generic_open
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

The function simply alias and hides the real event function.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  1 -
 chardev/char-pty.c    |  2 +-
 chardev/char-socket.c |  2 +-
 chardev/char.c        | 10 ++--------
 ui/console.c          |  2 +-
 ui/gtk.c              |  2 +-
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450881d42c..a30ff3fa80 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -427,7 +427,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
  */
 void qemu_chr_fe_take_focus(CharBackend *b);
=20
-void qemu_chr_be_generic_open(Chardev *s);
 void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 27eb85f505..3756310f0c 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -185,7 +185,7 @@ static gboolean qemu_chr_be_generic_open_func(gpointe=
r opaque)
     PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
     s->open_tag =3D 0;
-    qemu_chr_be_generic_open(chr);
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return FALSE;
 }
=20
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4068dc5e52..00b7de3cc4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -476,7 +476,7 @@ static void tcp_chr_connect(void *opaque)
                                            tcp_chr_read,
                                            chr, NULL);
     }
-    qemu_chr_be_generic_open(chr);
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
=20
 static void tcp_chr_update_read_handler(Chardev *chr,
diff --git a/chardev/char.c b/chardev/char.c
index abd525f75e..cec7224b98 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -66,12 +66,6 @@ void qemu_chr_be_event(Chardev *s, int event)
     be->chr_event(be->opaque, event);
 }
=20
-void qemu_chr_be_generic_open(Chardev *s)
-{
-    qemu_chr_be_event(s, CHR_EVENT_OPENED);
-}
-
-
 /* Not reporting errors from writing to logfile, as logs are
  * defined to be "best effort" only */
 static void qemu_chr_fe_write_log(Chardev *s,
@@ -469,7 +463,7 @@ static void muxes_realize_done(Notifier *notifier, vo=
id *unused)
             /* mark mux as OPENED so any new FEs will immediately receiv=
e
              * OPENED event
              */
-            qemu_chr_be_generic_open(chr);
+            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
         }
     }
     muxes_realized =3D true;
@@ -581,7 +575,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         /* We're connecting to an already opened device, so let's make s=
ure we
            also get the open event */
         if (s->be_open) {
-            qemu_chr_be_generic_open(s);
+            qemu_chr_be_event(s, CHR_EVENT_OPENED);
         }
     }
=20
diff --git a/ui/console.c b/ui/console.c
index 49d0740b40..992f35a5e7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2056,7 +2056,7 @@ static void text_console_do_init(Chardev *chr, Disp=
layState *ds)
         s->t_attrib =3D s->t_attrib_default;
     }
=20
-    qemu_chr_be_generic_open(chr);
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
=20
 static void vc_chr_open(Chardev *chr,
diff --git a/ui/gtk.c b/ui/gtk.c
index f21e9e7f7b..08cac2f47b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1867,7 +1867,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, V=
irtualConsole *vc,
     gtk_notebook_append_page(GTK_NOTEBOOK(s->notebook), vc->tab_item,
                              gtk_label_new(vc->label));
=20
-    qemu_chr_be_generic_open(vc->vte.chr);
+    qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
=20
     return group;
 }
--=20
2.11.0.295.gd7dffce1c.dirty
