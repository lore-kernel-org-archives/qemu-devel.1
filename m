Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbD2-0000xY-Ve
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCy-0001BB-TU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCy-0001B4-GO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:05 +0400
Message-Id: <20170131162122.29408-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/41] char: move mux to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A mechanical move, except that qemu_chr_write_all() needs to be declared
in char.h header to be used from chardev unit files.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-mux.h    |  63 +++++++++
 include/sysemu/char.h |   3 +-
 chardev/char-mux.c    | 358 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 352 +-------------------------------------------=
-----
 chardev/Makefile.objs |   1 +
 5 files changed, 426 insertions(+), 351 deletions(-)
 create mode 100644 chardev/char-mux.h
 create mode 100644 chardev/char-mux.c

diff --git a/chardev/char-mux.h b/chardev/char-mux.h
new file mode 100644
index 0000000000..9a2fffce91
--- /dev/null
+++ b/chardev/char-mux.h
@@ -0,0 +1,63 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#ifndef CHAR_MUX_H
+#define CHAR_MUX_H
+
+#include "sysemu/char.h"
+
+extern bool muxes_realized;
+
+#define MAX_MUX 4
+#define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
+#define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
+typedef struct MuxChardev {
+    Chardev parent;
+    CharBackend *backends[MAX_MUX];
+    CharBackend chr;
+    int focus;
+    int mux_cnt;
+    int term_got_escape;
+    int max_size;
+    /* Intermediate input buffer catches escape sequences even if the
+       currently active device is not accepting any input - but only unt=
il it
+       is full as well. */
+    unsigned char buffer[MAX_MUX][MUX_BUFFER_SIZE];
+    int prod[MAX_MUX];
+    int cons[MAX_MUX];
+    int timestamps;
+
+    /* Protected by the Chardev chr_write_lock.  */
+    int linestart;
+    int64_t timestamps_start;
+} MuxChardev;
+
+#define MUX_CHARDEV(obj) OBJECT_CHECK(MuxChardev, (obj), TYPE_CHARDEV_MU=
X)
+#define CHARDEV_IS_MUX(chr)                             \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+
+void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
+void mux_set_focus(Chardev *chr, int focus);
+void mux_chr_send_event(MuxChardev *d, int mux_nr, int event);
+
+#endif /* CHAR_MUX_H */
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 31229deaca..1e1f5c7b2b 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -441,6 +441,7 @@ bool qemu_chr_has_feature(Chardev *chr,
 void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
+int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len);
=20
 #define TYPE_CHARDEV "chardev"
 #define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
@@ -463,8 +464,6 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename);
 #define TYPE_CHARDEV_SOCKET "chardev-socket"
 #define TYPE_CHARDEV_UDP "chardev-udp"
