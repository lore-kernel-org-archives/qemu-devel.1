Received: from eggs.gnu.org ([209.51.188.92]:39192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG5-000450-Q4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG2-0005Js-44
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxG1-000597-F7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:18:49 +0100
Message-Id: <20190213161913.22107-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/25] chardev: fix mess in OPENED/CLOSED
 events when muxed
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

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

When chardev is multiplexed (mux=3Don) there are a lot of cases where
CHR_EVENT_OPENED/CHR_EVENT_CLOSED events pairing (expected from
frontend side) is broken. There are either generation of multiple
repeated or extra CHR_EVENT_OPENED events, or CHR_EVENT_CLOSED just
isn't generated at all.
This is mostly because 'qemu_chr_fe_set_handlers()' function makes its
own (and often wrong) implicit decision on updated frontend state and
invokes 'fd_event' callback with 'CHR_EVENT_OPENED'. And even worse,
it doesn't do symmetric action in opposite direction, as someone may
expect (i.e. it doesn't invoke previously set 'fd_event' with
'CHR_EVENT_CLOSED'). Muxed chardev uses trick by calling this function
again to replace callback handlers with its own ones, but it doesn't
account for such side effect.
Fix that using extended version of this function with added argument
for disabling side effect and keep original function for compatibility
with lots of frontends already using this interface and being
"tolerant" to its side effects.
One more source of event duplication is just line of code in
char-mux.c, which does far more than comment above says (obvious fix).

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <7dde6abbd21682857f8294644013173c0b9949b3.1541507990.git.arte=
m.k.pisarenko@gmail.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h | 18 +++++++++++++++++-
 chardev/char-fe.c         | 33 ++++++++++++++++++++++++---------
 chardev/char-mux.c        | 16 ++++++++--------
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 46c997d352..c1b7fd9a95 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -67,7 +67,7 @@ bool qemu_chr_fe_backend_connected(CharBackend *be);
 bool qemu_chr_fe_backend_open(CharBackend *be);
=20
 /**
- * qemu_chr_fe_set_handlers:
+ * qemu_chr_fe_set_handlers_full:
  * @b: a CharBackend
  * @fd_can_read: callback to get the amount of data the frontend may
  *               receive
@@ -79,12 +79,28 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  * @context: a main loop context or NULL for the default
  * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
  * any of the handler is non-NULL
+ * @sync_state: whether to issue event callback with updated state
  *
  * Set the front end char handlers. The front end takes the focus if
  * any of the handler is non-NULL.
  *
  * Without associated Chardev, nothing is changed.
  */
+void qemu_chr_fe_set_handlers_full(CharBackend *b,
+                                   IOCanReadHandler *fd_can_read,
+                                   IOReadHandler *fd_read,
+                                   IOEventHandler *fd_event,
+                                   BackendChangeHandler *be_change,
+                                   void *opaque,
+                                   GMainContext *context,
+                                   bool set_open,
+                                   bool sync_state);
+
+/**
+ * qemu_chr_fe_set_handlers:
+ *
+ * Version of qemu_chr_fe_set_handlers_full() with sync_state =3D true.
+ */
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a8931f7afd..b7bcbd59c0 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -246,14 +246,15 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
     }
 }
=20
-void qemu_chr_fe_set_handlers(CharBackend *b,
-                              IOCanReadHandler *fd_can_read,
-                              IOReadHandler *fd_read,
-                              IOEventHandler *fd_event,
-                              BackendChangeHandler *be_change,
-                              void *opaque,
-                              GMainContext *context,
-                              bool set_open)
+void qemu_chr_fe_set_handlers_full(CharBackend *b,
+                                   IOCanReadHandler *fd_can_read,
+                                   IOReadHandler *fd_read,
+                                   IOEventHandler *fd_event,
+                                   BackendChangeHandler *be_change,
+                                   void *opaque,
+                                   GMainContext *context,
+                                   bool set_open,
+                                   bool sync_state)
 {
     Chardev *s;
     int fe_open;
@@ -285,7 +286,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         qemu_chr_fe_take_focus(b);
         /* We're connecting to an already opened device, so let's make s=
ure we
            also get the open event */
-        if (s->be_open) {
+        if (sync_state && s->be_open) {
             qemu_chr_be_event(s, CHR_EVENT_OPENED);
         }
     }
@@ -295,6 +296,20 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     }
 }
=20
+void qemu_chr_fe_set_handlers(CharBackend *b,
+                              IOCanReadHandler *fd_can_read,
+                              IOReadHandler *fd_read,
+                              IOEventHandler *fd_event,
+                              BackendChangeHandler *be_change,
+                              void *opaque,
+                              GMainContext *context,
+                              bool set_open)
+{
+    qemu_chr_fe_set_handlers_full(b, fd_can_read, fd_read, fd_event, be_=
change,
+                                  opaque, context, set_open,
+                                  true);
+}
+
 void qemu_chr_fe_take_focus(CharBackend *b)
 {
     if (!b->chr) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6055e76293..1199d32674 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -283,13 +283,13 @@ void mux_chr_set_handlers(Chardev *chr, GMainContex=
t *context)
     MuxChardev *d =3D MUX_CHARDEV(chr);
=20
     /* Fix up the real driver with mux routines */
-    qemu_chr_fe_set_handlers(&d->chr,
-                             mux_chr_can_read,
-                             mux_chr_read,
-                             mux_chr_event,
-                             NULL,
-                             chr,
-                             context, true);
+    qemu_chr_fe_set_handlers_full(&d->chr,
+                                  mux_chr_can_read,
+                                  mux_chr_read,
+                                  mux_chr_event,
+                                  NULL,
+                                  chr,
+                                  context, true, false);
 }
=20
 void mux_set_focus(Chardev *chr, int focus)
@@ -367,7 +367,7 @@ static int open_muxes(Chardev *chr)
      * mark mux as OPENED so any new FEs will immediately receive
      * OPENED event
      */
-    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    chr->be_open =3D 1;
=20
     return 0;
 }
--=20
2.21.0.rc0.1.g036caf7885
