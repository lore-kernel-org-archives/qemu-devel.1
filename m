Received: from eggs.gnu.org ([209.51.188.92]:41504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOj-0002aZ-8r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOf-0005PP-Bw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwUON-0005IT-SF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF82B9A71
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:06:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 17:06:26 +0100
Message-Id: <20190220160628.6555-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190220160628.6555-1-marcandre.lureau@redhat.com>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] chardev: make qemu_chr_fe_set_handlers()
 context switching safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

qemu_chr_fe_set_handlers() may switch the context of various
sources. In order to prevent dispatch races from different threads,
let's acquire or freeze the context, do all the source switches, and
then release/resume the contexts. This should help to make context
switching safer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h |  23 +++++++++
 chardev/char-fe.c         | 103 +++++++++++++++++++++++++++++++++-----
 chardev/char-mux.c        |  14 +++---
 3 files changed, 121 insertions(+), 19 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index aa1b864ccd..4051435a1c 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -84,6 +84,14 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  * Set the front end char handlers. The front end takes the focus if
  * any of the handler is non-NULL.
  *
+ * A chardev may have multiple main loop sources. In order to prevent
+ * races when switching contexts, the function will temporarily block
+ * the contexts before the source switch to prevent them from
+ * dispatching in different threads concurrently.
+ *
+ * The current and the new @context must be acquirable or
+ * running & dispatched in a loop (the function will hang otherwise).
+ *
  * Without associated Chardev, nothing is changed.
  */
 void qemu_chr_fe_set_handlers_full(CharBackend *b,
@@ -110,6 +118,21 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               GMainContext *context,
                               bool set_open);
=20
+/**
+ * qemu_chr_fe_set_handlers_internal:
+ *
+ * Same as qemu_chr_fe_set_handlers(), without context freezing.
+ */
+void qemu_chr_fe_set_handlers_internal(CharBackend *b,
+                                       IOCanReadHandler *fd_can_read,
+                                       IOReadHandler *fd_read,
+                                       IOEventHandler *fd_event,
+                                       BackendChangeHandler *be_change,
+                                       void *opaque,
+                                       GMainContext *context,
+                                       bool set_open,
+                                       bool sync_state);
+
 /**
  * qemu_chr_fe_take_focus:
  *
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..90cd7db007 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -246,15 +246,67 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
     }
 }
=20
-void qemu_chr_fe_set_handlers_full(CharBackend *b,
-                                   IOCanReadHandler *fd_can_read,
-                                   IOReadHandler *fd_read,
-                                   IOEventHandler *fd_event,
-                                   BackendChangeHandler *be_change,
-                                   void *opaque,
-                                   GMainContext *context,
-                                   bool set_open,
-                                   bool sync_state)
+struct MainContextWait {
+    QemuCond cond;
+    QemuMutex lock;
+};
+
+static gboolean
+main_context_wait_cb(gpointer user_data)
+{
+    struct MainContextWait *w =3D user_data;
+
+    qemu_mutex_lock(&w->lock);
+    qemu_cond_signal(&w->cond);
+    /* wait until switching is over */
+    qemu_cond_wait(&w->cond, &w->lock);
+    qemu_mutex_unlock(&w->lock);
+
+    qemu_mutex_destroy(&w->lock);
+    qemu_cond_destroy(&w->cond);
+    g_free(w);
+
+    return G_SOURCE_REMOVE;
+}
+
+static void
+main_context_wait(struct MainContextWait **wait, GMainContext *ctxt)
+{
+    struct MainContextWait *w =3D NULL;
+
+    if (!g_main_context_acquire(ctxt)) {
+        w =3D g_new0(struct MainContextWait, 1);
+        qemu_mutex_init(&w->lock);
+        qemu_cond_init(&w->cond);
+        qemu_mutex_lock(&w->lock);
+        g_main_context_invoke(ctxt, main_context_wait_cb, w);
+        /* wait for the context to freeze */
+        qemu_cond_wait(&w->cond, &w->lock);
+        qemu_mutex_unlock(&w->lock);
+    }
+
+    *wait =3D w;
+}
+
+static void
+main_context_resume(struct MainContextWait *wait, GMainContext *ctxt)
+{
+    if (wait) {
+        qemu_cond_signal(&wait->cond);
+    } else {
+        g_main_context_release(ctxt);
+    }
+}
+
+void qemu_chr_fe_set_handlers_internal(CharBackend *b,
+                                       IOCanReadHandler *fd_can_read,
+                                       IOReadHandler *fd_read,
+                                       IOEventHandler *fd_event,
+                                       BackendChangeHandler *be_change,
+                                       void *opaque,
+                                       GMainContext *new_context,
+                                       bool set_open,
+                                       bool sync_state)
 {
     Chardev *s;
     int fe_open;
@@ -276,7 +328,7 @@ void qemu_chr_fe_set_handlers_full(CharBackend *b,
     b->chr_be_change =3D be_change;
     b->opaque =3D opaque;
=20
-    qemu_chr_be_update_read_handlers(s, context);
+    qemu_chr_be_update_read_handlers(s, new_context);
=20
     if (set_open) {
         qemu_chr_fe_set_open(b, fe_open);
@@ -292,6 +344,34 @@ void qemu_chr_fe_set_handlers_full(CharBackend *b,
     }
 }
=20
+void qemu_chr_fe_set_handlers_full(CharBackend *b,
+                                   IOCanReadHandler *fd_can_read,
+                                   IOReadHandler *fd_read,
+                                   IOEventHandler *fd_event,
+                                   BackendChangeHandler *be_change,
+                                   void *opaque,
+                                   GMainContext *new_context,
+                                   bool set_open,
+                                   bool sync_state)
+{
+    GMainContext *old_context =3D b->chr->gcontext;
+    struct MainContextWait *old_ctxt_wait, *new_ctxt_wait;
+
+    main_context_wait(&old_ctxt_wait, old_context);
+    if (old_context !=3D new_context) {
+        main_context_wait(&new_ctxt_wait, new_context);
+    }
+
+    qemu_chr_fe_set_handlers_internal(b, fd_can_read, fd_read, fd_event,
+                                      be_change, opaque, new_context,
+                                      set_open, sync_state);
+
+    main_context_resume(old_ctxt_wait, old_context);
+    if (old_context !=3D new_context) {
+        main_context_resume(new_ctxt_wait, new_context);
+    }
+}
+
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
@@ -302,8 +382,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     qemu_chr_fe_set_handlers_full(b, fd_can_read, fd_read, fd_event, be_=
change,
-                                  opaque, context, set_open,
-                                  true);
+                                  opaque, context, set_open, true);
 }
=20
 void qemu_chr_fe_take_focus(CharBackend *b)
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 23aa82125d..9830cc4b37 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -283,13 +283,13 @@ static void mux_chr_update_read_handlers(Chardev *c=
hr)
     MuxChardev *d =3D MUX_CHARDEV(chr);
=20
     /* Fix up the real driver with mux routines */
-    qemu_chr_fe_set_handlers_full(&d->chr,
-                                  mux_chr_can_read,
-                                  mux_chr_read,
-                                  mux_chr_event,
-                                  NULL,
-                                  chr,
-                                  chr->gcontext, true, false);
+    qemu_chr_fe_set_handlers_internal(&d->chr,
+                                      mux_chr_can_read,
+                                      mux_chr_read,
+                                      mux_chr_event,
+                                      NULL,
+                                      chr,
+                                      chr->gcontext, true, false);
 }
=20
 void mux_set_focus(Chardev *chr, int focus)
--=20
2.21.0.rc1