=20
-#define CHARDEV_IS_MUX(chr) \
-    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 #define CHARDEV_IS_RINGBUF(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
 #define CHARDEV_IS_PTY(chr) \
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
new file mode 100644
index 0000000000..5547a36a0a
--- /dev/null
+++ b/chardev/char-mux.c
@@ -0,0 +1,358 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+#include "sysemu/block-backend.h"
+#include "char-mux.h"
+
+/* MUX driver for serial I/O splitting */
+
+/* Called with chr_write_lock held.  */
+static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    MuxChardev *d =3D MUX_CHARDEV(chr);
+    int ret;
+    if (!d->timestamps) {
+        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
+    } else {
+        int i;
+
+        ret =3D 0;
+        for (i =3D 0; i < len; i++) {
+            if (d->linestart) {
+                char buf1[64];
+                int64_t ti;
+                int secs;
+
+                ti =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+                if (d->timestamps_start =3D=3D -1) {
+                    d->timestamps_start =3D ti;
+                }
+                ti -=3D d->timestamps_start;
+                secs =3D ti / 1000;
+                snprintf(buf1, sizeof(buf1),
+                         "[%02d:%02d:%02d.%03d] ",
+                         secs / 3600,
+                         (secs / 60) % 60,
+                         secs % 60,
+                         (int)(ti % 1000));
+                /* XXX this blocks entire thread. Rewrite to use
+                 * qemu_chr_fe_write and background I/O callbacks */
+                qemu_chr_fe_write_all(&d->chr,
+                                      (uint8_t *)buf1, strlen(buf1));
+                d->linestart =3D 0;
+            }
+            ret +=3D qemu_chr_fe_write(&d->chr, buf + i, 1);
+            if (buf[i] =3D=3D '\n') {
+                d->linestart =3D 1;
+            }
+        }
+    }
+    return ret;
+}
+
+static const char * const mux_help[] =3D {
+    "% h    print this help\n\r",
+    "% x    exit emulator\n\r",
+    "% s    save disk data back to file (if -snapshot)\n\r",
+    "% t    toggle console timestamps\n\r",
+    "% b    send break (magic sysrq)\n\r",
+    "% c    switch between console and monitor\n\r",
+    "% %  sends %\n\r",
+    NULL
+};
+
+int term_escape_char =3D 0x01; /* ctrl-a is used for escape */
+static void mux_print_help(Chardev *chr)
+{
+    int i, j;
+    char ebuf[15] =3D "Escape-Char";
+    char cbuf[50] =3D "\n\r";
+
+    if (term_escape_char > 0 && term_escape_char < 26) {
+        snprintf(cbuf, sizeof(cbuf), "\n\r");
+        snprintf(ebuf, sizeof(ebuf), "C-%c", term_escape_char - 1 + 'a')=
;
+    } else {
+        snprintf(cbuf, sizeof(cbuf),
+                 "\n\rEscape-Char set to Ascii: 0x%02x\n\r\n\r",
+                 term_escape_char);
+    }
+    /* XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks */
+    qemu_chr_write_all(chr, (uint8_t *)cbuf, strlen(cbuf));
+    for (i =3D 0; mux_help[i] !=3D NULL; i++) {
+        for (j =3D 0; mux_help[i][j] !=3D '\0'; j++) {
+            if (mux_help[i][j] =3D=3D '%') {
+                qemu_chr_write_all(chr, (uint8_t *)ebuf, strlen(ebuf));
+            } else {
+                qemu_chr_write_all(chr, (uint8_t *)&mux_help[i][j], 1);
+            }
+        }
+    }
+}
+
+void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
+{
+    CharBackend *be =3D d->backends[mux_nr];
+
+    if (be && be->chr_event) {
+        be->chr_event(be->opaque, event);
+    }
+}
+
+static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
+{
+    if (d->term_got_escape) {
+        d->term_got_escape =3D 0;
+        if (ch =3D=3D term_escape_char) {
+            goto send_char;
+        }
+        switch (ch) {
+        case '?':
+        case 'h':
+            mux_print_help(chr);
+            break;
+        case 'x':
+            {
+                 const char *term =3D  "QEMU: Terminated\n\r";
+                 qemu_chr_write_all(chr, (uint8_t *)term, strlen(term));
+                 exit(0);
+                 break;
+            }
+        case 's':
+            blk_commit_all();
+            break;
+        case 'b':
+            qemu_chr_be_event(chr, CHR_EVENT_BREAK);
+            break;
+        case 'c':
+            assert(d->mux_cnt > 0); /* handler registered with first fe =
*/
+            /* Switch to the next registered device */
+            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
+            break;
+        case 't':
+            d->timestamps =3D !d->timestamps;
+            d->timestamps_start =3D -1;
+            d->linestart =3D 0;
+            break;
+        }
+    } else if (ch =3D=3D term_escape_char) {
+        d->term_got_escape =3D 1;
+    } else {
+    send_char:
+        return 1;
+    }
+    return 0;
+}
+
+static void mux_chr_accept_input(Chardev *chr)
+{
+    MuxChardev *d =3D MUX_CHARDEV(chr);
+    int m =3D d->focus;
+    CharBackend *be =3D d->backends[m];
+
+    while (be && d->prod[m] !=3D d->cons[m] &&
+           be->chr_can_read && be->chr_can_read(be->opaque)) {
+        be->chr_read(be->opaque,
+                     &d->buffer[m][d->cons[m]++ & MUX_BUFFER_MASK], 1);
+    }
+}
+
+static int mux_chr_can_read(void *opaque)
+{
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
+    int m =3D d->focus;
+    CharBackend *be =3D d->backends[m];
+
+    if ((d->prod[m] - d->cons[m]) < MUX_BUFFER_SIZE) {
+        return 1;
+    }
+
+    if (be && be->chr_can_read) {
+        return be->chr_can_read(be->opaque);
+    }
+
+    return 0;
+}
+
+static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
+    int m =3D d->focus;
+    CharBackend *be =3D d->backends[m];
+    int i;
+
+    mux_chr_accept_input(opaque);
+
+    for (i =3D 0; i < size; i++)
+        if (mux_proc_byte(chr, d, buf[i])) {
+            if (d->prod[m] =3D=3D d->cons[m] &&
+                be && be->chr_can_read &&
+                be->chr_can_read(be->opaque)) {
+                be->chr_read(be->opaque, &buf[i], 1);
+            } else {
+                d->buffer[m][d->prod[m]++ & MUX_BUFFER_MASK] =3D buf[i];
+            }
+        }
+}
+
+bool muxes_realized;
+
+static void mux_chr_event(void *opaque, int event)
+{
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
+    int i;
+
+    if (!muxes_realized) {
+        return;
+    }
+
+    /* Send the event to all registered listeners */
+    for (i =3D 0; i < d->mux_cnt; i++) {
+        mux_chr_send_event(d, i, event);
+    }
+}
+
+static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
+{
+    MuxChardev *d =3D MUX_CHARDEV(s);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
+    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
+
+    if (!cc->chr_add_watch) {
+        return NULL;
+    }
+
+    return cc->chr_add_watch(chr, cond);
+}
+
+static void char_mux_finalize(Object *obj)
+{
+    MuxChardev *d =3D MUX_CHARDEV(obj);
+    int i;
+
+    for (i =3D 0; i < d->mux_cnt; i++) {
+        CharBackend *be =3D d->backends[i];
+        if (be) {
+            be->chr =3D NULL;
+        }
+    }
+    qemu_chr_fe_deinit(&d->chr);
+}
+
+void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
+{
+    MuxChardev *d =3D MUX_CHARDEV(chr);
+
+    /* Fix up the real driver with mux routines */
+    qemu_chr_fe_set_handlers(&d->chr,
+                             mux_chr_can_read,
+                             mux_chr_read,
+                             mux_chr_event,
+                             chr,
+                             context, true);
+}
+
+void mux_set_focus(Chardev *chr, int focus)
+{
+    MuxChardev *d =3D MUX_CHARDEV(chr);
+
+    assert(focus >=3D 0);
+    assert(focus < d->mux_cnt);
+
+    if (d->focus !=3D -1) {
+        mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
+    }
+
+    d->focus =3D focus;
+    mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
+}
+
+static void qemu_chr_open_mux(Chardev *chr,
+                              ChardevBackend *backend,
+                              bool *be_opened,
+                              Error **errp)
+{
+    ChardevMux *mux =3D backend->u.mux.data;
+    Chardev *drv;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
+
+    drv =3D qemu_chr_find(mux->chardev);
+    if (drv =3D=3D NULL) {
+        error_setg(errp, "mux: base chardev %s not found", mux->chardev)=
;
+        return;
+    }
+
+    d->focus =3D -1;
+    /* only default to opened state if we've realized the initial
+     * set of muxes
+     */
+    *be_opened =3D muxes_realized;
+    qemu_chr_fe_init(&d->chr, drv, errp);
+}
+
+static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
+                               Error **errp)
+{
+    const char *chardev =3D qemu_opt_get(opts, "chardev");
+    ChardevMux *mux;
+
+    if (chardev =3D=3D NULL) {
+        error_setg(errp, "chardev: mux: no chardev given");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_MUX;
+    mux =3D backend->u.mux.data =3D g_new0(ChardevMux, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));
+    mux->chardev =3D g_strdup(chardev);
+}
+
+static void char_mux_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_mux;
+    cc->open =3D qemu_chr_open_mux;
+    cc->chr_write =3D mux_chr_write;
+    cc->chr_accept_input =3D mux_chr_accept_input;
+    cc->chr_add_watch =3D mux_chr_add_watch;
+}
+
+static const TypeInfo char_mux_type_info =3D {
+    .name =3D TYPE_CHARDEV_MUX,
+    .parent =3D TYPE_CHARDEV,
+    .class_init =3D char_mux_class_init,
+    .instance_size =3D sizeof(MuxChardev),
+    .instance_finalize =3D char_mux_finalize,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_mux_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 2ca6c7cf67..c8d03776b1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -85,12 +85,12 @@
 #include "qemu/sockets.h"
 #include "ui/qemu-spice.h"
=20
+#include "char-mux.h"
+
 #define READ_BUF_LEN 4096
 #define READ_RETRIES 10
 #define TCP_MAX_FDS 16
=20
-typedef struct MuxChardev MuxChardev;
-
 /***********************************************************/
 /* Socket address helpers */
=20
@@ -284,7 +284,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
     return ret;
 }
