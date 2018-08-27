Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv6-0003gX-Te
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv6-0005lW-5V
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPv5-0005l5-Ut
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F812400738B
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:17 +0200
Message-Id: <20180827222322.26009-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180827222322.26009-1-marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/9] char: update the mux hanlders in class
 callback
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

Instead of handling mux chardev in a special way in
qemu_chr_fe_set_handlers(), we may use the chr_update_read_handler
class callback instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-mux.h | 1 -
 chardev/char-fe.c          | 4 ----
 chardev/char-mux.c         | 5 +++--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 1e13187767..572cefd517 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -55,7 +55,6 @@ typedef struct MuxChardev {
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
=20
-void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, int event);
=20
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b1f228e8b5..6ed8bff46a 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -288,10 +288,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
             qemu_chr_be_event(s, CHR_EVENT_OPENED);
         }
     }
-
-    if (CHARDEV_IS_MUX(s)) {
-        mux_chr_set_handlers(s, context);
-    }
 }
=20
 void qemu_chr_fe_take_focus(CharBackend *b)
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6055e76293..9406eaf08d 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -278,7 +278,7 @@ static void char_mux_finalize(Object *obj)
     qemu_chr_fe_deinit(&d->chr, false);
 }
=20
-void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
+static void mux_chr_update_read_handlers(Chardev *chr)
 {
     MuxChardev *d =3D MUX_CHARDEV(chr);
=20
@@ -289,7 +289,7 @@ void mux_chr_set_handlers(Chardev *chr, GMainContext =
*context)
                              mux_chr_event,
                              NULL,
                              chr,
-                             context, true);
+                             chr->gcontext, true);
 }
=20
 void mux_set_focus(Chardev *chr, int focus)
@@ -383,6 +383,7 @@ static void char_mux_class_init(ObjectClass *oc, void=
 *data)
     cc->chr_add_watch =3D mux_chr_add_watch;
     cc->chr_be_event =3D mux_chr_be_event;
     cc->chr_machine_done =3D open_muxes;
+    cc->chr_update_read_handler =3D mux_chr_update_read_handlers;
 }
=20
 static const TypeInfo char_mux_type_info =3D {
--=20
2.18.0.547.g1d89318c48
