Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdZs-0005lG-26
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdZq-0006sy-Qv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:08:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eAdZq-0006sO-IO
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:08:10 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Nov 2017 16:07:57 +0100
Message-Id: <20171103150758.15005-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171103150758.15005-1-marcandre.lureau@redhat.com>
References: <20171103150758.15005-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] chardev: fix backend events regression
 with mux chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kirill.shutemov@linux.intel.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Kirill noticied that on recent versions on QEMU he was not able to
trigger SysRq to invoke debug capabilites of Linux Kernel.  He tracked
it down to qemu_chr_be_event() ignoring CHR_EVENT_BREAK due s->be
being NULL. The bug was introduced in 2.8, commit a4afa548fc6d ("char:
move front end handlers in CharBackend"). Since the commit, the
qemu_chr_be_event() failed to deliver CHR_EVENT_BREAK due to
qemu_chr_fe_init() does not set s->be in case of mux.

Let's fix this by teaching mux to send an event to the frontend with
the focus.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
---
 include/chardev/char.h |  1 +
 chardev/char-mux.c     |  6 ++++++
 chardev/char.c         | 18 ++++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 43aabccef5..778d610295 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -248,6 +248,7 @@ typedef struct ChardevClass {
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
+    void (*chr_be_event)(Chardev *s, int event);
 } ChardevClass;
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 4cda5e7458..2281f07cb5 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -123,6 +123,11 @@ static void mux_chr_send_event(MuxChardev *d, int mu=
x_nr, int event)
     }
 }
=20
+static void mux_chr_be_event(MuxChardev *d, int event)
+{
+    mux_chr_send_event(d, d->focus, event);
+}
+
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
@@ -346,6 +351,7 @@ static void char_mux_class_init(ObjectClass *oc, void=
 *data)
     cc->chr_write =3D mux_chr_write;
     cc->chr_accept_input =3D mux_chr_accept_input;
     cc->chr_add_watch =3D mux_chr_add_watch;
+    cc->chr_be_event =3D mux_chr_be_event;
 }
=20
 static const TypeInfo char_mux_type_info =3D {
diff --git a/chardev/char.c b/chardev/char.c
index 2ae4f465ec..8c3765ee99 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -43,10 +43,19 @@ static Object *get_chardevs_root(void)
     return container_get(object_get_root(), "/chardevs");
 }
=20
-void qemu_chr_be_event(Chardev *s, int event)
+static void chr_be_event(Chardev *s, int event)
 {
     CharBackend *be =3D s->be;
=20
+    if (!be || !be->chr_event) {
+        return;
+    }
+
+    be->chr_event(be->opaque, event);
+}
+
+void qemu_chr_be_event(Chardev *s, int event)
+{
     /* Keep track if the char device is open */
     switch (event) {
         case CHR_EVENT_OPENED:
@@ -57,11 +66,7 @@ void qemu_chr_be_event(Chardev *s, int event)
             break;
     }
=20
-    if (!be || !be->chr_event) {
-        return;
-    }
-
-    be->chr_event(be->opaque, event);
+    CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
 }
=20
 /* Not reporting errors from writing to logfile, as logs are
@@ -244,6 +249,7 @@ static void char_class_init(ObjectClass *oc, void *da=
ta)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->chr_write =3D null_chr_write;
+    cc->chr_be_event =3D chr_be_event;
 }
=20
 static void char_finalize(Object *obj)
--=20
2.15.0.rc0.40.gaefcc5f6f
