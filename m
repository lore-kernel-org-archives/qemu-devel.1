Received: from eggs.gnu.org ([2001:4830:134:3::10]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJeG9-0006n5-M7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJeG2-0000aW-QR
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:34 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gJeFw-0000BL-SE
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:29 -0500
Received: by mail-lf1-x141.google.com with SMTP id u18so6001105lff.10
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:45:20 -0800 (PST)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Mon,  5 Nov 2018 18:45:09 +0600
Message-Id: <a0c4014ec4a385affeb1c97fbf77d4cd5fc1c214.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/2] chardev: fix mess in OPENED/CLOSED
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

When chardev is multiplexed (mux=on) there are a lot of cases, when
CHR_EVENT_OPENED/CHR_EVENT_CLOSED events pairing (expected from
frontend side) is broken. There are either generation of multiple
repeated or extra CHR_EVENT_OPENED events, or CHR_EVENT_CLOSED just
isn't generated at all (when it does with mux=off).
Fix that.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 chardev/char-fe.c         | 33 ++++++++++++++++++++++++---------
 chardev/char-mux.c        | 16 ++++++++--------
 include/chardev/char-fe.h | 18 +++++++++++++++++-
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a8931f7..b7bcbd5 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -246,14 +246,15 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
     }
 }
 
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
         /* We're connecting to an already opened device, so let's make sure we
            also get the open event */
-        if (s->be_open) {
+        if (sync_state && s->be_open) {
             qemu_chr_be_event(s, CHR_EVENT_OPENED);
         }
     }
@@ -295,6 +296,20 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     }
 }
 
+void qemu_chr_fe_set_handlers(CharBackend *b,
+                              IOCanReadHandler *fd_can_read,
+                              IOReadHandler *fd_read,
+                              IOEventHandler *fd_event,
+                              BackendChangeHandler *be_change,
+                              void *opaque,
+                              GMainContext *context,
+                              bool set_open)
+{
+    qemu_chr_fe_set_handlers_full(b, fd_can_read, fd_read, fd_event, be_change,
+                                  opaque, context, set_open,
+                                  true);
+}
+
 void qemu_chr_fe_take_focus(CharBackend *b)
 {
     if (!b->chr) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6055e76..1199d32 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -283,13 +283,13 @@ void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
     MuxChardev *d = MUX_CHARDEV(chr);
 
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
 
 void mux_set_focus(Chardev *chr, int focus)
@@ -367,7 +367,7 @@ static int open_muxes(Chardev *chr)
      * mark mux as OPENED so any new FEs will immediately receive
      * OPENED event
      */
-    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    chr->be_open = 1;
 
     return 0;
 }
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 46c997d..c1b7fd9 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -67,7 +67,7 @@ bool qemu_chr_fe_backend_connected(CharBackend *be);
 bool qemu_chr_fe_backend_open(CharBackend *be);
 
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
+ * Version of qemu_chr_fe_set_handlers_full() with sync_state = true.
+ */
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
-- 
2.7.4
