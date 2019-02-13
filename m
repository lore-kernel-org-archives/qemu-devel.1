Received: from eggs.gnu.org ([209.51.188.92]:39525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGX-0004XV-Lt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGU-0005lr-7F
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGU-0005lb-0T
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:09 +0100
Message-Id: <20190213161913.22107-22-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 21/25] char: update the mux handlers in class
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
Cc: peter.maydell@linaro.org

Instead of handling mux chardev in a special way in
qemu_chr_fe_set_handlers(), we may use the chr_update_read_handler
class callback instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190206174328.9736-2-marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
index b7bcbd59c0..f3530a90e6 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -290,10 +290,6 @@ void qemu_chr_fe_set_handlers_full(CharBackend *b,
             qemu_chr_be_event(s, CHR_EVENT_OPENED);
         }
     }
-
-    if (CHARDEV_IS_MUX(s)) {
-        mux_chr_set_handlers(s, context);
-    }
 }
=20
 void qemu_chr_fe_set_handlers(CharBackend *b,
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 1199d32674..23aa82125d 100644
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
-                                  context, true, false);
+                                  chr->gcontext, true, false);
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
2.21.0.rc0.1.g036caf7885