=20
-static int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
+int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
 {
     int offset;
     int res;
@@ -482,8 +482,6 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
 }
=20
 static void remove_fd_in_watch(Chardev *chr);
-static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
-static void mux_set_focus(Chardev *chr, int focus);
=20
 static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
@@ -560,235 +558,6 @@ static const TypeInfo char_type_info =3D {
     .class_init =3D char_class_init,
 };
=20
-/* MUX driver for serial I/O splitting */
-#define MAX_MUX 4
-#define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
-#define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
-struct MuxChardev {
-    Chardev parent;
-    CharBackend *backends[MAX_MUX];
-    CharBackend chr;
-    int focus;
-    int mux_cnt;
-    int term_got_escape;
-    int max_size;
-    /* Intermediate input buffer allows to catch escape sequences even i=
f the
-       currently active device is not accepting any input - but only unt=
il it
-       is full as well. */
-    unsigned char buffer[MAX_MUX][MUX_BUFFER_SIZE];
-    int prod[MAX_MUX];
-    int cons[MAX_MUX];
-    int timestamps;
-
-    /* Protected by the Chardev chr_write_lock.  */
-    int linestart;
-    int64_t timestamps_start;
-};
-
-#define MUX_CHARDEV(obj) OBJECT_CHECK(MuxChardev, (obj), TYPE_CHARDEV_MU=
X)
-
-/* Called with chr_write_lock held.  */
-static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    MuxChardev *d =3D MUX_CHARDEV(chr);
-    int ret;
-    if (!d->timestamps) {
-        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
-    } else {
-        int i;
-
-        ret =3D 0;
-        for (i =3D 0; i < len; i++) {
-            if (d->linestart) {
-                char buf1[64];
-                int64_t ti;
-                int secs;
-
-                ti =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-                if (d->timestamps_start =3D=3D -1)
-                    d->timestamps_start =3D ti;
-                ti -=3D d->timestamps_start;
-                secs =3D ti / 1000;
-                snprintf(buf1, sizeof(buf1),
-                         "[%02d:%02d:%02d.%03d] ",
-                         secs / 3600,
-                         (secs / 60) % 60,
-                         secs % 60,
-                         (int)(ti % 1000));
-                /* XXX this blocks entire thread. Rewrite to use
-                 * qemu_chr_fe_write and background I/O callbacks */
-                qemu_chr_fe_write_all(&d->chr,
-                                      (uint8_t *)buf1, strlen(buf1));
-                d->linestart =3D 0;
-            }
-            ret +=3D qemu_chr_fe_write(&d->chr, buf + i, 1);
-            if (buf[i] =3D=3D '\n') {
-                d->linestart =3D 1;
-            }
-        }
-    }
-    return ret;
-}
-
-static const char * const mux_help[] =3D {
-    "% h    print this help\n\r",
-    "% x    exit emulator\n\r",
-    "% s    save disk data back to file (if -snapshot)\n\r",
-    "% t    toggle console timestamps\n\r",
-    "% b    send break (magic sysrq)\n\r",
-    "% c    switch between console and monitor\n\r",
-    "% %  sends %\n\r",
-    NULL
-};
-
-int term_escape_char =3D 0x01; /* ctrl-a is used for escape */
-static void mux_print_help(Chardev *chr)
-{
-    int i, j;
-    char ebuf[15] =3D "Escape-Char";
-    char cbuf[50] =3D "\n\r";
-
-    if (term_escape_char > 0 && term_escape_char < 26) {
-        snprintf(cbuf, sizeof(cbuf), "\n\r");
-        snprintf(ebuf, sizeof(ebuf), "C-%c", term_escape_char - 1 + 'a')=
;
-    } else {
-        snprintf(cbuf, sizeof(cbuf),
-                 "\n\rEscape-Char set to Ascii: 0x%02x\n\r\n\r",
-                 term_escape_char);
-    }
-    /* XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks */
-    qemu_chr_write_all(chr, (uint8_t *)cbuf, strlen(cbuf));
-    for (i =3D 0; mux_help[i] !=3D NULL; i++) {
-        for (j=3D0; mux_help[i][j] !=3D '\0'; j++) {
-            if (mux_help[i][j] =3D=3D '%')
-                qemu_chr_write_all(chr, (uint8_t *)ebuf, strlen(ebuf));
-            else
-                qemu_chr_write_all(chr, (uint8_t *)&mux_help[i][j], 1);
-        }
-    }
-}
-
-static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
-{
-    CharBackend *be =3D d->backends[mux_nr];
-
-    if (be && be->chr_event) {
-        be->chr_event(be->opaque, event);
-    }
-}
-
-static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
-{
-    if (d->term_got_escape) {
-        d->term_got_escape =3D 0;
-        if (ch =3D=3D term_escape_char)
-            goto send_char;
-        switch(ch) {
-        case '?':
-        case 'h':
-            mux_print_help(chr);
-            break;
-        case 'x':
-            {
-                 const char *term =3D  "QEMU: Terminated\n\r";
-                 qemu_chr_write_all(chr, (uint8_t *)term, strlen(term));
-                 exit(0);
-                 break;
-            }
-        case 's':
-            blk_commit_all();
-            break;
-        case 'b':
-            qemu_chr_be_event(chr, CHR_EVENT_BREAK);
-            break;
-        case 'c':
-            assert(d->mux_cnt > 0); /* handler registered with first fe =
*/
-            /* Switch to the next registered device */
-            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
-            break;
-        case 't':
-            d->timestamps =3D !d->timestamps;
-            d->timestamps_start =3D -1;
-            d->linestart =3D 0;
-            break;
-        }
-    } else if (ch =3D=3D term_escape_char) {
-        d->term_got_escape =3D 1;
-    } else {
-    send_char:
-        return 1;
-    }
-    return 0;
-}
-
-static void mux_chr_accept_input(Chardev *chr)
-{
-    MuxChardev *d =3D MUX_CHARDEV(chr);
-    int m =3D d->focus;
-    CharBackend *be =3D d->backends[m];
-
-    while (be && d->prod[m] !=3D d->cons[m] &&
-           be->chr_can_read && be->chr_can_read(be->opaque)) {
-        be->chr_read(be->opaque,
-                     &d->buffer[m][d->cons[m]++ & MUX_BUFFER_MASK], 1);
-    }
-}
-
-static int mux_chr_can_read(void *opaque)
-{
-    MuxChardev *d =3D MUX_CHARDEV(opaque);
-    int m =3D d->focus;
-    CharBackend *be =3D d->backends[m];
-
-    if ((d->prod[m] - d->cons[m]) < MUX_BUFFER_SIZE) {
-        return 1;
-    }
-
-    if (be && be->chr_can_read) {
-        return be->chr_can_read(be->opaque);
-    }
-
-    return 0;
-}
-
-static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    MuxChardev *d =3D MUX_CHARDEV(opaque);
-    int m =3D d->focus;
-    CharBackend *be =3D d->backends[m];
-    int i;
-
-    mux_chr_accept_input(opaque);
-
-    for (i =3D 0; i < size; i++)
-        if (mux_proc_byte(chr, d, buf[i])) {
-            if (d->prod[m] =3D=3D d->cons[m] &&
-                be && be->chr_can_read &&
-                be->chr_can_read(be->opaque))
-                be->chr_read(be->opaque, &buf[i], 1);
-            else
-                d->buffer[m][d->prod[m]++ & MUX_BUFFER_MASK] =3D buf[i];
-        }
-}
-
-static bool muxes_realized;
-
-static void mux_chr_event(void *opaque, int event)
-{
-    MuxChardev *d =3D MUX_CHARDEV(opaque);
-    int i;
-
-    if (!muxes_realized) {
-        return;
-    }
-
-    /* Send the event to all registered listeners */
-    for (i =3D 0; i < d->mux_cnt; i++)
-        mux_chr_send_event(d, i, event);
-}
-
 /**
  * Called after processing of default and command-line-specified
  * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
@@ -827,85 +596,6 @@ static Notifier muxes_realize_notify =3D {
     .notify =3D muxes_realize_done,
 };
=20
-static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
-{
-    MuxChardev *d =3D MUX_CHARDEV(s);
-    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
-    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
-
-    if (!cc->chr_add_watch) {
-        return NULL;
-    }
-
-    return cc->chr_add_watch(chr, cond);
-}
-
-static void char_mux_finalize(Object *obj)
-{
-    MuxChardev *d =3D MUX_CHARDEV(obj);
-    int i;
-
-    for (i =3D 0; i < d->mux_cnt; i++) {
-        CharBackend *be =3D d->backends[i];
-        if (be) {
-            be->chr =3D NULL;
-        }
-    }
-    qemu_chr_fe_deinit(&d->chr);
-}
-
-static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
-{
-    MuxChardev *d =3D MUX_CHARDEV(chr);
-
-    /* Fix up the real driver with mux routines */
-    qemu_chr_fe_set_handlers(&d->chr,
-                             mux_chr_can_read,
-                             mux_chr_read,
-                             mux_chr_event,
-                             chr,
-                             context, true);
-}
-
-static void mux_set_focus(Chardev *chr, int focus)
-{
-    MuxChardev *d =3D MUX_CHARDEV(chr);
-
-    assert(focus >=3D 0);
-    assert(focus < d->mux_cnt);
-
-    if (d->focus !=3D -1) {
-        mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
-    }
-
-    d->focus =3D focus;
-    chr->be =3D d->backends[focus];
-    mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
-}
-
-static void qemu_chr_open_mux(Chardev *chr,
-                              ChardevBackend *backend,
-                              bool *be_opened,
-                              Error **errp)
-{
-    ChardevMux *mux =3D backend->u.mux.data;
-    Chardev *drv;
-    MuxChardev *d =3D MUX_CHARDEV(chr);
-
-    drv =3D qemu_chr_find(mux->chardev);
-    if (drv =3D=3D NULL) {
-        error_setg(errp, "mux: base chardev %s not found", mux->chardev)=
;
-        return;
-    }
-
-    d->focus =3D -1;
-    /* only default to opened state if we've realized the initial
-     * set of muxes
-     */
-    *be_opened =3D muxes_realized;
-    qemu_chr_fe_init(&d->chr, drv, errp);
-}
-
 Chardev *qemu_chr_fe_get_driver(CharBackend *be)
 {
     return be->chr;
@@ -3950,41 +3640,6 @@ static const TypeInfo char_memory_type_info =3D {
     .parent =3D TYPE_CHARDEV_RINGBUF,
 };
=20
-static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
-                               Error **errp)
-{
-    const char *chardev =3D qemu_opt_get(opts, "chardev");
-    ChardevMux *mux;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_MUX;
-    if (chardev =3D=3D NULL) {
-        error_setg(errp, "chardev: mux: no chardev given");
-        return;
-    }
-    mux =3D backend->u.mux.data =3D g_new0(ChardevMux, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));
-    mux->chardev =3D g_strdup(chardev);
-}
-
-static void char_mux_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_mux;
-    cc->open =3D qemu_chr_open_mux;
-    cc->chr_write =3D mux_chr_write;
-    cc->chr_accept_input =3D mux_chr_accept_input;
-    cc->chr_add_watch =3D mux_chr_add_watch;
-}
-
-static const TypeInfo char_mux_type_info =3D {
-    .name =3D TYPE_CHARDEV_MUX,
-    .parent =3D TYPE_CHARDEV,
-    .class_init =3D char_mux_class_init,
-    .instance_size =3D sizeof(MuxChardev),
-    .instance_finalize =3D char_mux_finalize,
-};
-
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
 {
@@ -5101,7 +4756,6 @@ static void register_types(void)
     type_register_static(&char_console_type_info);
 #endif
     type_register_static(&char_pipe_type_info);
-    type_register_static(&char_mux_type_info);
     type_register_static(&char_memory_type_info);
=20
     /* this must be done after machine init, since we register FEs with =
muxes
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index be7ff800c3..f1ccc40ae1 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,2 +1,3 @@
 chardev-obj-y +=3D char.o
+chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
--=20
2.11.0.295.gd7dffce1c.dirty
