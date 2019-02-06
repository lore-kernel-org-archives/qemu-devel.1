Received: from eggs.gnu.org ([209.51.188.92]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRFI-00068h-S0
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRFB-0004eo-1P
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grRFA-00040y-Kz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41B2480F7B
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:43:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:23 +0100
Message-Id: <20190206174328.9736-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] char: update the mux handlers in class
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index a8931f7afd..f69ca18647 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -289,10 +289,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
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
2.20.1.519.g8feddda32c
